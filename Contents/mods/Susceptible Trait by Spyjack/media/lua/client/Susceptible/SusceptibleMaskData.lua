local NONE = "None";
local CLOTH = "Cloth";
local FILTER = "Filter";
local WASH = "Wash";
local OXYGEN = "Oxygen";

SusceptibleRepairTypes = {
	NONE = NONE,
	CLOTH = CLOTH,
	FILTER = FILTER,
	WASH = WASH,
	OXYGEN = OXYGEN,
	DEFAULT = CLOTH,
};

-- quality defaults to infinite
-- repairType defaults to CLOTH

SusceptibleMaskItems = {
--- Hazmat Suits ---
	HazmatSuit =                                          { durability=600, repairType=OXYGEN },
	MysteriousHazmat =                                    { durability=600, repairType=OXYGEN },    
	CEDAHazmatSuit =                                      { durability=600, repairType=OXYGEN },    
	HazmatSuitCEDANoShoes =                               { durability=600, repairType=OXYGEN },    
	CEDAHazmatSuitBlack =                                 { durability=600, repairType=OXYGEN },    
	CEDAHazmatSuitBlackNoShoes =                          { durability=600, repairType=OXYGEN },    
	CEDAHazmatSuitBlue =                                  { durability=600, repairType=OXYGEN },    
	CEDAHazmatSuitBlueNoShoes =                           { durability=600, repairType=OXYGEN },    
	CEDAHazmatSuitRed =                                   { durability=600, repairType=OXYGEN },    
	CEDAHazmatSuitRedNoShoes =                            { durability=600, repairType=OXYGEN },    
	NBHHazmatSuit =                                       { durability=600, repairType=OXYGEN },    
	NBHHazmatSuitNoShoes =                                { durability=600, repairType=OXYGEN },
	HazmatSuit2 =                                         { durability=600, repairType=OXYGEN },        
	HazmatSuit2NoShoes =                                  { durability=600, repairType=OXYGEN },
	Hat_M17Doff =                                         { durability=600, repairType=OXYGEN },
	Hat_M40Doff =                                         { durability=600, repairType=OXYGEN },
	ssp9bluehelm =                                        { durability=600, repairType=OXYGEN },
	ssp9greenhelm =                                       { durability=600, repairType=OXYGEN },
	ssp9orangehelm =                                      { durability=600, repairType=OXYGEN },
	ssp9redhelm =                                         { durability=600, repairType=OXYGEN },
	ssp9whitehelm =                                       { durability=600, repairType=OXYGEN },
	ssp9yellowhelm =                                      { durability=600, repairType=OXYGEN },
	SEVAHelm =                                        	  { durability=600, repairType=OXYGEN },
	SEVAHelmBandit =                                      { durability=600, repairType=OXYGEN },
	SEVAHelmCS =                                          { durability=600, repairType=OXYGEN },
	SEVAHelmDuty =                                        { durability=600, repairType=OXYGEN },
	SEVAHelmFreedom =                                     { durability=600, repairType=OXYGEN },
	SEVAHelmEcologist =                                   { durability=600, repairType=OXYGEN },
	SEVAHelmMercs =                                       { durability=600, repairType=OXYGEN },
	SEVAHelmMonolith =                                    { durability=600, repairType=OXYGEN },
	SEVAHelmMonolithGreen =                               { durability=600, repairType=OXYGEN },
	PowerArmorHelmet =                           	      { durability=600, repairType=OXYGEN },

--- Gas masks ---
	Hat_GasMask =                                         { durability=400, repairType=FILTER },
	Hat_NBCmask =                                         { durability=400, repairType=FILTER },
	Hat_SwatGasMask =                                     { durability=400, repairType=FILTER },
	Hat_FM53 =                                            { durability=400, repairType=FILTER },
	Hat_M17 =                                             { durability=400, repairType=FILTER },
	Hat_M40 =                                             { durability=400, repairType=FILTER },    
	Hat_M45_GasMask =                                     { durability=400, repairType=FILTER },
	Hat_M50 =                                             { durability=400, repairType=FILTER },
	Hat_PoliceM17 =                                       { durability=400, repairType=FILTER },
	Hat_Mask_Cloth =                                      { durability=400, repairType=FILTER },
	Hat_Mask_Half =                                       { durability=400, repairType=FILTER },
	Hat_Maska =                                           { durability=400, repairType=FILTER },
	Hat_MCU_GasMask =                                     { durability=400, repairType=FILTER },
	Hat_MSA_Gas_Mask =                                    { durability=400, repairType=FILTER },
	Hat_MSA_Gas_Mask_AMP =                                { durability=400, repairType=FILTER },
	Hat_Riot_Visor =                                      { durability=400, repairType=FILTER },
	Hat_PSGT_Visor =                                      { durability=400, repairType=FILTER },
	Hat_MX_Helmet =                                       { durability=400, repairType=FILTER },
	Hat_Killa =                                           { durability=400, repairType=FILTER },
	Hat_Killa_Visor =                                     { durability=400, repairType=FILTER },
	Hat_HGU56 =                                           { durability=400, repairType=FILTER },
	Hat_HGU56_Visor =                                     { durability=400, repairType=FILTER },
	Hat_Ghost =                                           { durability=400, repairType=FILTER },
	Hhunk =                                               { durability=400, repairType=FILTER },
	Mhunk2 =                                              { durability=400, repairType=FILTER },
	Mhunk3 =                                              { durability=400, repairType=FILTER },
	Hage =                                                { durability=400, repairType=FILTER },
	HWhatup =                                             { durability=400, repairType=FILTER },    
	HWhatdown =                                           { durability=400, repairType=FILTER },
	Mask_HECU  =                                          { durability=400, repairType=FILTER },    
	GP5GasMask  =                                         { durability=400, repairType=FILTER },
 	Ranger_Advanced_Helmet  =                             { durability=400, repairType=FILTER },
	Ranger_Desert_Helmet  =                               { durability=400, repairType=FILTER },    
	Ranger_Elite_Helmet  =                                { durability=400, repairType=FILTER },
	Ranger_Riot_Helmet  =                                 { durability=400, repairType=FILTER }, 
	Ranger_Veteran_Helmet  =                              { durability=400, repairType=FILTER },
 	Ranger_Winter_Helmet  =                               { durability=400, repairType=FILTER },
	["StalkerArmorPack.GP5GasMask"]  =                    { durability=400, repairType=FILTER }, 
	M40GasMask  =                     				      { durability=400, repairType=FILTER }, 
	PPM88  =                              				  { durability=400, repairType=FILTER }, 
	GP10Z  =                              				  { durability=400, repairType=FILTER }, 
	SovietPMG  =                              			  { durability=400, repairType=FILTER }, 
	CS2aGasMask  =                               		  { durability=400, repairType=FILTER }, 
	PBF1  =                             				  { durability=400, repairType=FILTER }, 
	PBF1CS  =                              				  { durability=400, repairType=FILTER }, 
	PBF1Duty  =                           			      { durability=400, repairType=FILTER }, 
	PBF1Freedom  =                         			      { durability=400, repairType=FILTER }, 
	PBF2  =                             				  { durability=400, repairType=FILTER }, 
	PBF2C  =                             				  { durability=400, repairType=FILTER }, 
	PBF2Duty  =                            			      { durability=400, repairType=FILTER }, 
	PBF2Freedom  =                          		      { durability=400, repairType=FILTER }, 
	RespiratorGold  =                         		      { durability=400, repairType=FILTER }, 
	RespiratorSilver  =                        	          { durability=400, repairType=FILTER }, 
	RespiratorCS  =                             		  { durability=400, repairType=FILTER }, 
	RespiratorFreedom  =                                  { durability=400, repairType=FILTER }, 
	RespiratorDuty  =                            	      { durability=400, repairType=FILTER }, 
	RespiratorMonolith  =                                 { durability=400, repairType=FILTER }, 
	SphereM12Helmet  =                               	  { durability=400, repairType=FILTER }, 
	SphereM12HelmetCS  =                               	  { durability=400, repairType=FILTER }, 
	SphereM12HelmetDuty  =                                { durability=400, repairType=FILTER }, 
	SphereM12HelmetFreedom  =                             { durability=400, repairType=FILTER }, 
	SphereM12HelmetMonolith  =                            { durability=400, repairType=FILTER },
	SphereM12HelmetMercs  =                               { durability=400, repairType=FILTER },  
	Sphere08HelmetMilitary  =                             { durability=400, repairType=FILTER }, 
	Sphere08HelmetCS  =                            	      { durability=400, repairType=FILTER }, 
	Sphere08HelmetDuty  =                                 { durability=400, repairType=FILTER }, 
	Sphere08HelmetFreedom  =                              { durability=400, repairType=FILTER }, 
	Sphere08HelmetMonolith  =                             { durability=400, repairType=FILTER }, 
	Sphere08MaskMilitary  =                               { durability=400, repairType=FILTER }, 
	Sphere08MaskCS  =                            	      { durability=400, repairType=FILTER }, 
	Sphere08MaskDuty  =                             	  { durability=400, repairType=FILTER }, 
	Sphere08MaskFreedom  =                                { durability=400, repairType=FILTER }, 
	Sphere08MaskMonolith  =                               { durability=400, repairType=FILTER }, 
	Sphere08HelmetMercs  =                                { durability=400, repairType=FILTER }, 
	Sphere08MaskMercs  =                                  { durability=400, repairType=FILTER }, 	
	Exohelm  =                               			  { durability=400, repairType=FILTER }, 
	ExohelmBandit  =                         		      { durability=400, repairType=FILTER }, 
	ExohelmCS  =                             			  { durability=400, repairType=FILTER }, 
	ExohelmDuty  =                            		      { durability=400, repairType=FILTER }, 
	ExohelmFreedom  =                         	          { durability=400, repairType=FILTER }, 
	ExohelmMercs  =                              		  { durability=400, repairType=FILTER }, 
	ExohelmMilitary  =                           	      { durability=400, repairType=FILTER }, 
	ExohelmMonolith  =                           	      { durability=400, repairType=FILTER }, 
	ExohelmEcologists  =                         	      { durability=400, repairType=FILTER }, 
	ExohelmLoner  =                               		  { durability=400, repairType=FILTER }, 
	SteelHelmMask  =                               		  { durability=400, repairType=FILTER }, 
  	
 --- Enclosed Military Helmets ---   
	Hat_KillaHelmet =                                     { durability=350, repairType=CLOTH },
	Hat_880_Helmet =                                      { durability=350, repairType=CLOTH },
	Hat_880_Visor =                                       { durability=350, repairType=CLOTH },
	Hat_PSGT_Helmet_Camo =                                { durability=350, repairType=CLOTH },
	Hat_Face_Shield =                                     { durability=350, repairType=CLOTH },

--- Unique Mod masks ---
	NomadMask =                                           { durability=250, repairType=FILTER },
	OminousNomadMask =                                    { durability=250, repairType=FILTER },
	PrepperMask =                                         { durability=250, repairType=FILTER },
	StalkerMask =                                         { durability=250, repairType=FILTER },
	HeadhunterGasmask  =                                  { durability=250, repairType=FILTER },
	RogueMask =                                           { durability=250, repairType=FILTER },
	ClericMask =                                          { durability=250, repairType=FILTER },
	Hat_Rebreather =                                      { durability=250, repairType=FILTER },
	Mjill =                                               { durability=250, repairType=FILTER },	
	Hat_HalfMaskRespirator_Black =                        { durability=250, repairType=FILTER },
	Hat_HalfMaskRespirator_White =                        { durability=250, repairType=FILTER },
	Hat_HalfMaskRespiratorII_Black =                      { durability=250, repairType=FILTER },		
	Hat_HalfMaskRespiratorII_White =                      { durability=250, repairType=FILTER },
	Hat_TR2TacticalRespirator =                    		  { durability=400, repairType=FILTER },	
	CMWHelmet =                  					      { durability=120, repairType=CLOTH  },
	CMWOfficerHelmet =                  			      { durability=120, repairType=CLOTH  },
	slyyHat_PlagueDocMask =                  			  { durability=120, repairType=CLOTH  },
	
--- Surgical, dust and face masks ---
	Hat_SurgicalMask_Blue =                               { durability=120, repairType=WASH },
	Hat_SurgicalMask_Green =                              { durability=120, repairType=WASH },
	Hat_DustMask =                                        { durability=120, repairType=WASH },
	Hat_DisposableMask_White =                            { durability=120, repairType=WASH },
	Hat_DisposableMask_Black =                            { durability=120, repairType=WASH },        
	Hat_SpiffoMask_Black =                                { durability=120, repairType=WASH },    
	Hat_SpiffoMask_White =                                { durability=120, repairType=WASH },        
	Hat_SpiffoMask_Yellow =                               { durability=120, repairType=WASH },
	Hat_XMaskWhite =                                      { durability=120, repairType=WASH },    
	Hat_XMaskBlack =                                      { durability=120, repairType=WASH },    
	Hat_XMaskBlack_Red =                                  { durability=120, repairType=WASH },        
	Hat_SmileMaskYellow =                                 { durability=120, repairType=WASH },
	Hat_SmileMaskBlack =                                  { durability=120, repairType=WASH },    
	Hat_HalloweenMask1 =                                  { durability=120, repairType=WASH },    
	Hat_FaceMaskBlack =                                   { durability=120, repairType=WASH },        
	Hat_FaceMaskYellow =                                  { durability=120, repairType=WASH },
	Hat_FaceMaskNavy =                                    { durability=120, repairType=WASH },
	Hat_FaceMaskWhite =                                   { durability=120, repairType=WASH },    
	Hat_AdidasFaceMask_Black =                            { durability=120, repairType=WASH },    
	Hat_AdidasFaceMask_White =                            { durability=120, repairType=WASH },        
	Hat_WoodlandFaceMask =                                { durability=120, repairType=WASH },
	Hat_FaceMaskCatWhiskersBlack =                        { durability=120, repairType=WASH }, 	
	Hat_FaceMaskCatWhiskersPink =                         { durability=120, repairType=WASH },    
	Hat_FaceMaskCatWhiskersWhite =                        { durability=120, repairType=WASH },        
	Hat_FaceMaskJollyRoger =                              { durability=120, repairType=WASH },
	Hat_FaceMaskLeopardPrint =                            { durability=120, repairType=WASH }, 
	Hat_FaceMaskLeopardPrint2 =                        	  { durability=120, repairType=WASH },    
	Hat_FaceMaskRed =                        			  { durability=120, repairType=WASH }, 
		
--- Basic face covering helmets/headgear --- 
	Hat_CrashHelmetFULL =                                 { durability=90 },
	Hat_RiotHelmet =                                      { durability=90 },
	Hat_MilitaryHelmetRiot =                              { durability=90 },
	Hat_PoliceRiotHelmet =                                { durability=90 },
	Hat_SWATRiotHelmet2 =                                 { durability=90 },
	Hat_Antibombhelmet =                                  { durability=90 },
	WeldingMask =                                         { durability=90 },
	Hat_TagillaMask =                                     { durability=90 },
	Hat_TagillaMask2 =                                    { durability=90 },
	Hat_MotorcycleHelmet2 =                               { durability=90 },
	Hat_WelderMask2 =                                     { durability=90 },
	Shroud_Black =                                        { durability=90 },
	Full_Helmet_UN =                                      { durability=90 },
	Full_Helmet_Smiley =                                  { durability=90 },
	Hat_AuthenticCrashHelmetFULLDecalBobaFett =           { durability=90 },
	Hat_AuthenticCrashHelmetFULLEvelKnievel =             { durability=90 },
	Hat_AuthenticCrashHelmetFULLGreenDragon =             { durability=90 },
	Hat_AuthenticCrashHelmetFULLDecalKiss =               { durability=90 },
	Hat_AuthenticCrashHelmetFULLOptimus =                 { durability=90 },
	Hat_AuthenticCrashHelmetFULLPowerRangerRed    =       { durability=90 },
	Hat_AuthenticCrashHelmetFULLDecalShark =              { durability=90 },
	Hat_AuthenticCrashHelmetFULLDecalSnowLeopard =        { durability=90 },
	Hat_AuthenticCrashHelmetFULLDecalVenom =              { durability=90 },
	Hat_AuthenticCrashHelmetFULLDecalSimple =             { durability=90 },
	Hat_AuthenticCrashHelmetFULLRacing =                  { durability=90 },
	Hat_AuthenticCrashHelmetFULLTINT =                    { durability=90 },

--- Bandanas & cloth masks ---
	Hat_BandanaMask =                                     { durability=26, repairType=WASH },
	Hat_Balaclava_Swat =                                  { durability=26, repairType=WASH },
	Hat_PoliceBalaclava =                                 { durability=26, repairType=WASH },
	Hat_JasonSack =                                       { durability=26, repairType=WASH },
	Hat_LeatherFace    =                                  { durability=26, repairType=WASH },
	Hat_MichaelMyers =                                    { durability=26, repairType=WASH },
	Bandana_Clown =                                       { durability=26, repairType=WASH },
	Bandana_Mexico =                                      { durability=26, repairType=WASH },
	Bandana_Germany =                                     { durability=26, repairType=WASH },
	Bandana_USA =                                         { durability=26, repairType=WASH },
	Hat_BandanaMaskDesert =                               { durability=26, repairType=WASH },
	Hat_BandanaMaskRed =                                  { durability=26, repairType=WASH },
	SkullHalfMask =                                       { durability=26, repairType=WASH },
	Legion_Bandana_Black =                                { durability=26, repairType=WASH },
	Legion_Bandana_Red =                                  { durability=26, repairType=WASH },
	Legion_Bandana_Black_Ohio =                           { durability=26, repairType=WASH },
	Legion_Bandana_Red_Ohio =                             { durability=26, repairType=WASH },
	Legion_Bandana_Blue_Ohio =                            { durability=26, repairType=WASH },
	Hat_Shemagh =                                         { durability=26, repairType=WASH },
	Hat_ShemaghDesert =                                   { durability=26, repairType=WASH },
	Hat_ShemaghWoodland =                                 { durability=26, repairType=WASH },
	FaceMask			=                                 { durability=26, repairType=WASH },
	["StalkerArmorPack.FaceMask"]  =                      { durability=400, repairType=FILTER }, 	
	Hat_BandanaMaskTINT =                                 { durability=26, repairType=WASH, quality=1 },
	["Susceptible.ClothMask"] =                           { durability=26, repairType=WASH, quality=1 },

--- Not implemented ---
	Hat_GasMask_Improvised =                              { durability=24 },
	HCImprovisedgasmask =                                 { durability=24 },
	HCImprovisedhazmat =                                  { durability=24 },
    
--- Novelty masks & hats ---    
	Hat_Spiffo =                                       	  { durability=5 },
	Hat_TrueEyeCult =                                     { durability=5 },
	Hat_GhostFace =                                       { durability=5 },
	Hat_DRLegoHead =                                      { durability=5 },
	Hat_DeathMask =                                       { durability=5 },
    
}

function SusceptibleMaskItems.getMaskData(self, item)
	local itemType = item:getType();
	local modId = item:getModID();
	local fullItemId = modId.."."..itemType
	return self[fullItemId] or self[itemType];
end
