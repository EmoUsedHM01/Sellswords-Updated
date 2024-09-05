this.perk_mummy_insect_breath <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.mummy_insect_breath";
		this.m.Name = this.Const.Strings.PerkName.MummyInsectBreath;
		this.m.Description = this.Const.Strings.PerkDescription.MummyInsectBreath;
		this.m.Icon = "ui/perks/perk_insect_breath.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.insect_breath"))
			this.m.Container.add(this.new("scripts/skills/actives/mod_insect_breath"));
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.insect_breath");
	}

});

