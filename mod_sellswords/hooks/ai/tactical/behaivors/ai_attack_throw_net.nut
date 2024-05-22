::mods_hookExactClass("ai/tactical/behaviors/ai_attack_throw_net", function(o) {
	o.m.PossibleSkills.extend([
		"actives.throw_human_holy_water",
		"actives.throw_acid_flask",
		"actives.throw_net_free",	
	])
})