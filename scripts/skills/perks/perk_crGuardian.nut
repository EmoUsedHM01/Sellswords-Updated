this.perk_crGuardian <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.crGuardian";
		this.m.Name = this.Const.Strings.PerkName.crGuardian;
		this.m.Description = this.Const.Strings.PerkDescription.crGuardian;
		this.m.Icon = "ui/perks/crGuardian.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isInEffect()
	{
		local actor = this.getContainer().getActor();	
		if (!actor.isArmedWithShield())
		{
			return false;
		}

		return true;
	}
	
});
