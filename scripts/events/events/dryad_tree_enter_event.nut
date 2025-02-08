this.dryad_tree_enter_event <- ::inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.location.dryad_tree_enter";
		this.m.Title = "As you approach...";
		this.m.Cooldown = 999999.0 * ::World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/legend_heartwood.png[/img]{The company gather at the edge of the ancient forest, the dim glow of torches casting eerie shadows among the trees. The air is thick with tension, each sellsword\'s face set with a grim determination.%SPEECH_ON%We\'ve lost too many to them%SPEECH_OFF% %randombrother% mutters, tightening the grip on their weapon.%SPEECH_ON%These farkers won\'t stop until every village is overrun by their cursed roots.%SPEECH_OFF%You nod in agreement. The World Tree is their heart, their source of power. If we burn it, we end this war for good. The forests will never be safe as long as it stands.\n\nA whisper of wind rustled the leaves, almost as if the forest itself was listening.\n\n%randombrother% approaches you.%SPEECH_ON%Cap\'n? Are you sure about this?%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Burn it all down!",
					function getResult( _event )
					{
						return "Enter";
					}
				},
				{
					Text = "Let\'s come back once we\'re stronger.",
					function getResult( _event )
					{
						if (::World.State.getLastLocation() != null)
						{
							::World.State.getLastLocation().setVisited(false);
						}

						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "Enter",
			Text = "[img]gfx/ui/events/legend_heartwood_ritual.png[/img]{You push deeper into the heart of the forest, the glow of your torches barely piercing the thick fog. The ancient trees tower ominously, twisted branches forming an almost impenetrable barrier above.\n\nAs you approach the World Tree, a sense of unease settls over the group, the silence of the forest growing heavier with each step.%SPEECH_ON%Stay sharp%SPEECH_OFF%You whisper, voice tense.%SPEECH_ON%They know we\'re here.%SPEECH_OFF%As if by command, the forest starts to comes alive. From every direction, the Dryads emerge. Silent, ethereal figures stepping out from the trees as if they were one with the wood itself.\n\n%companyname% find themselves surrounded, the eerie eyes of your enemies glowing with an ancient fury. The smell of the air, thick with the scent of sap and earth. The rustling of leaves. The flickering of torches against the tree. You start to tighten your grip around your weapon as the first wave of Dryads lumber forward.}"
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Fight for your lives! Fight like you\'ve never fought before!",
					function getResult( _event )
					{
						if (::World.State.getLastLocation() != null)
						{
							::World.State.getLastLocation().setVisited(false);
						}

						local p = ::World.State.getLocalCombatProperties(::World.State.getPlayer().getPos());
						p.LocationTemplate = clone ::Const.Tactical.LocationTemplate;
						p.Entities = [
							{
								ID = ::Const.EntityType.DryadWolf,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/enemies/dryad_wolf",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.DryadWolf,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/enemies/dryad_wolf",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.DryadSnake,
								Variant = 0,
								Row = 1,
								Script = "scripts/entity/tactical/enemies/dryad_snake",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.DryadSnake,
								Variant = 0,
								Row = 1,
								Script = "scripts/entity/tactical/enemies/dryad_snake",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.DryadUnhold,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/enemies/dryad_unhold",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.DryadUnhold,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/enemies/dryad_unhold",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.DryadLindy,
								Variant = 0,
								Row = 1,
								Script = "scripts/entity/tactical/enemies/dryad_lindy",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.DryadWarrior,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/enemies/dryad_enemy_warrior",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.DryadWarrior,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/enemies/dryad_enemy_warrior",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.DryadGrunt,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/enemies/dryad_enemy_grunt",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.DryadGrunt,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/enemies/dryad_enemy_grunt",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.DryadArcher,
								Variant = 0,
								Row = 1,
								Script = "scripts/entity/tactical/enemies/dryad_enemy_archer",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.DryadArcher,
								Variant = 0,
								Row = 1,
								Script = "scripts/entity/tactical/enemies/dryad_enemy_archer",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.DryadArcher,
								Variant = 0,
								Row = 1,
								Script = "scripts/entity/tactical/enemies/dryad_enemy_archer",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.DryadShaman,
								Variant = 0,
								Row = 2,
								Script = "scripts/entity/tactical/enemies/dryad_enemy_shaman",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.DryadShaman,
								Variant = 0,
								Row = 2,
								Script = "scripts/entity/tactical/enemies/dryad_enemy_shaman",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.DryadTamer,
								Variant = 0,
								Row = 2,
								Script = "scripts/entity/tactical/enemies/dryad_enemy_tamer",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.DryadTamer,
								Variant = 0,
								Row = 2,
								Script = "scripts/entity/tactical/enemies/dryad_enemy_tamer",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.DryadBoss,
								Variant = 10,
								Row = 1,
								Script = "scripts/entity/tactical/enemies/dryad_enemy_boss",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.Schrat,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/enemies/schrat",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.Schrat,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/enemies/schrat",
								Faction = this.Const.Faction.Enemy
							}
						];

						_event.finishCombatInfo(p);
						_event.registerToShowAfterCombat("Victory", "Defeat");
						::World.State.startScriptedCombat(p, false, false, false);
						return 0;
					}
				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "Victory",
			Text = "[img]gfx/ui/events/legend_heartwood_dead.png[/img]{The forest was eerily quiet after the battle. The company, bloodied and weary, stand among the fallen dryads, their breath heavy in the stillness. The remains of the World Tree looming over them, its ancient bark now scarred, broken by the clash.\n\nFrom the shadows of the trees, a lone dryad emerged, moving slowly, almost hesitantly. Their form delicate, eyes wide with confusion and sorrow. They seem lost, as if the violence had shattered something within them. %randombro%, still gripping their sword, steps forward cautiously. %SPEECH_ON%What do you want?%SPEECH_OFF% they demand, though their voice lacks the earlier bravado.\n\nThe dryad didn't respond immediately. Instead they look around at the destruction, their gaze lingering on the bodies of their fallen kin. Finally, they met the sellsword's eyes, expression one of deep sadness.%SPEECH_ON%Why?%SPEECH_OFF%They quietly mutter, their gravelly voice barely audible.%SPEECH_ON%Why have you done this?%SPEECH_OFF%The sellswords exchanged uneasy glances, their earlier resolve wavering in the face of their grief. The dryad takes another step forward, posture unthreatening but filled with a profound sense of loss.%SPEECH_ON%We were only trying to protect our home. Our lives. And now? Now there is nothing left to protect.%SPEECH_OFF%Their words hang in the air, heavy with the weight of the devastation that had been wrought. The sellswords of %companyname%, victorious but hollow, only stand in silence, their triumph now tinged with the bitter taste of regret.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "You can continue your fight alongside us.",
					function getResult( _event )
					{
						return "Recruit";
					}

				},
				{
					Text = "You can burn with the rest of them!",
					function getResult( _event )
					{
						return "Deny";
					}

				}
			],
			function start( _event )
			{
				_event.m.Title = "After the battle...";

				if (::World.State.getLastLocation() != null)
					::World.State.getLastLocation().die();
			}

		});
		this.m.Screens.push({
			ID = "Defeat",
			Text = "[img]gfx/ui/events/event_22.png[/img]",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Perhaps one day...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Title = "After the battle...";

				if (::World.State.getLastLocation() != null)
					::World.State.getLastLocation().setVisited(false);
			}

		});
		this.m.Screens.push({
			ID = "Recruit",
			Text = "[img]gfx/ui/events/legend_heartwood_dead.png[/img]The sellswords, recognizing something in the Dryad\'s sorrowful plea, sheath their weapons. You step forward and extended a hand.%SPEECH_ON%You fought bravely,%SPEECH_OFF% You say, voice softer now.%SPEECH_ON%If you truly have nothing left here, come with us. The world outside this forest is harsh, but if your mission is to rid the world of man then there\'s no-one better to work with.%SPEECH_OFF%The Dryad looks up, their eyes searching your face. They see no malice, no bloodlust, only a weary soul trying to survive, much like them.\n\nAfter a moment\'s hesitation, they placed their hand in yours, the touch cool and delicate, like the leaves that once surrounded them.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Welcome to the company.",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx(["ssu_dryad_warrior_background"]);
				_event.m.Dude.setTitle("the Lost");
				_event.m.Dude.getBackground().m.RawDescription = "%name% was once a guardian of the sacred world tree Yggdrasil, deeply connected to the natural world and tasked with protecting the forest from invaders.\nThey lived in harmony with the other Dryads, using their abilities to heal the land and maintain the delicate balance of nature. However, after witnessing the destruction of their home and the loss of their kin, they found themselves at a crossroads.\nTorn between their duty to the forest and a growing curiosity about the human world, they eventually chose to join the company, hoping to understand your ways and perhaps find a new purpose beyond the confines of the forest.";
				_event.m.Dude.getBackground().buildDescription(true);

				this.Characters.push(_event.m.Dude.getImagePath());

				_event.m.Title = "It\'s time to leave.";
				if (::World.State.getLastLocation() != null)
					::World.State.getLastLocation().die();
			}

		});
		this.m.Screens.push({
			ID = "Deny",
			Text = "[img]gfx/ui/events/legend_heartwood_dead.png[/img]You don\'t think the Dryad should be left to roam the land, but you do set it free nonetheless.\n\nNo sooner than you shout the command does the company leap into action, resulting in the Dryad\'s swift demise. Better to leave nothing left, lest they somehow return down the road.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "It\'s time to leave.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Title = "It\'s time to leave.";
				if (::World.State.getLastLocation() != null)
					::World.State.getLastLocation().die();
			}

		});
	}

	function finishCombatInfo( _properties )
	{
		local f = ::World.FactionManager.getFactionOfType(::Const.FactionType.Beasts).getID();
		_properties.CombatID = "Yggdrasil";
		_properties.TerrainTemplate == "tactical.forest";
		_properties.LocationTemplate.OwnedByFaction = ::Const.Faction.Player;
		_properties.LocationTemplate.CutDownTrees = false;
		_properties.LocationTemplate.AdditionalRadius = 4;
		_properties.PlayerDeploymentType = ::Const.Tactical.DeploymentType.Center;
		_properties.EnemyDeploymentType = ::Const.Tactical.DeploymentType.Circle;
		_properties.Music = ::Const.Music.BeastsTracks;

		for( local i = 0; i < _properties.Entities.len(); i = ++i )
		{
			_properties.Entities[i].Faction <- f;
		}

		_properties.AfterDeploymentCallback = function ()
		{
			// Make the weather foggy
			local clouds = ::Tactical.getWeather().createCloudSettings();
			clouds.Type = this.getconsttable().CloudType.Fog;
			clouds.MinClouds = 20;
			clouds.MaxClouds = 20;
			clouds.MinVelocity = 3.0;
			clouds.MaxVelocity = 9.0;
			clouds.MinAlpha = 0.35;
			clouds.MaxAlpha = 0.45;
			clouds.MinScale = 2.0;
			clouds.MaxScale = 3.0;
			::Tactical.getWeather().buildCloudCover(clouds);
			::Tactical.getWeather().setAmbientLightingPreset(5);
			::Tactical.getWeather().setAmbientLightingSaturation(0.9);
		};
	}

	function onUpdateScore()
	{
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});