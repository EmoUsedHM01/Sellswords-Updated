this.ai_dryad_summon <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		PossibleSkills = [
			"actives.summon_dryad_snake",
			"actives.summon_dryad_unhold",
			"actives.summon_dryad_wolf"
		],
		Skill = null,
		Target = null,
		Cooldown = 0
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.RaiseUndead;
		this.m.Order = this.Const.AI.Behavior.Order.RaiseUndead;
		this.m.Cooldown = this.Math.rand(1, 3);
		this.behavior.create();
	}

	function onTurnStarted()
	{
		--this.m.Cooldown;
	}

	function onEvaluate( _entity )
	{
		this.m.Skill = null;
		this.m.Target = null;
		local score = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
			return this.Const.AI.Behavior.Score.Zero;

		if (_entity.isPlayerControlled() && _entity.getMoraleState() != this.Const.MoraleState.Fleeing && !this.Tactical.State.isAutoRetreat())
			return this.Const.AI.Behavior.Score.Zero;

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null)
			return this.Const.AI.Behavior.Score.Zero;

		if (this.m.Cooldown != 0)
			return this.Const.AI.Behavior.Score.Zero;

		score = score * this.getFatigueScoreMult(this.m.Skill);
		local myTile = _entity.getTile();

		for( local i = 0; i < 6; i = ++i )
		{
			if (!myTile.hasNextTile(i))
			{
			}
			else
			{
				local nextTile = myTile.getNextTile(i);

				if (this.m.Skill.onVerifyTarget(myTile, nextTile))
				{
					this.m.Target = nextTile;
					break;
				}
			}
		}

		if (this.m.Target == null)
			return this.Const.AI.Behavior.Score.Zero;

		return this.Const.AI.Behavior.Score.RaiseUndead;
	}

	function onExecute( _entity )
	{
		if (this.Const.AI.VerboseMode)
			this.logInfo("* " + _entity.getName() + ": Unleashes a companion!");

		this.m.Skill.use(this.m.Target);

		if (!_entity.isHiddenToPlayer())
			this.getAgent().declareAction();

		this.m.Skill = null;
		this.m.Target = null;
		this.m.Cooldown = this.Math.rand(2, 4);
		return true;
	}

});