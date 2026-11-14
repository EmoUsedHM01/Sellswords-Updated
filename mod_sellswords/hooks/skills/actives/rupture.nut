::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/rupture", function ( q ) {

	q.onAfterUpdate = @( __original ) function( _properties)
	{
		__original(_properties);
		local actor = this.getContainer().getActor().get();
		if (actor.getSkills().getSkillByID("perk.ssu_grandslam"))
			this.m.ActionPointCost += 1;
	}

});