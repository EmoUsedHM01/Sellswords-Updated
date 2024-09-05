this.perk_ghost_ghastly_touch <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ghost_ghastly_touch";
		this.m.Name = this.Const.Strings.PerkName.GhostGhastlyTouch;
		this.m.Description = this.Const.Strings.PerkDescription.GhostGhastlyTouch;
		this.m.Icon = "ui/perks/perk_ghost_ghastly_touch.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill != null && _skill.getID() == "actives.ghastly_touch")
		{
			_properties.MeleeSkill += 5;
			_properties.DamageRegularMax += 5;
		}
	}

});