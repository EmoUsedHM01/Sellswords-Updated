this.perk_crClarity <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.crClarity";
		this.m.Name = this.Const.Strings.PerkName.crClarity;
		this.m.Description = this.Const.Strings.PerkDescription.crClarity;
		this.m.Icon = "ui/perks/crClarity.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.cr_clarity"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/cr_clarity_skill"));
		}		
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.cr_clarity");	
	}

});

