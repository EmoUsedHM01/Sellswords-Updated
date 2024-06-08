this.ai_gruesome_feast_sequence <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		PossibleSkills = [
			"actives.legend_gruesome_feast"
		],
		Skill = null,
		IsTravelling = false,
		IsWaiting = false
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.GruesomeFeast;
		this.m.Order = this.Const.AI.Behavior.Order.GruesomeFeast;
		this.m.IsThreaded = true;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		// Function is a generator.
		this.m.Skill = null;
		this.m.TargetTile = null;
		this.m.IsTravelling = false;
		this.m.IsWaiting = false;
		local time = this.Time.getExactTime();
		local scoreMult = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getCurrentProperties().IsRooted)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getHitpointsPct() >= 1.0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local skills = [];

		foreach( skillID in this.m.PossibleSkills )
		{
			local skill = _entity.getSkills().getSkillByID(skillID);

			if (skill != null && skill.isUsable() && skill.isAffordable())
			{
				skills.push(skill);
			}
		}

		if (skills.len() == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.Skill = skills[this.Math.rand(0, skills.len() - 1)];
		local myTile = _entity.getTile();
		local isInMelee = this.queryTargetsInMeleeRange().len() != 0;
		local inZOC = myTile.getZoneOfControlCountOtherThan(_entity.getAlliedFactions());
		local potentialDanger = this.getPotentialDanger(true);

		if (this.isAllottedTimeReached(time))
		{
			yield null;
			time = this.Time.getExactTime();
		}

		local corpses = this.Tactical.Entities.getCorpses();

		if (corpses.len() == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local allies = this.getAgent().getKnownAllies();
		local potentialCorpses = [];

		if (myTile.IsCorpseSpawned && myTile.Properties.get("Corpse").IsConsumable)
		{
			potentialCorpses.push({
				Tile = myTile,
				Distance = 0,
				Score = 10.0
			});
		}
		else
		{
			foreach( c in corpses )
			{
				if (!c.IsCorpseSpawned || !c.Properties.get("Corpse").IsConsumable)
				{
					continue;
				}

				if (!c.IsEmpty && !(_entity.isAbleToWait() && c.IsOccupiedByActor && c.getEntity().getType() == this.Const.EntityType.Ghoul && c.getEntity().getMoraleState() == this.Const.MoraleState.Fleeing && !c.getEntity().isTurnDone() && c.getDistanceTo(myTile) == 1))
				{
					continue;
				}

				local score = 4.0;
				local dist = c.getDistanceTo(myTile);

				if (dist > this.Const.AI.Behavior.GruesomeFeastMaxDistance)
				{
					continue;
				}

				score = score - dist * this.Const.AI.Behavior.GruesomeFeastDistanceMult;

				if (this.getAgent().getIntentions().IsDefendingPosition && dist > this.m.Skill.getMaxRange())
				{
					continue;
				}

				score = score - this.Const.AI.Behavior.GruesomeFeastWaitPenalty;
				score = score - this.Const.AI.Behavior.GruesomeFeastSpearwallPenalty * this.querySpearwallValueForTile(_entity, c);
				local mag = this.queryOpponentMagnitude(c, this.Const.AI.Behavior.GruesomeFeastMagnitudeMaxRange);
				score = score - mag.Opponents * (1.0 - mag.AverageDistanceScore) * this.Math.maxf(0.5, 1.0 - mag.AverageEngaged) * this.Const.AI.Behavior.GruesomeFeastOpponentValue;

				if (isInMelee && !c.isSameTileAs(myTile))
				{
					score = score - this.Const.AI.Behavior.GruesomeFeastLeaveZOC;
				}

				potentialCorpses.push({
					Tile = c,
					Distance = dist,
					Score = score
				});
			}

			if (potentialCorpses.len() == 0)
			{
				return this.Const.AI.Behavior.Score.Zero;
			}

			potentialCorpses.sort(this.onSortByScore);
		}

		local navigator = this.Tactical.getNavigator();
		local bestTarget;
		local bestIntermediateTile;
		local bestCost = -9999;
		local bestTiles = 0;
		local bestDanger = 0;
		local n = 0;
		local maxRange = this.m.Skill.getMaxRange();

		foreach( t in potentialCorpses )
		{
			n = ++n;

			if (n > this.Const.AI.Behavior.GruesomeFeastMaxAttempts && bestTarget != null)
			{
				break;
			}

			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = this.Time.getExactTime();
			}

			local score = 0 + t.Score;
			local tiles = 0;
			local intermediateTile;
			local danger = 0.0;
			local danger_intermediate = 0.0;

			if (t.Distance > maxRange && t.Tile.IsEmpty)
			{
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

				if (navigator.findPath(_entity.getTile(), t.Tile, settings, maxRange))
				{
					local movementCosts = navigator.getCostForPath(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());

					if (movementCosts.Tiles == 0)
					{
						continue;
					}

					score = score - movementCosts.ActionPointsRequired;

					if (!movementCosts.IsComplete)
					{
						intermediateTile = movementCosts.End;
					}

					if (movementCosts.End.IsBadTerrain)
					{
						score = score - this.Const.AI.Behavior.RaiseUndeadMoveToBadTerrainPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult;
					}

					if (this.getProperties().EngageOnBadTerrainPenaltyMult != 0.0)
					{
						score = score - movementCosts.End.TVLevelDisadvantage;
					}

					score = score + movementCosts.End.Level;

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
							if (d.InZonesOfControl != 0 || opponent.getCurrentProperties().IsStunned)
							{
								score = score - this.Const.AI.Behavior.GruesomeFeastLowDangerPenalty;
							}
							else
							{
								score = score - this.Const.AI.Behavior.GruesomeFeastHighDangerPenalty;
							}
						}

						if (danger >= this.Const.AI.Behavior.GruesomeFeastMaxDanger || danger_intermediate >= this.Const.AI.Behavior.GruesomeFeastMaxDanger)
						{
							break;
						}
					}

					if (danger >= this.Const.AI.Behavior.GruesomeFeastMaxDanger || danger_intermediate >= this.Const.AI.Behavior.GruesomeFeastMaxDanger)
					{
						continue;
					}

					tiles = movementCosts.Tiles;
				}
				else
				{
					continue;
				}
			}
			else
			{
				score = score + myTile.Level;
			}

			if (score > bestCost)
			{
				bestTarget = t.Tile;
				bestCost = score;
				bestTiles = tiles;
				bestIntermediateTile = intermediateTile;
				bestDanger = this.Math.maxf(danger, danger_intermediate);
			}
		}

		if (bestTarget == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.TargetTile = bestTarget;
		this.m.IsTravelling = bestTarget.getDistanceTo(myTile) > this.m.Skill.getMaxRange();

		if (!bestTarget.IsEmpty && !bestTarget.isSameTileAs(myTile))
		{
			this.m.IsWaiting = true;
		}

		if (_entity.getHitpoints() < _entity.getHitpointsMax())
		{
			scoreMult = scoreMult + (1.0 - _entity.getHitpoints() / _entity.getHitpointsMax());
		}

		if (inZOC != 0 && !bestTarget.isSameTileAs(myTile))
		{
			scoreMult = scoreMult * (this.Const.AI.Behavior.GruesomeFeastLeaveZOCMult / inZOC);
		}

		scoreMult = scoreMult - this.Const.AI.Behavior.GruesomeFeastDangerPenaltyMult * bestDanger;
		return this.Math.max(0, this.Const.AI.Behavior.Score.GruesomeFeast * scoreMult);
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
			if (this.m.IsWaiting)
			{
				if (this.Tactical.TurnSequenceBar.entityWaitTurn(_entity))
				{
					if (this.Const.AI.VerboseMode)
					{
						this.logInfo("* " + _entity.getName() + ": Waiting until others have moved!");
					}

					this.m.TargetTile = null;
					return true;
				}
				else
				{
					this.m.IsWaiting = false;
				}
			}

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

				if (!navigator.findPath(_entity.getTile(), this.m.TargetTile, settings, this.m.Skill.getMaxRange()))
				{
					this.logWarning("* " + _entity.getName() + ": Failed to execute path for Gruesome Feast - No path found!");
					return true;
				}

				if (this.Const.AI.PathfindingDebugMode)
				{
					navigator.buildVisualisation(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());
				}

				local movement = navigator.getCostForPath(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());
				this.getAgent().adjustCameraToDestination(movement.End);

				if (this.Const.AI.VerboseMode)
				{
					this.logInfo("* " + _entity.getName() + ": Moving into range to use Gruesome Feast");
				}

				this.m.IsFirstExecuted = false;
				return false;
			}
		}

		if (this.m.IsTravelling)
		{
			if (!this.Tactical.getNavigator().travel(_entity, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue()))
			{
				this.m.IsTravelling = false;

				if (_entity.isAlive() && !this.Tactical.getNavigator().isTravelling(_entity))
				{
					local myTile = _entity.getTile();

					if (myTile.IsCorpseSpawned && myTile.Properties.get("Corpse").IsConsumable)
					{
						if (!this.m.Skill.isAffordable())
						{
							_entity.setActionPoints(0);
						}
						else
						{
							this.useSkill(_entity);
						}
					}
					else if (_entity.getActionPoints() <= 2)
					{
						_entity.setActionPoints(0);
					}
				}

				this.m.TargetTile = null;
				return true;
			}
		}
		else
		{
			this.useSkill(_entity);
			return true;
		}
	}

	function useSkill( _entity )
	{
		if (this.Const.AI.VerboseMode)
		{
			this.logInfo("* " + _entity.getName() + ": Using Gruesome Feast!");
		}

		if (this.m.Skill.use(this.m.TargetTile))
		{
			if (!_entity.isHiddenToPlayer() || this.m.TargetTile.IsVisibleForPlayer)
			{
				this.getAgent().declareAction();
				this.getAgent().declareEvaluationDelay(600);
			}
		}

		this.m.Skill = null;
		this.m.TargetTile = null;
	}

	function onSortByScore( _a, _b )
	{
		if (_a.Score > _b.Score)
		{
			return -1;
		}
		else if (_a.Score < _b.Score)
		{
			return 1;
		}

		return 0;
	}

});

