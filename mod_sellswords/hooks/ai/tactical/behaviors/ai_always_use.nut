::Mod_Sellswords.HooksMod.hook("scripts/ai/tactical/behaviors/ai_always_use", function ( q ) {

	q.m.PossibleSkills.extend([
		"actives.ssu_necro_ghost_collect_fragment"
	])

});