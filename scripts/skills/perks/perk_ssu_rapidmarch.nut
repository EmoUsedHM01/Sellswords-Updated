this.perk_ssu_rapidmarch <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_rapidmarch";
		this.m.Name = this.Const.Strings.PerkName.SsuRapidmarch;
		this.m.Description = this.Const.Strings.PerkDescription.SsuRapidmarch;	
		this.m.Icon = "ui/perks/ssu_rapidmarch.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.ssu_rapidmarch"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/ssu_rapidmarch_skill"));
		}	
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.ssu_rapidmarch");	
	}

});

