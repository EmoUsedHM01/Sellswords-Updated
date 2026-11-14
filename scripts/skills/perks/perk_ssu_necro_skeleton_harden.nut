this.perk_ssu_necro_skeleton_harden <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_necro_skeleton_harden";
		this.m.Name = this.Const.Strings.PerkName.SsuNecroSkeletonHarden;
		this.m.Description = this.Const.Strings.PerkDescription.SsuNecroSkeletonHarden;
		this.m.Icon = "ui/perks/ssu_necro_skeleton_harden.png";
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