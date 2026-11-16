::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/legend_dual_wielding_effect", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		// the skills of the united Bloodfang Twinblades already use both blades, so they get no follow-up attack and no off hand penalty
		this.m.ExcludedSkills.extend([
			"actives.ssu_bone_cleaver_slash",
			"actives.ssu_bone_cleaver_flurry",
			"actives.ssu_bone_cleaver_swing"
		]);
	}

});
