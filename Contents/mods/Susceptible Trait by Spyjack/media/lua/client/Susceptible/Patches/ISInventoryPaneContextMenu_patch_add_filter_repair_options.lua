local SusUtil = require "Susceptible/SusceptibleUtil"
local PatchUtil = require "Susceptible/Patches/PatchUtil"

local function getConditionPercent(item)
	local cond = SusUtil.getNormalizedDurability(item);
	cond = math.floor(cond * 100);
	return cond.."%";
end

local function swapOrInsertFilter(mask, filter, player)
	if SusUtil.containsFilter(mask) then
		SusUtil.removeFilter(mask, player);
	end
	SusUtil.insertFilter(mask, filter, player);
end

local function swapOrInsertOxygen(mask, oxygen, player)
	if SusUtil.containsOxygen(mask) then
		SusUtil.removeOxygen(mask, player);
	end
	SusUtil.insertOxygen(mask, oxygen, player);
end

local function addRepairOptions(context, player, isInPlayerInventory, items, x, y, origin)
	if not context or not isInPlayerInventory or #items ~= 1 then
		return context;
	end

	local item = items[1]
    if not instanceof(item, "InventoryItem") then
        if #item.items == 2 then
            item = item.items[1];
        else
        	return context
        end
    end

	local repairType = SusUtil.getRepairType(item);
	if not repairType or repairType == SusceptibleRepairTypes.NONE then
		return context;
	end

	if repairType == SusceptibleRepairTypes.CLOTH then

		local option = context:addOption(getText("UI_Susceptible_Swap_Filter"))
		local subMenu = context:getNew(context)
		context:addSubMenu(option, subMenu)

	elseif repairType == SusceptibleRepairTypes.FILTER then
		local playerObj = getSpecificPlayer(player)
    	local playerInv = playerObj:getInventory()

    	local hasFilter = SusUtil.containsFilter(item);
    	local optionText = getText("UI_Susceptible_Swap_Filter");
		if not hasFilter then
			optionText = getText("UI_Susceptible_Insert_Filter");
		end

		local filters = SusUtil.findAllFilters(playerInv);
		if filters:size() > 0 then
			local option = context:addOption(optionText)
			local subMenu = context:getNew(context)
			context:addSubMenu(option, subMenu)

			for i=1,filters:size() do
				local filter = filters:get(i-1);
				subMenu:addOption(getText("UI_Susceptible_Filter").." - "..getConditionPercent(filter), item, swapOrInsertFilter, filter, playerObj);
			end
		end

		if hasFilter then
			context:addOption(getText("UI_Susceptible_Remove_Filter"), item, SusUtil.removeFilter, playerObj);
		end
	elseif repairType == SusceptibleRepairTypes.OXYGEN then
		local playerObj = getSpecificPlayer(player)
    	local playerInv = playerObj:getInventory()

    	local hasOxygen = SusUtil.containsOxygen(item);
		local optionText = getText("UI_Susceptible_Swap_Oxygen");
		if not hasOxygen then
			optionText = getText("UI_Susceptible_Insert_Oxygen");
		end

		local oxygenTanks = SusUtil.findAllOxygen(playerInv);
		if oxygenTanks:size() > 0 then
			local option = context:addOption(optionText)
			local subMenu = context:getNew(context)
			context:addSubMenu(option, subMenu)

			for i=1,oxygenTanks:size() do
				local tank = oxygenTanks:get(i-1);
				subMenu:addOption(getText("UI_Susceptible_Oxygen").." - "..getConditionPercent(tank), item, swapOrInsertOxygen, tank, playerObj);
			end
		end

		if hasOxygen then
			context:addOption(getText("UI_Susceptible_Remove_Oxygen"), item, SusUtil.removeOxygen, playerObj);
		end
	end

	return context;
end

PatchUtil.patchBuiltInMethod(ISInventoryPaneContextMenu, "createMenu", "Susceptible_addRepairOptions", addRepairOptions);
