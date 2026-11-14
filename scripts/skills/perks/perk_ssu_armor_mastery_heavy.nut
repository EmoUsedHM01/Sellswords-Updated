this.perk_ssu_armor_mastery_heavy <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_armor_mastery_heavy";
		this.m.Name = this.Const.Strings.PerkName.SsuArmorMasteryHeavy;
		this.m.Description = this.Const.Strings.PerkDescription.SsuArmorMasteryHeavy;
		this.m.Icon = "ui/perks/ssu_armor_mastery_heavy.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

});