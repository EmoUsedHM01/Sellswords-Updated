::Mod_Sellswords.HooksMod.hook("scripts/ai/tactical/behaviors/ai_warcry", function ( q ) {

	q.m.PossibleSkills.extend([
		"actives.ssu_berserker_roar",
		"actives.ssu_banner_wave",
		"actives.ssu_howl_player"
	])

});