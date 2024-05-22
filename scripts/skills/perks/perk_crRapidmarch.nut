this.perk_crRapidmarch <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.crRapidmarch";
		this.m.Name = this.Const.Strings.PerkName.crRapidmarch;
		this.m.Description = this.Const.Strings.PerkDescription.crRapidmarch;	
		this.m.Icon = "ui/perks/crrapidmarch.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.crrapidmarch"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/crrapidmarch_skill"));
		}	
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.crrapidmarch");	
	}

});

