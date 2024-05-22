::mods_hookExactClass("ai/tactical/behaviors/ai_attack_split", function ( o )
{
	o.m.PossibleSkills.extend([
		"actives.jab",
		"actives.cr_overwhelm_attack"
	]);
});