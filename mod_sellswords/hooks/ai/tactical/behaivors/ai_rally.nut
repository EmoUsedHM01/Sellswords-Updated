::Mod_Sellswords.HooksMod.hook("ai/tactical/behaviors/ai_rally", function ( q )
{
	q.m.PossibleSkills.push("actives.banner_wave");
});
