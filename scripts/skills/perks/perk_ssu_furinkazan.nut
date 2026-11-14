this.perk_ssu_furinkazan <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_furinkazan";
		this.m.Name = this.Const.Strings.PerkName.SsuFurinkazan;
		this.m.Description = this.Const.Strings.PerkDescription.SsuFurinkazan;
		this.m.Icon = "ui/perks/ssu_furinkazan.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

});
