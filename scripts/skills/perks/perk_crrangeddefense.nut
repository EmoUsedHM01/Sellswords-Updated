this.perk_crrangeddefense <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.crrangeddefense";
		this.m.Name = this.Const.Strings.PerkName.crrangeddefense;
		this.m.Description = this.Const.Strings.PerkDescription.crrangeddefense;
		this.m.Icon = "ui/perks/crrangeddefense.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
	
	function onUpdate( _properties )
	{
		_properties.TargetAttractionMult *= 10;
	}	

});

