require 'NPCs/ZombiesZoneDefinition'

local Susceptible_spawnchance_hazmat = SandboxVars.Susceptible.SpawnChance * 0.01;
local Susceptible_spawnchance_military_highcommand = SandboxVars.Susceptible.SpawnChance * 0.005;
local Susceptible_spawnchance_military_gasmask = SandboxVars.Susceptible.SpawnChance * 0.02;
local Susceptible_spawnchance_military_NBC = SandboxVars.Susceptible.SpawnChance * 0.01;
local Susceptible_spawnchance_police_gasmask = SandboxVars.Susceptible.SpawnChance * 0.03;
local Susceptible_spawnchance_firefighter = SandboxVars.Susceptible.SpawnChance * 0.03;
local Susceptible_spawnchance_survivor_basic = SandboxVars.Susceptible.SpawnChance * 0.06;
local Susceptible_spawnchance_survivor_advanced = SandboxVars.Susceptible.SpawnChance * 0.04;

table.insert(ZombiesZoneDefinition.Default,{name = "SusceptibleHazmat", chance= Susceptible_spawnchance_hazmat});
table.insert(ZombiesZoneDefinition.Default,{name = "SusceptibleMilitaryHighcommand", chance= Susceptible_spawnchance_military_highcommand});
table.insert(ZombiesZoneDefinition.Default,{name = "SusceptibleMilitaryGasmask", chance= Susceptible_spawnchance_military_gasmask});
table.insert(ZombiesZoneDefinition.Default,{name = "SusceptibleMilitaryNBC", chance= Susceptible_spawnchance_military_NBC});
table.insert(ZombiesZoneDefinition.Default,{name = "SusceptiblePoliceGasmask", chance= Susceptible_spawnchance_police_gasmask});
table.insert(ZombiesZoneDefinition.Default,{name = "SusceptibleFirefighter", chance= Susceptible_spawnchance_firefighter});
table.insert(ZombiesZoneDefinition.Default,{name = "SusceptibleSurvivorBasic", chance= Susceptible_spawnchance_survivor_basic});
table.insert(ZombiesZoneDefinition.Default,{name = "SusceptibleSurvivorAdvanced", chance= Susceptible_spawnchance_survivor_advanced});
