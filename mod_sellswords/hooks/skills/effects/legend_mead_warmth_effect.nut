::mods_hookExactClass("skills/effects/legend_mead_warmth_effect", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.TurnsLeft = 10;
		this.m.Icon = "skills/status_effect_93.png";
		this.m.IconMini = "status_effect_93_mini";
		this.m.Overlay = "status_effect_93";
	}
	
	o.getDescription = function()
	{
		return "After consuming mead, this character has [color=" + this.Const.UI.Color.PositiveValue + "]+12%[/color] damage, damage reduction and  [color=" + this.Const.UI.Color.PositiveValue + "]+24%[/color] Resolve. At the expense of [color=" + this.Const.UI.Color.NegativeValue + "]-9%[/color] initiative and hitchance for [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] turn(s).";
	}
	
	o.getTooltip = function()
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+12%[/color] Damage"
			},	
			{
				id = 11,
				type = "text",
				icon = "ui/icons/sturdiness.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+12%[/color] Damage Reduction"
			},			
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+24%[/color] Resolve"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-8%[/color] Melee Skill"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-8%[/color] Ranged Skill"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-8%[/color] Initiative"
			}
		];
	}

	o.onUpdate = function( _properties )
	{
		_properties.DamageTotalMult *= 1.12;
		_properties.DamageReceivedTotalMult *= 0.88;		
		_properties.BraveryMult += 0.24;
		_properties.MeleeSkillMult *= 0.92;
		_properties.RangedSkillMult *= 0.92;
		_properties.InitiativeMult *= 0.92;
	}
	
	o.onAdded = function()
	{
		this.m.TurnsLeft = 10;
	}
})