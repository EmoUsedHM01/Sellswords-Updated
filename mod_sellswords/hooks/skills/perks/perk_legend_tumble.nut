::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_tumble", function ( q ) {

	q.m.Skills.extend([
		"actives.legend_sprint_skill_3",
		"actives.legend_sprint_skill_5",
		"actives.legend_evasion",
		"actives.zcr_charge"
	]);

});