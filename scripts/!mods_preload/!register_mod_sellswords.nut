::Mod_Sellswords <- {
	ID = "mod_sellswords",
	Name = "Sellswords Updated",
	Version = "6.4.13",
	EnableEnemySS = true,
	SellswordStrengthMultiplier = 100
};

::mods_registerMod(::Mod_Sellswords.ID, ::Mod_Sellswords.Version, ::Mod_Sellswords.Name);
::mods_queue(::Mod_Sellswords.ID, "mod_legends(>=18.1.0), mod_msu(>=1.2.4),>mod_legends_PTR(>=2.2.1), <mod_AC, <mod_nggh_magic_concept, <mod_world_editor_legends, >mod_breditor", function()
{
	// define mod class of this mod
	::Mod_Sellswords.Mod <- ::MSU.Class.Mod(::Mod_Sellswords.ID, ::Mod_Sellswords.Version, ::Mod_Sellswords.Name);
	
	// add GitHub mod source
	::Mod_Sellswords.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.GitHub, "https://github.com/EmoUsedHM01/Sellswords-Updated");
	::Mod_Sellswords.Mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.GitHub);

	// add NexusMods mod source 
	// ::Mod_Sellswords.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.NexusMods, "https://www.nexusmods.com/battlebrothers/mods/");
	// NexusMods api is closed
	//::Mod_Sellswords.Mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.NexusMods);
	
	// MSU config page
	local page = ::Mod_Sellswords.Mod.ModSettings.addPage("General");
	local settingEnableEnemySS = page.addBooleanSetting("EnableHostileSellswords", true, "Enable Hostile Sellswords", "When enabled, there will be roaming groups of hostile Sellsword companies, these parties will stop spawning once you defeat the Legendary Company Tower location.");
	local settingSellswordStrengthMultiplier = page.addRangeSetting("SellswordStrengthMultiplier", 100, 10, 300, 10.0, "Sellsword Strength Multiplier %", "Affects the CR rating of the hostile SS faction, only affects new spawns, not existing parties.");
	
	settingEnableEnemySS.addCallback(function(_value) { ::Mod_Sellswords.EnableEnemySS = _value; });
	settingSellswordStrengthMultiplier.addCallback(function(_value) { ::Mod_Sellswords.SellswordStrengthMultiplier = _value; });

	// important consts and objects
	if (!("Is_PTR_Exist" in this.getroottable())) ::Is_PTR_Exist <- ::mods_getRegisteredMod("mod_legends_PTR") != null;
	if (!("Is_AC_Exist" in this.getroottable())) ::Is_AC_Exist <- ::mods_getRegisteredMod("mod_AC") != null;
	if (!("Is_MC_Exist" in this.getroottable())) ::Is_MC_Exist <- ::mods_getRegisteredMod("mod_nggh_magic_concept") != null;
	if (!("Is_BR_Exist" in this.getroottable())) ::Is_BR_Exist <- ::mods_getRegisteredMod("mod_breditor") != null;

	// load hook files
	::include("mod_sellswords/load.nut");
});