this.ssu_destroy_rebellions_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Reward = 0,
		Kidnapper = null,
		Militia = null,
		Category = ::Const.Contracts.Categories.Battle
	},
	function create()
	{
		this.contract.create();
		local r = this.Math.rand(1, 100);

		if (r <= 30)
			this.m.DifficultyMult = this.Math.rand(90, 105) * 0.01;
		else if (r <= 80)
			this.m.DifficultyMult = this.Math.rand(115, 135) * 0.01;
		else
			this.m.DifficultyMult = this.Math.rand(145, 165) * 0.01;

		this.m.Type = "contract.destroy_rebellions";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Name;
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 5.0;
		this.m.MakeAllSpawnsResetOrdersOnContractEnd = false;
		this.m.MakeAllSpawnsAttackableByAIOnceDiscovered = true;
		this.m.DescriptionTemplates = [
			"Tensions rise in %s. A formidable rebel leader has emerged, spreading chaos and defiance in his wake.",
			"From the heart of %s emerges a rebel leader, determined to overthrow the existing order and claim power.",
			"Behold, the rise of a rebel leader in %s, his defiance unmatched, his cause unstoppable!",
			"The streets of %s are ablaze with rebellion, led by a fierce leader whose resolve is unchallenged and strength unmatched!",
			"The oppressed people of %s rally under the banner of their new leader, a rebel of unmatched determination.",
			"A powerful rebel leader rises in %s, his rule marked by defiance and the promise of change."
		];
	}

	function formatDescription()
	{
		local r = ::MSU.Array.rand(this.m.DescriptionTemplates);

		if (r.find("%") != null)
			r = this.format(r, ::Const.UI.getColorized(this.m.Home.getName(), ::Const.UI.Color.getHighlightLightBackgroundValue()));

		this.m.Description = r;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		if (this.m.Home == null)
			this.setHome(this.World.State.getCurrentTown());

		this.m.Payment.Pool = 1500 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
			this.m.Payment.Completion = 1.0;

		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Beat down the uprising of the rebellions at %townname% and its outskirts"
				];

				if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.IntroChance)
					this.Contract.setScreen("Intro");
				else
					this.Contract.setScreen("Task");
			}

			function end()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());	
				local playerTile = this.World.State.getPlayer().getTile();
				local nearest_bandits = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getNearestSettlement(playerTile);				
				local nearest_barbarians = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Barbarians).getNearestSettlement(playerTile);	
				local nearest_nomads = this.World.FactionManager.getFactionOfType(this.Const.FactionType.OrientalBandits).getNearestSettlement(playerTile);					
				
				if (nearest_bandits.getTile().getDistanceTo(this.Contract.m.Home.getTile()) <= nearest_barbarians.getTile().getDistanceTo(this.Contract.m.Home.getTile()) && nearest_bandits.getTile().getDistanceTo(this.Contract.m.Home.getTile()) <= nearest_nomads.getTile().getDistanceTo(this.Contract.m.Home.getTile()))
					this.Flags.set("IsBrigand", true);
				else if (nearest_nomads.getTile().getDistanceTo(this.Contract.m.Home.getTile()) <= nearest_bandits.getTile().getDistanceTo(this.Contract.m.Home.getTile()) && nearest_nomads.getTile().getDistanceTo(this.Contract.m.Home.getTile()) <= nearest_barbarians.getTile().getDistanceTo(this.Contract.m.Home.getTile()))
					this.Flags.set("IsNomad", true);
				else if (nearest_barbarians.getTile().getDistanceTo(this.Contract.m.Home.getTile()) <= nearest_bandits.getTile().getDistanceTo(this.Contract.m.Home.getTile()) && nearest_barbarians.getTile().getDistanceTo(this.Contract.m.Home.getTile()) <= nearest_nomads.getTile().getDistanceTo(this.Contract.m.Home.getTile()))
					this.Flags.set("IsBarbarian", true);

				local number = 1;				
				if (this.Contract.getDifficultyMult() <= 1.05)
				{
					this.Flags.set("IsEasy", true);
					number = number + this.Math.rand(0, 1);					
				}
				else if (this.Contract.getDifficultyMult() <= 1.35)
				{
					this.Flags.set("IsNormal", true);
					number = number + 1;					
				}
				else
				{
					this.Flags.set("IsHard", true);
					number = number + this.Math.rand(1, 2);					
				}				

				local locations = this.Contract.m.Home.getAttachedLocations();
				local targets = [];

				foreach( l in locations )
					if (l.isActive() && l.isUsable())
						targets.push(l);

				this.Flags.set("ActiveLocations", targets.len());

				for( local i = 0; i != number; i = ++i )
				{
					local party;					
					if (this.Flags.get("IsBrigand"))
					{
						local f = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits);					
						party = f.spawnEntity(nearest_bandits.getTile(), "Rebellions", false, this.Const.World.Spawn.SsuBanditMilitary, (225 + (this.Math.rand(100, 130) - 20 * number) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult()));
						party.setDescription(::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Description);
						party.getSprite("body").setBrush("figure_player_02");
						party.getSprite("banner").setBrush(nearest_bandits.getBanner());						
					}
					else if (this.Flags.get("IsNomad"))
					{
						local f = this.World.FactionManager.getFactionOfType(this.Const.FactionType.OrientalBandits);						
						party = f.spawnEntity(nearest_nomads.getTile(), "Rebellions", false, this.Const.World.Spawn.SsuNomadMilitary, (225 + (this.Math.rand(100, 130) - 20 * number) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult()));
						party.setDescription(::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Description);
						party.getSprite("body").setBrush("figure_player_14");	
						party.getSprite("banner").setBrush(nearest_nomads.getBanner());						
					}
					else if (this.Flags.get("IsBarbarian"))
					{
						local f = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Barbarians);						
						party = f.spawnEntity(nearest_barbarians.getTile(), "Rebellions", false, this.Const.World.Spawn.SsuBarbarianMilitary, (225 + (this.Math.rand(100, 130) - 20 * number) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult()));
						party.setDescription(::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Description);
						party.getSprite("body").setBrush("figure_wildman_02");
						party.getSprite("banner").setBrush(nearest_barbarians.getBanner());						
					}					
					party.setVisibilityMult(2.0);
					this.Contract.addUnitsToEntity(party, this.Const.World.Spawn.SsusoloHedgeKnight, 100);
					party.getLoot().Money = this.Math.rand(250, 350);
					party.getLoot().ArmorParts = this.Math.rand(20, 40);
					party.getLoot().Medicine = this.Math.rand(5, 10);
					party.getLoot().Ammo = this.Math.rand(20, 50);
					party.addToInventory("supplies/roots_and_berries_item");
					party.addToInventory("supplies/dried_fruits_item");
					party.addToInventory("supplies/pickled_mushrooms_item");
					this.Contract.m.UnitsSpawned.push(party.getID());					
					party.setAttackableByAI(false);
					local c = party.getController();
					c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
					c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
					local t = this.Math.rand(0, targets.len() - 1);

					if (i > 0)
					{
						local wait = this.new("scripts/ai/world/orders/wait_order");
						wait.setTime(4.0 * i);
						c.addOrder(wait);
					}

					local move = this.new("scripts/ai/world/orders/move_order");
					move.setDestination(targets[t].getTile());
					c.addOrder(move);
					local raid = this.new("scripts/ai/world/orders/raid_order");
					raid.setTime(40.0);
					raid.setTargetTile(targets[t].getTile());
					c.addOrder(raid);
					targets.remove(t);
				}

				this.Contract.m.Home.setLastSpawnTimeToNow();
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				this.Contract.m.Home.getSprite("selection").Visible = true;
				this.World.FactionManager.getFaction(this.Contract.getFaction()).setActive(false);
			}

			function update()
			{
				if (this.Contract.m.UnitsSpawned.len() == 0 || this.Flags.get("IsEnemyHereDialogShown"))
				{
					local isEnemyGone = true;

					foreach( id in this.Contract.m.UnitsSpawned )
					{
						local p = this.World.getEntityByID(id);

						if (p != null && p.isAlive() && p.getDistanceTo(this.Contract.m.Home) <= 1200.0)
						{
							isEnemyGone = false;
							break;
						}
					}

					if (isEnemyGone)
					{
						if (this.Flags.get("HadCombat"))
						{
							this.Contract.setScreen("ItsOver");
							this.World.Contracts.showActiveContract();
						}

						this.Contract.setState("Return");
						return;
					}
				}

				if (!this.Flags.get("IsEnemyHereDialogShown"))
				{
					local isEnemyHere = false;

					foreach( id in this.Contract.m.UnitsSpawned )
					{
						local p = this.World.getEntityByID(id);

						if (p != null && p.isAlive() && p.getDistanceTo(this.Contract.m.Home) <= 700.0)
						{
							isEnemyHere = true;
							break;
						}
					}

					if (isEnemyHere)
					{
						this.Flags.set("IsEnemyHereDialogShown", true);

						foreach( id in this.Contract.m.UnitsSpawned )
						{
							local p = this.World.getEntityByID(id);

							if (p != null && p.isAlive())
							{
							}
						}

						if (this.Flags.get("IsUndead"))
							this.Contract.setScreen("UndeadAttack");
						else
							this.Contract.setScreen("DefaultAttack");

						this.World.Contracts.showActiveContract();
					}
				}

				if (!this.Flags.get("IsMilitiaDialogShown"))
				{
					this.Flags.set("IsMilitiaDialogShown", true);
					this.Contract.setScreen("Militia1");
					this.World.Contracts.showActiveContract();
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				this.Flags.set("HadCombat", true);
			}

			function onCombatVictory( _combatID )
			{
				this.Flags.set("HadCombat", true);
			}

		});

		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Return to " + this.Contract.m.Home.getName()
				];
				this.Contract.m.Home.getSprite("selection").Visible = true;
				this.World.FactionManager.getFaction(this.Contract.getFaction()).setActive(true);

				if (this.Contract.m.Kidnapper != null && !this.Contract.m.Kidnapper.isNull())
					this.Contract.m.Kidnapper.getSprite("selection").Visible = false;
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					local locations = this.Contract.m.Home.getAttachedLocations();
					local numLocations = 0;

					foreach( l in locations )
						if (l.isActive() && l.isUsable())
							numLocations = ++numLocations;

					if (numLocations == 0 || this.Flags.get("ActiveLocations") - numLocations >= 2)
						this.Contract.setScreen("Failure1");
					else if (this.Flags.get("ActiveLocations") - numLocations >= 1)
						this.Contract.setScreen("Success2");
					else
						this.Contract.setScreen("Success1");

					this.World.Contracts.showActiveContract();
				}
			}

		});
	}

	function createScreens()
	{
		this.importScreens(this.Const.Contracts.NegotiationDefault);
		this.importScreens(this.Const.Contracts.Overview);
		this.m.Screens.push({
			ID = "Task",
			Title = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Title1,
			Text = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Text1,
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Text2,
					function getResult()
					{
						return ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Text3;
					}

				},
				{
					Text = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Text4,
					function getResult()
					{
						this.World.Contracts.removeContract(this.Contract);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "DefaultAttack",
			Title = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Title2,
			Text = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Text5,
			Image = "",
			List = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Text6,
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "ItsOver",
			Title = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Title2,
			Text = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Text7,
			Image = "",
			List = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Text8,
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "ItsOverDidNothing",
			Title = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Title2,
			Text = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Text9,
			Image = "",
			List = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Text10,
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Militia1",
			Title = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Title3,
			Text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Text11, this.Const.UI.Color.NegativeValue),
			Image = "",
			List = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Text12,
					function getResult()
					{
						for( local i = 0; i != 9; i = ++i )
						{
							local militia;

							if (i == 0)
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_knight_guest");
							}
							else if (i == 1)
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_squire_guest");							
							}
							else if (i == 2)   //sergeant
							{
								if (this.Flags.get("IsHard"))
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_sergeant_guest");
								}
								else
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_footman_guest");
								}								
							}
							else if (i == 3)	//standard bearer
							{
								if (this.Flags.get("IsEasy"))
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_billman_guest");
								}
								else
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_standard_bearer_guest");
								}								
							}
							else if (i <= 5)	//2 footmen
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_footman_guest");								
							}
							else if (i <= 7)	//2 billmen
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_billman_guest");								
							}
							else if (i == 8)	//1 arbalester
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_arbalester_guest");								
							}							
							militia.setFaction(this.Contract.getFaction());	
							militia.setPlaceInFormation(18 + i);							
							militia.assignRandomEquipment();
							militia.setFaction(1);								
						}

						return 0;
					}

				},
				{
					Text = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Text13,
					function getResult()
					{
						for( local i = 0; i != 7; i = ++i )
						{
							local militia;

							if (i == 0)
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_knight_guest");
							}
							else if (i == 1)
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_squire_guest");							
							}
							else if (i == 2)   //sergeant
							{
								if (this.Flags.get("IsHard"))
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_sergeant_guest");
								}
								else
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_footman_guest");
								}								
							}
							else if (i == 3)	//standard bearer
							{
								if (this.Flags.get("IsEasy"))
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_billman_guest");
								}
								else
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_standard_bearer_guest");
								}								
							}
							else if (i <= 6)	//3 arbalesters
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_arbalester_guest");								
							}							
							militia.setFaction(this.Contract.getFaction());	
							militia.setPlaceInFormation(20 + i);							
							militia.assignRandomEquipment();
							militia.setFaction(1);								
						}

						return 0;
					}

				},
				{
					Text = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Text14,
					function getResult()
					{
						for( local i = 0; i != 6; i = ++i )
						{
							local militia;

							if (i == 0)
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_knight_guest");
							}
							else if (i == 1)
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_squire_guest");							
							}
							else if (i == 2)   //sergeant
							{
								if (this.Flags.get("IsHard"))
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_sergeant_guest");
								}
								else
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_footman_guest");
								}								
							}
							else if (i == 3)	//standard bearer
							{
								if (this.Flags.get("IsEasy"))
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_billman_guest");
								}
								else
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_standard_bearer_guest");
								}								
							}
							else if (i <= 5)	//2 zweihanders
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_zweihander_guest");								
							}							
							militia.setFaction(this.Contract.getFaction());	
							militia.setPlaceInFormation(21 + i);							
							militia.assignRandomEquipment();
							militia.setFaction(1);								
						}

						return 0;
					}

				},
				{
					Text = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Text15,
					function getResult()
					{
						for( local i = 0; i != 5; i = ++i )
						{
							local militia;

							if (i == 0)
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_knight_guest");
							}
							else if (i <= 2)
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_squire_guest");							
							}
							else if (i == 3)   //sergeant
							{
								if (this.Flags.get("IsHard"))
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_sergeant_guest");
								}
								else
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_footman_guest");
								}								
							}
							else if (i == 4)	//standard bearer
							{
								if (this.Flags.get("IsEasy"))
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_billman_guest");
								}
								else
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/ssu_standard_bearer_guest");
								}								
							}							
							militia.setFaction(this.Contract.getFaction());	
							militia.setPlaceInFormation(22 + i);							
							militia.assignRandomEquipment();
							militia.setFaction(1);								
						}

						return 0;
					}

				}				
			]
		});
		this.m.Screens.push({
			ID = "Success1",
			Title = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Title4,
			Text = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Text16,
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Text17,
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "Defended " + this.Flags.get("ObjectiveName") + " against rebellions");
						this.World.Contracts.finishActiveContract();

						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.m.Reward = this.Contract.m.Payment.getOnCompletion();
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Tooltip, this.Const.UI.Color.PositiveEventValue, this.Contract.m.Reward)
				});
			}

		});
		this.m.Screens.push({
			ID = "Success2",
			Title = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Title4,
			Text = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Text18,
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Text19,
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion() / 2);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "Defended " + this.Flags.get("ObjectiveName") + " against rebellions");
						this.World.Contracts.finishActiveContract();

						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.m.Reward = this.Contract.m.Payment.getOnCompletion() / 2;
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Tooltip, this.Const.UI.Color.PositiveEventValue, this.Contract.m.Reward)
				});
				this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/raided_situation"), 3, this.Contract.m.Home, this.List);
			}

		});
		this.m.Screens.push({
			ID = "Failure1",
			Title = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Title4,
			Text = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Text20,
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract.Text21,
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "Failed to defend " + this.Flags.get("ObjectiveName") + " against rebellions");
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/raided_situation"), 3, this.Contract.m.Home, this.List);
			}

		});
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"reward",
			this.m.Reward
		]);
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			this.World.FactionManager.getFaction(this.getFaction()).setActive(true);
			if (this.m.Home == null)
			{
				this.setHome(this.World.State.getCurrentTown());
			}			
			this.m.Home.getSprite("selection").Visible = false;

			if (this.m.Militia != null && !this.m.Militia.isNull())
			{
				this.m.Militia.getController().clearOrders();
			}

			this.World.getGuestRoster().clear();
		}
	}

	function onIsValid()
	{
		return true;
	}

	function onSerialize( _out )
	{
		this.m.Flags.set("MilitiaID", this.m.Militia != null && !this.m.Militia.isNull() ? this.m.Militia.getID() : 0);
		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.contract.onDeserialize(_in);
		this.m.Militia = this.WeakTableRef(this.World.getEntityByID(this.m.Flags.get("MilitiaID")));
	}

});