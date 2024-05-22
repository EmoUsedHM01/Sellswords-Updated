this.perk_crTotalcover <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.crTotalcover";
		this.m.Name = "Total Cover";
		this.m.Description = this.Const.Strings.PerkDescription.crTotalcover;
		this.m.Icon = "ui/perks/crTotalcover.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}


});
