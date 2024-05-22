this.dryad_summon_lindwurm <- this.inherit("scripts/skills/skill", {
	m = {
	},
	function create()
	{
		this.m.ID = "perk.dryad_summon_lindwurm";
		this.m.Name = this.Const.Strings.PerkName.DryadSummonLindwurm;
		this.m.Description = this.Const.Strings.PerkDescription.DryadSummonLindwurm;
		this.m.Icon = "ui/perks/perk_dryad_summon_lindy.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
	
	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.summon_dryad_lindy"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/summon_dryad_lindy"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.summon_dryad_lindy");
	}

});