this.named_sword_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null,
		namedsword = null,
	},
	function create()
	{
		this.contract.create();
		this.m.DifficultyMult = this.Math.rand(145, 165) * 0.01;		
		this.m.Type = "contract.named_sword";
		this.m.Name = "Explore Treatures";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 14.0;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{		
		local items = [];	
		if (!this.World.Flags.get("excacquired"))
		{
			items.push("Excalibur, the sword in the lake");
		}
		if (!this.World.Flags.get("calacquired"))
		{
			items.push("Caliburnus, the sword in the stone");
		}
		if (!this.World.Flags.get("mikacquired"))
		{
			items.push("Mikazuki, the Crescent Moon");
		}
		if (!this.World.Flags.get("heracquired"))
		{
			items.push("Herbstnebel, the Autumn Mist");
		}
		if (!this.World.Flags.get("calacquired"))
		{
			items.push("Caliburnus, the sword in the stone");
		}
		if (!this.World.Flags.get("calacquired"))
		{
			items.push("Caliburnus, the sword in the stone");
		}
		if (!this.World.Flags.get("calacquired"))
		{
			items.push("Caliburnus, the sword in the stone");
		}		
		
		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}
		
		local items = clone this.Const.Items.NamedWeapons;
		local serial = this.Math.rand(0, items.len());
		local item = this.new("scripts/items/" + items[serial]);

		this.m.Flags.set("PrizeName", item.createRandomName());
		this.m.Flags.set("PrizeScript", item.ClassNameHash);

		local myTile = this.World.State.getPlayer().getTile();
		local objcamp;
		local highestDistance = 0;
		local best;		
		if (serial == 0)
		{
			objcamp = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getSettlements();
			this.m.Flags.set("IsUndead", true);			
		}		
		else if (serial == 1)
		{
			objcamp = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).getSettlements();
			this.m.Flags.set("IsZombies", true);			
		}
		else if (serial == 2)
		{
			objcamp = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getSettlements();
			this.m.Flags.set("IsBandits", true);				
		}
		else if (serial == 3)
		{
			objcamp = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Barbarians).getSettlements();
			this.m.Flags.set("IsBarbarians", true);				
		}
		else if (serial == 4)
		{
			objcamp = this.World.FactionManager.getFactionOfType(this.Const.FactionType.OrientalBandits).getSettlements();
			this.m.Flags.set("IsOrientalBandits", true);				
		}
		else if (serial == 5)
		{
			objcamp = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).getSettlements();
			this.m.Flags.set("IsGoblins", true);				
		}
		else if (serial == 6)
		{
			objcamp = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getSettlements();
			this.m.Flags.set("IsOrcs", true);				
		}		
		foreach( b in objcamp )
		{
			if (b.isLocationType(this.Const.World.LocationType.Unique))
			{
				continue;
			}

			local d = myTile.getDistanceTo(b.getTile()) + this.Math.rand(0, 45);

			if (d > highestDistance)
			{
				highestDistance = d;
				best = b;
			}
		}

		this.m.Destination = this.WeakTableRef(best);
		this.m.Flags.set("DestinationName", this.m.Destination.getName());
		this.m.Payment.Pool = 1200 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();		

		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Go and explore %location%, you'll get a famed %prizetype% called %prizename% as a bonus"
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
				this.Contract.m.Destination.setLastSpawnTimeToNow();
				this.Contract.m.Destination.clearTroops();

				if (this.Contract.getDifficultyMult() <= 1.35 && !this.Contract.m.Destination.getFlags().get("IsEventLocation"))
				{
					this.Contract.m.Destination.getLoot().clear();
				}

				if (this.Flags.get("IsBandits"))
				{
					this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.BanditBoss, 200 + 150 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				}
				else if (this.Flags.get("IsBarbarians"))
				{
					this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.Barbarians, 200 + 150 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				}	
				else if (this.Flags.get("IsOrientalBandits"))
				{
					this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.NomadDefenders, 200 + 150 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				}
				else if (this.Flags.get("IsOrcs"))
				{
					this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.OrcBoss, 200 + 150 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				}	
				else if (this.Flags.get("IsGoblins"))
				{
					this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.GoblinBoss, 200 + 150 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				}
				else if (this.Flags.get("IsUndead"))
				{
					this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.RomaLegion, 150 + 135 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				}				
				else if (this.Flags.get("IsZombies"))	
				{
					this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.Necromancer, 200 + 150 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				}				
				this.Contract.m.Destination.setLootScaleBasedOnResources(110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				//this.Contract.m.Destination.setResources(this.Math.min(this.Contract.m.Destination.getResources(), 70 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult()));
				this.Contract.m.Destination.setDiscovered(true);
				this.World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);

				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = true;
					this.Contract.m.Destination.setOnCombatWithPlayerCallback(this.onDestinationAttacked.bindenv(this));
				}
			}
			function update()
			{
				if (this.Contract.m.Destination == null || this.Contract.m.Destination.isNull())
				{
					this.Contract.setScreen("ItemObtained");
					this.World.Contracts.showActiveContract();
					this.Contract.setState("Return");
				}
			}
			function onDestinationAttacked( _dest, _isPlayerAttacking = true )
			{
				local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
				p.CombatID = "BHattack";
				//this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.BountyHunters, 40 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
				this.World.Contracts.startScriptedCombat(p, true, true, true);				
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
			}
			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
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
			Title = "Negotiations",
			Text = "[img]gfx/ui/events/event_92.png[/img]%employer% welcomes you and walks you toward the town's square. There\'s a party of peasants milling about, but when they see you coming they shape up and start talking as though they\'d been expecting you all along. They mostly talk in descriptors: tall as any man! Armor like you\'d never seen before! Spears as sharp as a peddler\'s tongue! You hold your hand up and ask what it is they are talking about. %employer% laughs.%SPEECH_ON%The men here say they saw some oddities out in a spot by the name of %location%. Naturally, they weren\'t out there for no reason. They were looking for something by the name of %item%, a relic dear to the town for through it we pray for food and shelter.%SPEECH_OFF%One of the peasants speak up.%SPEECH_ON%And we was lookin\' fer it at his behest!%SPEECH_OFF%%employer% nods.%SPEECH_ON%Of course. And where they failed, perhaps you can succeed? Get this relic for me and you\'ll be paid quite well for your services. Let's see, I've heard that a famed item called %prizename% was also buried there. Pay no mind to their fairy tales. I\'m sure there\'s nothing to worry about.%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{How many crowns are we talking about? | What is %townname% prepared to pay for their safety? | Let\'s talk money.}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{Not interested. | We have more important matters to settle. | I wish you luck, but we\'ll not be part of this.}",
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
			ID = "Approaching",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/event_113.png[/img]{You\'ve found the barbarian village and a series of cairns that lead toward it. The stones are stacked in the shapes of men, and at the top of each cairn rests a freshly hewn human head. %randombrother% nods.%SPEECH_ON%I wonder if they believe doing that gets them closer to their gods.%SPEECH_OFF%You suspect you have another way to get them closer to their gods: by killing them all. It\'s time to plan a way of attack. | You find the barbarian village and just to its outskirts lies a round stone in the snow. It\'s so large the entire company could lay foot-to-head and still not stretch across its middle. Runes have been carved into its outer rim, long divots that are caked with dried blood. In the center of the slab is a small square rise with a curve to hold the neck. %randombrother% spits.%SPEECH_ON%Looks like a sacrificial square, er, circle.%SPEECH_OFF%Looking around, you wonder aloud where they put the bodies. The sellsword shrugs.%SPEECH_ON%Dunno. Probably ate \'em.%SPEECH_OFF%It wouldn\'t surprise you if they did. You stare at the village and ponder attacking or waiting. | The barbarian village lies just a little ways away. It\'s a nomadic scene, tents surrounded by ad hoc smithy sites and tarped wagons for granaries. You get the feeling that they are not long for any particular part of the world. %randombrother% laughs.%SPEECH_ON%Look at that one. He\'s shittin\'. What a fucker.%SPEECH_OFF%Indeed, one of the savages is squatting while talking to his fellow villagers. It is almost a metaphor in and of itself for catching the entire encampment with their pants down. | The village of savages is surprisingly not the hellscape you expected. Aside from the flayed corpse hanging upside down from a wooden holy totem, it looks like any other place with ordinary folks. Aside from the heavy set clothes and every individual carrying an axe or sword of some kind. All quite normal. There\'s a guy chopping a corpse\'s legs off and feeding them to pigs, but you\'ll see that just about anywhere. %randombrother% nods.%SPEECH_ON%Well, we\'re ready to attack. Just give the word, captain.%SPEECH_OFF% | You find the barbarian village squatting in the snowy wastes. It couldn\'t have been there long: it\'s mostly tents and the tops of them don\'t carry much snow. They must set up for a time then get back on the road, either to keep hunts fresh or to avoid the retribution of those they raid. What a shame they\'ve failed to do the latter. You ready the company for action. | You find the village of savages. Though, from first glance, they look an ordinary sort. Men, women, children. There\'s a blacksmith, a tanner, a one-eyed guy making arrows, and a huge executioner disemboweling corpses and washing the offal scum on a donkey. That one. That one reminds you of why you\'re here. | You find the barbarian village. The savages are in the midst of some religious ritual. An elderly man with a tortoise shell necklace has his fist up the decapitated and shaved head. He\'s letting the blood run down his forearm where children take horsehair brushes and sweep up the \'paint\' and go to run it against a wooden holy totem that stands a good ten feet high. The primitives watch and chant in a tongue totally foreign to you. %randombrother% whispers as though out of respect for the ritual moreso than fear of them hearing.%SPEECH_ON%Well. I say we go on down there and make an introduction, yeah?%SPEECH_OFF% | You find the barbarians moseying about their village. It\'s mostly tents and impromptu snow houses. Elderly women sit in a circle weaving baskets and younger women are making arrows while throwing glances at the burly men walking around. The men themselves pretend they don\'t care, but you know a peacock in action when you see it. There are also children hurrying to and fro this task or that. And just outside the village stand a series of wooden stakes impaling naked corpses from anus to mouth, and their chest cavities have been spread apart like butterfly wings and the insides draped down like loosened embroidering.%SPEECH_ON%Horrid.%SPEECH_OFF%%randombrother% says. You nod. It is, but that\'s why you\'re here.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Prepare to attack.",
					function getResult()
					{
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "ItemObtained",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_133.png[/img]{With the help of local bounty hunters, all damned enemies have been slain to the last. With the %item% in hand, you figure you might as well grab the %item%. %randombrother% goes and does it, carefully freeing the statue of the piece. Once the metal wriggles free, the man pauses, readied to get clobbered if the statue were to jump to life. Instead, nothing happens. He nervously laughs.%SPEECH_ON%E-easy-peasy!%SPEECH_OFF%As relief spreads over the men, you tell them to get ready to return to %employer%. And, of course, you obtained the impressive %prizename%.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Farewell, king.",
					function getResult()
					{
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
			function start()
			{				
				this.World.Assets.getStash().makeEmptySlots(1);
				local item = this.new(this.IO.scriptFilenameByHash(this.Flags.get("PrizeScript")));
				item.setName(this.Flags.get("PrizeName"));
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 12,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});				
			}

		});		
		this.m.Screens.push({
			ID = "Success1",
			Title = "Near %townname%...",
			Text = "[img]gfx/ui/events/event_04.png[/img]{%employer% welcomes your entrance with applause.%SPEECH_ON%My scouts tracked your company to the north and to its, dare I say, inevitable success! Splendid work murdering those savages. Surely this will make them think twice about venturing down here again!%SPEECH_OFF%The man pays you what you\'re owed. | You enter %employer%\'s room and find him slackened into his chair. He\'s watching a naked woman saunter from one side of the room to the other. Shaking his head, he talks to you while not taking his eyes from the show.%SPEECH_ON%My scouts have already told me of your doings. Said you put it to the barbarians like they\'d done their wrongs against you personally. I like that. I like the lack of restraint. Wish more of my own men had it.%SPEECH_OFF%A servant, previously unseen, quickly marches across the room. He\'s got a red candle atop his head and a chest of crowns in his hands. You take your pay and leave the room as quick as you can. | You find %employer% and a group of armored men standing around a table. A barbarian\'s corpse is on it. The flesh is greyed, but the body\'s musculature and grit has not yet been decayed. They ask if you truly fought men of this sort. You cut to the chase and ask for your pay. %employer% claps and shows you off to the group.%SPEECH_ON%Gentlemen, this is the sort of man I want in my ranks! Unfearful and always focused.%SPEECH_OFF%One of the nobles spits and says something you don\'t hear. You ask him to speak up if he\'s something to say, but %employer% rushes forward, chest of crowns in hand, and sends you on your way. | Finding %employer% proves a little difficult, a hunt that ends in a seemingly abandoned barn. You see him standing before a dead barbarian, the corpse hanging from the rafters by his legs like a fisherman\'s haul. The body has been burned, mutilated, and all else. %employer% crouches and washes his hands in a bucket.%SPEECH_ON%I\'ve to say, sellsword, you killing a whole number of these savages is most impressive. This one here lasted a good long while. Took to the pain like he was gonna pay it forward to me tenfold. But he never did. Did you?%SPEECH_OFF%The man gently slaps the barbarian\'s face and the chains clink as the body gently twists. %employer% nods.%SPEECH_ON%A servant outside will have your pay. A job well done, sellsword.%SPEECH_OFF% | You find %employer% and a group of men overseeing the defense of %townname%, no doubt preparing themselves for whatever attack may come next. Judging by the appearance of the men, their ambitions of survival will meet a reality far more cruel than they are ready for. But you keep that to yourself. %employer% thanks you for a job well done and pays you what is owed. | A few denizens of %townname% see your return with horrified confusion, mistaking you for the savages that they\'d come to know. Windows are shuttered, doors slammed closed, children hurried away, and a few braver souls step out with pitchforks. %employer% hurries out of his abode and sets them straight, explaining you are the heroes of the tale, that you went north and annihilated the savages, burned their village, and scattered them to the wastes. Windows swing wide and doors creak open and the children return to their play. Just when you think order has returned, an old woman snarls.%SPEECH_ON%A sellsword is just a savage by another name!%SPEECH_OFF%Sighing, you tell %employer% to pay what is owed. | %employer% is studying a few scrolls. He\'s also penning notes into them and crossing others out. Looking up, he explains that he\'s putting you into the records as a \'hero who went to the wastes\' and \'slaughtered the savages in a fashion most proper and southernly.\' He asks you to remind him what your name is. You ask him to pay you what you\'re owed. | %employer% is in the company of a group of sobbing women. He\'s consoling them and when you enter he stands and points you out to them.%SPEECH_ON%Behold! The man who has slain those who murdered your husbands!%SPEECH_OFF%The women wail and clamber to you, one after the other, and you know what to do besides nod sternly and stoically. %employer% is the last of the crowd to find you, a chest of crowns in his arm and a wry smile on his lips. You take your pay and the man returns to the women.%SPEECH_ON%There there, fine ladies, the world will see a new dawn. Please, come with me. Does anyone want wine?%SPEECH_OFF% | %employer% welcomes you with open arms. You decline a hug and ask for your pay. He returns to his desk.%SPEECH_ON%I wasn\'t trying to hug you, sellsword.%SPEECH_OFF%He taps the chest rather despondently.%SPEECH_ON%But you did a good job slaughtering those savages. I\'ve a number of scouts who reported it as a \'splendid time\' you had out there. You\'ve earned this.%SPEECH_OFF%He pushes the chest across the desk and you take it at arm\'s length, meeting a slight bit of resistance as he holds onto it. You hurriedly leave the room without looking at him again. | You have a hard time finding %employer%, eventually finding him halfway down a well shaft plugging a hole with a stone slab. He shouts up to you.%SPEECH_ON%Ah, the sellsword. Hoist me up, men!%SPEECH_OFF%A pulley system draws up the plank upon which he sits. He swings his legs off and rests them on the rim of the wellhead.%SPEECH_ON%Our mason was killed by a donkey so I thought I\'d lend a hand myself. Nothing like a little dirty work to get a good man up in the morn\'.%SPEECH_OFF%He slaps your chest with his glove, it leaves a powdered outline. He nods and fetches a servant to go get your pay.%SPEECH_ON%A job well done, sellsword. Very, very well done. Heh.%SPEECH_OFF%You don\'t humor him. | %employer% is found giving a speech to a crowd of peasants. He describes an unnamed force of southerners that headed north and annihilated the savage scum. At no point are you or the %companyname% named. When he\'s done, the mob of peons cheer and clap and flowers are thrown and a general state of festivity takes over. %employer% seeks you out and shakes your hand while pushing a chest of crowns toward you.%SPEECH_ON%I wish I could call you the hero to these fine folk, but mercenaries are not seen in the best of light.%SPEECH_OFF%You wrap your hands around the payment and lean forward.%SPEECH_ON%All I want is the pay. Have fun out there, %employer%.%SPEECH_OFF% | You find %employer% attending a funeral ceremony. They\'re burning a pyre weighed with three corpses and what may possibly be a fourth, smaller one. Possibly a whole family. %employer% says a few kind words and then sets the woodwork ablaze. A servant surprises you with a chest of crowns.%SPEECH_ON%%employer% does not wish to be bothered. Here is your pay, sellsword. Please count if you do not trust it is all there.%SPEECH_OFF%}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "Crowns well deserved.",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Procured an artifact important for the war effort");						
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				local reward = this.Contract.m.Payment.getOnCompletion();
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + reward + "[/color] Crowns"
				});
				this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/high_spirits_situation"), 3, this.Contract.m.Home, this.List);
			}			

		});
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"prizename",
			this.m.Flags.get("PrizeName")
		]);	
		_vars.push([
			"location",
			this.m.Flags.get("DestinationName")
		]);			
		_vars.push([
			"direction",
			this.m.Destination == null || this.m.Destination.isNull() || !this.m.Destination.isAlive() ? "" : this.Const.Strings.Direction8[this.m.Home.getTile().getDirection8To(this.m.Destination.getTile())]
		]);
	}

	function onHomeSet()
	{
		if (this.m.SituationID == 0)
		{
			this.m.SituationID = this.m.Home.addSituation(this.new("scripts/entity/world/settlements/situations/ambushed_trade_routes_situation"));
		}
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Destination != null && !this.m.Destination.isNull())
			{
				this.m.Destination.getSprite("selection").Visible = false;
				this.m.Destination.setOnCombatWithPlayerCallback(null);
			}

			this.m.Home.getSprite("selection").Visible = false;
		}

		if (this.m.Home != null && !this.m.Home.isNull() && this.m.SituationID != 0)
		{
			local s = this.m.Home.getSituationByInstance(this.m.SituationID);

			if (s != null)
			{
				s.setValidForDays(4);
			}
		}
	}

	function onIsValid()
	{
		if (this.m.IsStarted)
		{
			if (this.m.Destination == null || this.m.Destination.isNull() || !this.m.Destination.isAlive())
			{
				return false;
			}

			return true;
		}
		else
		{
			return true;
		}
	}

	function onSerialize( _out )
	{
		_out.writeI32(0);

		if (this.m.Destination != null && !this.m.Destination.isNull())
		{
			_out.writeU32(this.m.Destination.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		_in.readI32();
		local destination = _in.readU32();

		if (destination != 0)
		{
			this.m.Destination = this.WeakTableRef(this.World.getEntityByID(destination));
		}

		this.contract.onDeserialize(_in);
	}

});

