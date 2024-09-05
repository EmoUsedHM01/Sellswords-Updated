this.ai_ghost_teleport <- ::inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		SelectedSkill = null,
		PossibleSkills = [
			"actives.ghost_teleport"
		],
		Inertia = 0,
		LastEvaluateTime = 0,
		LastExecuteTime = 0,
		UnlockTime = 0
	},
	function create()
	{
		this.m.ID = 9;
		this.m.Order = 12;
		this.m.IsThreaded = true;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		// Function is a generator.
		local score = this.getProperties().BehaviorMult[this.m.ID];
		this.m.TargetTile = null;
		this.m.SelectedSkill = null;
		this.m.UnlockTime = 0;
		local time = ::Time.getExactTime();

		if (_entity.isEngagedInMelee())
			return ::Const.AI.Behavior.Score.Zero;

		if (_entity.getActionPoints() != _entity.getActionPointsMax())
			return ::Const.AI.Behavior.Score.Zero;

		if (_entity.getCurrentProperties().IsRooted)
			return ::Const.AI.Behavior.Score.Zero;

		if (_entity.getMoraleState() == ::Const.MoraleState.Fleeing)
			return ::Const.AI.Behavior.Score.Zero;

		if (this.getAgent().getIntentions().IsDefendingPosition)
			return ::Const.AI.Behavior.Score.Zero;

		local skills = [];

		foreach( skillID in this.m.PossibleSkills )
		{
			local skill = _entity.getSkills().getSkillByID(skillID);

			if (skill != null && skill.isUsable() && skill.isAffordable())
			{
				this.m.SelectedSkill = skill;
				break;
			}
		}

		if (this.m.SelectedSkill == null)
			return ::Const.AI.Behavior.Score.Zero;

		if (this.m.LastEvaluateTime == this.m.LastExecuteTime)
			this.m.Inertia = ::Math.maxf(0, this.m.Inertia - 1);
		else
			this.m.Inertia = 0;

		this.m.LastEvaluateTime = ::Tactical.TurnSequenceBar.getCurrentRound();

		if (!this.getAgent().hasKnownOpponent())
			return ::Const.AI.Behavior.Score.Zero;

		score = score - ::Math.min(2, this.m.Inertia) * 0.33;
		local targetsInMelee = this.queryTargetsInMeleeRange();

		if (targetsInMelee.len() != 0)
		{
			foreach( t in targetsInMelee )
			{
				if (t.getMoraleState() == ::Const.MoraleState.Fleeing || t.getCurrentProperties().IsStunned)
					continue;

				local mult = 1.0;

				if (this.isRangedUnit(t))
					mult = 0.33;

				local hitpoints = t.getHitpoints() + t.getArmor(::Const.BodyPart.Body) + t.getArmor(::Const.BodyPart.Head);
				local hitpointsMax = t.getHitpointsMax() + t.getArmorMax(::Const.BodyPart.Body) + t.getArmorMax(::Const.BodyPart.Head);
				score = score + hitpoints / hitpointsMax * 0.2 * mult;
				score = score + (t.getArmor(::Const.BodyPart.Body) + t.getArmor(::Const.BodyPart.Head));
				score = score + t.getCurrentProperties().getMeleeDefense() * 0.5;

				if (this.getAgent().getForcedOpponent() != null && this.getAgent().getForcedOpponent().getID() == t.getID() && ::Math.rand(1, 100) <= 50)
					score = score + 100.0;
			}
		}

		local targets = this.getAgent().getKnownOpponents();
		local potentialDestinations = [];
		local lastResortPotentialDestinations = [];
		local myTile = _entity.getTile();
		local myTileScore;

		foreach( t in targets )
		{
			if (t.Actor.isNull())
				continue;

			local targetTile = t.Actor.getTile();
			local collection = potentialDestinations;

			if (myTile.getDistanceTo(targetTile) > this.m.SelectedSkill.getMaxRange() + 1)
			{
				local betweenTile = myTile.getTileBetweenThisAnd(targetTile);
				targetTile = betweenTile;
				collection = lastResortPotentialDestinations;
			}

			for( local i = 0; i < ::Const.Direction.COUNT; i = ++i )
			{
				if (!targetTile.hasNextTile(i))
				{
				}
				else
				{
					local tile = targetTile.getNextTile(i);

					if (!tile.IsEmpty && !tile.isSameTileAs(myTile) || tile.Type == ::Const.Tactical.TerrainType.Impassable)
					{
					}
					else
					{
						local dist = myTile.getDistanceTo(tile);

						if (dist > this.m.SelectedSkill.getMaxRange())
						{
						}
						else
						{
							local levelDifference = tile.Level - targetTile.Level;

							if (::Math.abs(levelDifference) > 1)
							{
							}
							else
							{
								collection.push({
									Tile = tile,
									LevelDifference = levelDifference,
									UltimateTile = collection == potentialDestinations ? tile : t.Actor.getTile(),
									Score = 0,
									ScoreMult = 1.0,
									DebugTargets = 0.0,
									DebugDanger = 0.0,
									DebugTV = 0.0
								});
							}
						}
					}
				}
			}
		}

		if (potentialDestinations.len() == 0)
		{
			if (lastResortPotentialDestinations.len() == 0)
				return ::Const.AI.Behavior.Score.Zero;

			potentialDestinations = lastResortPotentialDestinations;
		}

		foreach( dest in potentialDestinations )
		{
			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = ::Time.getExactTime();
			}

			local tileScore = 0.0;
			local tileScoreMult = 1.0;
			local before = 0;

			for( local i = 0; i < ::Const.Direction.COUNT; i = ++i )
			{
				if (!dest.Tile.hasNextTile(i))
				{
				}
				else
				{
					local tile = dest.Tile.getNextTile(i);
					local levelDifference = dest.Tile.Level - tile.Level;
					local distToMe = myTile.getDistanceTo(tile);

					if (::Math.abs(levelDifference) > 1)
					{
					}
					else if (tile.IsOccupiedByActor && !tile.getEntity().isAlliedWith(_entity))
					{
						local actor = tile.getEntity();
						local zoc = tile.getZoneOfControlCountOtherThan(actor.getAlliedFactions());
						local isTargetInEnemyZoneOfControl = distToMe > 1 && zoc != 0 || distToMe == 1 && zoc > 1;
						local isTargetArmedWithRangedWeapon = !isTargetInEnemyZoneOfControl && this.isRangedUnit(actor);

						if (isTargetArmedWithRangedWeapon)
						{
							tileScore = tileScore + 3.0 * this.getProperties().EngageTargetArmedWithRangedWeaponMult;
							tileScoreMult = tileScoreMult * 1.1;
						}

						if (actor.getMoraleState() != ::Const.MoraleState.Fleeing && !actor.getCurrentProperties().IsStunned)
						{
							tileScoreMult = tileScoreMult * 0.8;
							local hitpoints = actor.getHitpoints() + actor.getArmor(::Const.BodyPart.Body) + actor.getArmor(::Const.BodyPart.Head);
							local hitpointsMax = actor.getHitpointsMax() + actor.getArmorMax(::Const.BodyPart.Body) + actor.getArmorMax(::Const.BodyPart.Head);

							if (!isTargetArmedWithRangedWeapon)
								tileScore = tileScore - hitpoints / hitpointsMax * 4.0;
						}
						else
						{
							tileScore = tileScore + 2;
						}

						tileScore = tileScore - (actor.getArmor(::Const.BodyPart.Body) + actor.getArmor(::Const.BodyPart.Head));
						tileScore = tileScore - actor.getCurrentProperties().getMeleeDefense() * 0.1;
						tileScore = tileScore + levelDifference * 2 * this.getProperties().EngageOnGoodTerrainBonusMult;

						if (levelDifference > 0)
							tileScoreMult = tileScoreMult * 1.1;
						else if (levelDifference < 0)
							tileScoreMult = tileScoreMult * 0.9;

						if (this.getAgent().getForcedOpponent() != null && this.getAgent().getForcedOpponent().getID() == actor.getID() && ::Math.rand(1, 100) <= 50)
							tileScore = tileScore + 100.0;
					}
					else if (!tile.IsEmpty && !tile.IsOccupiedByActor)
					{
						tileScore = tileScore + 0.5;
					}
				}
			}

			dest.DebugTargets = tileScore - before;
			before = tileScore;
			local dangerTotal = 0.0;
			local dangerCount = 0.0;

			foreach( d in targets )
			{
				if (d.Actor.isNull())
					continue;

				if (this.isRangedUnit(d.Actor))
					continue;

				if (d.Actor.getMoraleState() == ::Const.MoraleState.Fleeing || d.Actor.getCurrentProperties().IsStunned)
					continue;

				local danger = this.queryActorTurnsNearTarget(d.Actor, dest.Tile, _entity);
				local localDanger = 1.0 - ::Math.minf(1.0, danger.Turns);
				dangerTotal = dangerTotal + localDanger;

				if (danger.Turns <= 1.0)
					dangerCount = ++dangerCount;
			}

			tileScore = tileScore - ::Math.maxf(0.0, dangerTotal) * 1.5;
			dest.DebugDanger = tileScore - before;
			before = tileScore;

			if (dest.Tile.IsBadTerrain)
			{
				tileScore = tileScore - ::Const.AI.Behavior.EngageBadTerrainPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult;
				tileScoreMult = tileScoreMult * 0.9;
			}

			if (this.hasNegativeTileEffect(dest.Tile, _entity))
			{
				tileScore = tileScore - ::Const.AI.Behavior.EngageBadTerrainPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult;
				tileScoreMult = tileScoreMult * 0.9;
			}

			tileScore = tileScore + dest.Tile.TVTotal * 0.3 * this.getProperties().EngageOnGoodTerrainBonusMult;
			tileScoreMult = tileScoreMult + dest.Tile.TVTotal * 0.3 * 0.3;
			dest.DebugTV = tileScore - before;

			if (dest.Tile.isSameTileAs(myTile))
			{
				tileScore = tileScore + 2.5;
				myTileScore = dest;
			}

			dest.Score = tileScore;
			dest.ScoreMult = tileScoreMult;
		}

		potentialDestinations.sort(this.onSortByScore);

		if (myTileScore != null && (potentialDestinations[0].Tile.isSameTileAs(myTile) || potentialDestinations[0].Score <= myTileScore.Score))
			return ::Const.AI.Behavior.Score.Zero;

		if (myTile.getDistanceTo(potentialDestinations[0].Tile) == 1 && targetsInMelee.len() == 0 && ::Math.abs(myTile.Level - potentialDestinations[0].Tile.Level) < 2 && this.getProperties().BehaviorMult[::Const.AI.Behavior.ID.EngageMelee] != 0)
			return ::Const.AI.Behavior.Score.Zero;

		local distToDest = myTile.getDistanceTo(potentialDestinations[0].UltimateTile);

		if (distToDest > 4)
		{
			score = score * ::Math.minf(2.0, distToDest / 4.0);
		}
		else if (distToDest < 2 && (potentialDestinations[0].Tile.Level <= myTile.Level || potentialDestinations[0].Tile.IsBadTerrain && !myTile.IsBadTerrain || potentialDestinations[0].Tile.IsBadTerrain && myTile.IsBadTerrain || this.hasNegativeTileEffect(potentialDestinations[0].Tile, _entity) && !this.hasNegativeTileEffect(myTile, _entity) || this.hasNegativeTileEffect(potentialDestinations[0].Tile, _entity) && this.hasNegativeTileEffect(myTile, _entity)))
		{
			score = score * (distToDest / 2.0);
		}
		else if (distToDest == 2 && myTileScore != null && potentialDestinations[0].Score <= myTileScore.Score + 2.5)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		this.m.TargetTile = potentialDestinations[0].Tile;
		this.getAgent().getIntentions().TargetTile = this.m.TargetTile;
		return 350 * score * potentialDestinations[0].ScoreMult;
	}

	function onBeforeExecute( _entity )
	{
		this.getAgent().getOrders().IsEngaging = true;
		this.getAgent().getOrders().IsDefending = false;
		this.getAgent().getIntentions().IsDefendingPosition = false;
		this.m.LastExecuteTime = ::Tactical.TurnSequenceBar.getCurrentRound();
		this.m.Inertia += 2;
	}

	function onExecute( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			this.m.IsFirstExecuted = false;
			this.m.Agent.adjustCameraToTarget(this.m.TargetTile);
			_entity.setActionPoints(::Math.max(0, _entity.getActionPoints() - 5));
			this.m.SelectedSkill.use(this.m.TargetTile);
		}
		else if (!_entity.isStoringColor())
		{
			return true;
		}

		return false;
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

