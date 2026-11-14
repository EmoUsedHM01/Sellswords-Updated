this.ssu_oath_effect <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "effects.ssu_oath_effect";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_oath_effect.Name;
		this.m.Description = ::Mod_Sellswords.Strings.ssu_oath_effect.Description;
		this.m.Icon = "skills/status_effect_73.png";
		this.m.Type = this.m.Type | this.Const.SkillType.StatusEffect;
		this.m.IsHealingMentioned = false;
		this.m.IsTreatable = false;
		this.m.IsContentWithReserve = false;
		this.m.HealingTimeMin = 7;
		this.m.HealingTimeMax = 7;
	}

	function getTooltip()
	{
		local ret = [
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
				id = 13,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::Mod_Sellswords.Strings.ssu_oath_effect.Tooltip1
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::Mod_Sellswords.Strings.ssu_oath_effect.Tooltip2
			},			
			{
				id = 13,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = ::Mod_Sellswords.Strings.ssu_oath_effect.Tooltip3
			}			
		];
		this.addTooltipHint(ret);
		return ret;
	}

	function onUpdate( _properties )
	{
		this.injury.onUpdate(_properties);
		_properties.BraveryMult *= 1.15;
		_properties.InitiativeMult *= 1.15;
		_properties.DamageTotalMult *= 1.05;		
	}

});

