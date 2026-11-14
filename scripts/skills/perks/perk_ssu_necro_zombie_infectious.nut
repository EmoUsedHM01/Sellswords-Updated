this.perk_ssu_necro_zombie_infectious <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_necro_zombie_infectious";
		this.m.Name = this.Const.Strings.PerkName.SsuNecroZombieInfectious;
		this.m.Description = this.Const.Strings.PerkDescription.SsuNecroZombieInfectious;
		this.m.Icon = "ui/perks/legend_violent_decomposition.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

});

