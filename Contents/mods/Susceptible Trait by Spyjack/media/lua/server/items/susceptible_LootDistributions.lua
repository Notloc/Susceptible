require 'Items/SuburbsDistributions'
require 'Items/ProceduralDistributions'

-- Boxes --
-- Blue
table.insert(ProceduralDistributions.list["MedicalClinicOutfit"].items, "Susceptible.MaskBox_Blue");
table.insert(ProceduralDistributions.list["MedicalClinicOutfit"].items, 40);
table.insert(ProceduralDistributions.list["MedicalClinicTools"].items, "Susceptible.MaskBox_Blue");
table.insert(ProceduralDistributions.list["MedicalClinicTools"].items, 40);
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, "Susceptible.MaskBox_Blue");
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, 40);
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, "Susceptible.MaskBox_Blue");
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, 40);
table.insert(ProceduralDistributions.list["ArmyStorageMedical"].items, "Susceptible.MaskBox_Blue");
table.insert(ProceduralDistributions.list["ArmyStorageMedical"].items, 10);
table.insert(ProceduralDistributions.list["StoreShelfMedical"].items, "Susceptible.MaskBox_Blue");
table.insert(ProceduralDistributions.list["StoreShelfMedical"].items, 3);

-- Green
table.insert(ProceduralDistributions.list["MedicalClinicOutfit"].items, "Susceptible.MaskBox_Green");
table.insert(ProceduralDistributions.list["MedicalClinicOutfit"].items, 10);
table.insert(ProceduralDistributions.list["MedicalClinicTools"].items, "Susceptible.MaskBox_Green");
table.insert(ProceduralDistributions.list["MedicalClinicTools"].items, 5);
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, "Susceptible.MaskBox_Green");
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, 5);
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, "Susceptible.MaskBox_Green");
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, 50);
table.insert(ProceduralDistributions.list["ArmyStorageMedical"].items, "Susceptible.MaskBox_Green");
table.insert(ProceduralDistributions.list["ArmyStorageMedical"].items, 40);

-- Empty Blue
table.insert(ProceduralDistributions.list["MedicalClinicOutfit"].items, "Susceptible.EmptyMaskBox_Blue");
table.insert(ProceduralDistributions.list["MedicalClinicOutfit"].items, 8);
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, "Susceptible.EmptyMaskBox_Blue");
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, 6);
table.insert(ProceduralDistributions.list["StoreShelfMedical"].items, "Susceptible.EmptyMaskBox_Blue");
table.insert(ProceduralDistributions.list["StoreShelfMedical"].items, 8);
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, "Susceptible.EmptyMaskBox_Blue");
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, 2);

-- Empty Green
table.insert(ProceduralDistributions.list["MedicalClinicOutfit"].items, "Susceptible.EmptyMaskBox_Green");
table.insert(ProceduralDistributions.list["MedicalClinicOutfit"].items, 8);
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, "Susceptible.EmptyMaskBox_Green");
table.insert(ProceduralDistributions.list["MedicalStorageOutfit"].items, 6);
table.insert(ProceduralDistributions.list["StoreShelfMedical"].items, "Susceptible.EmptyMaskBox_Green");
table.insert(ProceduralDistributions.list["StoreShelfMedical"].items, 8);
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, "Susceptible.EmptyMaskBox_Green");
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, 2);


-- Equipment Repair Items --

--Gas  Mask Filter  --
--Army base + Safehouse
table.insert(ProceduralDistributions.list["ArmyStorageMedical"].items, "Susceptible.GasmaskFilter");
table.insert(ProceduralDistributions.list["ArmyStorageMedical"].items, 40);
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, "Susceptible.GasmaskFilter");
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, 40);
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Susceptible.GasmaskFilter");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 3);
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, "Susceptible.GasmaskFilter");
table.insert(ProceduralDistributions.list["ArmyStorageOutfit"].items, 40);
table.insert(ProceduralDistributions.list["ArmyHangarTools"].items, "Susceptible.GasmaskFilter");
table.insert(ProceduralDistributions.list["ArmyHangarTools"].items, 3);

--Army Surplus
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, "Susceptible.GasmaskFilter");
table.insert(ProceduralDistributions.list["ArmySurplusOutfit"].items, 20);
table.insert(ProceduralDistributions.list["ArmySurplusMisc"].items, "Susceptible.GasmaskFilter");
table.insert(ProceduralDistributions.list["ArmySurplusMisc"].items, 20);
table.insert(ProceduralDistributions.list["ArmySurplusTools"].items, "Susceptible.GasmaskFilter");
table.insert(ProceduralDistributions.list["ArmySurplusTools"].items, 5);

--Police station + prison 
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Susceptible.GasmaskFilter");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 20);
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, "Susceptible.GasmaskFilter");
table.insert(ProceduralDistributions.list["PoliceStorageOutfit"].items, 40);
table.insert(ProceduralDistributions.list["PoliceStorageGuns"].items, "Susceptible.GasmaskFilter");
table.insert(ProceduralDistributions.list["PoliceStorageGuns"].items, 5);
table.insert(ProceduralDistributions.list["PoliceStorageAmmunition"].items, "Susceptible.GasmaskFilter");
table.insert(ProceduralDistributions.list["PoliceStorageAmmunition"].items, 5);

--Fire station
table.insert(ProceduralDistributions.list["FireDeptLockers"].items, "Susceptible.GasmaskFilter");
table.insert(ProceduralDistributions.list["FireDeptLockers"].items, 10);
table.insert(ProceduralDistributions.list["FireStorageTools"].items, "Susceptible.GasmaskFilter");
table.insert(ProceduralDistributions.list["FireStorageTools"].items, 20);
table.insert(ProceduralDistributions.list["FireStorageOutfit"].items, "Susceptible.GasmaskFilter");
table.insert(ProceduralDistributions.list["FireStorageOutfit"].items, 40);
