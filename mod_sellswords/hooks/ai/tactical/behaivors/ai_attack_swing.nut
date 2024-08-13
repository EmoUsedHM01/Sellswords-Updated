::Mod_Sellswords.HooksMod.hook("scripts/ai/tactical/behaviors/ai_attack_swing", function ( q ) {

	q.m.PossibleSkills.extend([
		"actives.twinaxes_2",
		"actives.cr_overwhelm_attack",
		"actives.crstaff_sweep",
		"actives.ssu_bone_cleaver_swing"
	])

});