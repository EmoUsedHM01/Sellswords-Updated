::mods_hookExactClass("contracts/contracts/decisive_battle_contract", function(o)
{
	local ws_createStates = o.createStates;
	o.createStates = function()
	{
		ws_createStates();

		foreach (state in this.m.States)
		{
			if (state.ID != "Running_FinalBattle") continue;
			
			state.update = function()
			{
				if (!this.TempFlags.get("IsFinalBattleStarted"))
				{
					this.TempFlags.set("IsFinalBattleStarted", true);
					local tile = this.Contract.getTileToSpawnLocation(this.Contract.m.Warcamp.getTile(), 3, 12, [
						this.Const.World.TerrainType.Shore,
						this.Const.World.TerrainType.Ocean,
						this.Const.World.TerrainType.Mountains,
						this.Const.World.TerrainType.Forest,
						this.Const.World.TerrainType.LeaveForest,
						this.Const.World.TerrainType.SnowyForest,
						this.Const.World.TerrainType.AutumnForest,
						this.Const.World.TerrainType.Swamp,
						this.Const.World.TerrainType.Hills
					], false);
					this.World.State.getPlayer().setPos(tile.Pos);
					this.World.getCamera().moveToPos(this.World.State.getPlayer().getPos());
					
					
					local allyStrength = 90;
					if (this.Flags.get("IsRequisitionFailure"))
					{
						allyStrength = allyStrength - 20;
					}
					if (this.Flags.get("IsDesertersFailed"))
					{
						allyStrength = allyStrength - 20;
					}					
					local enemyStrength = 150;
					if (this.Flags.get("IsScoutsFailed"))
					{
						enemyStrength = enemyStrength + 25;
					}
					if (this.Flags.get("IsInterceptSuppliesFailure"))
					{
						enemyStrength = enemyStrength + 25;
					}
					
					local eparty;
					local fparty;
					local dc = this.World.getTime().Days;
					dc = this.Math.min(dc, 300);					
						
					local e = this.World.FactionManager.getFaction(this.Flags.get("EnemyNobleHouse"));
					if (dc < 150)
					{					
						eparty = e.spawnEntity(tile, "Noble Army", false, this.Const.World.Spawn.Noble, enemyStrength * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						this.Contract.addUnitsToEntity(eparty, this.Const.World.Spawn.MercenariesLOW, 60 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());					
					}
					else if (dc <= 300)
					{					
						eparty = e.spawnEntity(tile, "Noble Army", false, this.Const.World.Spawn.Nobleenhanced, (enemyStrength + 0.15 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						this.Contract.addUnitsToEntity(eparty, this.Const.World.Spawn.MercenariesLOW, (60 + 0.1 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());					
					}
					else
					{					
						eparty = e.spawnEntity(tile, "Noble Army", false, this.Const.World.Spawn.Nobleenhanced, (enemyStrength + 0.15 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						this.Contract.addUnitsToEntity(eparty, this.Const.World.Spawn.MercenariesHIGH, 60 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());					
					}					
					eparty.getSprite("body").setBrush(eparty.getSprite("body").getBrush().Name + "_" + this.World.FactionManager.getFaction(this.Flags.get("EnemyNobleHouse")).getBannerString());				
					eparty.setDescription("Professional soldiers in service to local lords.");						
					eparty.getSprite("banner").setBrush(this.World.FactionManager.getFaction(this.Flags.get("EnemyNobleHouse")).getBannerSmall());
					this.Const.World.Common.addTroop(eparty, {
							Type = this.Const.World.Spawn.Troops.crKnightcommander
						}, true, 100);					
					eparty.getFlags().add("ContractEnemy");					
					this.Contract.m.UnitsSpawned.push(eparty.getID());					
					
					local f = this.World.FactionManager.getFaction(this.Contract.getFaction());
					if (dc < 150)
					{
						fparty = f.spawnEntity(tile, "Noble Army", false, this.Const.World.Spawn.Noble, allyStrength * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}
					else
					{
						fparty = f.spawnEntity(tile, "Noble Army", false, this.Const.World.Spawn.Nobleenhanced, (allyStrength + 0.1 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}	
					this.Const.World.Common.addTroop(fparty, {
							Type = this.Const.World.Spawn.Troops.crKnightcommander
						}, true, 0);					
					fparty.getSprite("body").setBrush(fparty.getSprite("body").getBrush().Name + "_" + this.World.FactionManager.getFaction(this.Contract.getFaction()).getBannerString());
					fparty.setDescription("Professional soldiers in service to local lords.");					
					fparty.getSprite("banner").setBrush(this.World.FactionManager.getFaction(this.Contract.getFaction()).getBannerSmall());	
					fparty.getFlags().add("ContractAlly");						
															
					this.Contract.setState("Running_FinalBattle");				
				}
			};

			state.onPartyDestroyed <- function( _party )
			{
				if (_party.getFlags().has("ContractEnemy"))
				{
					this.Contract.m.Warcamp.die();
					this.Contract.m.Warcamp = null;
					this.Contract.setScreen("BattleWon");
					this.World.Contracts.showActiveContract();					
				}				
				else if (_party.getFlags().has("ContractAlly"))
				{
					this.Contract.m.Warcamp.die();
					this.Contract.m.Warcamp = null;
					this.Contract.setScreen("BattleLost");
					this.World.Contracts.showActiveContract();
				}	
			};
		}
	}
	
	local ws_createScreens = o.createScreens;
	o.createScreens = function()
	{
		ws_createScreens();

		foreach (screen in this.m.Screens)
		{
			switch(screen.ID)
			{
			case "ScoutsSighted":
				screen.start = function()
				{
					local playerTile = this.Contract.m.Warcamp.getTile();
					local tile = this.Contract.getTileToSpawnLocation(playerTile, 5, 8);
					local dc = this.World.getTime().Days;
					local party;
					dc = this.Math.min(dc, 300);
					if (dc < 150)
					{
						party = this.World.FactionManager.getFaction(this.Flags.get("EnemyNobleHouse")).spawnEntity(tile, "Scouts", false, this.Const.World.Spawn.Noble, 60 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}
					else if (dc >= 150)
					{
						party = this.World.FactionManager.getFaction(this.Flags.get("EnemyNobleHouse")).spawnEntity(tile, "Scouts", false, this.Const.World.Spawn.Nobleenhanced, (50 + 0.1 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}				
					party.getSprite("banner").setBrush(this.World.FactionManager.getFaction(this.Flags.get("EnemyNobleHouse")).getBannerSmall());
					party.setDescription("Professional soldiers in service to local lords.");
					party.setFootprintType(this.Const.World.FootprintsType.Nobles);
					this.Contract.m.UnitsSpawned.push(party);
					party.getLoot().Money = this.Math.rand(50, 100);
					party.getLoot().ArmorParts = this.Math.rand(0, 10);
					party.getLoot().Medicine = this.Math.rand(0, 2);
					party.getLoot().Ammo = this.Math.rand(0, 20);
					local r = this.Math.rand(1, 6);

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
					else if (r == 5)
					{
						party.addToInventory("supplies/pickled_mushrooms_item");
					}

					this.Contract.m.Destination = this.WeakTableRef(party);
					party.setAttackableByAI(false);
					party.setFootprintSizeOverride(0.75);
					local c = party.getController();
					c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
					local roam = this.new("scripts/ai/world/orders/roam_order");
					roam.setPivot(this.Contract.m.Warcamp);
					roam.setMinRange(4);
					roam.setMaxRange(9);
					roam.setAllTerrainAvailable();
					roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
					roam.setTerrain(this.Const.World.TerrainType.Shore, false);
					roam.setTerrain(this.Const.World.TerrainType.Mountains, false);
					c.addOrder(roam);
				}
				break;

			case "Ambush":
				foreach(option in screen.Options)
				{
					if (option.Text == "To arms!")
					{
						option.getResult = function()
						{
							local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
							p.CombatID = "Ambush";
							p.Music = this.Const.Music.CivilianTracks;
							p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Center;
							p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Circle;
							local n = 0;

							do
							{
								n = this.Math.rand(1, this.Const.PlayerBanners.len());
							}
							while (n == this.World.Assets.getBannerID());

							p.Entities = [];
							p.EnemyBanners = [
								this.Const.PlayerBanners[n - 1],
								"banner_noble_11"
							];
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.MercenariesLOW, 100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Const.Faction.Enemy);
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.PeasantsArmed, 40 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Const.Faction.Enemy);
							this.World.Contracts.startScriptedCombat(p, false, true, true);
							return 0;
						}
					}
				}
				break;

			case "InterceptSupplies":
				screen.start = function()
				{
					local startTile = this.World.getEntityByID(this.Flags.get("InterceptSuppliesStart")).getTile();
					local destTile = this.World.getEntityByID(this.Flags.get("InterceptSuppliesDest")).getTile();
					local enemyFaction = this.World.FactionManager.getFaction(this.Flags.get("EnemyNobleHouse"));
					local dc = this.World.getTime().Days;
					local party;
					dc = this.Math.min(dc, 300);
					if (dc < 150)
					{
						party = enemyFaction.spawnEntity(startTile, "Supply Caravan", false, this.Const.World.Spawn.NobleCaravan, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}
					else if (dc >= 150)
					{
						party = enemyFaction.spawnEntity(startTile, "Supply Caravan", false, this.Const.World.Spawn.NobleCaravan, (115 + 0.15 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}				
					party.getSprite("base").Visible = false;
					party.getSprite("banner").setBrush(this.World.FactionManager.getFaction(this.Flags.get("EnemyNobleHouse")).getBannerSmall());
					party.setMirrored(true);
					party.setVisibleInFogOfWar(true);
					party.setImportant(true);
					party.setDiscovered(true);
					party.setDescription("A caravan with armed escorts transporting provisions, supplies and equipment between settlements.");
					party.setFootprintType(this.Const.World.FootprintsType.Caravan);
					party.setAttackableByAI(false);
					party.getFlags().add("ContractSupplies");
					this.Contract.m.Destination = this.WeakTableRef(party);
					this.Contract.m.UnitsSpawned.push(party);
					party.getLoot().Money = this.Math.rand(50, 100);
					party.getLoot().ArmorParts = this.Math.rand(0, 10);
					party.getLoot().Medicine = this.Math.rand(0, 2);
					party.getLoot().Ammo = this.Math.rand(0, 20);
					local r = this.Math.rand(1, 6);

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
					else if (r == 5)
					{
						party.addToInventory("supplies/pickled_mushrooms_item");
					}

					local c = party.getController();
					c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
					c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
					local move = this.new("scripts/ai/world/orders/move_order");
					move.setDestination(destTile);
					move.setRoadsOnly(true);
					local despawn = this.new("scripts/ai/world/orders/despawn_order");
					c.addOrder(move);
					c.addOrder(despawn);
				}
				break;

			case "Deserters1":
				screen.start = function()
				{
					local playerTile = this.World.State.getPlayer().getTile();
					local tile = this.Contract.getTileToSpawnLocation(playerTile, 5, 10, [
						this.Const.World.TerrainType.Shore,
						this.Const.World.TerrainType.Mountains
					]);
					local dc = this.World.getTime().Days;
					local party;				
					dc = this.Math.min(dc, 300);
					if (dc < 150)
					{
						party = this.World.FactionManager.getFaction(this.Contract.getFaction()).spawnEntity(tile, "Deserters", false, this.Const.World.Spawn.Noble, 80 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}
					else if (dc >= 150)
					{
						party = this.World.FactionManager.getFaction(this.Contract.getFaction()).spawnEntity(tile, "Deserters", false, this.Const.World.Spawn.Noble, (75 + 0.1 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}				
					party.getSprite("banner").setBrush("banner_deserters");
					party.setFootprintType(this.Const.World.FootprintsType.Nobles);
					party.setAttackableByAI(false);
					party.getController().getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
					party.setFootprintSizeOverride(0.75);
					this.Const.World.Common.addFootprintsFromTo(playerTile, party.getTile(), this.Const.GenericFootprints, this.Const.World.FootprintsType.Nobles, 0.75);
					this.Contract.m.Destination = this.WeakTableRef(party);
					party.getLoot().Money = this.Math.rand(50, 100);
					party.getLoot().ArmorParts = this.Math.rand(0, 10);
					party.getLoot().Medicine = this.Math.rand(0, 2);
					party.getLoot().Ammo = this.Math.rand(0, 20);
					local r = this.Math.rand(1, 6);

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
					else if (r == 5)
					{
						party.addToInventory("supplies/pickled_mushrooms_item");
					}

					local c = party.getController();
					local wait = this.new("scripts/ai/world/orders/wait_order");
					wait.setTime(9000.0);
					c.addOrder(wait);
				}
				break;

			case "BattleWon":
				foreach(option in screen.Options)
				{
					if (option.Text == "Victory!")
					{
						option.getResult = function()
						{
							this.Contract.setState("Return");					
							return 0;
						}
					}
				}
				break;
			}
		}
	}
})