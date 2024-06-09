::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/legend_rations_effect", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.Amount = amount;
		this.m.TurnsLeft = turnLeft;
		this.m.Icon = "skills/status_effect_93.png";
		this.m.IconMini = "status_effect_93_mini";
		this.m.Overlay = "status_effect_93";
	}

	q.getDescription = @(__original) function()
	{
		return "Thanks to eating food, this character regains Health, Fatigue, Resolve and Initiative for [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.TurnsLeft + "[/color] turn(s). ";
	}

	q.getTooltip = @(__original) function()
	{
		local rate = this.Math.max(1, this.Math.ceil(this.m.Amount / 8));
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
				icon = "ui/icons/bravery.png",
				text = "On self, will increase [color=" + this.Const.UI.Color.PositiveValue + "]" + rate + "[/color] Resolve for ten turns"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "On self, will increase [color=" + this.Const.UI.Color.PositiveValue + "]" + rate + "[/color] Initiative for ten turns"
			}
		];
		return ret;
	}

	q.onUpdate = @(__original) function( _properties )
	{
		local rate = this.Math.max(1, this.Math.ceil(this.m.Amount / 8));
		_properties.FatigueRecoveryRate += rate;
		_properties.Bravery += rate;
		_properties.Initiative += rate;		
	}

	q.onTurnEnd = @(__original) function()
	{
		local rate = this.Math.max(1, this.Math.ceil(this.m.Amount / 8));
		local actor = this.getContainer().getActor();
		actor.setHitpoints(this.Math.min(actor.getHitpointsMax(), actor.getHitpoints() + rate));

		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}
});
