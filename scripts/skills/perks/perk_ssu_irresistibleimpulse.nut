this.perk_ssu_irresistibleimpulse <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_irresistibleimpulse";
		this.m.Name = this.Const.Strings.PerkName.SsuIrresistibleimpulse;
		this.m.Description = this.Const.Strings.PerkDescription.SsuIrresistibleimpulse;
		this.m.Icon = "ui/perks/legend_smackdown.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

});


