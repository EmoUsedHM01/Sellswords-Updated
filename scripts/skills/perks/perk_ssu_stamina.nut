this.perk_ssu_stamina <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_stamina";
		this.m.Name = this.Const.Strings.PerkName.SsuStamina;
		this.m.Description = this.Const.Strings.PerkDescription.SsuStamina;
		this.m.Icon = "ui/perks/ssu_stamina.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
	
	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.ssu_stamina"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/ssu_stamina_skill"));
		}
		if (!this.m.Container.hasSkill("actives.recover"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/recover_skill"));
		}		
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.ssu_stamina");
		this.m.Container.removeByID("actives.recover");		
	}

	function onUpdate( _properties )
	{
		_properties.TargetAttractionMult *= 1.2;
	}	

});

