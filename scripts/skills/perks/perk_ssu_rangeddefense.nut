this.perk_ssu_rangeddefense <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_rangeddefense";
		this.m.Name = this.Const.Strings.PerkName.SsuRangeddefense;
		this.m.Description = this.Const.Strings.PerkDescription.SsuRangeddefense;
		this.m.Icon = "ui/perks/ssu_rangeddefense.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
	
	function onUpdate( _properties )
	{
		_properties.AggroMult *= 2;
	}	

});

