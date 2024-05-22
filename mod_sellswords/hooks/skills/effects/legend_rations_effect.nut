::mods_hookExactClass("skills/effects/legend_rations_effect", function(o) {
	::Mod_Sellswords.HookHelper.hookNewEatFoodEffectSystem(o);

	o.getDescription = function()
	{
		return "Thanks to eating food, this character regains Health, Fatigue, Resolve and Initiative for [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.TurnsLeft + "[/color] turn(s). ";
	}

	o.getTooltip = function()
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

	o.onUpdate = function( _properties )
	{
		local rate = this.Math.max(1, this.Math.ceil(this.m.Amount / 8));
		_properties.FatigueRecoveryRate += rate;
		_properties.Bravery += rate;
		_properties.Initiative += rate;		
	}

	o.onTurnEnd = function()
	{
		local rate = this.Math.max(1, this.Math.ceil(this.m.Amount / 8));
		local actor = this.getContainer().getActor();
		actor.setHitpoints(this.Math.min(actor.getHitpointsMax(), actor.getHitpoints() + rate));

		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}
})