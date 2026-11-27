::Mod_Sellswords.HooksMod.hook("scripts/skills/skill_container", function ( q ) {

	q.m.SsuAssistanceSkillCount <- 0;

	q.onTargetHit = @(__original) function ( _caller, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		__original(_caller, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor);

		if (_caller == null || !_caller.isAttack() || _caller.isRanged())
			return;

		if (_targetEntity == null || !_targetEntity.isAlive() || _targetEntity.isDying())
			return;

		local actor = this.getActor();

		// Only attacks made in their own turn count, and an assisting attack never causes another one
		local assistance = this.getSkillByID("effects.ssu_assistance");

		if (!actor.isTurnStarted() || assistance != null && assistance.m.IsAssisting)
			return;

		// Once for every use of a skill, no matter how many targets it hits
		if (this.m.SsuAssistanceSkillCount == this.Const.SkillCounter)
			return;

		this.m.SsuAssistanceSkillCount = this.Const.SkillCounter;

		// Every ally of the attacker can assist, whatever their faction: brothers, their animals and allied troops
		foreach (ally in this.Tactical.Entities.getAllInstancesAsArray())
		{
			if (ally.getID() == actor.getID() || !ally.isPlacedOnMap() || !ally.isAlliedWith(actor) || ally.isAlliedWith(_targetEntity))
				continue;

			local effect = ally.getSkills().getSkillByID("effects.ssu_assistance");

			if (effect != null)
				effect.onAllyHit(_targetEntity);
		}
	}

});
