this.perk_crirresistibleimpulse <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.crirresistibleimpulse";
		this.m.Name = this.Const.Strings.PerkName.crirresistibleimpulse;
		this.m.Description = this.Const.Strings.PerkDescription.crirresistibleimpulse;
		this.m.Icon = "ui/perks/smackdown_circle.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

});


