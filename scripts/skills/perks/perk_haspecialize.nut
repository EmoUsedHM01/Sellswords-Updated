this.perk_haspecialize <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.haspecialize";
		this.m.Name = this.Const.Strings.PerkName.haspecialize;
		this.m.Description = this.Const.Strings.PerkDescription.haspecialize;
		this.m.Icon = "ui/perks/crSpecialize_ha.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}	

});

