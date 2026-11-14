::Mod_Sellswords.HooksMod.hook("scripts/ai/tactical/behaviors/ai_attack_split", function ( q ) {

	q.m.PossibleSkills.extend([
		"actives.ssu_jab",
		"actives.ssu_overwhelm_attack"
	]);
});
