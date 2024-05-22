::Mod_Sellswords.HooksMod.hook("ai/tactical/behaviors/ai_boost_morale", function ( q )
{
	q.m.PossibleSkills.push("actives.crwhip");	
});
