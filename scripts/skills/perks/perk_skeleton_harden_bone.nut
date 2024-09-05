this.perk_skeleton_harden_bone <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.skeleton_harden_bone";
		this.m.Name = this.Const.Strings.PerkName.SkeletonHarden;
		this.m.Description = this.Const.Strings.PerkDescription.SkeletonHarden;
		this.m.Icon = "ui/perks/perk_skeleton_harden_bone.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.Hitpoints += 30;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_hitInfo.DamageType == this.Const.Damage.DamageType.Cutting)
			_properties.DamageReceivedRegularMult *= 0.75;
	}
});