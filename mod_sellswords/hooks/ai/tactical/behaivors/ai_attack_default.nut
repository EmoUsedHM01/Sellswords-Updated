::mods_hookExactClass("ai/tactical/behaviors/ai_attack_default", function ( o )
{
	o.m.PossibleSkills.extend([
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