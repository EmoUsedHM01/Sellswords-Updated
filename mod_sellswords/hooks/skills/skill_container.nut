::Mod_Sellswords.HooksMod.hook("scripts/skills/skill_container", function ( q ) {

	q.m.SsuAssistanceSkillCount <- 0;

	q.onTargetHit = @(__original) function ( _caller, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		__original(_caller, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor);

		if (_caller == null || !_caller.isAttack() || _caller.isRanged())
			return;

		local actor = this.getActor();

		if (_targetEntity == null || !_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity.isAlliedWith(actor))
			return;

		// Only attacks made in their own turn count, so that no assisting attack causes another one
		local active = this.Tactical.TurnSequenceBar.getActiveEntity();

		if (active == null || active.getID() != actor.getID())
			return;

		// Once for every use of a skill, no matter how many targets it hits
		if (this.m.SsuAssistanceSkillCount == this.Const.SkillCounter)
			return;

		this.m.SsuAssistanceSkillCount = this.Const.SkillCounter;

		foreach (ally in this.Tactical.Entities.getAllInstancesAsArray())
		{
			if (ally.getID() == actor.getID() || !ally.isPlacedOnMap() || !ally.isAlliedWith(actor))
				continue;

			local effect = ally.getSkills().getSkillByID("effects.ssu_assistance");

			if (effect != null)
				effect.onAllyHit(_targetEntity);
		}
	}

});
