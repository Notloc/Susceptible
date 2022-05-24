function CheckDrops(zombie)
	if not zombie:getOutfitName() then return false end
	local outfit = tostring(zombie:getOutfitName());
	local inv = zombie:getInventory();
	if outfit == "TheyKnewNBC" then
		local lootchance = SandboxVars.TheyKnew.LootChance;
		if lootchance >= ZombRand(1, 100) then
			inv:AddItems("TheyKnew.Zomboxivir", 1);
		end
		local pillslootchance = SandboxVars.TheyKnew.LootChanceZomboxycycline;
		if pillslootchance >= ZombRand(1, 100) then
			inv:AddItems("TheyKnew.Zomboxycycline", 1);
		end
	end
end

Events.OnZombieDead.Add(CheckDrops);