::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/legend_porridge_effect", function ( q ) {
	::Mod_Sellswords.HookHelper.hookNewEatFoodEffectSystem(q);

	q.getDescription = @(__original) function()
	{
		return "Thanks to eating food, this character increase all combat attributes for [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.TurnsLeft + "[/color] turn(s). ";
	}

	q.getTooltip = @(__original) function()
	{
		local rate = this.Math.max(1, this.Math.floor(this.m.Amount / 8));
		local turns = this.m.TurnsLeft;
		local title = this.getName();
		local actor = this.getContainer().getActor();

		if (actor != null)
		{
			local stuffed = actor.getSkills().getSkillByID("effects.legend_stuffed_effect");

			if (stuffed != null)
			{
				title = "Stuffed";
				rate = rate;
				local sick = actor.getSkills().getSkillByID("injury.sickness");

				if (sick != null)
				{
					title = "Overate";
				}
			}
		}

		local ret = [
			{
				id = 1,
				type = "title",
				text = title
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "On self, will restore [color=" + this.Const.UI.Color.PositiveValue + "]" + rate + "[/color] Health per turn for ten turns"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "On self, recovers fatigue by [color=" + this.Const.UI.Color.PositiveValue + "]" + rate + "[/color] per turn for ten turns"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "On self, will increase [color=" + this.Const.UI.Color.PositiveValue + "]" + rate + "[/color] Skill for ten turns"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "On self, will increase [color=" + this.Const.UI.Color.PositiveValue + "]" + rate + "[/color] Defenses for ten turns"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "On self, will increase [color=" + this.Const.UI.Color.PositiveValue + "]" + rate + "[/color] Resolve for ten turns"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "On self, will increase [color=" + this.Const.UI.Color.PositiveValue + "]" + rate + "[/color] Initiative for ten turns"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "On self, will increase [color=" + this.Const.UI.Color.PositiveValue + "]" + 2 * rate + "%[/color] Damage for ten turns"
			}				
		];
		return ret;
	}

	q.onAfterUpdate <- function( _properties )
	{
		local rate = this.Math.max(1, this.Math.floor(this.m.Amount / 8));
		_properties.DamageTotalMult *= (1 + 0.02 * rate);		
		_properties.FatigueRecoveryRate += rate;
		_properties.MeleeSkill += rate;
		_properties.RangedSkill += rate;
		_properties.MeleeDefense += rate;
		_properties.RangedDefense += rate;
		_properties.Bravery += rate;
		_properties.Initiative += rate;	
	}

	q.onTurnEnd = @(__original) function()
	{
		local rate = this.Math.max(1, this.Math.floor(this.m.Amount / 8));
		local actor = this.getContainer().getActor();
		actor.setHitpoints(this.Math.min(actor.getHitpointsMax(), actor.getHitpoints() + rate));

		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}
});
