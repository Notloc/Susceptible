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

return SusceptibleUtil;