require "Susceptible/SusceptibleMaskData"

local function getRepairType(maskData)
	if not maskData or not maskData.repairType then
		return SusceptibleRepairTypes.DEFAULT;
	else
		return maskData.repairType;
	end
end

local function isFilter(item)
	return item:getType() == "GasmaskFilter";
end

local function getFilters(inventory)
	local filtersOut = ArrayList.new();
	inventory:getAllEval(isFilter, filtersOut);
	return filtersOut;
end

local function getConditionPercent(filter)
	local cond = 100;
	local modData = filter:getModData()
	if modData.filterDelta then
		cond = math.floor(modData.filterDelta * 100);
	end
	return cond.."%";
end

local function ensureFilterData(filterModData)
	if not filterModData.filterDelta then
		filterModData.filterDelta = 1;
	end
end

local function ensureMaskData(mask, maskModData) 
	if not maskModData.filterDurabilityMax then
		local maskInfo = SusceptibleMaskItems[mask:getType()];
		maskModData.filterDurabilityMax = maskInfo.durability;
		maskModData.filterDurability = maskInfo.durability;
	end
end

local function swapFilter(mask, filter, player)
	local filterData = filter:getModData();
	ensureFilterData(filterData);

	local maskData = mask:getModData();
	ensureMaskData(mask, maskData);

	local inDelta = filterData.filterDelta;
	local outDelta = maskData.filterDurability / maskData.filterDurabilityMax;

	filterData.filterDelta = outDelta;
	maskData.filterDurability = inDelta * maskData.filterDurabilityMax;
end


ISInventoryPaneContextMenu.createMenu_prepatch_susceptible = ISInventoryPaneContextMenu.createMenu;
ISInventoryPaneContextMenu.createMenu = function(player, isInPlayerInventory, items, x, y, origin)
	local context = ISInventoryPaneContextMenu.createMenu_prepatch_susceptible(player, isInPlayerInventory, items, x, y, origin);
	ISInventoryPaneContextMenu.addFilterRepairOptions(context, player, isInPlayerInventory, items, x, y, origin);
	return context;
end

ISInventoryPaneContextMenu.addFilterRepairOptions = function(context, player, isInPlayerInventory, items, x, y, origin)
	if not context or not isInPlayerInventory or #items ~= 1 then
		return;
	end

	local item = items[1]
    if not instanceof(item, "InventoryItem") then
        if #item.items == 2 then
            item = item.items[1];
        else
        	return
        end
    end

	local maskData = SusceptibleMaskItems[item:getType()];
	local repairType = getRepairType(maskData);
	if not maskData or repairType == SusceptibleRepairTypes.NONE then
		return;
	end

--[[	if repairType == SusceptibleRepairTypes.CLOTH then

		local option = context:addOption(getText("Swap Filter"))
		local subMenu = context:getNew(context)
		context:addSubMenu(option, subMenu)

	elseif repairType == SusceptibleRepairTypes.FILTER then--]]
		local playerObj = getSpecificPlayer(player)
    	local playerInv = playerObj:getInventory()


		local filters = getFilters(playerInv);
		if filters:size() > 0 then
			local option = context:addOption(getText("Swap Filter"))
			local subMenu = context:getNew(context)
			context:addSubMenu(option, subMenu)

			for i=1,filters:size() do
				local filter = filters:get(i-1);
				subMenu:addOption(getText("Filter: ")..getConditionPercent(filter), item, swapFilter, filter, playerObj);
			end
		end
	--end
end
