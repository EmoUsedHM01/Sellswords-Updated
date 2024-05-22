::mods_hookExactClass("contracts/contracts/free_greenskin_prisoners_contract", function(o)
{
	local ws_createScreens = o.createScreens;
	o.createScreens = function()
	{
		ws_createScreens();

		foreach (screen in this.m.Screens)
		{
			switch(screen.ID)
			{
			case "Battlesite2":
				::Mod_Sellswords.HookHelper.getOptionInEventScreen("Let\'s get moving!", screen).getResult = function()
				{
					this.Contract.m.Destination.die();
					this.Contract.m.Destination = null;
					local playerTile = this.World.State.getPlayer().getTile();
					local nearest_goblins = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).getNearestSettlement(playerTile);
					local nearest_orcs = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getNearestSettlement(playerTile);
					local camp;

					if (nearest_goblins.getTile().getDistanceTo(playerTile) <= nearest_orcs.getTile().getDistanceTo(playerTile))
					{
						camp = nearest_goblins;
					}
					else
					{
						camp = nearest_orcs;
					}

					if (this.Flags.get("IsEnemyParty"))
					{
						local tile = this.Contract.getTileToSpawnLocation(playerTile, 10, 15);
						local dc = this.World.getTime().Days;
						dc = this.Math.min(dc, 300);	
						local party;
						if (dc < 150)
						{
							party = this.World.FactionManager.getFaction(camp.getFaction()).spawnEntity(tile, "Greenskin Horde", false, this.Const.World.Spawn.GreenskinHorde, 120 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						}
						else if (dc >= 150)
						{
							party = this.World.FactionManager.getFaction(camp.getFaction()).spawnEntity(tile, "Greenskin Horde", false, this.Const.World.Spawn.GreenskinHordeenhanced, (105 + 0.15 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						}							
						party.getSprite("banner").setBrush(camp.getBanner());
						party.setDescription("A horde of greenskins marching to war.");
						party.setFootprintType(this.Const.World.FootprintsType.Orcs);
						this.Contract.m.UnitsSpawned.push(party);
						party.getLoot().ArmorParts = this.Math.rand(0, 25);
						party.getLoot().Ammo = this.Math.rand(0, 10);
						party.addToInventory("supplies/strange_meat_item");
						this.Contract.m.Destination = this.WeakTableRef(party);
						party.setAttackableByAI(false);
						party.setFootprintSizeOverride(0.75);
						local c = party.getController();
						c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
						local wait = this.new("scripts/ai/world/orders/wait_order");
						wait.setTime(15.0);
						c.addOrder(wait);
						local roam = this.new("scripts/ai/world/orders/roam_order");
						roam.setPivot(camp);
						roam.setMinRange(5);
						roam.setMaxRange(10);
						roam.setAllTerrainAvailable();
						roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
						roam.setTerrain(this.Const.World.TerrainType.Shore, false);
						roam.setTerrain(this.Const.World.TerrainType.Mountains, false);
						c.addOrder(roam);
					}
					else
					{
						this.Contract.m.Destination = this.WeakTableRef(camp);
						camp.clearTroops();

						if (this.Flags.get("IsEmptyCamp"))
						{
							camp.setResources(0);
							this.Contract.m.Destination.setLootScaleBasedOnResources(0);
						}
						else
						{
							this.Contract.m.Destination.setLootScaleBasedOnResources(120 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());

							if (this.Contract.getDifficultyMult() <= 1.15 && !this.Contract.m.Destination.getFlags().get("IsEventLocation"))
							{
								this.Contract.m.Destination.getLoot().clear();
							}

							camp.setResources(this.Math.min(camp.getResources(), 80 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult()));
							local dc = this.World.getTime().Days;
							dc = this.Math.min(dc, 300);		
							if (dc < 150)
							{
								this.Contract.addUnitsToEntity(camp, this.Const.World.Spawn.GreenskinHorde, 120 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
							}
							else if (dc >= 150)
							{
								this.Contract.addUnitsToEntity(camp, this.Const.World.Spawn.GreenskinHordeenhanced, (105 + 0.15 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
							}								
						}
					}

					this.Const.World.Common.addFootprintsFromTo(playerTile, this.Contract.m.Destination.getTile(), this.Const.OrcFootprints, this.Const.World.FootprintsType.Orcs, 0.75, 10.0);
					this.Contract.setState("Pursuit");
					return 0;
				}
				break;

			case "Scouts":
				::Mod_Sellswords.HookHelper.getOptionInEventScreen("To arms!", screen).getResult = function()
				{
					local tile = this.World.State.getPlayer().getTile();
					local p = this.Const.Tactical.CombatInfo.getClone();
					p.TerrainTemplate = this.Const.World.TerrainTacticalTemplate[tile.TacticalType];
					p.Tile = tile;
					p.CombatID = "Scouts";
					p.Music = this.Const.Music.GoblinsTracks;
					p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
					p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
					local nearest_goblins = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).getNearestSettlement(tile);
					local nearest_orcs = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getNearestSettlement(tile);
					local camp;

					if (nearest_goblins.getTile().getDistanceTo(tile) <= nearest_orcs.getTile().getDistanceTo(tile))
					{
						camp = nearest_goblins;
					}
					else
					{
						camp = nearest_orcs;
					}

					p.EnemyBanners.push(camp.getBanner());
					p.Entities = [];
					local dc = this.World.getTime().Days;
					dc = this.Math.min(dc, 300);
					if (dc < 150)
					{
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.GreenskinHorde, 100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).getID());
					}
					else if (dc >= 150)
					{
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.GreenskinHordeenhanced, (90 + 0.1 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).getID());
					}						
					this.World.Contracts.startScriptedCombat(p, false, true, true);
					return 0;
				}
				break;
			}
		}
	}
})