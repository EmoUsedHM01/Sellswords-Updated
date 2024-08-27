this.perk_armor_mastery_heavy <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.armor_mastery_heavy";
		this.m.Name = this.Const.Strings.PerkName.ArmorMasteryHeavy;
		this.m.Description = this.Const.Strings.PerkDescription.ArmorMasteryHeavy;
		this.m.Icon = "ui/perks/crSpecialize_ha.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

});