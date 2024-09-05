::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/tactical_entity_manager", function( q ) {

	q.onResurrect = @(__original) function(_info, _force = false)
	{
		if (!("PlayerID" in _info))
			return __original(_info, _force);
		
		if (this.Tactical.State.m.TacticalDialogScreen.isVisible() || this.Tactical.State.m.TacticalDialogScreen.isAnimating())
		{
			this.Time.scheduleEvent(this.TimeUnit.Rounds, 1, this.Tactical.Entities.resurrect, _info);
			return null;
		}

		if (this.Tactical.Entities.isCombatFinished() || !_force && this.Tactical.Entities.isEnemyRetreating())
			return null;

		local targetTile = _info.Tile;

		if (!targetTile.IsEmpty)
		{
			local knockToTile;

			for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
			{
				if (!targetTile.hasNextTile(i))
				{
				}
				else
				{
					local newTile = targetTile.getNextTile(i);

					if (!newTile.IsEmpty || newTile.IsCorpseSpawned)
					{
					}
					else if (newTile.Level > targetTile.Level + 1)
					{
					}
					else
					{
						knockToTile = newTile;
						break;
					}
				}
			}

			if (knockToTile == null)
			{
				this.Time.scheduleEvent(this.TimeUnit.Rounds, 1, this.Tactical.Entities.resurrect, _info);
				return null;
			}

			this.Tactical.getNavigator().teleport(targetTile.getEntity(), knockToTile, null, null, true);

			if (_info.Tile.IsVisibleForPlayer)
			{
				this.Tactical.CameraDirector.pushMoveToTileEvent(0, _info.Tile, -1, this.onResurrect.bindenv(this), _info, 200, this.Const.Tactical.Settings.CameraNextEventDelay);
				this.Tactical.CameraDirector.addDelay(0.2);
			}
			else if (knockToTile.IsVisibleForPlayer)
			{
				this.Tactical.CameraDirector.pushMoveToTileEvent(0, knockToTile, -1, this.onResurrect.bindenv(this), _info, 200, this.Const.Tactical.Settings.CameraNextEventDelay);
				this.Tactical.CameraDirector.addDelay(0.2);
			}
			else
			{
				this.Tactical.CameraDirector.pushIdleEvent(0, this.onResurrect.bindenv(this), _info, 200, this.Const.Tactical.Settings.CameraNextEventDelay);
				this.Tactical.CameraDirector.addDelay(0.2);
			}

			return null;
		}

		local survivor = this.Tactical.getSurvivorRoster().getAll();
		local player;

		foreach ( s in survivor )
		{
			if (s.getID() == _info.PlayerID)
			{
				player = s;
				break;
			}
		}

		if (player == null)
			return null;

		this.Tactical.Entities.removeCorpse(targetTile);
		targetTile.clear(this.Const.Tactical.DetailFlag.Corpse);
		targetTile.Properties.remove("Corpse");
		targetTile.Properties.remove("IsSpawningFlies");
		this.Const.Movement.AnnounceDiscoveredEntities = false;
		this.Tactical.addEntityToMap(player, targetTile.Coords.X, targetTile.Coords.Y);
		this.Const.Movement.AnnounceDiscoveredEntities = true;
		player.onResurrected(_info);
		player.riseFromGround();

		if (!player.isHiddenToPlayer())
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(entity) + " has risen from the dead");

		return player;
	}

	q.resurrect = @() function(_info, _delay = 0)
	{
		if (_info.Type == "" && !("PlayerID" in _info))
			return;

		if (!this.MSU.Tile.canResurrectOnTile(_info.Tile, true))
			return;

		if (_info.Tile.IsVisibleForPlayer)
		{
			this.Tactical.CameraDirector.addMoveToTileEvent(_delay, _info.Tile, -1, this.onResurrect.bindenv(this), _info, this.Const.Tactical.Settings.CameraWaitForEventDelay, this.Const.Tactical.Settings.CameraNextEventDelay);
			this.Tactical.CameraDirector.addDelay(1.5);
		}
		else
		{
			this.onResurrect(_info);

			if (this.Tactical.TurnSequenceBar.getActiveEntity() != null && this.Tactical.TurnSequenceBar.getActiveEntity().isPlayerControlled())
				this.Tactical.TurnSequenceBar.getActiveEntity().setDirty(true);
		}
	}

});