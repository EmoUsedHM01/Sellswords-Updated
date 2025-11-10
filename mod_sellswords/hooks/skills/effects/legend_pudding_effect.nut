::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/legend_pudding_effect", function ( q ) {

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
		return "Thanks to eating food, this character regains Health, Resolve and Defenses for [color=%positive%]" + this.m.TurnsLeft + "[/color] turn(s). ";
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
				icon = "ui/icons/health.png",
				text = "On self, will restore [color=%positive%]" + crate + "[/color] Health per turn for ten turns"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "On self, will increase [color=%positive%]" + rate + "[/color] Resolve for ten turns"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "On self, will increase [color=%positive%]" + rate + "[/color] Melee Defenses for ten turns"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "On self, will increase [color=%positive%]" + rate + "[/color] Ranged Defenses for ten turns"
			}			
		];
		return ret;
	}

	q.onUpdate = @(__original) function( _properties )
	{
		local rate = this.Math.max(1, this.Math.ceil(this.m.Amount / 8));
		local crate = this.Math.ceil(1.5 * rate);		
		_properties.Bravery += rate;
		_properties.MeleeDefense += rate;
		_properties.RangedDefense += rate;	
	}

	q.onTurnEnd = @(__original) function()
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
});
