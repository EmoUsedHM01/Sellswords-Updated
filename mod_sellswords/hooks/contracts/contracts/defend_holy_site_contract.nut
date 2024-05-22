::mods_hookExactClass("contracts/contracts/defend_holy_site_contract", function(o)
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
						this.Flags.set("IsQuartermaster", true);
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

					local cityStates = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState);

					foreach( c in cityStates )
					{
						c.addPlayerRelation(-99.0, "Took sides in the war");
					}

					this.Contract.m.Destination.setDiscovered(true);
					this.World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);

					if (this.Contract.getDifficultyMult() >= 0.95)
					{
						local cityState = cityStates[this.Math.rand(0, cityStates.len() - 1)];
						local dc = this.World.getTime().Days;
						local party;
						dc = this.Math.min(dc, 300);	
						if (dc < 150)
						{						
							party = cityState.spawnEntity(this.Contract.m.Destination.getTile(), "Regiment of " + cityState.getNameOnly(), true, this.Const.World.Spawn.Southern, this.Math.rand(100, 150) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						}
						else if (dc >= 150)
						{						
							party = cityState.spawnEntity(this.Contract.m.Destination.getTile(), "Regiment of " + cityState.getNameOnly(), true, this.Const.World.Spawn.Southernenhanced, this.Math.rand(90 + 0.1 * dc, 135 + 0.15 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
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
						p.Music = this.Const.Music.OrientalCityStateTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.Entities = [];
						local dc = this.World.getTime().Days;
						dc = this.Math.min(dc, 300);	
						if (dc < 150)
						{						
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Southern, 130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyID"));
						}
						else if (dc >= 150)
						{						
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Southernenhanced, (115 + 0.15 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyID"));
						}						
						p.EnemyBanners = [
							this.World.FactionManager.getFaction(this.Flags.get("EnemyID")).getPartyBanner()
						];

						if (this.Flags.get("IsLocalsRecruited"))
						{
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.PeasantsArmed, 10, this.Contract.getFaction());
							p.AllyBanners.push("banner_noble_11");
						}

						this.World.Contracts.startScriptedCombat(p, false, true, true);
					}
					else if (this.Flags.get("IsSallyForth"))
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "DefendHolySite";
						p.Music = this.Const.Music.OrientalCityStateTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.Entities = [];
						local dc = this.World.getTime().Days;
						dc = this.Math.min(dc, 300);	
						if (dc < 150)
						{						
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Southern, (this.Flags.get("IsEnemyReinforcements") ? 130 : 100) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyID"));
						}
						else if (dc >= 150)
						{						
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Southern, (this.Flags.get("IsEnemyReinforcements") ? 150 : 120) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Flags.get("EnemyID"));
						}						
						p.EnemyBanners = [
							this.World.FactionManager.getFaction(this.Flags.get("EnemyID")).getPartyBanner()
						];

						if (this.Flags.get("IsLocalsRecruited"))
						{
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.PeasantsArmed, 40 + 0.1 * dc, this.Contract.getFaction());
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
							p.MapSeed = this.Flags.getAsInt("MapSeed");
							p.LocationTemplate.Template[0] = "tactical.southern_ruins";
							p.LocationTemplate.Fortification = this.Flags.get("IsPalisadeBuilt") ? this.Const.Tactical.FortificationType.WallsAndPalisade : this.Const.Tactical.FortificationType.Walls;
							p.LocationTemplate.CutDownTrees = true;
							p.LocationTemplate.ShiftX = -2;
							p.Music = this.Const.Music.OrientalCityStateTracks;
							p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.LineForward;
							p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.LineBack;
							p.AllyBanners = [
								this.World.Assets.getBanner()
							];
							local dc = this.World.getTime().Days;
							dc = this.Math.min(dc, 300);							

							if (this.Flags.get("IsAlliedReinforcements"))
							{
								if (dc < 150)
								{
									this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 50 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
								}
								else if (dc >= 150)
								{
									this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Nobleenhanced, 65 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
								}							
								p.AllyBanners.push(this.World.FactionManager.getFaction(this.Contract.getFaction()).getPartyBanner());
							}

							if (this.Flags.get("IsLocalsRecruited"))
							{
								this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.PeasantsArmed, 40 + 0.1 * dc, this.Contract.getFaction());
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

	local ws_createScreens = o.createScreens;
	o.createScreens = function()
	{
		ws_createScreens();

		foreach (screen in this.m.Screens)
		{
			if (screen.ID != "Preparation3") continue;

			screen.start = function()
			{
				for( local i = 0; i < 2; ++i )
				{
					local r = this.Math.rand(1, 12);
					local item;

					switch(r)
					{
					case 1:
						item = this.new("scripts/items/weapons/oriental/saif");
						break;

					case 2:
						item = this.new("scripts/items/tools/throwing_net");
						break;

					case 3:
						item = this.new("scripts/items/weapons/oriental/polemace");
						break;

					case 4:
						item = this.new("scripts/items/weapons/ancient/broken_ancient_sword");
						break;

					case 5:
						item = this.Const.World.Common.pickArmor([
							[
								1,
								"ancient/ancient_mail"
							]
						]);
						break;

					case 6:
						item = this.new("scripts/items/supplies/ammo_item");
						break;

					case 7:
						item = this.new("scripts/items/supplies/armor_parts_item");
						break;

					case 8:
						item = this.new("scripts/items/shields/ancient/tower_shield");
						break;

					case 9:
						item = this.new("scripts/items/loot/ancient_gold_coins_item");
						break;

					case 10:
						item = this.new("scripts/items/loot/silver_bowl_item");
						break;

					case 11:
						item = this.new("scripts/items/weapons/wooden_stick");
						break;

					case 12:
						local helmet = [
							[
								1,
								"oriental/spiked_skull_cap_with_mail"
							]
						];
						item = this.Const.World.Common.pickHelmet(helmet);
						break;
					}

					if (item.getConditionMax() > 1)
					{
						item.setCondition(this.Math.max(1, item.getConditionMax() * this.Math.rand(10, 50) * 0.01));
					}

					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});
				}

				local amount = this.Math.rand(10, 30);
				this.World.Assets.addArmorParts(amount);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_supplies.png",
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + amount + "[/color] Tools and Supplies."
				});
			}
		}
	}

	o.spawnAlly = function()
	{
		local o = this.m.Destination.getTile().SquareCoords;
		local tiles = [];

		for( local x = o.X - 4; x < o.X + 4; ++x )
		{
			for( local y = o.Y + 4; y <= o.Y + 6; ++y )
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
			}
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
		local f = this.World.FactionManager.getFaction(this.getFaction());
		local candidates = [];

		foreach( s in f.getSettlements() )
		{
			this.logInfo("name: " + s.getName());

			if (s.isMilitary())
			{
				candidates.push(s);
			}
		}
		
		local dc = this.World.getTime().Days;
		local party;
		dc = this.Math.min(dc, 300);
		if (dc < 150)
		{
			party = f.spawnEntity(tiles[0].Tile, candidates[this.Math.rand(0, candidates.len() - 1)].getNameOnly() + " Company", true, this.Const.World.Spawn.Noble, this.Math.rand(100, 150) * this.getDifficultyMult() * this.getScaledDifficultyMult());
		}
		else if (dc >= 150)
		{
			party = f.spawnEntity(tiles[0].Tile, candidates[this.Math.rand(0, candidates.len() - 1)].getNameOnly() + " Company", true, this.Const.World.Spawn.Nobleenhanced, this.Math.rand(90 + 0.1 * dc, 135 + 0.15 * dc) * this.getDifficultyMult() * this.getScaledDifficultyMult());
		}		
		party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + f.getBannerString());
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
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(this.m.Destination.getTile());
		c.addOrder(move);
		local guard = this.new("scripts/ai/world/orders/guard_order");
		guard.setTarget(this.m.Destination.getTile());
		guard.setTime(240.0);
		c.addOrder(guard);
		return party;
	}

	o.spawnEnemy = function()
	{
		local cityState = this.World.FactionManager.getFaction(this.getFaction());
		local o = this.m.Destination.getTile().SquareCoords;
		local tiles = [];

		for( local x = o.X - 4; x < o.X + 4; x = x )
		{
			for( local y = o.Y - 4; y <= o.Y - 3; y = y )
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
		local f = this.World.FactionManager.getFaction(this.m.Flags.get("EnemyID"));
		local candidates = [];

		foreach( s in f.getSettlements() )
		{
			candidates.push(s);
		}
		
		local dc = this.World.getTime().Days;
		local party;
		dc = this.Math.min(dc, 300);
		if (dc < 150)
		{
			party = f.spawnEntity(tiles[0].Tile, "Regiment of " + candidates[this.Math.rand(0, candidates.len() - 1)].getNameOnly(), true, this.Const.World.Spawn.Southern, (this.m.Flags.get("IsEnemyLuredAway") ? 130 : 160) * this.getScaledDifficultyMult());
		}
		if (dc >= 150)
		{
			party = f.spawnEntity(tiles[0].Tile, "Regiment of " + candidates[this.Math.rand(0, candidates.len() - 1)].getNameOnly(), true, this.Const.World.Spawn.Southernenhanced, (this.m.Flags.get("IsEnemyLuredAway") ? 155 : 190) * this.getScaledDifficultyMult());
		}		
		party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + f.getBannerString());
		party.setDescription("Conscripted soldiers loyal to their city state.");
		party.setAttackableByAI(false);
		party.setAlwaysAttackPlayer(true);
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