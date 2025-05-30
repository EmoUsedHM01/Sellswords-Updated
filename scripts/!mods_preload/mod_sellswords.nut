::Mod_Sellswords <- {
	ID = "mod_sellswords",
	Name = "Sellswords Updated",
	Version = "8.4.7",
	EnableEnemySS = true,
	KeepSpawningEnemySS = false,
	SellswordStrengthMultiplier = 100,
	EnableHostileSequences = true,
	SellswordsPerk = "Student"
};

::Mod_Sellswords.HooksMod <- ::Hooks.register(::Mod_Sellswords.ID, ::Mod_Sellswords.Version, ::Mod_Sellswords.Name);

// Both the "require" and "conflictWith" functions have an adaptive number of parameters, so you can add as many as you want
// Add which mods are needed to run this one
::Mod_Sellswords.HooksMod.require("mod_msu >= 1.2.6", "mod_modern_hooks >= 0.5.4", "mod_legends>= 19.0.0");

// Use this to list which mods may causes conflicts
::Mod_Sellswords.HooksMod.conflictWith("mod_ROTU", "mod_fantasybro", "modMoreArrows", "mod_background_perks");

// Like above you can add as many parameters as you need to in order to determine the queue of the mods before adding the parameters that run the callback function
::Mod_Sellswords.HooksMod.queue(">mod_msu", ">mod_legends", ">mod_legends_PTR", ">mod_breditor", "<mod_AC", "<mod_nggh_magic_concept", "<mod_world_editor_legends", function()
{
	// Define mod class of this mod
	::Mod_Sellswords.Mod <- ::MSU.Class.Mod(::Mod_Sellswords.ID, ::Mod_Sellswords.Version, ::Mod_Sellswords.Name);

	// Register the updates with MSU so people know to update
	::Mod_Sellswords.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.GitHub, "https://github.com/EmoUsedHM01/Sellswords-Updated");
	// Add the GitHub api, make sure to use semantic versioning for release tags
	::Mod_Sellswords.Mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.GitHub);

	// Add NexusMods mod source
	// ::Mod_Sellswords.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.NexusMods, "https://www.nexusmods.com/battlebrothers/mods/");
	// But the NexusMods api is closed so don't actually
	//::Mod_Sellswords.Mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.NexusMods);

	// MSU config page
	local page = ::Mod_Sellswords.Mod.ModSettings.addPage("General");
	local settingSellswordsEnable = page.addEnumSetting(
		"SellswordsSpawn",
		"Enabled until destroyed",
		["Enabled", "Enabled until destroyed", "Disabled"],
		"Enable hostile Sellswords",
		"Enabled - there will be roaming groups of hostile Sellsword companies,\n\nEnabled until destroyed - there will be roaming groups of hostile Sellsword companies, but these parties will stop spawning once you defeat the Legendary Company Tower location,\n\nDisabled - standard non-hostile mercenary parties will spawn."
	);
	local settingSellswordStrengthMultiplier = page.addRangeSetting(
		"SellswordStrengthMultiplier",
		100, 10, 300, 10.0,
		"Sellsword Strength Multiplier %",
		"Affects the CR rating of the hostile SS faction, only affects new spawns, not existing parties."
	);
	page.addDivider("divider_sequences");
	local settingEnableHostileSequences = page.addBooleanSetting(
		"EnableHostileSequences",
		true,
		"Enable Hostile Sequences",
		"When enabled, enemies have a low chance to roll with Sequences. If they do, then they also have a chance to drop whichever one they obtain."
	);
	page.addDivider("divider_perks");
	local settingSellswordsPerk = page.addEnumSetting(
		"SellswordsPerk",
		"Student",
		["Back to Basics", "Backstabber", "Berserker", "Dodge", "Escape Artist", "Footwork", "Fortified Mind", "Mind Over Body", "Nine Lives", "Pathfinder", "Quick Hands", "Rotation", "Steel Brow", "Student", "Thrives in Chaos", "Underdog"],
		"Sellsword Scenario Perk",
		"Choose a company perk to be added when you recruit a bro for the Sellswords Scenario.\n\nStudent by default."
	);

	// Settings for that config 
	settingSellswordsEnable.addCallback(function(_value) {
		if (_value == "Disabled") {
			::Mod_Sellswords.EnableEnemySS = false;
			::Mod_Sellswords.KeepSpawningEnemySS = false;
		} else if (_value == "Enabled") {
			::Mod_Sellswords.EnableEnemySS = true;
			::Mod_Sellswords.KeepSpawningEnemySS = true;
		} else {
			::Mod_Sellswords.EnableEnemySS = true;
			::Mod_Sellswords.KeepSpawningEnemySS = false;
		}
	});
	settingSellswordStrengthMultiplier.addCallback(function(_value) { ::Mod_Sellswords.SellswordStrengthMultiplier = _value; });
	settingEnableHostileSequences.addCallback(function(_value) { ::Mod_Sellswords.EnableHostileSequences = _value; });
	settingSellswordsPerk.addCallback(function(_value) { ::Mod_Sellswords.SellswordsPerk = _value; });

	// Important objects for compatibility purposes
	if (!("Is_PTR_Exist" in this.getroottable())) ::Is_PTR_Exist <- ::mods_getRegisteredMod("mod_legends_PTR") != null;
	if (!("Is_AC_Exist" in this.getroottable())) ::Is_AC_Exist <- ::mods_getRegisteredMod("mod_AC") != null;
	if (!("Is_MC_Exist" in this.getroottable())) ::Is_MC_Exist <- ::mods_getRegisteredMod("mod_nggh_magic_concept") != null;
	if (!("Is_BR_Exist" in this.getroottable())) ::Is_BR_Exist <- ::mods_getRegisteredMod("mod_breditor") != null;

	// Load hook files
	::include("mod_sellswords/load.nut");
}, ::Hooks.QueueBucket.Normal);