::Mod_Sellswords.HooksMod.hook("scripts/ai/tactical/behaviors/ai_attack_default", function ( q ) {

	q.m.PossibleSkills.extend([
		"actives.twinaxes_1",
		"actives.twincleavers_1",
		"actives.twincleavers_2",
		"actives.serrated_axe",
		"actives.crcudgel_skill",
		"actives.crdecapitate",
		"actives.crstrike",
		"actives.earth_hammer_smite",
		"actives.ssu_bone_cleaver_slash",
		"actives.ssu_bone_cleaver_flurry",
		"actives.ssu_ghost_spear_strike"
	])

});