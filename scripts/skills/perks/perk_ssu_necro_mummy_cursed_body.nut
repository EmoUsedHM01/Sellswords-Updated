this.perk_ssu_necro_mummy_cursed_body <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.ssu_necro_mummy_cursed_body";
		this.m.Name = this.Const.Strings.PerkName.SsuNecroMummyCursedBody;
		this.m.Description = this.Const.Strings.PerkDescription.SsuNecroMummyCursedBody;
		this.m.Icon = "ui/perks/ssu_necro_mummy_cursed_body.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.Threat += 10;
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_attacker != null && this.Math.rand(1, 100) <= 25)
			_attacker.getSkills().add(this.new("scripts/skills/effects/legend_curse_of_the_mummy_effect"));
	}

});