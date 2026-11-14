this.perk_ssu_clarity <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_clarity";
		this.m.Name = this.Const.Strings.PerkName.SsuClarity;
		this.m.Description = this.Const.Strings.PerkDescription.SsuClarity;
		this.m.Icon = "ui/perks/ssu_clarity.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.ssu_clarity"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/ssu_clarity_skill"));
		}		
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.ssu_clarity");	
	}

});

