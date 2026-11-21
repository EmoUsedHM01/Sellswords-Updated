this.ssu_hyena_sequence_effect <- this.inherit("scripts/skills/effects/ssu_sequence_effect", {
	m = {},
	function create()
	{
		this.ssu_sequence_effect.create();
		this.setSequence("hyena");
		this.m.Icon = "skills/status_effect_143.png";
		this.m.Overlay = "status_effect_143";
	}

	function onUpdate( _properties )
	{
		_properties.Initiative += this.isStrong() ? 30 : 15;
		_properties.MovementFatigueCostMult *= 0.5;

		if (this.isStrong())
			_properties.MovementAPCostAdditional -= 1;
	}

	// Subdermal Clotting
	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill != null && _skill.getID() == "effects.bleeding")
			_properties.DamageReceivedRegularMult *= 0.5;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_skill.isAttack() || _targetEntity == null || !_targetEntity.isAlive() || _targetEntity.isDying())
			return;

		if (_targetEntity.getCurrentProperties().IsImmuneToBleeding || _damageInflictedHitpoints < this.Const.Combat.MinDamageToApplyBleeding)
			return;

		local bleed = this.new("scripts/skills/effects/bleeding_effect");
		bleed.setDamage(this.isStrong() ? 10 : 5);
		bleed.setActor(this.getContainer().getActor());
		_targetEntity.getSkills().add(bleed);
	}

});
