this.perk_ssu_guardian <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_guardian";
		this.m.Name = this.Const.Strings.PerkName.SsuGuardian;
		this.m.Description = this.Const.Strings.PerkDescription.SsuGuardian;
		this.m.Icon = "ui/perks/ssu_guardian.png";
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
