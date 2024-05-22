this.dryad_summon_wolf <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.dryad_summon_wolf";
		this.m.Name = this.Const.Strings.PerkName.DryadSummonWolf;
		this.m.Description = this.Const.Strings.PerkDescription.DryadSummonWolf;
		this.m.Icon = "ui/perks/perk_dryad_summon_wolf.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.summon_dryad_wolf"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/summon_dryad_wolf"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.summon_dryad_wolf");
	}

});

