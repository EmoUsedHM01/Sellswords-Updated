::Mod_Sellswords.HooksMod.hook("scripts/ai/tactical/behaviors/ai_warcry", function ( q ) {

	q.m.PossibleSkills.extend([
		"actives.kuangzhanshinuhou",
		"actives.banner_wave",
		"actives.howl_player"
	])

});