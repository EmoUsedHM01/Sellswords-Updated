this.perk_crstamina <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.crstamina";
		this.m.Name = this.Const.Strings.PerkName.crstamina;
		this.m.Description = this.Const.Strings.PerkDescription.crstamina;
		this.m.Icon = "ui/perks/crstamina.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
	
	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.crstamina"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/crstamina_skill"));
		}
		if (!this.m.Container.hasSkill("actives.recover"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/recover_skill"));
		}		
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.crstamina");
		this.m.Container.removeByID("actives.recover");		
	}

	function onUpdate( _properties )
	{
		_properties.TargetAttractionMult *= 1.2;
	}	

});

