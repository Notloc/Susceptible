local function rollToAddLoot(lootName, inventory)
	local lootchance = SandboxVars.Susceptible.LootChance;
	if lootchance >= ZombRand(1, 100) then
		inventory:AddItems(lootName, 1);
	end
end

local function checkDrops(zombie)
	if not zombie:getOutfitName() then return false end
	local outfit = tostring(zombie:getOutfitName());
	local inv = zombie:getInventory();

	if outfit == "SusceptibleHazmat" then
		rollToAddLoot("Susceptible.OxygenTank", inv);
		
	elseif outfit == "SusceptibleMilitary" or outfit == "SusceptibleMilitaryNBC" or outfit == "SusceptiblePoliceGasmask" then
		rollToAddLoot("Susceptible.GasmaskFilter", inv)
	end
end

Events.OnZombieDead.Add(checkDrops);