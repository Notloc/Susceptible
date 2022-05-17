require "TimedActions/ISEatFoodAction"
require "Susceptible/SusceptibleTrait"


ISEatFoodAction.start_prepatch_susceptible = ISEatFoodAction.start;


ISEatFoodAction.start = function(self)
	if self.character:HasTrait("Susceptible") then
		local threat = SusceptibleMod.threatByPlayer[self.character];
		if threat and threat > 0 then
			self:forceStop();
			return;
		end

		local mask = SusceptibleMod.getEquippedMaskItemAndData(self.character);
		if mask then
			self:stop();
			self:autoManageMask(mask);
			return;
		end
	end

	return self:start_prepatch_susceptible();
end


ISEatFoodAction.autoManageMask = function(self, mask)
	ISTimedActionQueue.add(ISUnequipAction:new(self.character, mask, 50));
	ISTimedActionQueue.add(ISEatFoodAction:new(self.character, self.item, self.percentage));
	ISTimedActionQueue.add(ISWearClothing:new(self.character, mask, 50));
end