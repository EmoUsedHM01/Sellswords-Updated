this.ssu_direwolf_sequence_effect <- this.inherit("scripts/skills/effects/ssu_sequence_effect", {
	m = {
		MissCount = 0,
		HitCount = 0
	},
	function create()
	{
		this.ssu_sequence_effect.create();
		this.setSequence("direwolf");
		this.m.Icon = "skills/status_effect_139.png";
		this.m.Overlay = "status_effect_139";
		this.m.StrongIcon = "skills/ssu_effect_white_direwolf.png";
	}

	function onUpdate( _properties )
	{
		_properties.Stamina += 10;

		if (this.isStrong())
		{
			_properties.Hitpoints += 10;
			_properties.Stamina += 10;
			_properties.Initiative += 10;
			_properties.MeleeSkill += 5;
			_properties.MeleeDefense += 5;
			this.keepSkill("actives.ssu_howl_player", "scripts/skills/actives/ssu_howl_player");
		}

		// Adrenaline Gland
		local isLegendary = ("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary;
		local missing = _properties.Hitpoints - this.getContainer().getActor().getHitpoints();
		local damage = this.Math.floor(missing * (isLegendary ? 0.5 : 0.25));

		if (damage > 0)
		{
			_properties.DamageRegularMin += damage;
			_properties.DamageRegularMax += damage;
		}
	}

	// Elasticized Sinew: a skill that hits nobody gives half its Fatigue back.
	// It is checked a moment later, so that every target of the skill has been resolved by then
	function onTargetMissed( _skill, _targetEntity )
	{
		if (this.m.MissCount == this.Const.SkillCounter)
			return;

		this.m.MissCount = this.Const.SkillCounter;
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 400, this.onRefundFatigue, {
			Actor = this.getContainer().getActor(),
			Effect = this,
			SkillCount = this.Const.SkillCounter,
			Fatigue = _skill.getFatigueCost() / 2
		});
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.m.HitCount = this.Const.SkillCounter;
	}

	function onTargetKilled( _targetEntity, _skill )
	{
		this.m.HitCount = this.Const.SkillCounter;
	}

	function onRefundFatigue( _tag )
	{
		if (_tag.Effect.m.HitCount == _tag.SkillCount || !_tag.Actor.isAlive())
			return;

		local active = this.Tactical.TurnSequenceBar.getActiveEntity();

		if (active == null || active.getID() != _tag.Actor.getID())
			return;

		_tag.Actor.setFatigue(this.Math.max(0, _tag.Actor.getFatigue() - _tag.Fatigue));
		_tag.Actor.setDirty(true);
	}

});
