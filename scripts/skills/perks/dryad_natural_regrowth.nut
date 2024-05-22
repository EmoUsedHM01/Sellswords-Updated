this.dryad_natural_regrowth <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.dryad_natural_regrowth";
		this.m.Name = this.Const.Strings.PerkName.DryadNaturalRegrowth;
		this.m.Description = this.Const.Strings.PerkDescription.DryadNaturalRegrowth;
		this.m.Icon = "ui/perks/perk_natural_regrowth.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.natural_regrowth"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/natural_regrowth"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.natural_regrowth");
	}

});
