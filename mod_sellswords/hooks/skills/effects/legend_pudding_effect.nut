::mods_hookExactClass("skills/effects/legend_pudding_effect", function(o) {
	::Mod_Sellswords.HookHelper.hookNewEatFoodEffectSystem(o);

	o.getDescription = function()
	{
		return "Thanks to eating food, this character regains Health, Resolve and Defenses for [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.TurnsLeft + "[/color] turn(s). ";
	}

	o.getTooltip = function()
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
				icon = "ui/icons/health.png",
				text = "On self, will restore [color=" + this.Const.UI.Color.PositiveValue + "]" + crate + "[/color] Health per turn for ten turns"
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
				icon = "ui/icons/melee_defense.png",
				text = "On self, will increase [color=" + this.Const.UI.Color.PositiveValue + "]" + rate + "[/color] Melee Defenses for ten turns"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "On self, will increase [color=" + this.Const.UI.Color.PositiveValue + "]" + rate + "[/color] Ranged Defenses for ten turns"
			}			
		];
		return ret;
	}

	o.onUpdate = function( _properties )
	{
		local rate = this.Math.max(1, this.Math.ceil(this.m.Amount / 8));
		local crate = this.Math.ceil(1.5 * rate);		
		_properties.Bravery += rate;
		_properties.MeleeDefense += rate;
		_properties.RangedDefense += rate;	
	}

	o.onTurnEnd = function()
	{
		local rate = this.Math.max(1, this.Math.ceil(this.m.Amount / 8));
		local crate = this.Math.ceil(1.5 * rate);		
		local actor = this.getContainer().getActor();
		actor.setHitpoints(this.Math.min(actor.getHitpointsMax(), actor.getHitpoints() + crate));

		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}
})