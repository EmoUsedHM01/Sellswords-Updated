::Mod_Sellswords.HooksMod.hook("scripts/ai/tactical/behaviors/ai_attack_swing", function ( q ) {

	q.m.PossibleSkills.extend([
		"actives.ssu_overwhelm_attack",
		"actives.ssu_staff_sweep",
		"actives.ssu_bone_cleaver_swing"
	])

});