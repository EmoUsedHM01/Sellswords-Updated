::Mod_Sellswords.HooksMod.hook("scripts/ai/tactical/behaviors/ai_attack_split", function ( q )
{
	q.m.PossibleSkills.extend([
		"actives.jab",
		"actives.cr_overwhelm_attack"
	]);
});
