::mods_hookExactClass("contracts/contracts/defend_holy_site_southern_contract", function(o)
{
	local ws_createStates = o.createStates;
	o.createStates = function()
	{
		ws_createStates();

		foreach (state in this.m.States)
		{
			switch(state.ID)
			{
			case "Offer":
				state.end = function()
				{
					this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
					local r = this.Math.rand(1, 100);

					if (r <= 25)
					{
						this.Flags.set("IsAlchemist", true);
					}

					local r = this.Math.rand(1, 100);

					if (r <= 30)
					{
						this.Flags.set("IsSallyForth", true);
					}
					else if (r <= 60)
					{
						this.Flags.set("IsAlliedSoldiers", true);
					}

					local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
					local houses = [];

					foreach( n in nobles )
					{
						if (n.getFlags().get("IsHolyWarParticipant"))
						{
							n.addPlayerRelation(-99.0, "Took sides in the war");
							houses.push(n);
						}
					}

					this.Contract.m.Destination.setDiscovered(true);
					this.World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);

					if (this.Contract.getDifficultyMult() >= 0.95)
					{
						local f = houses[this.Math.rand(0, houses.len() - 1)];
						local candidates = [];

						foreach( s in f.getSettlements() )
						{
							if (s.isMilitary())
							{
								candidates.push(s);
							}
						}

						local party = f.spawnEntity(this.Contract.m.Destination.getTile(), candidates[this.Math.rand(0, candidates.len() - 1)].getNameOnly() + " Company", true, this.Const.World.Spawn.Noble, this.Math.rand(100, 150) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + f.getBannerString());
						party.setDescription("Professional soldiers in service to local lords.");
						party.getLoot().Money = this.Math.rand(100, 300);
						party.getLoot().ArmorParts = this.Math.rand(10, 35);
						party.getLoot().Medicine = this.Math.rand(5, 15);
						party.getLoot().Ammo = this.Math.rand(10, 40);
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
						local roam = this.new("scripts/ai/world/orders/roam_order");
						roam.setAllTerrainAvailable();
						roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
						roam.setTerrain(this.Const.World.TerrainType.Shore, false);
						roam.setTerrain(this.Const.World.TerrainType.Mountains, false);
						roam.setPivot(this.Contract.m.Destination);
						roam.setMinRange(4);
						roam.setMaxRange(8);
						roam.setTime(300.0);
					}

					local entities = this.World.getAllEntitiesAtPos(this.Contract.m.Destination.getPos(), 1.0);

					foreach( e in entities )
					{
						if (e.isParty())
						{
							e.getController().clearOrders();
						}
					}

					this.Contract.setScreen("Overview");
					this.World.Contracts.setActiveContract(this.Contract);
				}
				break;

			case "Running_Defend":
				state.onDestinationAttacked = function( _dest, _isPlayerInitiated = false )
				{
					if (this.Flags.get("IsSallyForthNextWave"))
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "DefendHolySite";
						p.Music = this.Const.Music.NobleTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.Entities = [];
						local dc = this.World.getTime().Days;
						dc = this.Math.min(dc, 300);
						if (dc < 150)
						{
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyID"));
						}
						else if (dc >= 150)
						{
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Nobleenhanced, (115 + 0.15 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyID"));
						}					
						p.EnemyBanners = [
							this.World.FactionManager.getFaction(this.Flags.get("EnemyID")).getPartyBanner()
						];

						if (this.Flags.get("IsLocalsRecruited"))
						{
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.PeasantsSouthern, 10, this.Contract.getFaction());
							p.AllyBanners.push("banner_noble_11");
						}

						this.World.Contracts.startScriptedCombat(p, false, true, true);
					}
					else if (this.Flags.get("IsSallyForth"))
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "DefendHolySite";
						p.Music = this.Const.Music.NobleTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.Entities = [];
						local dc = this.World.getTime().Days;
						dc = this.Math.min(dc, 300);
						if (dc < 150)
						{
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, (this.Flags.get("IsEnemyReinforcements") ? 130 : 100) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyID"));
						}
						else if (dc >= 150)
						{
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Nobleenhanced, (this.Flags.get("IsEnemyReinforcements") ? 155 : 120) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyID"));
						}					
						p.EnemyBanners = [
							this.World.FactionManager.getFaction(this.Flags.get("EnemyID")).getPartyBanner()
						];

						if (this.Flags.get("IsLocalsRecruited"))
						{
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.PeasantsSouthern, 50, this.Contract.getFaction());
							p.AllyBanners.push("banner_noble_11");
						}

						this.World.Contracts.startScriptedCombat(p, false, true, true);
					}
					else
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
						p.LocationTemplate.OwnedByFaction = this.Const.Faction.Player;
						p.CombatID = "DefendHolySite";

						if (this.Contract.isPlayerAt(this.Contract.m.Destination))
						{
							p.LocationTemplate.Template[0] = "tactical.southern_ruins";
							p.LocationTemplate.Fortification = this.Flags.get("IsPalisadeBuilt") ? this.Const.Tactical.FortificationType.WallsAndPalisade : this.Const.Tactical.FortificationType.Walls;
							p.LocationTemplate.CutDownTrees = true;
							p.LocationTemplate.ShiftX = -4;
							p.Music = this.Const.Music.NobleTracks;
							p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.LineForward;
							p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.LineBack;
							p.AllyBanners = [
								this.World.Assets.getBanner()
							];

							if (this.Flags.get("IsAlliedReinforcements"))
							{
								this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Southern, 50 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
								p.AllyBanners.push(this.World.FactionManager.getFaction(this.Contract.getFaction()).getPartyBanner());
							}

							if (this.Flags.get("IsLocalsRecruited"))
							{
								this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.PeasantsSouthern, 50, this.Contract.getFaction());
								p.AllyBanners.push("banner_noble_11");
							}
						}

						this.World.Contracts.startScriptedCombat(p, false, true, true);
					}
				}
				break;
			}
		}
	}

	o.spawnEnemy = function()
	{
		local cityState = this.World.FactionManager.getFaction(this.getFaction());
		local o = this.m.Destination.getTile().SquareCoords;
		local tiles = [];

		for( local x = o.X - 4; x < o.X + 4; x = x )
		{
			for( local y = o.Y + 4; y <= o.Y + 6; y = y )
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
		local f = this.World.FactionManager.getFaction(this.m.Flags.get("EnemyID"));
		local candidates = [];

		foreach( s in f.getSettlements() )
		{
			if (s.isMilitary())
			{
				candidates.push(s);
			}
		}

		local dc = this.World.getTime().Days;
		dc = this.Math.min(dc, 300);
		local party;
		if (dc < 150)
		{
			party = f.spawnEntity(tiles[0].Tile, candidates[this.Math.rand(0, candidates.len() - 1)].getNameOnly() + " Company", true, this.Const.World.Spawn.Noble, (this.m.Flags.get("IsEnemyLuredAway") ? 130 : 160) * this.getDifficultyMult() * this.getScaledDifficultyMult());
		}
		else if (dc >= 150)
		{
			party = f.spawnEntity(tiles[0].Tile, candidates[this.Math.rand(0, candidates.len() - 1)].getNameOnly() + " Company", true, this.Const.World.Spawn.Nobleenhanced, (this.m.Flags.get("IsEnemyLuredAway") ? 155 : 190) * this.getDifficultyMult() * this.getScaledDifficultyMult());
		}		
		party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + f.getBannerString());
		party.setDescription("Professional soldiers in service to local lords.");
		party.setAttackableByAI(false);
		party.setAlwaysAttackPlayer(true);
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
		attack.setTargetTile(this.m.Destination.getTile());
		c.addOrder(attack);
		local occupy = this.new("scripts/ai/world/orders/occupy_order");
		occupy.setTarget(this.m.Destination);
		occupy.setTime(10.0);
		occupy.setSafetyOverride(true);
		c.addOrder(occupy);
		local guard = this.new("scripts/ai/world/orders/guard_order");
		guard.setTarget(this.m.Destination.getTile());
		guard.setTime(999.0);
		c.addOrder(guard);
		return party;
	}
})