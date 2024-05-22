::Mod_Sellswords.HooksMod.hook("ai/tactical/behaviors/ai_attack_bow", function ( q )
{
	q.m.PossibleSkills.push("actives.legend_piercing_bolt");	
});
