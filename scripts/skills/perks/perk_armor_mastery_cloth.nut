this.perk_armor_mastery_cloth <- this.inherit("scripts/skills/skill", {
	m = {
		dashCost = 4
	},
	function create()
	{
		this.m.ID = "perk.armor_mastery_cloth";
		this.m.Name = this.Const.Strings.PerkName.ArmorMasteryCloth;
		this.m.Description = this.Const.Strings.PerkDescription.ArmorMasteryCloth;
		this.m.Icon = "ui/perks/crSpecialize_ca.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function enemyCheck()
	{
		local actor = this.getContainer().getActor();
		if (actor.getTile().hasZoneOfControlOtherThan(actor.getAlliedFactions()))
		{
			local myTile = this.getContainer().getActor().getTile();

			for( local i = 0; i < 6; i++ )
			{
				if (myTile.hasNextTile(i))
				{
					local nextTile = myTile.getNextTile(i);

					if (nextTile.IsOccupiedByActor && this.Math.abs(nextTile.Level - myTile.Level) <= 1)
					{
						local entity = nextTile.getEntity();

						if (!entity.getCurrentProperties().IsStunned && !entity.isAlliedWith(this.getContainer().getActor()))
							return true;
					}
				}
			}
		}
		return false;  // Ensure a boolean is always returned
	}

	function teleportMe( _user, _targetTile )
	{
		local tag = {
			Skill = this,
			User = _user,
			OldTile = _user.getTile(),
			TargetTile = _targetTile,
			OnRepelled = this.onRepelled
		};

		if (tag.OldTile.IsVisibleForPlayer || _targetTile.IsVisibleForPlayer)
		{
			local myPos = _user.getPos();
			local targetPos = _targetTile.Pos;
			local distance = tag.OldTile.getDistanceTo(_targetTile);
			local Dx = (targetPos.X - myPos.X) / distance;
			local Dy = (targetPos.Y - myPos.Y) / distance;

			// Add an incremental loop to find the tile
			for( local i = 0; i < distance; i++ )
			{
				local x = myPos.X + Dx * i;
				local y = myPos.Y + Dy * i;
				local tile = this.Tactical.worldToTile(this.createVec(x, y));

				if (this.Tactical.isValidTile(tile.X, tile.Y) && this.Const.Tactical.DustParticles.len() != 0)
				{
					for( local j = 0; j < this.Const.Tactical.DustParticles.len(); j++ )
					{
						this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DustParticles[j].Brushes, this.Tactical.getTile(tile), this.Const.Tactical.DustParticles[j].Delay, this.Const.Tactical.DustParticles[j].Quantity * 0.5, this.Const.Tactical.DustParticles[j].LifeTimeQuantity * 0.5, this.Const.Tactical.DustParticles[j].SpawnRate, this.Const.Tactical.DustParticles[j].Stages);
					}
				}
			}
		}

		this.Tactical.getNavigator().teleport(_user, _targetTile, this.onTeleportDone, tag, false, 2.0);
		return true;
	}

	function onRepelled( _tag )
	{
		this.Tactical.getNavigator().teleport(_tag.User, _tag.TargetTile, null, null, false);
	}

	function onTeleportDone( _entity, _tag )
	{
		local myTile = _entity.getTile();
		local potentialVictims = [];
		local betterThanNothing;
		local ZOC = [];
		local dirToTarget = _tag.OldTile.getDirectionTo(myTile);

		for( local i = 0; i != 6; i = i )
		{
			if (!myTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = myTile.getNextTile(i);

				if (!tile.IsOccupiedByActor)
				{
				}
				else
				{
					local actor = tile.getEntity();

					if (actor.isAlliedWith(_entity) || actor.getCurrentProperties().IsStunned)
					{
					}
					else
					{
						ZOC.push(actor);

						if (i != dirToTarget && i + 1 != dirToTarget && i - 1 != dirToTarget)
						{
						}
						else
						{
							if (betterThanNothing == null)
							{
								betterThanNothing = actor;
							}

							if (actor.getCurrentProperties().IsImmuneToStun)
							{
							}
							else
							{
								potentialVictims.push(actor);
							}
						}
					}
				}
			}

			i = ++i;
		}

		local zoc_fail = false;

		foreach( actor in ZOC )
		{
			if (actor.onMovementInZoneOfControl(_entity, true))
			{
				if (actor.onAttackOfOpportunity(_entity, true))
				{
					zoc_fail = true;
					local dir = myTile.getDirectionTo(_tag.OldTile);

					if (myTile.hasNextTile(dir))
					{
						local tile = myTile.getNextTile(dir);

						if (tile.IsEmpty && this.Math.abs(tile.Level - myTile.Level) <= 1 && tile.getDistanceTo(actor.getTile()) > 1)
						{
							if (_entity.isAlive() && !_entity.isDying())
							{
								_tag.TargetTile = tile;
								this.Time.scheduleEvent(this.TimeUnit.Virtual, 50, _tag.OnRepelled, _tag);
							}

							if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer)
							{
								this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_entity) + " sprints and is repelled");
							}

							return;
						}
					}

					for( local i = 0; i != 6; i = i )
					{
						if (!myTile.hasNextTile(i))
						{
						}
						else
						{
							local tile = myTile.getNextTile(i);

							if (tile.IsEmpty && this.Math.abs(tile.Level - myTile.Level) <= 1)
							{
								if (_entity.isAlive() && !_entity.isDying())
								{
									_tag.TargetTile = tile;
									this.Time.scheduleEvent(this.TimeUnit.Virtual, 50, _tag.OnRepelled, _tag);
								}

								if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer)
								{
									this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_entity) + " sprints and is repelled");
								}

								return;
							}
						}

						i = ++i;
					}
				}
			}
		}

		if (potentialVictims.len() == 0 && betterThanNothing != null)
		{
			potentialVictims.push(betterThanNothing);
		}

		if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_entity) + " sprints");
		}
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();

		if (this.enemyCheck() == false || actor == null || actor.getCurrentProperties().IsStunned)
			return;

		if (actor.getCurrentProperties().IsRooted && !actor.getSkills().getSkillByID("perk.legend_escape_artist"))
			return;

		local currentTile = actor.getTile();
		local closestTile = null;
		local minDistance = 99;
		local mapSize = this.Tactical.getMapSize();

		for( local x = 1; x < mapSize.X - 1; x++ )
		{
			for( local y = 1; y < mapSize.Y - 1; y++ )
			{
				local tile = this.Tactical.getTileSquare(x, y);

				if (tile.IsOccupiedByActor || tile.hasZoneOfControlOtherThan(actor.getAlliedFactions()))
					continue;

				local distance = currentTile.getDistanceTo(tile);
				if (distance < minDistance)
				{
					minDistance = distance;
					closestTile = tile;
				}
			}
		}

		if (closestTile != null)
		{
			this.teleportMe(actor, closestTile);
			actor.setActionPoints(actor.getActionPoints() - this.m.dashCost)
		}
	}

	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();
		this.m.dashCost = 4;

		local skills = [
			"perk.legend_blend_in",
			"perk.legend_small_target",
			"perk.legend_fashionable"
		];

		foreach( skillID in skills ) // Iterate over the skill IDs
		{
			local skill = actor.getSkills().getSkillByID(skillID);

			if (skill) // Check if the actor has the skill and if they do reduce the AP cost by 1 for each skill
				this.m.dashCost--;
		}
	}

});