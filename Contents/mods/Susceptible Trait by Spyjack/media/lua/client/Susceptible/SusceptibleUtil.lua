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
	return SusceptibleMaskItems[itemType] or durabilityItems[itemType];
end

local function initializeModData(item, modData)
	modData.susceptibleData = {}

	local maxDurability = 1;

	local itemType = item:getType();
	local maskInfo = SusceptibleMaskItems[itemType]
	if maskInfo then
		maxDurability = maskInfo.durability;
	end

    modData.susceptibleData.durabilityMax = maxDurability;
    modData.susceptibleData.durability = maxDurability;

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
	local data = SusceptibleUtil.getModData(item);
    if data.durabilityMax then
    	return data.durability <= 0;
    end
    return false;
end

function SusceptibleUtil.getRepairType(item)
	local maskInfo = SusceptibleMaskItems[item:getType()];
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

function SusceptibleUtil.calculateOxygenTankWeight(durability)
	local variableWeight = 3;
	return 2 + (variableWeight * durability);
end

function SusceptibleUtil.updateWeight(item)
	local maskInfo = SusceptibleMaskItems[item:getType()];
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

return SusceptibleUtil;