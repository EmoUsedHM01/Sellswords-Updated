this.perk_crresilient <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.crresilient";
		this.m.Name = this.Const.Strings.PerkName.crresilient;
		this.m.Description = this.Const.Strings.PerkDescription.crresilient;
		this.m.Icon = "ui/perks/crresilient.png";
		this.m.IconDisabled = "ui/perks/crresilient_bw.png",		
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


