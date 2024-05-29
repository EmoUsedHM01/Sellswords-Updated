::Mod_Sellswords.HooksMod.hook("scripts/ai/tactical/behaviors/ai_attack_throw_net", function ( q ) {

	q.m.PossibleSkills.extend([
		"actives.throw_human_holy_water",
		"actives.throw_acid_flask",
		"actives.throw_net_free",	
	])
});