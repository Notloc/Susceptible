require 'NPCs/ZombiesZoneDefinition'

local Susceptible_spawnchance_hazmat = SandboxVars.Susceptible.SpawnChance * 0.003;
local Susceptible_spawnchance_military = SandboxVars.Susceptible.SpawnChance * 0.006;
local Susceptible_spawnchance_military_NBC = SandboxVars.Susceptible.SpawnChance * 0.005;
local Susceptible_spawnchance_survivor_medicalmask_blue = SandboxVars.Susceptible.SpawnChance * 1;
local Susceptible_spawnchance_survivor_medicalmask_green = SandboxVars.Susceptible.SpawnChance * 1;
local Susceptible_spawnchance_survivor_dustmask = SandboxVars.Susceptible.SpawnChance * 1;
local Susceptible_spawnchance_survivor_clothmask = SandboxVars.Susceptible.SpawnChance * 2;

table.insert(ZombiesZoneDefinition.Default,{name = "SusceptibleHazmat", chance= Susceptible_spawnchance_hazmat});
table.insert(ZombiesZoneDefinition.Default,{name = "SusceptibleMilitary", chance= Susceptible_spawnchance_military});
table.insert(ZombiesZoneDefinition.Default,{name = "SusceptibleMilitaryNBC", chance= Susceptible_spawnchance_military_NBC});
table.insert(ZombiesZoneDefinition.Default,{name = "SusceptibleSurvivorMedicalBlue", chance= Susceptible_spawnchance_survivor_medicalmask_blue});
table.insert(ZombiesZoneDefinition.Default,{name = "SusceptibleSurvivorMedicalGreen", chance= Susceptible_spawnchance_survivor_medicalmask_green});
table.insert(ZombiesZoneDefinition.Default,{name = "SusceptibleSurvivorDust", chance= Susceptible_spawnchance_survivor_dustmask});
table.insert(ZombiesZoneDefinition.Default,{name = "SusceptibleSurvivorBandana", chance= Susceptible_spawnchance_survivor_clothmask});
