::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/legend_wine_tipsy_effect", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.TurnsLeft = 10;
		this.m.Icon = "skills/status_effect_93.png";
		this.m.IconMini = "status_effect_93_mini";
		this.m.Overlay = "status_effect_93";
	}
	
	q.getDescription = @(__original) function()
	{
		return "After imbibing wine, this character has [color=%positive%]+15%[/color] damage, damage reduction and  [color=%positive%]+30%[/color] Resolve. At the expense of [color=%negative%]-10%[/color] initiative and hitchance for [color=%negative%]" + this.m.TurnsLeft + "[/color] turn(s).";
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
				text = "[color=%positive%]+15%[/color] Damage"
			},	
			{
				id = 11,
				type = "text",
				icon = "ui/icons/sturdiness.png",
				text = "[color=%positive%]+15%[/color] Damage Reduction"
			},			
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%positive%]+30%[/color] Resolve"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%negative%]-10%[/color] Melee Skill"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%negative%]-10%[/color] Ranged Skill"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-10%[/color] Initiative"
			}
		];
	}

	q.onUpdate = @(__original) function( _properties )
	{
		_properties.DamageTotalMult *= 1.15;
		_properties.DamageReceivedTotalMult *= 0.85;		
		_properties.BraveryMult += 0.3;
		_properties.MeleeSkillMult *= 0.9;
		_properties.RangedSkillMult *= 0.9;
		_properties.InitiativeMult *= 0.9;
	}
	
	q.onAdded = @(__original) function()
	{
		this.m.TurnsLeft = 10;
	}
});
