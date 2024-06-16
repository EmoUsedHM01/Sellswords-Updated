this.purge_infection_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null,
		Settlement = null,
		temproster = null,
		temprostercbt = null,
		Category = ::Const.Contracts.Categories.Battle
	},
	function setSettlement( _s )
	{
		this.m.Flags.set("SettlementName", _s.getName());
		this.m.Settlement = this.WeakTableRef(_s);
	}

	function setLocation( _l )
	{
		this.m.Destination = this.WeakTableRef(_l);
		this.m.Flags.set("DestinationName", _l.getName());
	}

	function create()
	{
		this.contract.create();
		local r = this.Math.rand(1, 100);
		
		if (r <= 20)
			this.m.DifficultyMult = this.Math.rand(90, 105) * 0.01;
		else if (r <= 80)
			this.m.DifficultyMult = this.Math.rand(115, 135) * 0.01;
		else
			this.m.DifficultyMult = this.Math.rand(145, 165) * 0.01;

		this.m.Type = "contract.purge_infection";
		this.m.Name = "Purge Infection";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		local s = this.World.EntityManager.getSettlements()[this.Math.rand(0, this.World.EntityManager.getSettlements().len() - 1)];

		while(s.getAttachedLocations().len() == 0)
			s = this.World.EntityManager.getSettlements()[this.Math.rand(0, this.World.EntityManager.getSettlements().len() - 1)];

		this.logDebug("------raze_attached_location_contract getAttachedLocations's nunm: " + s.getAttachedLocations().len());
		this.m.Destination = this.WeakTableRef(s.getAttachedLocations()[this.Math.rand(0, s.getAttachedLocations().len() - 1)]);
		
		this.m.Flags.set("NecroEscaped", 0);
		this.m.Flags.set("IsDone", false);
		this.m.DescriptionTemplates = [
			"The dead rise in %s, spreading fear and chaos. Purge the undead and restore peace to the town.",
			"From the town of %s emerges a threat of the undead. Cleanse the area and reclaim the town.",
			"Behold, the rise of the undead in %s. Your mission: to eradicate this unholy menace and bring safety.",
			"The streets of %s are overrun with the undead. A sellsword is needed to purge this blight and restore order.",
			"The restless dead have emerged in %s, spreading terror. Rid the town of these horrors and bring peace.",
			"An undead horde threatens %s. Your task: to eliminate the undead and ensure the safety of its people."
		];
	}

	function formatDescription()
	{
		local r = ::MSU.Array.rand(this.m.DescriptionTemplates);

		if (r.find("%") != null)
			r = this.format(r, ::Const.UI.getColorized(this.m.Destination.getName(), ::Const.UI.Color.getHighlightLightBackgroundValue()));

		this.m.Description = r;
	}

	function onImportIntro()
	{
		this.importNobleIntro();
	}

	function start()
	{
		this.m.Payment.Pool = 1800 * this.getPaymentMult() * this.getDifficultyMult() * this.getReputationToPaymentMult();

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
					"Purge the scourge at " + this.Flags.get("DestinationName") + " near " + this.Flags.get("SettlementName")
					"Do not let any necromancers escape"
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
					this.Contract.m.Destination.setFaction(this.Const.Faction.Enemy);
					this.Contract.m.Destination.setAttackable(true);
					this.Contract.m.Destination.setOnCombatWithPlayerCallback(this.onDestinationAttacked.bindenv(this));
				}
			}

			function update()
			{
				if (this.Flags.get("IsDone"))
				{
					this.Contract.setScreen("Done");
					this.World.Contracts.showActiveContract();
				}
			}

			function onEntityPlaced( _entity, _tag )
			{
				if (_entity.getFlags().has("Necro"))
				{
					_entity.setMoraleState(this.Const.MoraleState.Fleeing);
					_entity.getBaseProperties().Bravery = 0;
					_entity.getSkills().update();
					_entity.getAIAgent().addBehavior(this.new("scripts/ai/tactical/behaviors/ai_retreat_always"));
				}
			}

			function onDestinationAttacked( _dest, _isPlayerAttacking = true )
			{
				if (!this.Flags.get("IsAttackDialogTriggered"))
				{
					this.Flags.set("IsAttackDialogTriggered", true);
					this.Contract.setScreen("DefaultAttack");
					this.World.Contracts.showActiveContract();
				}
				else
				{
					local p = this.World.State.getLocalCombatProperties(this.Contract.m.Destination.getPos());
					p.CombatID = "PURGEEE";
					p.TemporaryEnemies = [
						this.Contract.getFaction()
					];
					p.TerrainTemplate = this.Const.World.TerrainTacticalTemplate[this.Contract.m.Destination.getTile().Type];
					p.Tile = this.World.getTile(this.World.worldToTile(this.World.State.getPlayer().getPos()));
					p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
					p.LocationTemplate.Template[0] = "tactical.human_camp";
					this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.ZombieMilitary, 80 + this.Math.rand(115, 125) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
					p.LocationTemplate.Fortification = this.Const.Tactical.FortificationType.None;
					p.LocationTemplate.CutDownTrees = true;
					p.LocationTemplate.AdditionalRadius = 5;
					p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Edge;
					p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Center;
					p.Music = this.Const.Music.UndeadTracks;
					p.IsAutoAssigningBases = false;
					p.IsFogOfWarVisible = false;
					this.Contract.m.temprostercbt = this.World.Assets.m.BrothersMaxInCombat;
					this.Contract.m.temproster = this.World.Assets.m.BrothersMax;
					this.World.Assets.m.BrothersMaxInCombat = 27;
					p.EnemyBanners = [
						this.World.FactionManager.getFaction(this.Contract.getFaction()).getPartyBanner()
					];
					foreach( e in p.Entities )
						e.Callback <- this.onEntityPlaced.bindenv(this);

					this.World.Contracts.startScriptedCombat(p, false, true, true);
				}
			}

			function onActorRetreated( _actor, _combatID )
			{
				if (_actor.getFlags().has("Necro"))
					this.Flags.set("NecroEscaped", this.Flags.get("NecroEscaped") + 1);
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "PURGEEE")
					this.Flags.set("IsDone", true);
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "PURGEEE")
					this.Flags.set("NecroEscaped", 100);
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Return to " + this.Contract.m.Home.getName()
				];
				this.Contract.m.Destination.getSprite("selection").Visible = false;
				this.Contract.m.Home.getSprite("selection").Visible = true;
				this.Contract.m.Destination.setOnCombatWithPlayerCallback(null);
				this.Contract.m.Destination.setFaction(this.Contract.m.Destination.getSettlement().getFaction());
				this.Contract.m.Destination.clearTroops();
			}

			function update()
			{
				this.World.Assets.m.BrothersMaxInCombat = this.Contract.m.temproster;
				this.World.Assets.m.BrothersMax = this.Contract.m.temprostercbt;								
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					if (this.Flags.get("NecroEscaped") == 0)
					{
						this.Contract.setScreen("Success1");
					}
					else
					{
						this.Contract.setScreen("Failure1");
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
			Text = "[img]gfx/ui/events/event_31.png[/img]{%employer% throws back his silken sleeves and cracks his knuckles.%SPEECH_ON%Just weeks ago, an extremely vile threat arose in the form of a plague. To our horror, my cabinet discovered that the plague was not merely an illness but a way of turning innocent townsfolk into undead creatures. The fallen have been resurrected en masse by a local clique of Necromancers.%SPEECH_OFF%You nod, as a sellsword is often hired to deal with difficult things. The man continues.%SPEECH_ON%Some of my men were sent to the town of %settlementname% for an investigation. The grain there had been tampered with, and without an influx of new food and a quarantine, the people of %settlementname% will all soon become infected. %noblehousename% is sorry for this, but we must do anything we can to prevent further harm to our House.\n\n What I need you to do is burn them all, especially those despicable necromancers, the puppeteers behind this insidious plot, along with any infected who continue to spread this plague. To end the assault by these monsters, I will also send along two experienced Paladins with you. These are strong men, experienced against the \'undead\', but unfortunately, two men won\'t be enough here. There\'ll be a large satchel of crowns waiting for you right here if you go there and help them. What do you say, hm?%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{Let\'s talk money. | How many crowns are we talking about? | What will the pay be? | For the right price, anything can be done.}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{That\'s not our line of work. | That\'s not for the %companyname%.| We don\'t deal with the Undead.}",
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
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/event_02.png[/img]{Approaching %settlementname%, %randombrother% suddenly calls out from the front.%SPEECH_ON%Sir, hurry!%SPEECH_OFF%You rush over to him and look ahead. The town is absolutely surrounded by a pale sea of bobbing, moaning undead! The %companyname% will have to cut through them to get inside. \nA man jogs toward the %companyname%. He\'s holding one of his arms and a crown of blood runs down his head. He yells out.%SPEECH_ON%Go, go away! There\'s nothing for you here but horrors!%SPEECH_OFF%%randombrother% throws the stranger to the ground and draws a weapon to keep him there. You stay the mercenary\'s hand as you look ahead; %settlementname% is already surrounded by a large number of the undead. The %companyname% needs to act fast! \nRounding a pathway, you\'re brought to a sudden stop. Near you, a few of the cold, pale undead linger, oddly outcast from the horde. %randombrother% remarks that there are a couple of warm-blooded figures clad in black among these outliers; it seems you\'ve found your target. \nWith the horde of undead already pushing in from outside %settlementname%\'s walls, and the heads of the militia peeking over the defenses, you leave them to defend the town while you make your way over to the Necromancers. \nDrawing out your sword, you command the %companyname% to battle!}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Prepare to attack.",
					function getResult()
					{
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						
						for( local i = 0; i != 2; i = ++i )
						{
							local paladin;
							paladin = this.World.getGuestRoster().create("scripts/entity/tactical/humans/crPaladin_guest");							
							paladin.setFaction(this.Contract.getFaction());	
							paladin.setPlaceInFormation(28 + i);							
							paladin.assignRandomEquipment();
							paladin.setFaction(1);	
						}							
						
						return 0;
					}

				}
			]			
		});
		this.m.Screens.push({
			ID = "Done",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_46.png[/img]{You stare over the battlefield. It is littered with the dead, the dying, the undying, and the dying undead. Men, of the living, breathing sort, march through the muck, finishing off anything that remotely resembles a walking corpse. With the fight over and the town saved, %employer% should now be expecting you. | The battle is over and the town is saved. Time to return to %employer% for a hell of a payday. | %settlementname% resembles a flooded graveyard more than any town you know. Corpses, new and old, are washed out across the earth, blood and moldy filth pooled about each. The stench reminds you of a dead dog you found alongside a creek, bones dripping with decomposition, the body being fed upon by crawfish and maggots.\n\nThe relentless attacks have finally ceased; %settlementname% seems safe for now. %employer% should be expecting you and you\'ve no reason to stay in this horrid place any longer. | Well, the town is saved. The peasants step about the battlefield with long sticks, poking the earth like pelicans prodding over a pool of the most dangerous waters. %randombrother% comes over, cleaning the sludge off his blade, and asks if it is time to return to %employer%. You nod. The sooner you can get back for your pay, the better. | The battle is over. Among the dead are peasants and militiamen, each attended by survivors who\'ve come to cloak the bodies with sobbing silhouettes. As for the dead undead, well, nobody cares. Those bodies lay as though they came with no purpose and yet departed with thorough destruction of whatever they touched. The sight of their corpses, and the chaotic nothingness they represent, is infuriating. Not wanting to be around a second longer, you inform the men to get ready to return to %employer%. | You and the %companyname% stand victorious. The town and its people will survive, for now, and you can return to %employer% for your pay. | The lieutenant of the guard thanks you for saving the town. You mention that the only reason you\'re here is because someone paid you. He shrugs.%SPEECH_ON%I thank the rains I\'ve no command over; I\'ll thank you mercenary whether you like it or not.%SPEECH_OFF% | The battle is over and, thankfully, won. Undead bodies spill over the earth in such disarray that they hardly look any different than they did shambling and shuffling just hours ago. But the more recently expired share no such cosmic despondence. Wailing women and confused children attend to them. You look away from the scene, ordering the %companyname% to prepare its return to %employer%. | A dead man is at your feet and beside him is an undead corpse. It\'s the strangest of sights, for they are equally put out of this world, but there\'s life yet in the man. The breath of a recent memory. You saw him swinging to the very end. A noble way for a fighter to go. This corpse, though? What of it? You\'ll remember it tearing a man\'s throat out with its bare teeth. Maybe the corpse had a time beyond that moment, when it had a family, a time when it was but a kind man doing good in this world. But a throat-ripping monstrosity is all it is now. All it will be remembered as.\n\nThe relentless attacks on %settlementname% have finally ceased, and so you hurry to collect the company and prepare a return to %employer% in %townname%. A good payday is better than another moment of looking at this shite. | What is a dead man? What if a dead man was killed twice over? And what of a dead man killed thrice over? Unfortunate. Misfortunate. And a joke.\n\n You walk the battlefield collecting the men of the %companyname%. The town of %settlementname% is saved for now, and so it\'s time for you to get back to %employer% in %townname% for a well-earned payday. | %randombrother% wipes his forehead with a cloth, leaving behind a disgusting smear of pale liquid.%SPEECH_ON%Shite, what is that? Is that brain? Sir, would you please?%SPEECH_OFF%You help the man clean himself off. He stands back, arms wide. He\'s still absolutely covered in blood, guts, and things which may forever be left unknown.%SPEECH_ON%How do I look?%SPEECH_OFF%His grin winks out of the murk like a rind of the moon through a pale sky. You refuse to answer and just tell him to go get the men. With %settlementname% saved for now, %employer% will be expecting the company back in %townname%, and the company should be expecting a well-earned payday. | %randombrother% comes to your side, together the two of you overlooking the battlefield. Already you can see the families of the dead coming out to find their lost ones. Their wailing is sharp, humanly pitched, a disturbingly welcome respite from the growling, moaning despondence of the undead. The mercenary claps you on the shoulder.%SPEECH_ON%I\'ll go and collect the men so we can get on back to %townname% and collect our pay.%SPEECH_OFF% | You watch as women shuffle about the battlefield, holding their dresses up like wetted fowl steering clear of a pond\'s murk. Of course, once they find what they\'re looking for, they drop all regard for cleanliness and drop into the filth, wailing and howling, covering themselves in the very horrors which had dispatched their fathers and husbands with infuriating indifference.\n\n %randombrother% joins your side.%SPEECH_ON%Sir, the attacks have ceased and the men are ready to return to %townname%. Just give the word.%SPEECH_OFF% | The lieutenant of the guard comes to your side and shakes your hand. Drying blood cracks and crumbles as you shake. He puts his fists to his hips and nods at the scene.%SPEECH_ON%You did well, sellsword, and we could not have done it without you. I\'d like to offer you more as thanks, but this town needs all the resources it has to rebuild. I do hope that %employer% pays you all that you are worth.%SPEECH_OFF%You hope so, too.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "We\'re done here.",
					function getResult()
					{
						this.World.Assets.addMoralReputation(-5);
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_56.png[/img]{You enter %townname% and find %employer% looking over a balcony. He calls to you just as a guard slams a satchel of crowns into your arms .%SPEECH_ON%Sellsword! So glad to have you back! My little birds have already told me much of your doings. I hope you spend those crowns well!%SPEECH_OFF%Before you can say anything, the man spins and leaves. The guard who handed you the crowns is already gone as well. Peasants walk around you like a signpost pointing to places they\'ll never go. | You find %employer% slapping and kicking a child around, eventually punting him into the dirt with a swift boot to the chest. Seeing you, the nobleman wipes the sweat from his brow and explains himself.%SPEECH_ON%This doesn\'t concern you.%SPEECH_OFF%The kid is tilting on hands and knees, one hand to his belly, the other drawing blood from his leaking nose. Gradually, he gets to his feet, wavering there, blinkered eyes blinking crimson. A servant comes by and starts dabbing water over him, but the nobleman grabs the cloth and tosses it aside .%SPEECH_ON%You think he\'ll learn that way. If you want to help someone, help this sellsword. He is owed %reward_completion% crowns. Snap snap.%SPEECH_OFF%The servant nods and quickly leaves. You stay awhile, watching the beating continue. The kid doesn\'t cry or call out for there is a learned expectation in this punishment. A few minutes pass when the servant suddenly reappears, satchel in hand. He hands it to you and whispers an earnest suggestion that you make your leave. | %employer% is stooped over his table, arms tented long and stiff, his head drooped low as he stares at a dead crow.%SPEECH_ON%Found this raven in my bed this morning. Just lying there. Dead. Do you \'ve any idea what that means?%SPEECH_OFF%You suggest that it was, perhaps, a joke. The nobleman scoffs.%SPEECH_ON%Nay. I think this has to do with you, sellsword. You did well in saving that town, but perhaps it was not meant to be saved. Maybe that is what this bird represents. Maybe the dead shall come for me next as I have left Death itself unpaid.%SPEECH_OFF%You use this statement to slowly segue into the issue of your own pay. Despite his wild ravings, the nobleman does momentarily get his wits together to pay you your %reward_completion% crowns. | %employer% is listening to a group of scribes, somehow arranged in order of age and seniority. The youth of the group stay quiet, the only noise out of them is the scribbling of their quill pens. The elders argue amongst themselves, using volume just as much as reason and rationality. This seems a common sight nowadays, no doubt the dead climbing out of their graves being of some concern to men of philosophical takes. Regardless, you belch loudly to introduce yourself, shattering their conversation with disgusting aplomb. %employer% laughs and waves you in.%SPEECH_ON%Ah, sellsword! The man who gets things done, come to talk with the men who simply yap?%SPEECH_OFF%You shake your head and tell him you\'re only there for the pay. The nobleman nods.%SPEECH_ON%Of course. You did well in saving that town. I\'ve heard much of your heroics. %reward_completion% crowns await you there in the corner.%SPEECH_OFF%You walk across the room, your boots filling the suddenly hollow room with quiet claps of leather on stone. The scribes twist to watch you, murmuring amongst themselves. You pick a satchel up, hearing the chink of crowns shift around with a most welcomed weight. You quietly leave, though the second the door closes behind you the scribes erupt with arguing once again. | %employer% is found with a few women beside him. They\'re telling him of their lost fathers, husbands, and brothers. He nods, attentively, though occasionally sparing a moment to glance at the bosom of the youngest girl.%SPEECH_ON%Yes, yes of course. Absolutely horrible. Horrible! Hold on one moment. Sellsword!%SPEECH_OFF%He waves you in. The women part as you make your entrance. The youngest gal looks you up and down, quickly wiping tears from her eyes and does a little bit of youthful primping. The nobleman sees this and glances between you and her .%SPEECH_ON%Ahem, yes, uh, your crowns are in the corner. You must go. Now. I\'ve things to attend to.%SPEECH_OFF%He stands and points toward your %reward_completion% crowns, and in one swift motion takes the lady by the hand.%SPEECH_ON%Now, young backstress, you said your husband is dead and you\'ve no one left in this life? Absolutely no one at all?%SPEECH_OFF% | Dogs chew up something in the path. Whatever it was, it once had life, bones and organs which have long since grown pale and rotten, though the mongrel\'s rabid eating would suggest it might as well be a slab of steak. %employer% greets you, attentive guards at his side.%SPEECH_ON%My birds tell me the town was saved. You\'ve done well, mercenary, better than I had thought you would. Your pay, as agreed upon.%SPEECH_OFF%He hands you a satchel of %reward_completion% crowns. The dogs pause, turning their heads toward you with flesh swinging from their teeth, narrow black eyes staring with an emptiness that reflects their hunger. The guards lower their spears and the dogs, somehow interpreting this correctly, slowly turn back to their dinner. | %employer% is found sitting low in his chair. He despondently waves you into the room.%SPEECH_ON%I\'ve horrid news. My seer says I\'ve brought a curse upon my land and my people. That\'s why the dead rise again.%SPEECH_OFF%You shrug and kindly state that the seer is full of shite. The nobleman shrugs.%SPEECH_ON%I sure hope so. What was it we agreed upon, %reward_completion% crowns?%SPEECH_OFF%You\'re tempted to say you agreed to more, but dare not cross a man who is so superstitious. When you answer, he smiles warmly at your accurate response.%SPEECH_ON%Good call, sellsword. You passed that test. I may be going mad, but I\'m not one to trifle with. %SPEECH_OFF%You ask if your honesty will be rewarded. The man raises an eyebrow.%SPEECH_ON%Your head is on your shoulders, is it not?%SPEECH_OFF%Point taken. | %employer% is found on his balcony. You join him, though guards stand very nearby, eyeing you carefully. The man waves his arm to the town which lies beneath him.%SPEECH_ON%I know you did not save this town directly but, in a way, I think you did. Stopping the undead anywhere is as good as stopping them here. Would you agree?%SPEECH_OFF%The man punctuates the question with a satchel of %reward_completion% crowns. You take the pay and nod. He nods back.%SPEECH_ON%Glad you agree for we may yet need your services again.%SPEECH_OFF% | You step into %employer%\'s darkened room. There are rugs over the windows and most of the candles are not lit. All the light flickers beside a scribe standing with a candelabra, his fire-red face grinning behind the candles like a little devil holding a trident. He glances at you and quietly sets the candles down. As he steps back, it is as though he were falling into a black pool, his disembodied face slowly dipping into the darkness. He\'s still there, breathing slightly, rustling his cloak, but you\'ve nought a part of him to see. %employer% waves you in.%SPEECH_ON%Sellsword! By the old gods, you did well in saving that town!%SPEECH_OFF%You step forward, glancing at the darkness which shifts around, some of it shadow, some of it man. %employer% hands you a satchel. A scattering of candlelit coins shimmers across its open top.%SPEECH_ON%%reward_completion% crowns, as agreed upon. Now, please, depart. I have more to study, and even more to learn.%SPEECH_OFF%You take your pay and slowly leave. As the door closes, you see the scribe reemerge like a gaunt spectre, bony hands reaching for the light once more. | %employer% is found in his study. Guards stand at all the corners and a scribe quietly goes around the shelves, pulling scrolls and putting them back with equal earnestness and disappointment. You\'re quickly waved in and just as quickly paid by the nobleman.%SPEECH_ON%Good job, sellsword. You\'re already a hero in some parts of these lands. Hell, maybe you\'ll end up in one of these scrolls, forever remembered.%SPEECH_OFF%You hear the scribe scoff. %employer% waves toward the door.%SPEECH_ON%Please? I\'ve immense things to study, and so little time to do it.%SPEECH_OFF% | You enter %employer%\'s room to find the man deep in his chair. Peasants argue on either side of him, pointing and accusing.%SPEECH_ON%This man is a murderer!%SPEECH_OFF%The defendant scoffs.%SPEECH_ON%Murderer? What happened was an accident! I thought he was one of them undead fellers!%SPEECH_OFF%The other man scoffs this time.%SPEECH_ON%Undead? He was merely drunk!%SPEECH_OFF%Tempers rise.%SPEECH_ON%Well, I heard growling! Or grunting.%SPEECH_OFF%Your employer despondently waves you in.%SPEECH_ON%Sellsword, good job on saving that town. Your pay.%SPEECH_OFF%He pushes a satchel of %reward_completion% crowns across the table. The peasants pause, staring at the coins wink out of its open top. You take the satchel, pretending that it weighs far too much for you.%SPEECH_ON%Oof, so heavy it is! You sirs have a good day.%SPEECH_OFF% | %employer% welcomes you into his room.%SPEECH_ON%My little birds tell me of the town being saved. You did well, mercenary, well enough in a world that\'s become so dark. Your pay of %reward_completion% crowns, as agreed upon.%SPEECH_OFF% | %employer% is standing outside, staring toward a graveyard that has gathered quite a few residents since your last visit. He hands you a satchel of %reward_completion% crowns.%SPEECH_ON%You did well, mercenary. Word of your doings has spread across the land. One success won\'t save us all, but it puts us on the right path. If we are to win this damned war with the dead, we need as much spirit and hope we can muster.%SPEECH_OFF%Taking your pay, you add that sellswords need as many crowns as possible. You know, to keep their \'spirits\' high. The nobleman grins.%SPEECH_ON%I\'m being sanctimonious, not philanthropic. Get on out of here.%SPEECH_OFF% | %employer%\'s guards take you into his room. He\'s got a few scrolls unwound all around him. Broken quill pens litter his table as though someone had splattered a bird there.%SPEECH_ON%Sellsword! Tis good to see the man of the hour, the day, the week! You did well in saving that town.%SPEECH_OFF%He throws you a satchel of %reward_completion% crowns.%SPEECH_ON%One victory to keep a town alive, one victory to keep the hopes of the people alive. I should pay you more. I mean, I won\'t, but I should.%SPEECH_OFF%You glumly take your pay, nodding back and responding.%SPEECH_ON%Well, it\'s the thought that counts.%SPEECH_OFF%The nobleman snaps his fingers.%SPEECH_ON%Exactly!%SPEECH_OFF% | You find %employer% slunk deep in his chair with an even deeper frown. His clothes wink with shiny opulence and the candelabras look worth more than the servants holding them. The gaudy grouch despondently waves you in. He speaks slowly and sarcastically.%SPEECH_ON%One victory for man. One more victory to carry us to the next day. Mmm, thank you sellsword.%SPEECH_OFF%You slowly step forward, the servants glancing at you with fearful eyes. You take your pay and step back. %employer% waves you away now.%SPEECH_ON%Begone. I hope to see you again, lest you are of ill-shape and of dead body, then it would be a shame. Then again, that\'s how we\'re all going to end up, isn\'t it?%SPEECH_OFF%You say nothing and make your leave. It appears the war against the unending undead has worn on the nobleman.}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "{Honest pay for honest work. | Crowns is crowns.}",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "Purged the infection");
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color] Crowns"
				});
				this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/terrified_villagers_situation"), 3, this.Contract.m.Settlement, this.List);	
			}

		});
		this.m.Screens.push({
			ID = "Failure1",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_56.png[/img]{The undead were too many and you had to retreat. Unfortunately, a whole town doesn\'t have such liberties and so %settlementname% was completely overrun. You didn\'t stick around to see what became of its citizens, though it doesn\'t take a genius to guess. | The %companyname% has been defeated in the field by the hordes of undead. In the wake of your failure, %settlementname% is quickly overrun. A mass of peasants run from the town and those too slow are added to the sea of shambling corpses. | You failed to hold back the undead! The corpses slowly shuffle beyond the walls of %settlementname% and eat and kill all that they come across. As you flee the field, you see the lieutenant of the militia shuffling alongside the horde of corpses.}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "They won\'t be welcoming us in %settlementname%...",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "Failed to purge the infection");						
						this.World.Contracts.finishActiveContract();
						return 0;
					}
				}
			],
			function start()
			{
				this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/terrified_villagers_situation"), 7, this.Contract.m.Settlement, this.List);	
			}			
		});
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"location",
			this.m.Flags.get("DestinationName")
		]);
		_vars.push([
			"settlementname",
			this.m.Flags.get("SettlementName")
		]);
		_vars.push([
			"noblehousename",
			this.World.FactionManager.getFaction(this.m.Faction).getNameOnly()
		]);
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Destination != null && !this.m.Destination.isNull())
			{
				this.m.Destination.getSprite("selection").Visible = false;
				this.m.Destination.setFaction(this.m.Destination.getSettlement().getFaction());
				this.m.Destination.setOnCombatWithPlayerCallback(null);
				this.m.Destination.setAttackable(false);
				this.m.Destination.clearTroops();
			}

			this.m.Home.getSprite("selection").Visible = false;
						
			this.World.getGuestRoster().clear();			
		}
	}

	function onIsValid()
	{
		if (this.World.FactionManager.isGreaterEvil())
		{
			return false;
		}

		if (this.m.Destination == null || this.m.Destination.isNull() || !this.m.Destination.isActive())
		{
			return false;
		}

		if (this.m.Settlement == null || this.m.Settlement.isNull())
		{
			return false;
		}

		return true;
	}

	function onSerialize( _out )
	{
		if (this.m.Destination != null && !this.m.Destination.isNull())
		{
			_out.writeU32(this.m.Destination.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		if (this.m.Settlement != null && !this.m.Settlement.isNull())
		{
			_out.writeU32(this.m.Settlement.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local dest = _in.readU32();

		if (dest != 0)
		{
			this.m.Destination = this.WeakTableRef(this.World.getEntityByID(dest));
		}

		local settlement = _in.readU32();

		if (settlement != 0)
		{
			this.m.Settlement = this.WeakTableRef(this.World.getEntityByID(settlement));
		}

		this.contract.onDeserialize(_in);
	}

});