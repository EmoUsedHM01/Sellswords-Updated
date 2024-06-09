::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/legend_beer_buzz_effect", function( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.Icon = "skills/status_effect_93.png";
		this.m.IconMini = "status_effect_93_mini";
		this.m.Overlay = "status_effect_93";
		this.m.TurnsLeft = 10;
	}

	q.getDescription = @(__original) function()
	{
		return "After guzzling beer, this character has [color=" + this.Const.UI.Color.PositiveValue + "]+9%[/color] damage, damage reduction and  [color=" + this.Const.UI.Color.PositiveValue + "]+18%[/color] Resolve. At the expense of [color=" + this.Const.UI.Color.NegativeValue + "]-6%[/color] initiative and hitchance for [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] turn(s).";
	}

	q.getTooltip = @(__original) function()
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
				id = 11,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+9%[/color] Damage"
			},	
			{
				id = 11,
				type = "text",
				icon = "ui/icons/sturdiness.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+9%[/color] Damage Reduction"
			},			
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+18%[/color] Resolve"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-6%[/color] Melee Skill"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-6%[/color] Ranged Skill"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-6%[/color] Initiative"
			}
		]
	}

	q.onUpdate = @(__original) function( _properties )
	{
		_properties.DamageTotalMult *= 1.09;
		_properties.DamageReceivedTotalMult *= 0.91;		
		_properties.BraveryMult += 0.18;
		_properties.MeleeSkillMult *= 0.94;
		_properties.RangedSkillMult *= 0.94;
		_properties.InitiativeMult *= 0.94;
	}

	q.onAdded = @(__original) function()
	{
		this.m.TurnsLeft = 10;
	}
});
