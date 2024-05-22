this.dryad_forest_blessing <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.dryad_forest_blessing";
		this.m.Name = this.Const.Strings.PerkName.DryadForestBlessing;
		this.m.Description = this.Const.Strings.PerkDescription.DryadForestBlessing;
		this.m.Icon = "ui/perks/perk_forest_blessing.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.forest_blessing"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/forest_blessing"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.forest_blessing");
	}

});
