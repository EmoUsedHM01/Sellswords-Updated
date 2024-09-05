this.perk_zombie_infectious_bite <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.zombie_infectious_bite";
		this.m.Name = this.Const.Strings.PerkName.ZombieInfectious;
		this.m.Description = this.Const.Strings.PerkDescription.ZombieInfectious;
		this.m.Icon = "ui/perks/violent_decomposition_circle.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

});

