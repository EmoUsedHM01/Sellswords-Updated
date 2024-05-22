this.cr_houndmaster_effect <- this.inherit("scripts/skills/skill", {
	m = {
	dogbreeder = false,
	doghandling = false,
	packleader = false
	},
	function create()
	{
		this.m.ID = "effects.cr_houndmaster_01";
		this.m.Name = "Well Trianed Hound";
		this.m.Icon = "ui/perks/perk_60.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;		
		this.m.IsHidden = true;
	}	

	function onUpdate( _properties )
	{
		if (this.m.packleader)
		{
			//_properties.ArmorMult[this.Const.BodyPart.Head] *= 2.0;
			_properties.ArmorMult[this.Const.BodyPart.Body] *= 2.0;	
		}
		if (this.m.dogbreeder)
		{
			_properties.MeleeSkill += 5;	
		}
		if (this.m.doghandling)
		{
			_properties.MeleeDefense += 5;	
		}		
	}
});

