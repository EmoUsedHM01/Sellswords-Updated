this.perk_ssu_necro_mummy_insect_breath <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_necro_mummy_insect_breath";
		this.m.Name = this.Const.Strings.PerkName.SsuNecroMummyInsectBreath;
		this.m.Description = this.Const.Strings.PerkDescription.SsuNecroMummyInsectBreath;
		this.m.Icon = "ui/perks/ssu_necro_mummy_insect_breath.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.ssu_necro_insect_breath"))
			this.m.Container.add(this.new("scripts/skills/actives/ssu_necro_insect_breath"));
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.ssu_necro_insect_breath");
	}

});

