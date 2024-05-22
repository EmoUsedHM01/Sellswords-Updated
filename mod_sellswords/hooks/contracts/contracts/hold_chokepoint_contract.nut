::mods_hookExactClass("contracts/contracts/hold_chokepoint_contract", function(o)
{
	local ws_createStates = o.createStates;
	o.createStates = function()
	{
		ws_createStates();

		foreach (state in this.m.States)
		{
			if (state.ID != "Running_Defend") continue;
			
			state.update = function()
			{
				if (this.Flags.get("IsFailure") || !this.Contract.isPlayerNear(this.Contract.m.Destination, 600))
				{
					this.Contract.setScreen("Failure");
					this.World.Contracts.showActiveContract();
					return;
				}

				if (this.Flags.get("Wave") > this.Flags.get("WavesDefeated") && (this.Contract.m.Target == null || this.Contract.m.Target.isNull() || !this.Contract.m.Target.isAlive()))
				{
					this.Flags.increment("WavesDefeated", 1);
					this.Flags.set("WaitUntil", this.Time.getVirtualTimeF() + this.Math.rand(3, 6));

					if (this.Flags.get("WavesDefeated") == 1)
					{
						this.Contract.setScreen("Waiting1");
					}
					else if (this.Flags.get("WavesDefeated") == 2)
					{
						this.Contract.setScreen("Waiting2");
					}
					else if (this.Flags.get("WavesDefeated") == 3)
					{
						this.Contract.setScreen("Victory");
					}

					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("WaitUntil") > 0 && this.Time.getVirtualTimeF() >= this.Flags.get("WaitUntil"))
				{
					this.Flags.set("WaitUntil", 0.0);
					this.Flags.set("IsWaveShown", false);

					if (this.Flags.getAsInt("Wave") == 2 && this.Flags.get("IsEnemyRetreating"))
					{
						this.Contract.setScreen("EnemyRetreats");
						this.World.Contracts.showActiveContract();
						return;
					}
					else if (this.Flags.getAsInt("Wave") == 2 && this.Flags.get("IsUltimatum"))
					{
						this.Contract.setScreen("Ultimatum1");
						this.World.Contracts.showActiveContract();
						return;
					}
					else
					{
						this.Flags.increment("Wave", 1);
						local enemyNobleHouse = this.World.FactionManager.getFaction(this.Flags.get("EnemyID"));
						local candidates = [];

						foreach( s in enemyNobleHouse.getSettlements() )
						{
							if (s.isMilitary())
							{
								candidates.push(s);
							}
						}

						local mapSize = this.World.getMapSize();
						local o = this.Contract.m.Destination.getTile().SquareCoords;
						local tiles = [];

						for( local x = o.X - 3; x < o.X + 3; x = x )
						{
							for( local y = o.Y + 3; y <= o.Y + 6; y = y )
							{
								if (!this.World.isValidTileSquare(x, y))
								{
								}
								else
								{
									local tile = this.World.getTileSquare(x, y);

									if (tile.Type == this.Const.World.TerrainType.Ocean)
									{
									}
									else
									{
										local s = this.Math.rand(0, 3);

										if (tile.Type == this.Const.World.TerrainType.Mountains)
										{
											s = s - 10;
										}

										if (tile.HasRoad)
										{
											s = s + 10;
										}

										tiles.push({
											Tile = tile,
											Score = s
										});
									}
								}

								y = ++y;
							}

							x = ++x;
						}

						tiles.sort(function ( _a, _b )
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
						});
						local dc = this.World.getTime().Days;
						local party;
						dc = this.Math.min(dc, 300);	
						if (dc < 150)
						{							
							party = enemyNobleHouse.spawnEntity(tiles[0].Tile, candidates[this.Math.rand(0, candidates.len() - 1)].getName() + " Company", true, this.Const.World.Spawn.Noble, (this.Math.rand(100, 120) + this.Flags.get("Wave") * 10 + (this.Flags.get("IsAlliedReinforcements") ? 50 : 0)) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						}
						if (dc >= 150)
						{							
							party = enemyNobleHouse.spawnEntity(tiles[0].Tile, candidates[this.Math.rand(0, candidates.len() - 1)].getName() + " Company", true, this.Const.World.Spawn.Nobleenhanced, (this.Math.rand(120, 135) + this.Flags.get("Wave") * 10 + (this.Flags.get("IsAlliedReinforcements") ? 50 : 0)) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						}						
						party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + enemyNobleHouse.getBannerString());
						party.setDescription("Professional soldiers in service to local lords.");
						party.getLoot().Money = this.Math.rand(50, 200);
						party.getLoot().ArmorParts = this.Math.rand(0, 25);
						party.getLoot().Medicine = this.Math.rand(0, 3);
						party.getLoot().Ammo = this.Math.rand(0, 30);
						local r = this.Math.rand(1, 4);

						if (r == 1)
						{
							party.addToInventory("supplies/bread_item");
						}
						else if (r == 2)
						{
							party.addToInventory("supplies/roots_and_berries_item");
						}
						else if (r == 3)
						{
							party.addToInventory("supplies/dried_fruits_item");
						}
						else if (r == 4)
						{
							party.addToInventory("supplies/ground_grains_item");
						}

						local c = party.getController();
						local attack = this.new("scripts/ai/world/orders/attack_zone_order");
						attack.setTargetTile(this.Contract.m.Destination.getTile());
						c.addOrder(attack);
						local move = this.new("scripts/ai/world/orders/move_order");
						move.setDestination(this.Contract.m.Destination.getTile());
						c.addOrder(move);
						local guard = this.new("scripts/ai/world/orders/guard_order");
						guard.setTarget(this.Contract.m.Destination.getTile());
						guard.setTime(240.0);
						c.addOrder(guard);
						party.setAttackableByAI(false);
						party.setAlwaysAttackPlayer(true);
						party.setOnCombatWithPlayerCallback(this.onDestinationAttacked.bindenv(this));
						this.Contract.m.Target = this.WeakTableRef(party);
					}
				}
			}
		}
	}

	o.spawnAllies = function()
	{
		local cityState = this.World.FactionManager.getFaction(this.getFaction());
		local mapSize = this.World.getMapSize();
		local o = this.m.Destination.getTile().SquareCoords;
		local tiles = [];

		for( local x = o.X - 3; x < o.X + 3; x = x )
		{
			for( local y = o.Y - 6; y <= o.Y - 3; y = y )
			{
				if (!this.World.isValidTileSquare(x, y))
				{
				}
				else
				{
					local tile = this.World.getTileSquare(x, y);

					if (tile.Type == this.Const.World.TerrainType.Ocean)
					{
					}
					else
					{
						local s = this.Math.rand(0, 3);

						if (tile.Type == this.Const.World.TerrainType.Mountains)
						{
							s = s - 10;
						}

						if (tile.HasRoad)
						{
							s = s + 10;
						}

						tiles.push({
							Tile = tile,
							Score = s
						});
					}
				}

				y = ++y;
			}

			x = ++x;
		}

		if (tiles.len() == 0)
		{
			tiles.push({
				Tile = this.m.Destination.getTile(),
				Score = 0
			});
		}

		tiles.sort(function ( _a, _b )
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
		});
		local dc = this.World.getTime().Days;
		local party;
		dc = this.Math.min(dc, 300);	
		if (dc < 150)
		{			
			party = cityState.spawnEntity(tiles[0].Tile, "Regiment of " + cityState.getNameOnly(), true, this.Const.World.Spawn.Southern, this.Math.rand(100, 150) * this.getDifficultyMult() * this.getScaledDifficultyMult());
		}
		else if (dc < 150)
		{			
			party = cityState.spawnEntity(tiles[0].Tile, "Regiment of " + cityState.getNameOnly(), true, this.Const.World.Spawn.Southernenhanced, this.Math.rand(135, 175) * this.getDifficultyMult() * this.getScaledDifficultyMult());
		}		
		party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + cityState.getBannerString());
		party.setDescription("Conscripted soldiers loyal to their city state.");
		party.getLoot().Money = this.Math.rand(100, 300);
		party.getLoot().ArmorParts = this.Math.rand(10, 35);
		party.getLoot().Medicine = this.Math.rand(5, 15);
		party.getLoot().Ammo = this.Math.rand(10, 40);
		local r = this.Math.rand(1, 4);

		if (r <= 2)
		{
			party.addToInventory("supplies/rice_item");
		}
		else if (r == 3)
		{
			party.addToInventory("supplies/dates_item");
		}
		else if (r == 4)
		{
			party.addToInventory("supplies/dried_lamb_item");
		}

		local arr = [
			"trade/silk_item",
			"trade/silk_item",
			"trade/incense_item",
			"trade/spices_item"
		];

		for( local i = 0; i < this.Math.round(r / 2); i++ )
		{
			party.addToInventory(arr[r - 1]);
		}

		local c = party.getController();
		local guard = this.new("scripts/ai/world/orders/guard_order");
		guard.setTarget(this.m.Destination.getTile());
		guard.setTime(240.0);
		c.addOrder(guard);
	}
})