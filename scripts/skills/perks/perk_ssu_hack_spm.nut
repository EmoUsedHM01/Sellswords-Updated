this.perk_ssu_hack_spm <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_hack_spm";
		this.m.Name = this.Const.Strings.PerkName.SsuHackSpm;
		this.m.Description = this.Const.Strings.PerkDescription.SsuHackSpm;
		this.m.Icon = "ui/perks/ssu_hack_spm.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}


});
