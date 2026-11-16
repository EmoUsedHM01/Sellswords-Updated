::Mod_Sellswords.HooksMod.hook("scripts/ai/tactical/behaviors/ai_attack_default", function ( q ) {

	q.m.PossibleSkills.extend([
		"actives.ssu_strike",
		"actives.ssu_earth_hammer_smite",
		"actives.ssu_bone_cleaver_slash",
		"actives.ssu_bone_cleaver_flurry",
		"actives.ssu_ghost_spear_strike"
	])

});