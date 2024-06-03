this.perk_crPerseverance <- this.inherit("scripts/skills/skill", {
	m = {
		DamageReduction = 0
	},
	function create()
	{
		this.m.ID = "perk.crPerseverance";
		this.m.Name = this.Const.Strings.PerkName.crPerseverance;
		this.m.Description = this.Const.Strings.PerkDescription.crPerseverance;
		this.m.Icon = "ui/perks/crPerseverance.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}
	
	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack())
		{
			return;
		}

		local count = this.Math.max(0, _hitInfo.DamageRegular - 25) / 5;
		local damagereduction = 0;
		local i = 0;

		while (i <= count)
		{
			damagereduction += 0.5 * this.Math.min(i, 6);
			i = ++i;
		}

		this.m.DamageReduction = damagereduction;
		_hitInfo.DamageRegular -= damagereduction;
	}
	
	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		local actor = this.getContainer().getActor().get();

		if (this.m.DamageReduction < 20 || _damageHitpoints < 11)
		{
			return;
		}

		if (!actor.getCurrentProperties().IsImmuneToBleeding)
		{
			local bleed = this.new("scripts/skills/effects/bleeding_effect");
			bleed.setDamage(this.Math.floor(this.m.DamageReduction / 4));
			bleed.m.bleed_type = 2;
			actor.getSkills().add(bleed);
		}

		this.m.DamageReduction = 0;
	}

});