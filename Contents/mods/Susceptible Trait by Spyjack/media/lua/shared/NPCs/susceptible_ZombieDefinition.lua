require 'NPCs/ZombiesZoneDefinition'

local spawnChance = SandboxVars.Susceptible.SpawnChance;

table.insert(ZombiesZoneDefinition.Default, {name = "SusceptibleHazmat",                  chance = spawnChance * 0.01});
table.insert(ZombiesZoneDefinition.Default, {name = "SusceptibleMilitary",                chance = spawnChance * 0.03});
table.insert(ZombiesZoneDefinition.Default, {name = "SusceptibleMilitaryNBC",             chance = spawnChance * 0.02});
table.insert(ZombiesZoneDefinition.Default, {name = "SusceptiblePoliceRiot",              chance = spawnChance * 0.04});
table.insert(ZombiesZoneDefinition.Default, {name = "SusceptiblePoliceGasmask",           chance = spawnChance * 0.04});
table.insert(ZombiesZoneDefinition.Default, {name = "SusceptibleSurvivorMedicalBlue",     chance = spawnChance * 0.05});
table.insert(ZombiesZoneDefinition.Default, {name = "SusceptibleSurvivorMedicalGreen",    chance = spawnChance * 0.05});
table.insert(ZombiesZoneDefinition.Default, {name = "SusceptibleSurvivorDust",            chance = spawnChance * 0.05});
table.insert(ZombiesZoneDefinition.Default, {name = "SusceptibleSurvivorBandana",         chance = spawnChance * 0.08});
