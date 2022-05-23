require "Susceptible/SusceptibleMaskData"
local SusUtil = require "Susceptible/SusceptibleUtil"

local fgBar = {r=0.0, g=0.6, b=0.0, a=0.7}
local fgText = {r=0.6, g=0.8, b=0.5, a=0.6}

ISInventoryPane.drawItemDetails_prepatch_susceptible = ISInventoryPane.drawItemDetails;
ISInventoryPane.drawItemDetails = function(self, item, y, xoff, yoff, red)
	self:drawItemDetails_prepatch_susceptible(item, y, xoff, yoff, red);

	if item == nil then
        return;
    end
	
	if SusUtil.hasSusceptibleFilterDurability(item) then
		local delta = SusUtil.getFilterDelta(item);
		local top = self.headerHgt + y * self.itemHgt + yoff;
		self:drawSuceptibleConditionProgressBar(item:getName(), delta, xoff, top, fgText, fgBar)
	end
end

function ISInventoryPane:drawSuceptibleConditionProgressBar(itemName, fraction, xoff, top, fgText, fgBar)
	local textWid = getTextManager():MeasureStringX(self.font, itemName)

	local filterText = getText("UI_Susceptible_Filter");
	local xoff2 = 40 + math.max(120, 50 + textWid) + xoff;
	self:drawText(filterText, xoff2, top + (self.itemHgt - self.fontHgt) / 2, fgText.a, fgText.r, fgText.g, fgText.b, self.font)

	textWid = getTextManager():MeasureStringX(self.font, filterText)
	self:drawProgressBar(15 + textWid + xoff2 + xoff, top+(self.itemHgt/2)-1, 100, 2, fraction, fgBar)
end