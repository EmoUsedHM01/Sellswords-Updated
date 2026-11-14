this.perk_ssu_totalcover <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_totalcover";
		this.m.Name = this.Const.Strings.PerkName.SsuTotalcover;
		this.m.Description = this.Const.Strings.PerkDescription.SsuTotalcover;
		this.m.Icon = "ui/perks/ssu_totalcover.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}


});
