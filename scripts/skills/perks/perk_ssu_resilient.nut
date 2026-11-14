this.perk_ssu_resilient <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_resilient";
		this.m.Name = this.Const.Strings.PerkName.SsuResilient;
		this.m.Description = this.Const.Strings.PerkDescription.SsuResilient;
		this.m.Icon = "ui/perks/ssu_resilient.png";
		this.m.IconDisabled = "ui/perks/ssu_resilient_bw.png",		
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.NegativeStatusEffectDuration += -5;
		_properties.SurviveWithInjuryChanceMult = 2.0;			
	}

});