require "Susceptible/SusceptibleMaskData"
local SusUtil = require "Susceptible/SusceptibleUtil"

local function getRepairType(maskData)
	if not maskData or not maskData.repairType then
		return SusceptibleRepairTypes.DEFAULT;
	else
		return maskData.repairType;
	end
end

local function getConditionPercent(filter)
	local cond = 100;
	local modData = filter:getModData()
	if modData.filterDelta then
		cond = math.floor(modData.filterDelta * 100);
	end
	return cond.."%";
end

local function swapOrInsertFilter(mask, filter, player)
	if SusUtil.containsFilter(mask) then
		SusUtil.removeFilter(mask, player);
	end
	SusUtil.insertFilter(mask, filter, player);
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

	if repairType == "SusceptibleRepairTypes.CLOTH" then

		local option = context:addOption(getText("UI_Susceptible_Swap_Filter"))
		local subMenu = context:getNew(context)
		context:addSubMenu(option, subMenu)

	elseif repairType ~= SusceptibleRepairTypes.FILTER then--]]
		local playerObj = getSpecificPlayer(player)
    	local playerInv = playerObj:getInventory()

		local filters = SusUtil.findAllFilters(playerInv);
		if filters:size() > 0 then
			local hasFilter = SusUtil.containsFilter(item);

			local optionText = getText("UI_Susceptible_Swap_Filter");
			if not hasFilter then
				optionText = getText("UI_Susceptible_Insert_Filter");
			end

			local option = context:addOption(optionText)
			local subMenu = context:getNew(context)
			context:addSubMenu(option, subMenu)

			for i=1,filters:size() do
				local filter = filters:get(i-1);
				subMenu:addOption(getText("UI_Susceptible_Filter").." - "..getConditionPercent(filter), item, swapOrInsertFilter, filter, playerObj);
			end
		end

		if SusUtil.containsFilter(item) then
			context:addOption(getText("UI_Susceptible_Remove_Filter"), item, SusUtil.removeFilter, playerObj);
		end
	end
end
