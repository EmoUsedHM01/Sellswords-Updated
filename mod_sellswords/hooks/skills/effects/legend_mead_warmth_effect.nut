::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/legend_mead_warmth_effect", function( q ) {

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
		return ::Mod_Sellswords.text(::Mod_Sellswords.Strings.legend_mead_warmth_effect.Text, this.m.TurnsLeft);
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
				text = ::Mod_Sellswords.Strings.legend_mead_warmth_effect.Tooltip1
			},	
			{
				id = 11,
				type = "text",
				icon = "ui/icons/sturdiness.png",
				text = ::Mod_Sellswords.Strings.legend_mead_warmth_effect.Tooltip2
			},			
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::Mod_Sellswords.Strings.legend_mead_warmth_effect.Tooltip3
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = ::Mod_Sellswords.Strings.legend_mead_warmth_effect.Tooltip4
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = ::Mod_Sellswords.Strings.legend_mead_warmth_effect.Tooltip5
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::Mod_Sellswords.Strings.legend_mead_warmth_effect.Tooltip6
			}
		];
	}

	q.onUpdate = @(__original) function( _properties )
	{
		_properties.DamageTotalMult *= 1.12;
		_properties.DamageReceivedTotalMult *= 0.88;		
		_properties.BraveryMult += 0.24;
		_properties.MeleeSkillMult *= 0.92;
		_properties.RangedSkillMult *= 0.92;
		_properties.InitiativeMult *= 0.92;
	}
	
	q.onAdded = @(__original) function()
	{
		this.m.TurnsLeft = 10;
	}
});
