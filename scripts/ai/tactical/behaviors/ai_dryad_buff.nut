this.ai_dryad_buff <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		PossibleSkills = [
			"actives.forest_blessing",
			"actives.natural_regrowth"
		],
		Skill = null,
		IsTravelling = false
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.DryadBuff;
		this.m.Order = this.Const.AI.Behavior.Order.DryadBuff;
		this.m.IsThreaded = true;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		// Function is a generator.
		this.m.Skill = null;
		this.m.TargetTile = null;
		this.m.IsTravelling = false;
		local time = this.Time.getExactTime();
		local scoreMult = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getTile().hasZoneOfControlOtherThan(_entity.getAlliedFactions()))
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		scoreMult = scoreMult * this.getFatigueScoreMult(this.m.Skill);
		local myTile = _entity.getTile();
		local potentialDanger = this.getPotentialDanger(true);
		local currentDanger = 0.0;
		yield null;

		foreach( t in potentialDanger )
		{
			local d = this.queryActorTurnsNearTarget(t, myTile, _entity);

			if (d.Turns <= 1.0)
			{
				currentDanger = currentDanger + (1.0 - d.Turns);
			}
		}

		yield null;
		local allAllies = this.getAgent().getKnownAllies();
		local allEnemies = this.getAgent().getKnownAllies();
		local potentialTargets = [];

		foreach( a in allAllies )
		{
			if (!a.hasSkill("racial.dryad"))
				continue;

			if (a.getCurrentProperties().IsStunned)
				continue;

			local score = 0.0;
			local tile = a.getTile();
			local distToMe = myTile.getDistanceTo(tile);
			local zoc = tile.getZoneOfOccupationCountOtherThan(a.getAlliedFactions());

			if (zoc == 0 && a.getCurrentProperties().IsRooted)
				continue;

			score = score + zoc * this.Const.AI.Behavior.PossessUndeadZOCMult;
			local mag = this.queryOpponentMagnitude(tile, this.Const.AI.Behavior.PossessUndeadMagnitudeMaxRange);
			score = score + mag.Opponents * (1.0 - mag.AverageDistanceScore) * this.Math.maxf(0.5, 1.0 - mag.AverageEngaged) * this.Const.AI.Behavior.PossessUndeadOpponentValue;
			score = score * (0.25 + 0.75 * this.Math.maxf(0.33, a.getHitpointsPct()));
			score = score * (0.5 + 0.5 * a.getXPValue() * 0.01);

			if (!a.isArmedWithMeleeWeapon())
				score = score * this.Const.AI.Behavior.PossessUndeadNoWeaponMult;

			if (currentDanger != 0 && distToMe <= 2)
				score = score * this.Const.AI.Behavior.PossessUndeadHelpMeMult;
			else if (zoc == 0 && a.getCurrentProperties().IsRooted)
				continue;

			if (this.m.Skill.isInRange(tile))
				score = score * this.Const.AI.Behavior.PossessUndeadInRangeMult;

			if (!a.isTurnDone())
				score = score * this.Const.AI.Behavior.PossessUndeadStillToActMult;

			potentialTargets.push({
				Tile = tile,
				Distance = distToMe,
				Score = score
			});
		}

		if (potentialTargets.len() == 0)
			return this.Const.AI.Behavior.Score.Zero;

		potentialTargets.sort(this.onSortByScore);
		local navigator = this.Tactical.getNavigator();
		local bestTarget;
		local bestIntermediateTile;
		local bestCost = -9000;
		local bestTiles = 0;
		local n = 0;
		local maxRange = this.m.Skill.getMaxRange();
		local entityActionPointCosts = _entity.getActionPointCosts();
		local entityFatigueCosts = _entity.getFatigueCosts();

		foreach( t in potentialTargets )
		{
			n = ++n;

			if (n > this.Const.AI.Behavior.PossessUndeadMaxAttempts && bestTarget != null)
				break;

			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = this.Time.getExactTime();
			}

			local score = t.Score;
			local tiles = 0;
			local intermediateTile;

			if (!this.m.Skill.isInRange(t.Tile))
			{
				local settings = navigator.createSettings();
				settings.ActionPointCosts = entityActionPointCosts;
				settings.FatigueCosts = entityFatigueCosts;
				settings.FatigueCostFactor = 0.0;
				settings.ActionPointCostPerLevel = _entity.getLevelActionPointCost();
				settings.FatigueCostPerLevel = _entity.getLevelFatigueCost();
				settings.AllowZoneOfControlPassing = false;
				settings.ZoneOfControlCost = this.Const.AI.Behavior.ZoneOfControlAPPenalty;
				settings.AlliedFactions = _entity.getAlliedFactions();
				settings.Faction = _entity.getFaction();

				if (!_entity.getCurrentProperties().IsRooted && navigator.findPath(myTile, t.Tile, settings, maxRange))
				{
					local movementCosts = navigator.getCostForPath(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());

					if (movementCosts.IsComplete && !this.m.Skill.onVerifyTarget(movementCosts.End, t.Tile))
						continue;

					if (!movementCosts.IsComplete)
						intermediateTile = movementCosts.End;

					if (movementCosts.End.IsBadTerrain)
						score = score - this.Const.AI.Behavior.PossessUndeadMoveToBadTerrainPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult;

					if (this.getProperties().EngageOnBadTerrainPenaltyMult != 0.0)
						score = score - movementCosts.End.TVLevelDisadvantage;

					score = score - movementCosts.ActionPointsRequired;
					score = score + movementCosts.End.Level;
					local danger = 0.0;
					local danger_intermediate = 0.0;

					foreach( opponent in potentialDanger )
					{
						if (this.isAllottedTimeReached(time))
						{
							yield null;
							time = this.Time.getExactTime();
						}

						local d = this.queryActorTurnsNearTarget(opponent, t.Tile, _entity);
						danger = danger + this.Math.maxf(0.0, 1.0 - d.Turns);

						if (!movementCosts.IsComplete)
						{
							local id = this.queryActorTurnsNearTarget(opponent, movementCosts.End, _entity);
							danger_intermediate = danger_intermediate + this.Math.maxf(0.0, 1.0 - id.Turns);
							d = d.Turns > id.Turns ? id : d;
						}

						if (d.Turns <= 1.0)
						{
							if (d.InZonesOfControl != 0 || opponent.getCurrentProperties().IsStunned || opponent.getCurrentProperties().IsRooted)
								score = score - this.Const.AI.Behavior.PossessUndeadLowDangerPenalty;
							else
								score = score - this.Const.AI.Behavior.PossessUndeadHighDangerPenalty;
						}

						if (danger >= this.Const.AI.Behavior.PossessUndeadMaxDanger || danger_intermediate >= this.Const.AI.Behavior.PossessUndeadMaxDanger)
							break;
					}

					if (danger >= this.Const.AI.Behavior.PossessUndeadMaxDanger || danger_intermediate >= this.Const.AI.Behavior.PossessUndeadMaxDanger)
						continue;

					tiles = movementCosts.Tiles;
				}
				else
					continue;
			}
			else
			{
				for( ; currentDanger >= this.Const.AI.Behavior.PossessUndeadMaxDanger;  )
				{
				}

				if (!this.m.Skill.onVerifyTarget(myTile, t.Tile))
					continue;

				score = score + myTile.Level;
			}

			if (score > bestCost)
			{
				bestTarget = t.Tile;
				bestCost = score;
				bestTiles = tiles;
				bestIntermediateTile = intermediateTile;
			}
		}

		if (bestTarget == null)
			return this.Const.AI.Behavior.Score.Zero;

		this.m.TargetTile = bestTarget;
		this.m.IsTravelling = !this.m.Skill.isInRange(this.m.TargetTile);

		if (this.m.IsTravelling && bestIntermediateTile != null && bestIntermediateTile.ID == myTile.ID)
			return this.Const.AI.Behavior.Score.Zero;

		return this.Const.AI.Behavior.Score.PossessUndead * scoreMult;
	}

	function onBeforeExecute( _entity )
	{
		if (this.m.IsTravelling)
		{
			this.getAgent().getOrders().IsEngaging = true;
			this.getAgent().getOrders().IsDefending = false;
			this.getAgent().getIntentions().IsDefendingPosition = false;
			this.getAgent().getIntentions().IsEngaging = true;
		}
	}

	function onExecute( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			if (this.m.IsTravelling)
			{
				local navigator = this.Tactical.getNavigator();
				local settings = navigator.createSettings();
				settings.ActionPointCosts = _entity.getActionPointCosts();
				settings.FatigueCosts = _entity.getFatigueCosts();
				settings.FatigueCostFactor = 0.0;
				settings.ActionPointCostPerLevel = _entity.getLevelActionPointCost();
				settings.FatigueCostPerLevel = _entity.getLevelFatigueCost();
				settings.AllowZoneOfControlPassing = false;
				settings.ZoneOfControlCost = this.Const.AI.Behavior.ZoneOfControlAPPenalty;
				settings.AlliedFactions = _entity.getAlliedFactions();
				settings.Faction = _entity.getFaction();
				navigator.findPath(_entity.getTile(), this.m.TargetTile, settings, this.m.Skill.getMaxRange());

				if (this.Const.AI.PathfindingDebugMode)
					navigator.buildVisualisation(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());

				local movement = navigator.getCostForPath(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());
				this.getAgent().adjustCameraToDestination(movement.End);

				if (this.Const.AI.VerboseMode)
					this.logInfo("* " + _entity.getName() + ": Moving into range to buff allies");

				this.m.IsFirstExecuted = false;
				return false;
			}
			else
			{
				if (this.m.TargetTile.IsVisibleForPlayer && _entity.isHiddenToPlayer())
				{
					_entity.setDiscovered(true);
					_entity.getTile().addVisibilityForFaction(this.Const.Faction.Player);
				}

				this.getAgent().adjustCameraToTarget(this.m.TargetTile);
				this.m.IsFirstExecuted = false;
				return false;
			}
		}

		if (this.m.IsTravelling)
		{
			if (!this.Tactical.getNavigator().travel(_entity, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue()))
			{
				this.m.TargetTile = null;
				return true;
			}
		}
		else
		{
			if (this.Const.AI.VerboseMode)
				this.logInfo("* " + _entity.getName() + ": Using Dryad Buffs!");

			if (this.m.Skill.use(this.m.TargetTile))
			{
				if (!_entity.isHiddenToPlayer() || this.m.TargetTile.IsVisibleForPlayer)
				{
					this.getAgent().declareAction();
					this.getAgent().declareEvaluationDelay();
				}
			}

			this.m.Skill = null;
			this.m.TargetTile = null;
			return true;
		}
	}

	function onSortByScore( _a, _b )
	{
		if (_a.Score > _b.Score)
			return -1;
		else if (_a.Score < _b.Score)
			return 1;

		return 0;
	}

});