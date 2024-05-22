::Mod_Sellswords.HooksMod.hook("ai/tactical/behaviors/ai_attack_swing", function ( q )
{
	q.m.PossibleSkills.extend([
		"actives.twinaxes_2",
		"actives.cr_overwhelm_attack"
		"actives.crstaff_sweep"
	])
});
