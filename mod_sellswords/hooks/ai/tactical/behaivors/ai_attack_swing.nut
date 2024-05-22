::mods_hookExactClass("ai/tactical/behaviors/ai_attack_swing", function ( o )
{
	o.m.PossibleSkills.extend([
		"actives.twinaxes_2",
		"actives.cr_overwhelm_attack"
		"actives.crstaff_sweep"
	])
});