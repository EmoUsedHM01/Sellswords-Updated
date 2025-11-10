::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/legend_pie_effect", function ( q ) {
	::Mod_Sellswords.HookHelper.hookNewEatFoodEffectSystem(q);

	q.getDescription = @(__original) function()
	{
		return "Thanks to eating food, this character regains Health, Fatigue, Resolve and Initiative for [color=%positive%]" + this.m.TurnsLeft + "[/color] turn(s). ";
	}

	q.getTooltip = @(__original) function()
	{
		local rate = this.Math.max(1, this.Math.ceil(this.m.Amount / 8));
		local crate = this.Math.ceil(1.5 * rate);		
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
				icon = "ui/icons/fatigue.png",
				text = "On self, will recovers fatigue by [color=%positive%]" + crate + "[/color] per turn for ten turns"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "On self, will increase [color=%positive%]" + rate + "[/color] Initiative for ten turns"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "On self, will increase [color=%positive%]" + rate + "[/color] Melee Skill for ten turns"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "On self, will increase [color=%positive%]" + rate + "[/color] Ranged Skill for ten turns"
			}
		];
		return ret;
	}

	q.onUpdate = @(__original) function( _properties )
	{
		local rate = this.Math.max(1, this.Math.ceil(this.m.Amount / 8));
		local crate = this.Math.ceil(1.5 * rate);		
		_properties.FatigueRecoveryRate += crate;
		_properties.Initiative += rate;
		_properties.MeleeSkill += rate;
		_properties.RangedSkill += rate;	
	}

	q.onTurnEnd = @(__original) function()
	{
		local rate = this.Math.max(1, this.Math.ceil(this.m.Amount / 8));
		local crate = this.Math.ceil(1.5 * rate);		
		local actor = this.getContainer().getActor();
		actor.setHitpoints(this.Math.min(actor.getHitpointsMax(), actor.getHitpoints() + 0 * crate));

		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}
});
