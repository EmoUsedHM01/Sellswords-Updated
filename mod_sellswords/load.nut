// load the hook helper
::include("mod_sellswords/hook_helper.nut")
// all folders below must be loaded in that order

// load the config folder which contains new Const added by this mod 
foreach (file in ::IO.enumerateFiles("mod_sellswords/config"))
	::include(file);

// load all hooks related to vanilla and legends
foreach (file in ::IO.enumerateFiles("mod_sellswords/hooks"))
	::include(file);

// load all hooks related to ptr 
if (::Is_PTR_Exist)
	foreach (file in ::IO.enumerateFiles("mod_sellswords/hooks_ptr"))
		::include(file);

// load all hooks related to breditor
if (::Is_BR_Exist)
{
	foreach (file in ::IO.enumerateFiles("mod_sellswords/hooks_breditor"))
		::include(file);

	::mods_registerJS("mod_ssu_breditor_add_on.js");

	if (::Is_MC_Exist)
		::mods_registerJS("mod_nggh_breditor_add_on.js");

	if (::Is_PTR_Exist)
		::mods_registerJS("mod_ptr_breditor_add_on.js");

	if (::Is_PTR_Exist && ::Is_MC_Exist)
		::mods_registerJS("mod_ptr_and_nggh_breditor_add_on.js");
}

// update the perk tooltips
::Const.Perks.updatePerkGroupTooltips();

// update new armor sets
::Const.LegendMod.Armors <- {};
foreach( i, v in ::Const.LegendMod.ArmorObjs )
	::Const.LegendMod.Armors[v.ID] <- v;

// update new helmet sets
::Const.LegendMod.Helmets <- {};
foreach( i, v in ::Const.LegendMod.HelmObjs )
	::Const.LegendMod.Helmets[v.ID] <- v;