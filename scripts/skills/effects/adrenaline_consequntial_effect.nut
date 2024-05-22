this.adrenaline_consequntial_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1
	},
	function create()
	{
		this.m.ID = "effects.adrenaline_consequntial";
		this.m.Name = "Irresistible Impulse";
		this.m.Icon = "ui/perks/perk_36.png";
		this.m.IconMini = "perk_36_mini";
		this.m.Overlay = "perk_36";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;		
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "Go, go, go! This character has an adrenaline rush and will present destructive power.";
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "] +5 [/color] Melee Skill"
			},			
			{
				id = 10,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "] +5% [/color] Damage"
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

