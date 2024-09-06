::Mod_Sellswords.HooksMod.hook("scripts/skills/traits/legend_rotten_flesh_trait", function( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.Icon = "ui/traits/necro_rotten_flesh.png";
	}

	q.onAdded = @(__original) function()
	{
		__original();

		local actor = this.getContainer.getActor();

		if (actor.getSkills().getSkillByID("actives.hand_to_hand"))
			actor.getSkills().removeByID("actives.hand_to_hand");

		if (!actor.getSkills().getSkillByID("actives.zombie_bite"))
			actor.getSkills().add(this.new("scripts/skills/actives/zombie_bite"));
	}


});