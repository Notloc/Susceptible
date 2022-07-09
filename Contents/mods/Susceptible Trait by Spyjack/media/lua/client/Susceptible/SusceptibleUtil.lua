require "Susceptible/SusceptibleMaskData"

local OXYGEN_TANK_ITEM = "Susceptible.OxygenTank";
local FILTER_ITEM = "Susceptible.GasmaskFilter";

local SusceptibleUtil = {}

local durabilityItems = {
	GasmaskFilter = true,
	OxygenTank = true,
}

function SusceptibleUtil.hasSusceptibleDurability(item)
	local itemType = item:getType();
	return SusceptibleMaskItems:getMaskData(item) or durabilityItems[itemType];
end

local function initializeModData(item, modData)
	modData.susceptibleData = {}

	local maxDurability = 1;

	local itemType = item:getType();
	local maskInfo = SusceptibleMaskItems:getMaskData(item)
	if maskInfo then
		maxDurability = maskInfo.durability;
	end

    modData.susceptibleData.durabilityMax = maxDurability;
    modData.susceptibleData.durability = maxDurability;

    -- Import old mask durability if available
    if modData.filterDurability then
    	modData.susceptibleData.durability = modData.filterDurability;
    end

    modData.susceptibleData.weights = {}

    if maskInfo and maskInfo.repairType == SusceptibleRepairTypes.FILTER then
	    SusceptibleUtil.setWeightChange(item, "filter", 0.5);
	end
end

function SusceptibleUtil.getModData(item)
	local modData = item:getModData();
	if not modData.susceptibleData then
		initializeModData(item, modData);
	end
    return modData.susceptibleData;
end



function SusceptibleUtil.damageDurability(item, damage)
    local data = SusceptibleUtil.getModData(item);

    data.durability = data.durability - damage;
    if data.durability < 0 then
        data.durability = 0;
    end

    SusceptibleUtil.updateWeight(item);
end

function SusceptibleUtil.getNormalizedDurability(item)
	local durability = 1;
	local modData = item:getModData().susceptibleData
	if modData then
		durability = modData.durability / modData.durabilityMax;
	end
	return durability;
end

function SusceptibleUtil.isBroken(item)
	if item:getCondition() <= 0 then
		return true;
	end

	local data = SusceptibleUtil.getModData(item);

	local maskInfo = SusceptibleMaskItems:getMaskData(item);
	if not maskInfo or maskInfo.repairType == SusceptibleRepairTypes.OXYGEN and not data.hasOxygenTank then 
		return true;
	end
	
    if data.durabilityMax then
    	return data.durability <= 0;
    end
    return false;
end

function SusceptibleUtil.getRepairType(item)
	local maskInfo = SusceptibleMaskItems:getMaskData(item);
	if not maskInfo then
		return nil;
	elseif not maskInfo.repairType then
		return SusceptibleRepairTypes.DEFAULT;
	else
		return maskInfo.repairType;
	end
end

function SusceptibleUtil.insertFilter(maskItem, filterItem, player)
	local maskData = SusceptibleUtil.getModData(maskItem);
	if not maskData.removedFilter then
		return
	end

	SusceptibleUtil.overwriteDurability(filterItem, maskItem);
	SusceptibleUtil.setWeightChange(maskItem, "filter", 0.5);

	maskData.removedFilter = false;
	player:getInventory():DoRemoveItem(filterItem);
end

function SusceptibleUtil.removeFilter(maskItem, player)
	local maskData = SusceptibleUtil.getModData(maskItem)
	if maskData.removedFilter then
		return;
	end

	local filterItem = player:getInventory():AddItem(FILTER_ITEM);
	SusceptibleUtil.overwriteDurability(maskItem, filterItem);
	SusceptibleUtil.setWeightChange(maskItem, "filter", 0);
	
	maskData.removedFilter = true;
end

function SusceptibleUtil.insertOxygen(mask, oxygen, player)
	local maskData = SusceptibleUtil.getModData(mask);
	if maskData.hasOxygenTank then
		return;
	end

	SusceptibleUtil.overwriteDurability(oxygen, mask);
	local weight = SusceptibleUtil.calculateOxygenTankWeight(SusceptibleUtil.getNormalizedDurability(mask));
	SusceptibleUtil.setWeightChange(mask, "oxygenTank", weight);

	maskData.hasOxygenTank = true;
	player:getInventory():DoRemoveItem(oxygen);
end

function SusceptibleUtil.removeOxygen(mask, player)
	local maskData = SusceptibleUtil.getModData(mask)
	if not maskData.hasOxygenTank then
		return;
	end

	local oxygenItem = player:getInventory():AddItem(OXYGEN_TANK_ITEM);

	SusceptibleUtil.overwriteDurability(mask, oxygenItem);
	SusceptibleUtil.setWeightChange(mask, "oxygenTank", 0);

	local durability = SusceptibleUtil.getNormalizedDurability(oxygenItem);
	SusceptibleUtil.setWeightChange(oxygenItem, "oxygenTank", (1-durability) * -3);

	maskData.hasOxygenTank = false;
end

function SusceptibleUtil.isFilter(item)
	return item:getType() == "GasmaskFilter";
end

function SusceptibleUtil.isOxygen(item)
	return item:getType() == "OxygenTank";
end

function SusceptibleUtil.isBleach(item)
	return item:getType() == "Bleach";
end

