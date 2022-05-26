require 'NPCs/ZombiesZoneDefinition'

local Susceptible_spawnchance_hazmat = SandboxVars.Susceptible.SpawnChance * 0.01;
local Susceptible_spawnchance_military = SandboxVars.Susceptible.SpawnChance * 0.03;
local Susceptible_spawnchance_military_NBC = SandboxVars.Susceptible.SpawnChance * 0.02;
local Susceptible_spawnchance_police_riot = SandboxVars.Susceptible.SpawnChance * 0.04;
local Susceptible_spawnchance_police_gasmask = SandboxVars.Susceptible.SpawnChance * 0.04;
local Susceptible_spawnchance_survivor_medicalmask_blue = SandboxVars.Susceptible.SpawnChance * 0.05;
local Susceptible_spawnchance_survivor_medicalmask_green = SandboxVars.Susceptible.SpawnChance * 0.05;
local Susceptible_spawnchance_survivor_dustmask = SandboxVars.Susceptible.SpawnChance * 0.05;
local Susceptible_spawnchance_survivor_clothmask = SandboxVars.Susceptible.SpawnChance * 0.08;

table.insert(ZombiesZoneDefinition.Default,{name = "SusceptibleHazmat", chance= Susceptible_spawnchance_hazmat});
table.insert(ZombiesZoneDefinition.Default,{name = "SusceptibleMilitary", chance= Susceptible_spawnchance_military});
table.insert(ZombiesZoneDefinition.Default,{name = "SusceptibleMilitaryNBC", chance= Susceptible_spawnchance_military_NBC});
table.insert(ZombiesZoneDefinition.Default,{name = "SusceptiblePoliceRiot", chance= Susceptible_spawnchance_police_riot});
table.insert(ZombiesZoneDefinition.Default,{name = "SusceptiblePoliceGasmask", chance= Susceptible_spawnchance_police_gasmask});
table.insert(ZombiesZoneDefinition.Default,{name = "SusceptibleSurvivorMedicalBlue", chance= Susceptible_spawnchance_survivor_medicalmask_blue});
table.insert(ZombiesZoneDefinition.Default,{name = "SusceptibleSurvivorMedicalGreen", chance= Susceptible_spawnchance_survivor_medicalmask_green});
table.insert(ZombiesZoneDefinition.Default,{name = "SusceptibleSurvivorDust", chance= Susceptible_spawnchance_survivor_dustmask});
table.insert(ZombiesZoneDefinition.Default,{name = "SusceptibleSurvivorBandana", chance= Susceptible_spawnchance_survivor_clothmask});
