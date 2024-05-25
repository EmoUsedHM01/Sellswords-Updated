::Mod_Sellswords.HooksMod.hook("scripts/contracts/contracts/find_artifact_contract", function(q)
{
	q.createStates = @(__original) function()
	{
		__original();

		foreach (state in this.m.States)
		{
			if (state.ID != "Offer") continue;
			
			state.end = function()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				local r = this.Math.rand(1, 100);

				if (r <= 20)
				{
					this.Flags.set("IsLost", true);
				}

				r = this.Math.rand(1, 100);

				if (r <= 20)
				{
					if (!this.Flags.get("IsLost"))
					{
						this.Flags.set("IsScavengerHunt", true);
					}
				}
				else if (r <= 25)
				{
					this.Flags.set("IsTrap", true);
				}
				else if (r <= 30)
				{
					this.Flags.set("IsTooLate", true);
				}

				if (!this.Contract.m.Destination.getFlags().get("IsEventLocation"))
				{
					this.Contract.m.Destination.getLoot().clear();
				}

				this.Contract.m.Destination.setDiscovered(true);
				this.World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);
				this.Contract.m.Destination.setLootScaleBasedOnResources(130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				this.Contract.m.Destination.clearTroops();
				this.Contract.m.Destination.setResources(this.Math.min(this.Contract.m.Destination.getResources(), 130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult()));

				if (!this.Flags.get("IsLost") && !this.Flags.get("IsTooLate"))
				{
					local dc = this.World.getTime().Days;
					dc = this.Math.min(dc, 300);	
					if (dc < 150)
					{						
						this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.UndeadArmy, 130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}
					else if (dc >= 150)
					{						
						this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.UndeadScourgeenhanced, (115 + 0.15 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}					
				}

				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

			break;
		}
	}

	q.createScreens = @(__original) function()
	{
		__original();

		foreach (screen in this.m.Screens)
		{
			switch(screen.ID)
			{
			case "AlmostLost":
				::Mod_Sellswords.HookHelper.getOptionInEventScreen("Useful knowledge to have.", screen).getResult = function()
				{
					this.Contract.m.Destination.die();
					this.Contract.m.Destination = null;
					local myTile = this.World.State.getPlayer().getTile();
					local undead = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getSettlements();
					local lowestDistance = 9999;
					local best;

					foreach( b in undead )
					{
						if (b.isLocationType(this.Const.World.LocationType.Unique))
						{
							continue;
						}

						local d = myTile.getDistanceTo(b.getTile()) + this.Math.rand(0, 25);

						if (d < lowestDistance)
						{
							lowestDistance = d;
							best = b;
						}
					}

					this.Contract.m.Destination = this.WeakTableRef(best);
					this.Flags.set("DestinationName", this.Contract.m.Destination.getName());
					this.Contract.m.Destination.setDiscovered(true);
					this.World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);
					this.Contract.m.Destination.clearTroops();
					this.Contract.m.Destination.setResources(this.Math.min(this.Contract.m.Destination.getResources(), 130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult()));
					local dc = this.World.getTime().Days;
					dc = this.Math.min(dc, 300);	
					if (dc < 150)
					{								
						this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.UndeadArmy, 130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}
					else if (dc >= 150)
					{								
						this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.UndeadScourgeenhanced, (130 + 0.1 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}						
					this.Contract.getActiveState().start();
					this.World.Contracts.updateActiveContract();
					this.Contract.m.Dude = null;
					return 0;
				}
				break;

			case "Lost":
				::Mod_Sellswords.HookHelper.getOptionInEventScreen("Damnit!", screen).getResult = function()
				{
					this.Contract.m.Destination.die();
					this.Contract.m.Destination = null;
					local myTile = this.World.State.getPlayer().getTile();
					local undead = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getSettlements();
					local lowestDistance = 9999;
					local best;

					foreach( b in undead )
					{
						if (b.isLocationType(this.Const.World.LocationType.Unique))
						{
							continue;
						}

						local d = myTile.getDistanceTo(b.getTile()) + this.Math.rand(0, 25);

						if (d < lowestDistance)
						{
							lowestDistance = d;
							best = b;
						}
					}

					this.Contract.m.Destination = this.WeakTableRef(best);
					this.Flags.set("DestinationName", this.Contract.m.Destination.getName());
					this.Contract.m.Destination.setDiscovered(true);
					this.World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);
					this.Contract.m.Destination.clearTroops();
					this.Contract.m.Destination.setResources(this.Math.min(this.Contract.m.Destination.getResources(), 130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult()));
					local dc = this.World.getTime().Days;
					dc = this.Math.min(dc, 300);	
					if (dc < 150)
					{								
						this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.UndeadArmy, 130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}
					else if (dc >= 150)
					{								
						this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.UndeadScourgeenhanced, (115 + 0.15 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}						
					this.Contract.m.Destination.setLootScaleBasedOnResources(130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());

					if (this.Contract.getDifficultyMult() <= 1.15 && !this.Contract.m.Destination.getFlags().get("IsEventLocation"))
					{
						this.Contract.m.Destination.getLoot().clear();
					}

					this.Contract.getActiveState().start();
					this.World.Contracts.updateActiveContract();
					return 0;
				}
				break;

			case "TooLate1":
				::Mod_Sellswords.HookHelper.getOptionInEventScreen("An unexpected twist!", screen).getResult = function()
				{
					this.Contract.m.Destination.die();
					this.Contract.m.Destination = null;
					local playerTile = this.World.State.getPlayer().getTile();
					local camp = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getNearestSettlement(playerTile);
					local tile = this.Contract.getTileToSpawnLocation(playerTile, 8, 14);
					local dc = this.World.getTime().Days;
					local party;
					dc = this.Math.min(dc, 300);	
					if (dc < 150)
					{								
						party = this.World.FactionManager.getFaction(camp.getFaction()).spawnEntity(tile, this.Flags.get("NemesisNameC"), false, this.Const.World.Spawn.MercenariesLOW, 120 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}
					else if (dc >= 150)
					{								
						party = this.World.FactionManager.getFaction(camp.getFaction()).spawnEntity(tile, this.Flags.get("NemesisNameC"), false, this.Const.World.Spawn.MercenariesLOW, 135 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}						
					party.setFootprintType(this.Const.World.FootprintsType.Mercenaries);
					local n = 0;

					do
					{
						n = this.Math.rand(1, this.Const.PlayerBanners.len());
					}
					while (n == this.World.Assets.getBannerID());

					party.getSprite("banner").setBrush(this.Const.PlayerBanners[n - 1]);
					this.Flags.set("NemesisBanner", n);
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
					roam.setPivot(camp);
					roam.setMinRange(5);
					roam.setMaxRange(10);
					roam.setAllTerrainAvailable();
					roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
					roam.setTerrain(this.Const.World.TerrainType.Shore, false);
					roam.setTerrain(this.Const.World.TerrainType.Mountains, false);
					c.addOrder(roam);
					this.Const.World.Common.addFootprintsFromTo(playerTile, this.Contract.m.Destination.getTile(), this.Const.GenericFootprints, this.Const.World.FootprintsType.Mercenaries, 0.75);
					this.Contract.setState("Running_TooLate");
					return 0;
				}
				break;

			case "ScavengerHunt":
				screen.start = function()
				{
					this.Contract.m.Destination = null;
					local myTile = this.World.State.getPlayer().getTile();
					local undead = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getSettlements();
					local lowestDistance = 9999;
					local best;

					foreach( b in undead )
					{
						if (b.isLocationType(this.Const.World.LocationType.Unique))
						{
							continue;
						}

						local d = myTile.getDistanceTo(b.getTile()) + this.Math.rand(0, 35);

						if (d < lowestDistance)
						{
							lowestDistance = d;
							best = b;
						}
					}

					this.Contract.m.Destination = this.WeakTableRef(best);
					this.Flags.set("DestinationName", this.Contract.m.Destination.getName());
					this.Contract.m.Destination.setDiscovered(true);
					this.World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);
					this.Contract.m.Destination.clearTroops();
					this.Contract.m.Destination.setResources(this.Math.min(this.Contract.m.Destination.getResources(), 120 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult()));
					local dc = this.World.getTime().Days;
					dc = this.Math.min(dc, 300);	
					if (dc < 150)
					{						
						this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.UndeadArmy, 120 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}
					else if (dc >= 150)
					{						
						this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.UndeadScourgeenhanced, (105 + 0.15 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}				
					this.Contract.getActiveState().start();
					this.World.Contracts.updateActiveContract();
				}
				break;
			}
		}
	}
});
