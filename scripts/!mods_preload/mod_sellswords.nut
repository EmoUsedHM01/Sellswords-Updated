::Mod_Sellswords <- {
	ID = "mod_sellswords",
	Name = "Sellswords Updated",
	Version = "9.0.0",
	EnableEnemySS = true,
	KeepSpawningEnemySS = false,
	SellswordStrengthMultiplier = 100,
	EnableHostileSequences = true,
	SellswordsPerk = "Student",
	AllLootDrops = false,
	DualWieldVisuals = true,
	AutoLevel = false
};

::Mod_Sellswords.HooksMod <- ::Hooks.register(::Mod_Sellswords.ID, ::Mod_Sellswords.Version, ::Mod_Sellswords.Name);

::Mod_Sellswords.HooksMod.require("mod_msu >= 1.9.0", "mod_modern_hooks >= 0.5.4", "mod_legends >= 19.5.0-alpha1");
::Mod_Sellswords.HooksMod.conflictWith("mod_ROTU", "mod_fantasybro", "modMoreArrows", "mod_background_perks");

::Mod_Sellswords.HooksMod.queue(">mod_msu", ">mod_legends", ">mod_breditor", "<mod_ACU", "<mod_world_editor_legends", function()
{
	::Mod_Sellswords.Mod <- ::MSU.Class.Mod(::Mod_Sellswords.ID, ::Mod_Sellswords.Version, ::Mod_Sellswords.Name);
	::Mod_Sellswords.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.GitHub, "https://github.com/EmoUsedHM01/Sellswords-Updated");
	::Mod_Sellswords.Mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.GitHub);

	// the texts are loaded first, the settings below read their names and descriptions from them
	::include("mod_sellswords/strings.nut");

	// MSU config page
	local page = ::Mod_Sellswords.Mod.ModSettings.addPage("General");
	local settingSellswordsEnable = page.addEnumSetting(
		"SellswordsSpawn",
		"Enabled until destroyed",
		["Enabled", "Enabled until destroyed", "Disabled"],
		::Mod_Sellswords.Strings.mod_sellswords.SellswordsSpawn.Name,
		::Mod_Sellswords.Strings.mod_sellswords.SellswordsSpawn.Description
	);
	local settingSellswordStrengthMultiplier = page.addRangeSetting(
		"SellswordStrengthMultiplier",
		100, 10, 300, 10.0,
		::Mod_Sellswords.Strings.mod_sellswords.SellswordStrengthMultiplier.Name,
		::Mod_Sellswords.Strings.mod_sellswords.SellswordStrengthMultiplier.Description
	);
	page.addDivider("divider_sequences");
	local settingEnableHostileSequences = page.addBooleanSetting(
		"EnableHostileSequences",
		true,
		::Mod_Sellswords.Strings.mod_sellswords.EnableHostileSequences.Name,
		::Mod_Sellswords.Strings.mod_sellswords.EnableHostileSequences.Description
	);
	page.addDivider("divider_perks");
	local settingSellswordsPerk = page.addEnumSetting(
		"SellswordsPerk",
		"Student",
		["Back to Basics", "Backstabber", "Berserker", "Dodge", "Escape Artist", "Fortified Mind", "Mind Over Body", "Nine Lives", "Pathfinder", "Quick Hands", "Steel Brow", "Student", "Tactical Maneuvers", "Thrives in Chaos", "Underdog"],
		::Mod_Sellswords.Strings.mod_sellswords.SellswordsPerk.Name,
		::Mod_Sellswords.Strings.mod_sellswords.SellswordsPerk.Description
	);
	page.addDivider("divider_loot");
	local settingAllLootDrops = page.addBooleanSetting(
		"AllLootDrops",
		false,
		::Mod_Sellswords.Strings.mod_sellswords.AllLootDrops.Name,
		::Mod_Sellswords.Strings.mod_sellswords.AllLootDrops.Description
	);
	page.addDivider("divider_visuals");
	local settingDualWieldVisuals = page.addBooleanSetting(
		"DualWieldVisuals",
		true,
		::Mod_Sellswords.Strings.mod_sellswords.DualWieldVisuals.Name,
		::Mod_Sellswords.Strings.mod_sellswords.DualWieldVisuals.Description
	);
	page.addDivider("divider_levels");
	local settingAutoLevel = page.addBooleanSetting(
		"AutoLevel",
		false,
		::Mod_Sellswords.Strings.mod_sellswords.AutoLevel.Name,
		::Mod_Sellswords.Strings.mod_sellswords.AutoLevel.Description
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
	settingAllLootDrops.addCallback(function(_value) { ::Mod_Sellswords.AllLootDrops = _value; });
	settingAutoLevel.addCallback(function(_value) { ::Mod_Sellswords.AutoLevel = _value; });
	settingDualWieldVisuals.addCallback(function(_value) {
		::Mod_Sellswords.DualWieldVisuals = _value;

		if (!::MSU.Utils.hasState("world_state"))
			return;

		foreach (bro in ::World.getPlayerRoster().getAll())
		{
			if (bro.hasSprite("shield_icon") && ::Legends.Weapons.isDualWielding(bro))
				bro.flipOffhandSprite();
		}
	});

	if (!("Is_AC_Exist" in this.getroottable())) ::Is_AC_Exist <- ::mods_getRegisteredMod("mod_ACU") != null;
	if (!("Is_BR_Exist" in this.getroottable())) ::Is_BR_Exist <- ::IO.enumerateFiles("scripts/ui/screens/world/").find("scripts/ui/screens/world/world_breditor_screen") != null;

	::Hooks.registerLateJS("ui/mods/mod_sellswords/ssu_auto_level.js");

	::include("mod_sellswords/load.nut");
}, ::Hooks.QueueBucket.Normal);
