::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/stunned_effect", function ( q ) {

	q.getTooltip <- function()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-35%[/color] Melee Defense"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-35%[/color] Ranged Defense"
			}
		];
	}		
	q.onAdded = @(__original) function()
	{
		local skill = this.getContainer().getSkillByID("effects.shieldwall");
		local steel = this.getContainer().getSkillByID("perk.steel_brow");

		if (steel != null)
		{
			if (this.getContainer().getActor().getTile().IsVisibleForPlayer)
			{
				this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " resists the Stun with " + steel.getName() + " and is Dazed instead.");
			}

			this.removeSelf();
			this.getContainer().add(this.new("scripts/skills/effects/dazed_effect"));
			return;
		}

		if (skill == null)
		{
			skill = this.getContainer().getSkillByID("effects.legend_fortify");
		}

		if (skill != null)
		{
			if (this.getContainer().getActor().getTile().IsVisibleForPlayer)
			{
				this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " shakes off the stun but loses " + skill.getName());
			}
			if (!this.m.Container.getActor().getCurrentProperties().IsImmuneToStun)
			{
				skill.removeSelf();
			}
			this.removeSelf();
			return;
		}

		local statusResisted = this.getContainer().getActor().getCurrentProperties().IsResistantToAnyStatuses ? this.Math.rand(1, 100) <= 50 : false;
		statusResisted = statusResisted || this.getContainer().getActor().getCurrentProperties().IsResistantToPhysicalStatuses ? this.Math.rand(1, 100) <= 33 : false;
		local crrd = this.getContainer().hasSkill("perk.crrangeddefense") ? this.Math.rand(1, 100) <= this.getContainer().getActor().getBaseProperties().RangedDefense : false;

		if (statusResisted || crrd)
		{
			if (!this.getContainer().getActor().isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " shook off being stunned thanks to his unnatural physiology");
			}

			this.removeSelf();
		}
		else if (!this.m.Container.getActor().getCurrentProperties().IsImmuneToStun)
		{
			//this.m.Container.removeByID("effects.shieldwall");
			this.m.Container.removeByID("effects.spearwall");
			this.m.Container.removeByID("effects.riposte");
			this.m.Container.removeByID("effects.return_favor");
			this.m.Container.removeByID("effects.possessed_undead");
			this.m.Container.removeByID("effects.legend_vala_currently_chanting");
			this.m.Container.removeByID("effects.legend_vala_in_trance");
			//this.m.Container.removeByID("effects.legend_fortify");
		}
		else
		{
			this.m.IsGarbage = true;
		}
	};

	q.onUpdate = @(__original) function( _properties )
	{
		__original(_properties);
		if (this.getContainer().hasSkill("perk.crresilient"))
		{
			_properties.MeleeDefenseMult *= 0.74;
			_properties.RangedDefenseMult *= 0.74;
		}
		else
		{
			_properties.MeleeDefenseMult *= 0.65;
			_properties.RangedDefenseMult *= 0.65;
		}
	}		
});
