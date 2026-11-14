this.ssu_adrenaline_consequential_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1
	},
	function create()
	{
		this.m.ID = "effects.ssu_adrenaline_consequntial";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_adrenaline_consequential_effect.Name;
		this.m.Icon = "ui/perks/perk_36.png";
		this.m.IconMini = "perk_36_mini";
		this.m.Overlay = "perk_36";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;		
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = false;
	}

	function getDescription()
	{
		return ::Mod_Sellswords.Strings.ssu_adrenaline_consequential_effect.Text;
	}
	
	function getTooltip()
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
				id = 9,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = ::Mod_Sellswords.Strings.ssu_adrenaline_consequential_effect.Tooltip1
			},			
			{
				id = 10,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = ::Mod_Sellswords.Strings.ssu_adrenaline_consequential_effect.Tooltip2
			},			
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::Mod_Sellswords.Strings.ssu_adrenaline_consequential_effect.Tooltip3
			},			
			{
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.ssu_adrenaline_consequential_effect.Tooltip4
			}

		];
	}	

	function onUpdate( _properties )
	{
		if (this.m.TurnsLeft != 0)
		{
			_properties.MeleeSkill += 5;
			_properties.DamageTotalMult *= 1.05;
			_properties.TargetAttractionMult *= 1.25;			
		}
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

