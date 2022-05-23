require "Susceptible/SusceptibleMaskData"

local SusceptibleUtil = {}

function SusceptibleUtil.hasSusceptibleFilterDurability(item)
	local itemType = item:getType();
	return SusceptibleMaskItems[itemType] or itemType == "GasmaskFilter";
end

function SusceptibleUtil.getFilterDelta(item)
	local delta = 1;
	local data = item:getModData()
	if data.filterDurability then
		delta = data.filterDurability / data.filterDurabilityMax;
	end
	if data.filterDelta then
		delta = data.filterDelta;
	end
	return delta;
end

function SusceptibleUtil.containsFilter(maskItem)
	return not maskItem:getModData().removedFilter;
end

function SusceptibleUtil.createFilterItem()
	return InventoryItemFactory.CreateItem("Susceptible.GasmaskFilter");
end

function SusceptibleUtil.canMaskFilter(maskItem)
	local itemData = maskItem:getModData();
    return not itemData.filterDurability or itemData.filterDurability > 0;
end

function SusceptibleUtil.getFilterData(filterItem)
	local filterModData = filterItem:getModData();
	if not filterModData.filterDelta then
		filterModData.filterDelta = 1;
	end
	return filterModData;
end

function SusceptibleUtil.getMaskData(maskItem)
	local maskModData = maskItem:getModData(); 
	if not maskModData.filterDurabilityMax then
		local maskInfo = SusceptibleMaskItems[maskItem:getType()];
		maskModData.filterDurabilityMax = maskInfo.durability;
		maskModData.filterDurability = maskInfo.durability;
	end
	return maskModData;
end

function SusceptibleUtil.insertFilter(mask, filter, player)
	local maskData =SusceptibleUtil.getMaskData(mask);
	local filterData = SusceptibleUtil.getFilterData(filter);
	
	maskData.removedFilter = false;
	maskData.filterDurability = filterData.filterDelta * maskData.filterDurabilityMax;

	player:getInventory():DoRemoveItem(filter);
end

function SusceptibleUtil.removeFilter(mask, player)
	local maskData = SusceptibleUtil.getMaskData(mask)
	if maskData.removedFilter then
		return;
	end

	local outDelta = maskData.filterDurability / maskData.filterDurabilityMax;

	maskData.removedFilter = true;
	maskData.filterDurability = 0;

	local filterItem = SusceptibleUtil.createFilterItem();
	filterItem:getModData().filterDelta = outDelta;

	player:getInventory():addItem(filterItem);
end

function SusceptibleUtil.isFilter(item)
	return item:getType() == "GasmaskFilter";
end

function SusceptibleUtil.findAllFilters(inventory)
	local filtersOut = ArrayList.new();
	inventory:getAllEval(SusceptibleUtil.isFilter, filtersOut);
	return filtersOut;
end

return SusceptibleUtil;