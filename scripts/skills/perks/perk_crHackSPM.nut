this.perk_crHackSPM <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.crHackSPM";
		this.m.Name = "Split Man";
		this.m.Description = this.Const.Strings.PerkDescription.crHackSPM;
		this.m.Icon = "ui/perks/crHackSPM.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}


});
