function CheckDrops(zombie)
	if not zombie:getOutfitName() then return false end
	local outfit = tostring(zombie:getOutfitName());
	local inv = zombie:getInventory();
	if outfit == "SusceptibleHazmat" then
			local lootchance = SandboxVars.Susceptible.LootChance;
			if lootchance >= ZombRand(1, 100) then
			inv:AddItems("Susceptible.OxygenTank", 1);
			end
		end
		
	if outfit == "SusceptibleMilitaryGasmask" then	
			local lootchance = SandboxVars.Susceptible.LootChance;
			if lootchance >= ZombRand(1, 100) then
			inv:AddItems("Susceptible.GasmaskFilter", 1);
			end
		end
		
	if outfit == "SusceptibleMilitaryNBC" then
			local lootchance = SandboxVars.Susceptible.LootChance;
			if lootchance >= ZombRand(1, 100) then
			inv:AddItems("Susceptible.GasmaskFilter", 1);
			end		
		end

	if outfit == "SusceptiblePoliceGasmask" then
			local lootchance = SandboxVars.Susceptible.LootChance;
			if lootchance >= ZombRand(1, 100) then
			inv:AddItems("Susceptible.GasmaskFilter", 1);
			end		
		end

	if outfit == "SusceptibleFirefighter" then
			local lootchance = SandboxVars.Susceptible.LootChance;
			if lootchance >= ZombRand(1, 100) then
			inv:AddItems("Susceptible.OxygenTank", 1);
			end		
		end		
		
	if outfit == "SusceptibleHazmat" then
				local lootchance = SandboxVars.Susceptible.LootChance;
				if lootchance >= ZombRand(1, 100) then
				inv:AddItems("Susceptible.OxygenTank", 1);
				end	
	end
end

Events.OnZombieDead.Add(CheckDrops);