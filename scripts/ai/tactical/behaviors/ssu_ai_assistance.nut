this.ssu_ai_assistance <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		Skill = null,
		PossibleSkills = [
			"actives.ssu_assistance"
		]
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.SsuAssistance;
		this.m.Order = this.Const.AI.Behavior.Order.SsuAssistance;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		this.m.Skill = null;

		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP || _entity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (!this.getAgent().hasVisibleOpponent())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);
		local attack = _entity.getSkills().getAttackOfOpportunity();

		if (this.m.Skill == null || attack == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local targets = this.queryTargetsInMeleeRange(attack.getMinRange(), attack.getMaxRange(), attack.getMaxLevelDifference());
		local best = this.queryBestMeleeTarget(_entity, attack, targets);

		if (best.Target == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		// an enemy that can be killed right now is better attacked than assisted against
		local damage = attack.getExpectedDamage(best.Target);

		if (best.Target.getHitpoints() <= damage.HitpointDamage + damage.DirectDamage)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local myTile = _entity.getTile();
		local helpers = 0;

		foreach( ally in this.getAgent().getKnownAllies() )
		{
			if (ally.getID() == _entity.getID() || !ally.hasZoneOfControl())
			{
				continue;
			}

			local allyAttack = ally.getSkills().getAttackOfOpportunity();

			if (allyAttack == null)
			{
				continue;
			}

			foreach( target in targets )
			{
				local targetTile = target.getTile();

				if (!attack.isInRange(targetTile, myTile) || !attack.onVerifyTarget(myTile, targetTile))
				{
					continue;
				}

				if (allyAttack.isInRange(targetTile, ally.getTile()) && allyAttack.onVerifyTarget(ally.getTile(), targetTile))
				{
					helpers++;
					break;
				}
			}
		}

		if (helpers < this.Const.AI.Behavior.SsuAssistanceMinHelpers)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local score = this.getProperties().BehaviorMult[this.m.ID] * this.getFatigueScoreMult(this.m.Skill);
		return this.Const.AI.Behavior.Score.SsuAssistance * best.Score * score * helpers;
	}

	function onExecute( _entity )
	{
		this.m.Skill.use(_entity.getTile());

		if (!_entity.isHiddenToPlayer())
		{
			this.getAgent().declareAction();
		}

		this.m.Skill = null;
		return true;
	}

});
