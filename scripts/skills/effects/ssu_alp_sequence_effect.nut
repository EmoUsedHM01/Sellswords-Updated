this.ssu_alp_sequence_effect <- this.inherit("scripts/skills/effects/ssu_sequence_effect", {
	m = {},
	function create()
	{
		this.ssu_sequence_effect.create();
		this.setSequence("alp");
		this.m.Icon = "skills/status_effect_147.png";
		this.m.Overlay = "status_effect_147";
		this.m.StrongIcon = "skills/ssu_effect_demon.png";
	}

	function onUpdate( _properties )
	{
		_properties.IsAffectedByNight = false;
		_properties.Vision += 1;
		_properties.Hitpoints += 10;

		if (this.isStrong())
			this.keepSkill("actives.horrific_scream", "scripts/skills/actives/horrific_scream");
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill == null || _hitInfo.DamageType != this.Const.Damage.DamageType.Piercing)
			return;

		_properties.DamageReceivedRegularMult *= _skill.isRanged() ? 0.5 : 0.75;
	}

	// the Demon Strain floats over the battlefield
	function onCombatStarted()
	{
		if (!this.isStrong())
			return;

		local actor = this.getContainer().getActor();
		actor.m.ActionPointCosts = this.Const.LegendFlightMovementAPCost;
		actor.m.FatigueCosts = this.Const.LegendFlightMovementFatigueCost;
		actor.m.LevelActionPointCost = 0;
	}

	function onCombatFinished()
	{
		if (!this.isStrong())
			return;

		local actor = this.getContainer().getActor();
		actor.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		actor.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		actor.m.LevelActionPointCost = this.Const.Movement.LevelDifferenceActionPointCost;
	}

});
