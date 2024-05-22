::mods_hookExactClass("contracts/contracts/privateering_contract", function(o)
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
				state.start = function()
				{
					this.Flags.set("StartDay", this.World.getTime().Days);
					this.Contract.m.BulletpointsObjectives = [
						"Travel to the lands of %feudfamily%",
						"Raid and burn down places",
						"Destroy any caravans or patrols",
						"Return after 5 days"
					];

					if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.IntroChance)
					{
						this.Contract.setScreen("Intro");
					}
					else
					{
						this.Contract.setScreen("Task");
					}
				};

				state.end = function()
				{
					this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
					local f = this.World.FactionManager.getFaction(this.Flags.get("FeudingHouseID"));
					f.addPlayerRelation(-99.0, "Took sides in the war");
					this.Flags.set("StartDay", this.World.getTime().Days);
					local nonIsolatedSettlements = [];

					foreach( s in f.getSettlements() )
					{
						if (s.isIsolated() || !s.isDiscovered())
						{
							continue;
						}

						nonIsolatedSettlements.push(s);
						local a = s.getActiveAttachedLocations();

						if (a.len() == 0)
						{
							continue;
						}

						local obj = a[this.Math.rand(0, a.len() - 1)];
						this.Contract.m.Objectives.push(this.WeakTableRef(obj));
						obj.clearTroops();
						local dc = this.World.getTime().Days;
						dc = this.Math.min(dc, 300);					

						if (s.isMilitary())
						{
							if (obj.isMilitary())
							{
								if (dc < 150)
								{
									this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.Noble, this.Math.rand(90, 120) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
								}
								else if (dc >= 150)
								{
									this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.Nobleenhanced, this.Math.rand(115, 150) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
								}							
							}
							else
							{
								local r = this.Math.rand(1, 100);

								if (r <= 10)
								{
									if (dc < 150)
									{							
									this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.MercenariesLOW, this.Math.rand(90, 110) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
									}
									else if (dc >= 150)
									{							
									this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.MercenariesLOW, this.Math.rand(110, 140) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
									}								
								}
								else
								{
									if (dc < 150)
									{
										this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.Noble, this.Math.rand(70, 100) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
									}
									else if (dc >= 150)
									{
										this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.Nobleenhanced, this.Math.rand(95, 125) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
									}	
								}
							}
						}
						else if (obj.isMilitary())
						{
							if (dc < 150)
							{					
								this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.Militia, this.Math.rand(80, 110) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
							}
							else if (dc >= 150)
							{					
								this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.Militia, this.Math.rand(100, 135) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
							}						
						}
						else
						{
							local r = this.Math.rand(1, 100);

							if (r <= 15)
							{
								if (dc < 150)
								{							
								this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.MercenariesLOW, this.Math.rand(80, 110) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
								}
								else if (dc >= 150)
								{							
								this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.MercenariesLOW, this.Math.rand(100, 140) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
								}
							}
							else if (r <= 30)
							{
								obj.getFlags().set("HasNobleProtection", true);
								if (dc < 150)
								{
									this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.Noble, this.Math.rand(80, 100) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
								}
								else if (dc >= 150)
								{
									this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.Nobleenhanced, this.Math.rand(100, 125) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
								}
							}
							else if (r <= 70)
							{
								if (dc < 150)
								{					
									this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.Militia, this.Math.rand(70, 110) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
								}
								else if (dc >= 150)
								{					
									this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.Militia, this.Math.rand(90, 135) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
								}
							}
							else
							{
								this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.Peasants, this.Math.rand(70, 100));
							}
						}

						if (this.Contract.m.Objectives.len() >= 3)
						{
							break;
						}
					}

					local origin = nonIsolatedSettlements[this.Math.rand(0, nonIsolatedSettlements.len() - 1)];
					local dc = this.World.getTime().Days;
					dc = this.Math.min(dc, 300);
					local party;
					if (dc < 150)
					{
						if (this.Math.rand(1,100) <= 33)
						{
							party = f.spawnEntity(origin.getTile(), origin.getName() + " Noble man-at-arms", true, this.Const.World.Spawn.Noblewithbaron, 150 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
							party.getSprite("body").setBrush("figure_player_noble");					
						}
						else
						{
							party = f.spawnEntity(origin.getTile(), origin.getName() + " Company", true, this.Const.World.Spawn.Noble, 190 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
							party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + f.getBannerString());						
						}					
					}
					else if (dc >= 150)
					{
						if (this.Math.rand(1,100) <= 50)
						{
							party = f.spawnEntity(origin.getTile(), origin.getName() + " Noble man-at-arms", true, this.Const.World.Spawn.Noblewithbaron, (150 + 0.1 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
							party.getSprite("body").setBrush("figure_player_noble");					
						}
						else
						{
							party = f.spawnEntity(origin.getTile(), origin.getName() + " Company", true, this.Const.World.Spawn.Nobleenhanced, (175 + 0.25 * dc) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
							party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + f.getBannerString());					
						}
					}				
					party.setDescription("Professional soldiers in service to local lords.");
					this.Contract.m.UnitsSpawned.push(party.getID());
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
					local wait = this.new("scripts/ai/world/orders/wait_order");
					wait.setTime(9000.0);
					c.addOrder(wait);
					local r = this.Math.rand(1, 100);

					if (r <= 15)
					{
						local rival = this.World.FactionManager.getFaction(this.Flags.get("RivalHouseID"));

						if (!f.getFlags().get("Betrayed"))
						{
							this.Flags.set("IsChangingSides", true);
							local item = this.new("scripts/items/" + this.Const.Items.NamedWeapons[this.Math.rand(0, this.Const.Items.NamedWeapons.len() - 1)]);
							item.onAddedToStash("");
							this.Contract.m.Item = item;
						}
					}

					this.Contract.setScreen("Overview");
					this.World.Contracts.setActiveContract(this.Contract);
				};
				break;

			case "Running":
				state.start = function()
				{
					this.Contract.m.BulletpointsObjectives = [];

					foreach( obj in this.Contract.m.Objectives )
					{
						if (obj != null && !obj.isNull() && obj.isActive())
						{
							this.Contract.m.BulletpointsObjectives.push("Destroy " + obj.getName() + " near " + obj.getSettlement().getName());
							obj.getSprite("selection").Visible = true;
							obj.setAttackable(true);
							obj.setOnCombatWithPlayerCallback(this.onCombatWithLocation.bindenv(this));
						}
					}

					this.Contract.m.BulletpointsObjectives.push("Destroy any caravans or patrols of %feudfamily%");
					this.Contract.m.BulletpointsObjectives.push("Return in %days%");
					this.Contract.m.CurrentObjective = null;
				};

				state.update = function()
				{
					if (this.Flags.get("LastUpdateDay") != this.World.getTime().Days)
					{
						if (this.World.getTime().Days - this.Flags.get("StartDay") >= 5)
						{
							this.Contract.setScreen("TimeIsUp");
							this.World.Contracts.showActiveContract();
						}
						else
						{
							this.Flags.set("LastUpdateDay", this.World.getTime().Days);
							this.start();
							this.World.State.getWorldScreen().updateContract(this.Contract);
						}
					}

					if (this.Contract.m.UnitsSpawned.len() != 0 && this.Time.getVirtualTimeF() - this.Contract.m.LastOrderUpdateTime > 2.0)
					{
						this.Contract.m.LastOrderUpdateTime = this.Time.getVirtualTimeF();
						local party = this.World.getEntityByID(this.Contract.m.UnitsSpawned[0]);
						local playerTile = this.World.State.getPlayer().getTile();

						if (party != null && party.getTile().getDistanceTo(playerTile) > 3)
						{
							local f = this.World.FactionManager.getFaction(this.Flags.get("FeudingHouseID"));
							local nearEnemySettlement = false;

							foreach( s in f.getSettlements() )
							{
								if (s.getTile().getDistanceTo(playerTile) <= 6)
								{
									nearEnemySettlement = true;
									break;
								}
							}

							if (nearEnemySettlement)
							{
								local c = party.getController();
								c.clearOrders();
								local move = this.new("scripts/ai/world/orders/move_order");
								move.setDestination(this.World.State.getPlayer().getTile());
								c.addOrder(move);
								local wait = this.new("scripts/ai/world/orders/wait_order");
								wait.setTime(this.World.getTime().SecondsPerDay * 1);
								c.addOrder(wait);

								if (party.getTile().getDistanceTo(playerTile) <= 8 && this.Time.getVirtualTimeF() - this.Flags.get("SearchPartyLastNotificationTime") >= 300.0)
								{
									this.Flags.set("SearchPartyLastNotificationTime", this.Time.getVirtualTimeF());
									this.Contract.setScreen("SearchParty");
									this.World.Contracts.showActiveContract();
								}
							}
						}
					}

					if (this.Flags.get("IsChangingSides") && this.Contract.getDistanceToNearestSettlement() >= 5 && this.World.State.getPlayer().getTile().HasRoad && this.Math.rand(1, 1000) <= 1)
					{
						this.Flags.set("IsChangingSides", false);
						this.Contract.setScreen("ChangingSides");
						this.World.Contracts.showActiveContract();
					}

					foreach( i, obj in this.Contract.m.Objectives )
					{
						if (obj != null && !obj.isNull() && !obj.isActive() || obj.getSettlement().getOwner().isAlliedWithPlayer() || obj.isAlliedWithPlayer())
						{
							obj.getSprite("selection").Visible = false;
							obj.setAttackable(false);
							obj.getFlags().set("HasNobleProtection", false);
							obj.setOnCombatWithPlayerCallback(null);
						}

						if (obj == null || obj.isNull() || !obj.isActive() || obj.getSettlement().getOwner().isAlliedWithPlayer() || obj.isAlliedWithPlayer())
						{
							this.Contract.m.Objectives.remove(i);
							this.Flags.set("LastUpdateDay", 0);
							break;
						}
					}
				};
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
			if (screen.ID != "Task") continue;

			screen.Options[0].Text = "{Heading out for five whole days will cost you. | That\'s something the %companyname% can take care of. | Payment?}";
			break;
		}
	}

	o.onPrepareVariables = function( _vars )
	{
		_vars.push([
			"noblehouse",
			this.World.FactionManager.getFaction(this.m.Faction).getName()
		]);
		_vars.push([
			"rivalhouse",
			this.m.Flags.get("RivalHouseName")
		]);
		_vars.push([
			"feudfamily",
			this.m.Flags.get("FeudingHouseName")
		]);
		_vars.push([
			"maxdays",
			"five days"
		]);
		local days = 5 - (this.World.getTime().Days - this.m.Flags.get("StartDay"));
		_vars.push([
			"days",
			days > 1 ? "" + days + " days" : "1 day"
		]);

		if (this.m.Item != null)
		{
			_vars.push([
				"nameditem",
				this.m.Item.getName()
			]);
		}
	}
})