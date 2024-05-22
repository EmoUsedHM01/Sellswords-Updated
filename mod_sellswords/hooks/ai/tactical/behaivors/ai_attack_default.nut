::Mod_Sellswords.HooksMod.hook("ai/tactical/behaviors/ai_attack_default", function ( q )
{
	q.m.PossibleSkills.extend([
		"actives.twinaxes_1",
		"actives.pseudohack",
		"actives.twincleavers_1",
		"actives.twincleavers_2",
		"actives.pseudomince",
		"actives.serrated_axe",
		"actives.crcudgel_skill",
		"actives.crdecapitate",
		"actives.crstrike",
	])	
});
