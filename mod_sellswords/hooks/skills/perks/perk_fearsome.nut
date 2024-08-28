::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_fearsome", function ( q ) {

	q.onAfterUpdate = @( __original ) function ( _properties )
	{
		local modification = 1;

		if (this.getContainer().getActor().getSkills().getSkillByID("effects.crfearsome"))
			modification = 3;

		_properties.ThreatOnHit += this.Math.min(modification * 20, this.Math.max(0, modification * _properties.getBravery() * 0.2));
	}

	q.onTargetHit = @( __original ) function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_targetEntity == null || !_targetEntity.isAlive())
			return;

		if (_targetEntity.getMoraleState() == this.Const.MoraleState.Ignore || !_targetEntity.getCurrentProperties().IsAffectedByLosingHitpoints)
			return;

		if ((this.Time.getFrame() == this.m.LastFrameApplied || this.m.SkillCount == this.Const.SkillCounter) && _targetEntity.getID() == this.m.LastEnemyAppliedTo)
		{
			if (_damageInflictedHitpoints >= this.Const.Morale.OnHitMinDamage)
				this.spawnIcon("perk_27", _targetEntity.getTile());

			return;
		}

		if (_damageInflictedHitpoints >= 1)
			this.spawnIcon("perk_27", _targetEntity.getTile());

		this.m.LastFrameApplied = this.Time.getFrame();
		this.m.LastEnemyAppliedTo = _targetEntity.getID();
		this.m.SkillCount = this.Const.SkillCounter;

		if (_damageInflictedHitpoints >= 1 && _damageInflictedHitpoints < this.Const.Morale.OnHitMinDamage)
			_targetEntity.checkMorale(-1, this.Const.Morale.OnHitBaseDifficulty * (1.0 - _targetEntity.getHitpoints() / _targetEntity.getHitpointsMax()) - this.getContainer().getActor().getCurrentProperties().ThreatOnHit);

		local effect = this.getContainer().getActor().getSkills().getSkillByID("effects.crfearsome");

		if (effect != null)
			this.getContainer().getActor().getSkills().removeByID("effects.crfearsome");
	}

	q.onTargetKilled <- function ( _targetEntity, _skill )
	{
		if (!_targetEntity.isAlliedWith(this.getContainer().getActor()))
		{
			local effect = this.getContainer().getActor().getSkills().getSkillByID("effects.crfearsome");

			if (effect != null)
				return;
			else
				this.getContainer().add(this.new("scripts/skills/effects/crfearsome_effect"));
		}
	}

});