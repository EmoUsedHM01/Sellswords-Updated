// load every text first so the rest of the mod can read it
::include("mod_sellswords/strings.nut");

// load the hook helper
::include("mod_sellswords/hook_helper.nut");
// all folders below must be loaded in that order

// load the config folder which contains new Const added by this mod 
foreach (file in ::IO.enumerateFiles("mod_sellswords/config"))
	::include(file);

// load all hooks related to vanilla and legends
foreach (file in ::IO.enumerateFiles("mod_sellswords/hooks"))
	::include(file);

// load all hooks related to breditor
if (::Is_BR_Exist)
{
	foreach (file in ::IO.enumerateFiles("mod_sellswords/hooks_breditor"))
		::include(file);
}

// load all hooks related to Of Flesh and Faith+
if (::mods_getRegisteredMod("of_flesh_and_faith_plus") != null)
{
	foreach (file in ::IO.enumerateFiles("mod_sellswords/hooks_offplus"))
		::include(file);
}

// update new armor sets
::Const.LegendMod.Armors <- {};
foreach( i, v in ::Const.LegendMod.ArmorObjs )
	::Const.LegendMod.Armors[v.ID] <- v;

// update new helmet sets
::Const.LegendMod.Helmets <- {};
foreach( i, v in ::Const.LegendMod.HelmObjs )
	::Const.LegendMod.Helmets[v.ID] <- v;