function SusceptibleUtil.isClothMask(item)
	local maskInfo = SusceptibleMaskItems:getMaskData(item);
	return maskInfo and maskInfo.repairType == SusceptibleRepairTypes.WASH and not SusceptibleUtil.isBroken(item);
end

function SusceptibleUtil.findAllFilters(inventory)
	local filtersOut = ArrayList.new();
	inventory:getAllEval(SusceptibleUtil.isFilter, filtersOut);
	return filtersOut;
end

function SusceptibleUtil.findAllOxygen(inventory)
	local oxygenOut = ArrayList.new();
	inventory:getAllEval(SusceptibleUtil.isOxygen, oxygenOut);
	return oxygenOut;
end

function SusceptibleUtil.findAllClothMasks(inventory)
	local masksOut = ArrayList.new();
	inventory:getAllEval(SusceptibleUtil.isClothMask, masksOut);
	return masksOut;
end

function SusceptibleUtil.findAllCleaningSupplies(inventory)
	local cleanerOut = ArrayList.new();
	cleanerOut:addAll(inventory:getItemsFromType("Soap2", true))
    cleanerOut:addAll(inventory:getItemsFromType("CleaningLiquid2", true))
	return cleanerOut;
end

function SusceptibleUtil.findAllBleach(inventory)
	local cleanerOut = ArrayList.new();
	inventory:getAllEval(SusceptibleUtil.isBleach, cleanerOut);
	return cleanerOut;
end

function SusceptibleUtil.containsFilter(maskItem)
	local data = maskItem:getModData().susceptibleData;
	return not data or not data.removedFilter;
end

function SusceptibleUtil.containsOxygen(maskItem)
	local data = maskItem:getModData().susceptibleData;
	return data and data.hasOxygenTank;
end

function SusceptibleUtil.overwriteDurability(fromItem, toItem)
	local fromData = SusceptibleUtil.getModData(fromItem)
	local outPercent = fromData.durability / fromData.durabilityMax;
	fromData.durability = 0;

	local toData = SusceptibleUtil.getModData(toItem);
	toData.durability = outPercent * toData.durabilityMax;
end

function SusceptibleUtil.addDurabilityFrom(fromItem, toItem, mult)
	local fromData = SusceptibleUtil.getModData(fromItem)
	local outPercent = mult * fromData.durability / fromData.durabilityMax;
	fromData.durability = 0;

	local toData = SusceptibleUtil.getModData(toItem);
	toData.durability = (outPercent * toData.durabilityMax) + toData.durability;
	if toData.durability > toData.durabilityMax then
		toData.durability = toData.durabilityMax;
	end
end

function SusceptibleUtil.repairWith(itemToRepair, repairItem, repairMult, player)
	SusceptibleUtil.addDurabilityFrom(repairItem, itemToRepair, repairMult);
	player:getInventory():DoRemoveItem(repairItem);
end

function SusceptibleUtil.repair(item, repairPercentage)
	local data = SusceptibleUtil.getModData(item);
	data.durability = data.durability + (data.durabilityMax * repairPercentage);
	if data.durability > data.durabilityMax then
		data.durability = data.durabilityMax;
	end
end

function SusceptibleUtil.calculateOxygenTankWeight(durability)
	local variableWeight = 3;
	return 2 + (variableWeight * durability);
end

function SusceptibleUtil.updateWeight(item)
	local maskInfo = SusceptibleMaskItems:getMaskData(item);
	if not maskInfo then
		return;
	end

	if maskInfo.repairType == SusceptibleRepairTypes.OXYGEN then
		local modData = SusceptibleUtil.getModData(item);
		if modData.hasOxygenTank then
			local weight = SusceptibleUtil.calculateOxygenTankWeight(SusceptibleUtil.getNormalizedDurability(item))
			SusceptibleUtil.setWeightChange(item, "oxygenTank", weight);
		end
	end
end

function SusceptibleUtil.setWeightChange(item, key, amount)
	local data = SusceptibleUtil.getModData(item);

	local change = amount;
	if data.weights[key] then
		change = amount - data.weights[key];
	end

	data.weights[key] = amount;
	item:setActualWeight(item:getActualWeight() + change);
	item:setCustomWeight(true);
end

function SusceptibleUtil.getSplitScreenType()
	local players = IsoPlayer.getPlayers();
	if players:get(1) ~= nil and players:get(2) ~= nil then
		return "CROSS";
	elseif players:get(1) ~= nil then
		return "VERTICAL";
	else
		return "NONE";
	end
end

function SusceptibleUtil.saveUiOffsets(x, y)
	local splitScreenType = SusceptibleUtil.getSplitScreenType();
	if splitScreenType == "CROSS" or splitScreenType == "VERTICAL" then
		x = x * 2.0;
	end
	if splitScreenType == "CROSS" then
		y = y * 2.0;
	end

	local data = ModData.getOrCreate("SusceptibleUiOffsets");
	data.susceptibleUiX = x;
	data.susceptibleUiY = y;
end

function SusceptibleUtil.loadUiOffsets()
	local BASE_UI_SIZE = 64;

	local data = ModData.getOrCreate("SusceptibleUiOffsets");
    local x = data.susceptibleUiX;
    local y = data.susceptibleUiY;
    if not x or not y then
    	x = 60;
    	y = 10;
    end

    local width = getCore():getScreenWidth();
    local height = getCore():getScreenHeight();

    if x + BASE_UI_SIZE > width then x = width - BASE_UI_SIZE end
    if y + BASE_UI_SIZE > height then y = height - BASE_UI_SIZE end

    return x, y;
end

return SusceptibleUtil;
