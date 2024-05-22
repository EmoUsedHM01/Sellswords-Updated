this.perk_crFurinkazan <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.crFurinkazan";
		this.m.Name = "Furinkazan";
		this.m.Description = this.Const.Strings.PerkDescription.crFurinkazan;
		this.m.Icon = "ui/perks/crFurinkazan.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

});
