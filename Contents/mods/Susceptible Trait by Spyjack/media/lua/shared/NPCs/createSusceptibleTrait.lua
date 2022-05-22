function SusceptibleMod.initTraitData()
    TraitFactory.addTrait("Susceptible", getText("UI_trait_Susceptible"), -11, getText("UI_trait_SusceptibleDesc"), false, false);
end

Events.OnGameBoot.Add(SusceptibleMod.initTraitData);