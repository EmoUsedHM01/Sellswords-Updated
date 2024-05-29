::Mod_Sellswords.HooksMod.hook("scripts/ai/tactical/behaviors/ai_rally", function ( q ) {

	q.m.PossibleSkills.push("actives.banner_wave");
});
