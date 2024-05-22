this.perk_crNavigator <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.crNavigator";
		this.m.Name = this.Const.Strings.PerkName.crNavigator;
		this.m.Description = this.Const.Strings.PerkDescription.crNavigator;
		this.m.Icon = "ui/perks/crNavigator.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTurnStart()
	{
		if (!this.getContainer().getActor().isEngagedInMelee())
		{
			local myTile = this.getContainer().getActor().getTile();
			for (local i = 0; i < 6; i++)
			{
				if (myTile.hasNextTile(i))
				{
					local nextTile = myTile.getNextTile(i);
					if (nextTile.IsOccupiedByActor)
					{
						if (nextTile.getEntity().getFaction() == this.getContainer().getActor().getFaction() && !nextTile.getEntity().getSkills().hasSkill("effects.legend_steps_guided"))
						{
							nextTile.getEntity().getSkills().add(this.new("scripts/skills/effects/legend_steps_guided_temp"));							
						}
					}
				}
			}
		}
	}
	
	function onTurnEnd()
	{
		if (!this.getContainer().getActor().isEngagedInMelee())
		{
			local myTile = this.getContainer().getActor().getTile();
			for (local i = 0; i < 6; i++)
			{
				if (myTile.hasNextTile(i))
				{
					local nextTile = myTile.getNextTile(i);
					if (nextTile.IsOccupiedByActor)
					{
						if (nextTile.getEntity().getFaction() == this.getContainer().getActor().getFaction() && !nextTile.getEntity().getSkills().hasSkill("effects.legend_steps_guided"))
						{
							nextTile.getEntity().getSkills().add(this.new("scripts/skills/effects/legend_steps_guided_temp"));							
						}
					}
				}
			}
		}
	}
});
