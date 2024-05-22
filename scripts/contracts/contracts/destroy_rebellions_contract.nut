this.destroy_rebellions_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Reward = 0,
		Kidnapper = null,
		Militia = null
	},
	function create()
	{
		this.contract.create();
		local r = this.Math.rand(1, 100);

		if (r <= 30)
		{
			this.m.DifficultyMult = this.Math.rand(90, 105) * 0.01;
		}
		else if (r <= 80)
		{
			this.m.DifficultyMult = this.Math.rand(115, 135) * 0.01;
		}
		else
		{
			this.m.DifficultyMult = this.Math.rand(145, 165) * 0.01;
		}		
		this.m.Type = "contract.destroy_rebellions";
		this.m.Name = "Destroy Rebellions";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 5.0;
		this.m.MakeAllSpawnsResetOrdersOnContractEnd = false;
		this.m.MakeAllSpawnsAttackableByAIOnceDiscovered = true;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		if (this.m.Home == null)
		{
			this.setHome(this.World.State.getCurrentTown());
		}	
		this.m.Payment.Pool = 1500 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

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
				{
					this.Contract.setScreen("Intro");
				}
				else
				{
					this.Contract.setScreen("Task");
				}
			}

			function end()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());	
				local playerTile = this.World.State.getPlayer().getTile();
				local nearest_bandits = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getNearestSettlement(playerTile);				
				local nearest_barbarians = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Barbarians).getNearestSettlement(playerTile);	
				local nearest_nomads = this.World.FactionManager.getFactionOfType(this.Const.FactionType.OrientalBandits).getNearestSettlement(playerTile);					
				
				if (nearest_bandits.getTile().getDistanceTo(this.Contract.m.Home.getTile()) <= nearest_barbarians.getTile().getDistanceTo(this.Contract.m.Home.getTile()) && nearest_bandits.getTile().getDistanceTo(this.Contract.m.Home.getTile()) <= nearest_nomads.getTile().getDistanceTo(this.Contract.m.Home.getTile()))		
				{
					this.Flags.set("IsBrigand", true);
				}
				else if (nearest_nomads.getTile().getDistanceTo(this.Contract.m.Home.getTile()) <= nearest_bandits.getTile().getDistanceTo(this.Contract.m.Home.getTile()) && nearest_nomads.getTile().getDistanceTo(this.Contract.m.Home.getTile()) <= nearest_barbarians.getTile().getDistanceTo(this.Contract.m.Home.getTile()))		
				{
					this.Flags.set("IsNomad", true);
				}
				else if (nearest_barbarians.getTile().getDistanceTo(this.Contract.m.Home.getTile()) <= nearest_bandits.getTile().getDistanceTo(this.Contract.m.Home.getTile()) && nearest_barbarians.getTile().getDistanceTo(this.Contract.m.Home.getTile()) <= nearest_nomads.getTile().getDistanceTo(this.Contract.m.Home.getTile()))		
				{
					this.Flags.set("IsBarbarian", true);
				}

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
				{
					if (l.isActive() && l.isUsable())
					{
						targets.push(l);
					}
				}

				this.Flags.set("ActiveLocations", targets.len());

				for( local i = 0; i != number; i = ++i )
				{
					local party;					
					if (this.Flags.get("IsBrigand"))
					{
						local f = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits);					
						party = f.spawnEntity(nearest_bandits.getTile(), "Rebellions", false, this.Const.World.Spawn.BanditMilitary, (225 + (this.Math.rand(100, 130) - 20 * number) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult()));
						party.setDescription("A group of outlaws, trying to overthrow the noble house.");
						party.getSprite("body").setBrush("figure_player_02");
						party.getSprite("banner").setBrush(nearest_bandits.getBanner());						
					}
					else if (this.Flags.get("IsNomad"))
					{
						local f = this.World.FactionManager.getFactionOfType(this.Const.FactionType.OrientalBandits);						
						party = f.spawnEntity(nearest_nomads.getTile(), "Rebellions", false, this.Const.World.Spawn.NomadMilitary, (225 + (this.Math.rand(100, 130) - 20 * number) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult()));
						party.setDescription("A group of outlaws, trying to overthrow the noble house.");
						party.getSprite("body").setBrush("figure_player_14");	
						party.getSprite("banner").setBrush(nearest_nomads.getBanner());						
					}
					else if (this.Flags.get("IsBarbarian"))
					{
						local f = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Barbarians);						
						party = f.spawnEntity(nearest_barbarians.getTile(), "Rebellions", false, this.Const.World.Spawn.BarbarianMilitary, (225 + (this.Math.rand(100, 130) - 20 * number) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult()));
						party.setDescription("A group of outlaws, trying to overthrow the noble house.");
						party.getSprite("body").setBrush("figure_wildman_02");
						party.getSprite("banner").setBrush(nearest_barbarians.getBanner());						
					}					
					party.setVisibilityMult(2.0);
					this.Contract.addUnitsToEntity(party, this.Const.World.Spawn.soloHedgeKnight, 100);
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
						{
							this.Contract.setScreen("UndeadAttack");
						}
						else
						{
							this.Contract.setScreen("DefaultAttack");
						}

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
				{
					this.Contract.m.Kidnapper.getSprite("selection").Visible = false;
				}
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					local locations = this.Contract.m.Home.getAttachedLocations();
					local numLocations = 0;

					foreach( l in locations )
					{
						if (l.isActive() && l.isUsable())
						{
							numLocations = ++numLocations;
						}
					}

					if (numLocations == 0 || this.Flags.get("ActiveLocations") - numLocations >= 2)
					{
						this.Contract.setScreen("Failure1");
					}
					else if (this.Flags.get("ActiveLocations") - numLocations >= 1)
					{
						this.Contract.setScreen("Success2");
					}
					else
					{
						this.Contract.setScreen("Success1");
					}

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
			Title = "Negotiations",
			Text = "[img]gfx/ui/events/event_63.png[/img]{%employer%\'s sitting in his chair with pursed lips. He\'s thumbing a dagger around, the tip of it auguring a divot into his desk, and there is more tension than usual in the air. You are gated off from getting anywhere close to he and his underlings. You\'re not sure how, but large golden bars have been brought down from the ceiling. They talk amongst themselves, nodding now and again, before handing a servant a scroll. You watch as the servant rushes to you. He hands it over, and then repeats its words from memory.%SPEECH_ON%A large amount of rebellions are assembled aiming to take over the %townname%, a savage so strong and nasty he threatens to get a horde and after that, well, I suspect the leader of them will want to expand his realm. Considerable crowns are available to dispatch to the coffers of the man or mans who will crush this band of upstarts.%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{What is %townname% prepared to pay for their safety? | This should be worth a good amount of crowns to you, right?}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{I\'m afraid you\'re on your own. | We have more important matters to settle. | I wish you luck, but we\'ll not be part of this.}",
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
			Title = "Near %townname%",
			Text = "[img]gfx/ui/events/event_36.png[/img]The rebellions are in sight! Prepare for battle and protect the town!",
			Image = "",
			List = [],
			Options = [
				{
					Text = "To arms!",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "ItsOver",
			Title = "Near %townname%",
			Text = "[img]gfx/ui/events/event_22.png[/img]{The fighting is over and the men idle in a welcome respite. %employer% will be waiting for you back in town. | With the battle over, you survey the corpses littered across the field. It is a gruesome sight, yet for some reason it spurs you with energy. The ghastly hills of dead only remind you of the vitality you\'ve yet to yield to this horrid world. People like %employer% should come and see it, but he won\'t, so you\'ll have to go and see him instead. | Flesh and bone scattered across the field, hardly discernible from one owner to the next. Black buzzards cycle overhead, halos of chevron shadows rippling over the dead, the birds waiting for the mourners to clear out. %randombrother% comes to your side and asks if they should start the return trip to %employer%. You leave the sight of the battlefield behind and nod. | A peaceful sort of ruin is made of the dead. Like it was their natural state, stiffened and at a permanent loss, and their whole living was but a fleeting fit of an accident finally come to an end. %randombrother% comes up and asks if you\'re alright. You\'re not sure, to be honest, and simply answer that it is time to go see %employer%. | Misshapen men and crooked corpses litter the ground for battle gives the dead no sovereignty over how one comes to a final rest. The bodiless heads look at most peace, for in battle no man or beast has time to truly hack a neck away, it only comes by the quickest and sharpest of blade swings. A part of you hopes to go with such instant finality, but another part hopes you get the chance to take your killer down with you.\n\n %randombrother% comes to your side and asks for orders. You turn away from the field and tell the %companyname% to get ready to return to %employer%.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "We head back to the townhall!",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "ItsOverDidNothing",
			Title = "Near %townname%",
			Text = "[img]gfx/ui/events/event_30.png[/img]Smoke fills the air, smoke and the caustic smell of burning wood, burning livelihoods. %townname%\'s folk put all their hopes into hiring the %companyname%, a fatal mistake.",
			Image = "",
			List = [],
			Options = [
				{
					Text = "That didn\'t go as planned...",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Militia1",
			Title = "At %townname%",
			Text = "[img]gfx/ui/events/event_78.png[/img]{A troop of noble soldiers arrives. Their leading knight tips his helmet.%SPEECH_ON%When they told me to come out this way to aide a sellsword, I said they can go shit that command out their arse. But you know what convinced me? Knowing it was the %companyname%. You\'ve reputation, and I\'ve men to spare for this fight.%SPEECH_OFF%Judging by their equipment, they\'d be best used as a screening force to perhaps draw away elements of the oncoming enemy force. That, or perhaps it\'d be best to just fold them into the company, bolstering your ranks where you\'re already strongest.\n[color=" + this.Const.UI.Color.NegativeValue + "][u]Warning:[/u] [/color]Make sure the sum of your fighting roster and allies is less than 27, or the game will crash.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "A typical standing army will easily handle it.",
					function getResult()
					{
						for( local i = 0; i != 9; i = ++i )
						{
							local militia;

							if (i == 0)
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crKnight_guest");
							}
							else if (i == 1)
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crSquire_guest");							
							}
							else if (i == 2)   //sergeant
							{
								if (this.Flags.get("IsHard"))
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crSergeant_guest");
								}
								else
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crFootman_guest");
								}								
							}
							else if (i == 3)	//standard bearer
							{
								if (this.Flags.get("IsEasy"))
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crBillman_guest");
								}
								else
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crStandardBearer_guest");
								}								
							}
							else if (i <= 5)	//2 footmen
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crFootman_guest");								
							}
							else if (i <= 7)	//2 billmen
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crBillman_guest");								
							}
							else if (i == 8)	//1 arbalester
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crArbalester_guest");								
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
					Text = "Ranged fire support will provide overwhelming combat power.",
					function getResult()
					{
						for( local i = 0; i != 7; i = ++i )
						{
							local militia;

							if (i == 0)
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crKnight_guest");
							}
							else if (i == 1)
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crSquire_guest");							
							}
							else if (i == 2)   //sergeant
							{
								if (this.Flags.get("IsHard"))
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crSergeant_guest");
								}
								else
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crFootman_guest");
								}								
							}
							else if (i == 3)	//standard bearer
							{
								if (this.Flags.get("IsEasy"))
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crBillman_guest");
								}
								else
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crStandardBearer_guest");
								}								
							}
							else if (i <= 6)	//3 arbalesters
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crArbalester_guest");								
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
					Text = "Those strongest soldiers will help us break through thier frontline.",
					function getResult()
					{
						for( local i = 0; i != 6; i = ++i )
						{
							local militia;

							if (i == 0)
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crKnight_guest");
							}
							else if (i == 1)
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crSquire_guest");							
							}
							else if (i == 2)   //sergeant
							{
								if (this.Flags.get("IsHard"))
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crSergeant_guest");
								}
								else
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crFootman_guest");
								}								
							}
							else if (i == 3)	//standard bearer
							{
								if (this.Flags.get("IsEasy"))
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crBillman_guest");
								}
								else
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crStandardBearer_guest");
								}								
							}
							else if (i <= 5)	//2 zweihanders
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crZweihander_guest");								
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
					Text = "Bodyguards are enough.",
					function getResult()
					{
						for( local i = 0; i != 5; i = ++i )
						{
							local militia;

							if (i == 0)
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crKnight_guest");
							}
							else if (i <= 2)
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crSquire_guest");							
							}
							else if (i == 3)   //sergeant
							{
								if (this.Flags.get("IsHard"))
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crSergeant_guest");
								}
								else
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crFootman_guest");
								}								
							}
							else if (i == 4)	//standard bearer
							{
								if (this.Flags.get("IsEasy"))
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crBillman_guest");
								}
								else
								{
									militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crStandardBearer_guest");
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
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_04.png[/img]{You return to %employer% looking rightfully smug.%SPEECH_ON%Work\'s done.%SPEECH_OFF%He nods, tipping a goblet of wine while not necessarily offering it.%SPEECH_ON%Yes. The town is eternally grateful for your help. They are also... monetarily grateful.%SPEECH_OFF%The man gestures toward the corner of the room. You see a satchel of crowns there.%SPEECH_ON%%reward% crowns, just as we had agreed. Thanks again, sellsword.%SPEECH_OFF% | %employer% welcomes your return with a glass of wine.%SPEECH_ON%Drink up, sellsword, you\'ve earned it.%SPEECH_OFF%It tastes... particular. Haughty, if that could be a flavor. Your employer swings around his desk, taking a gleefully happy seat.%SPEECH_ON%You managed to protect the town just as you had promised! I am most impressed.%SPEECH_OFF%He nods, tipping his goblet toward a wooden chest.%SPEECH_ON%MOST impressed.%SPEECH_OFF%You open the chest to find a bevy of golden crowns. | %employer% welcomes you into his room.%SPEECH_ON%I watched from my window, you know? Saw it all. Well, most of it. The good parts, I suppose.%SPEECH_OFF%You raise an eyebrow.%SPEECH_ON%Oh, don\'t give me that look. I don\'t feel bad for enjoying what I saw. We\'re alive, right? Us, the good guys.%SPEECH_OFF%The other eyebrow goes up.%SPEECH_ON%Well... anyway, your payment, as promised.%SPEECH_OFF%The man hands over a chest of %reward% crowns. | When you return to %employer% you find his room has almost been packed up, everything ready to move and go. You raise a bit of humorous concern.%SPEECH_ON%Getting ready to go somewhere?%SPEECH_OFF%The man\'s settled down into his chair.%SPEECH_ON%I had my doubts, sellsword. Can you blame me? For what it\'s worth, you shouldn\'t need doubt my ability to pay.%SPEECH_OFF%He sways a hand across his desk. On the corner is a satchel, lumpy and bulbous with coins.%SPEECH_ON%%reward% crowns, as promised.%SPEECH_OFF% | %employer% raises from his chair when you enter. He bows, somewhat incredulously, but also earnestly. He tips his head toward the window where the din of happy peasants murmurs.%SPEECH_ON%You hear that? You\'ve earned that, mercenary. The people here love you now.%SPEECH_OFF%You nod, but the love of the common man is not what brought you here.%SPEECH_ON%What else have I earned?%SPEECH_OFF%%employer% smiles.%SPEECH_ON%A man on point. I bet that\'s what gives you your... edge. Of course, you\'ve also earned this.%SPEECH_OFF%He heaves a wooden chest onto his desk and unlatches it. The shine of gold crowns warms your heart. | %employer%\'s staring out his window when you enter. He\'s almost in a dreamstate, head bent low to his hand. You interrupt his thoughts.%SPEECH_ON%Thinking of me?%SPEECH_OFF%The man chuckles and playfully clutches his chest.%SPEECH_ON%You are truly the man of my dreams, mercenary.%SPEECH_OFF%He crosses the room and takes a chest from the bookshelf. He unlatches it as he sets it on the table. A glorious pile of gold crowns stare you in the face. %employer% grins.%SPEECH_ON%Now who is dreaming?%SPEECH_OFF% | %employer%\'s at his desk when you enter.%SPEECH_ON%I saw a good deal of it. The killing, the dying.%SPEECH_OFF%You take a seat.%SPEECH_ON%Hope you enjoyed the show. Viewing\'s ain\'t free, though.%SPEECH_OFF%The man nods, taking a satchel and handing it over.%SPEECH_ON%I\'d pay for an encore, but I\'m not sure %townname% wants that.%SPEECH_OFF%}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "{The %companyname% will make good use of this. | Payment for a hard day\'s work.}",
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
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Reward + "[/color] Crowns"
				});
			}

		});
		this.m.Screens.push({
			ID = "Success2",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_30.png[/img]{%employer% welcomes your return with a point out his window.%SPEECH_ON%You see that? There, in the distance.%SPEECH_OFF%You join his side. He asks.%SPEECH_ON%What is it that you see?%SPEECH_OFF%There\'s smoke on the horizon. You let him know that\'s what you see.%SPEECH_ON%Right, smoke. I didn\'t hire you to let the brigands make smoke, understand? Of course... most of the town is still upright...%SPEECH_OFF%He heaves a satchel into your chest.%SPEECH_ON%Good work, sellsword. Just... not good enough.%SPEECH_OFF% | You return to %employer%, he looks a mix of happy and sad, somewhere between drunk and straight. This is not the look you want to see.%SPEECH_ON%You did good, sellsword. Word has it you laid those brigands utterly flat. Word also has it that they burned parts of our outskirts.%SPEECH_OFF%You nod. Not worth lying about what you can\'t cover up.%SPEECH_ON%You\'ll be getting paid, but you have to understand that it takes money to rebuild those areas. Obviously, the crowns for that will be coming out of your pockets...%SPEECH_OFF% | %employer%\'s slouched in his seat when you return.%SPEECH_ON%Most in %townname% are happy, but a few are not. Can you guess which of those aren\'t?%SPEECH_OFF%The brigands did manage to destroy a few parts of the outskirts, but this here was rhetorical question.%SPEECH_ON%I need funds to help rebuild the territories those marauders managed to get their hands on. I\'m sure you understand, then, why you\'ll be receiving less pay...%SPEECH_OFF%You shrug. It is what it is. | %employer%\'s at his bookshelf. He takes a book, spinning around and opening it all in one move. He lays it across his table.%SPEECH_ON%There\'s numbers there. I\'m sure you can\'t read them, but here\'s what they say: the brigands managed to destroy parts of this town and now I need crowns to help rebuild. Unfortunately, I don\'t have that many crowns on hand to do this. I\'m sure you understand this predicament.%SPEECH_OFF%You nod and state the obvious.%SPEECH_ON%It\'s coming out of my pay.%SPEECH_OFF%The man nods and slides an open hand across his desk, drawing your attention to a satchel. There\'s no point in arguing about pay. You take the sack and make your leave.}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "{That\'s just half of what we agreed to! | It is what it is...}",
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
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Reward + "[/color] Crowns"
				});
				this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/raided_situation"), 3, this.Contract.m.Home, this.List);
			}

		});
		this.m.Screens.push({
			ID = "Failure1",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_30.png[/img]{When you enter %employer%\'s room, he tells you to close the door behind you. Just as the latch clicks, the man slams you with a stream of obscenities which you couldn\'t hope to keep track of. Calming down, his voice - and language - return to some level of normalcy.%SPEECH_ON%Every bit of our outskirts were destroyed. What is it, exactly, did you think I was paying you for? Get out of here.%SPEECH_OFF% | %employer%\'s slamming back goblets of wine when you enter. There\'s the din of angry peasants squalling outside his window.%SPEECH_ON%Hear that? They\'ll have my head if I pay you, sellsword. You had one job, one job! Protect this town. And you couldn\'t do it. So now you could do one thing and it comes free: get the hell out of my sight.%SPEECH_OFF% | %employer% clasps his hands over his desk.%SPEECH_ON%What is it, exactly, are you expecting to get here? I\'m surprised you returned to me at all. Half the town is on fire and the other half is already ash. I didn\'t hire you to produce smoke and desolation, sellsword. Get the hell out of here.%SPEECH_OFF% | When you return to %employer%, he\'s holding a mug of ale. His hand his shaking. His face is red.%SPEECH_ON%It\'s taking everything in me to not throw this in your face right now.%SPEECH_OFF%Just in case, the man finishes the drink in one big gulp. He slams it on his desk.%SPEECH_ON%This town expected you protect them. Instead, the brigands swarmed the outskirts like they were taking a goddam leisure trip! I\'m not in the business of giving marauders a good time, sellsword. Get the farkin\' hell out of here!%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "{We should have asked for more payment in advance... | Damnit!}",
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

