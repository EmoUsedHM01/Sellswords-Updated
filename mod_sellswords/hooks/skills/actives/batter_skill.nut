::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/batter_skill", function ( q ) {

	q.onAfterUpdate = @( __original ) function( _properties)
	{
		__original(_properties);
		this.m.ActionPointCost = _properties.IsSpecializedInPolearms ? 5 : 6;

		local actor = this.getContainer().getActor().get();
		if (actor.getSkills().getSkillByID("perk.crGrandslam"))
			this.m.ActionPointCost += 1;
	}

});