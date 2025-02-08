this.kriegsgeist_castle_enter_event <- ::inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.location.kriegsgeist_castle_enter";
		this.m.Title = "As you approach...";
		this.m.Cooldown = 999999.0 * ::World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_99.png[/img]{Standing before you, the stronghold of a forgotten past. From rumors, there is great treasures inside this ruins of a castle, untouched by treasure hunters as none of them return alive or are still sane of mind.\n\nYou used to think such tales were nonsense but now you\'ve finally reached here, the chilling air, the dreadful feeling in your gut, the thought of being watched by something. It\'s as true as the rumors said, making you grow ever more anxious, a sentiment you\'re sure most of the company shares.\n\n%randombrother% approaches you.%SPEECH_ON%Cap\'n? Why again must we enter this damned place? Surely nothing good can come from us tresspassing.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Be that as it may, we\'re going in. Get ready for anything.",
					function getResult( _event )
					{
						return "B";
					}
				}
				,{
					Text = "Aye, let\'s not disturb what rests here just yet.",
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
			ID = "B",
			Text = "[img]gfx/ui/events/event_57.png[/img]{You enter the keep, keeping your wits about you as the company carefully advances through these hallowed grounds. You glance around as you approach a giant castle in the centre of the keep.%SPEECH_ON%Hey %randombrother%, open the doors.%SPEECH_OFF% You hear them muttering something about a \'being a farkin\' chicken\', but you sure-as-shit aren\'t about to open them yourself.\n\nAs they push open the massive, time-worn doors of the keep, the groan of rusted hinges echoes through the cold, dark surroundings. The company enters, air thick with what is certainly the passage of centuries and you swear you can hear the faint whispers of long-dead souls as you navigate the men through the ancient halls.\n\nUpon entering what you can only imagine was once a beautiful courtyard, you spot a figure ahead. Its giant spectral form draped in an ancient armor, and as it turns in welcome, their glowing eyes lock onto yours. In its hands, the prize of the keep, the entire reason you\'re here, a glowing halberd forged from a forgotten age wielded with a deadly intent.%SPEECH_ON%Trespassers, you shouldn\'t have come here. Now you\'ll pay for such foolishness with your lives!%SPEECH_OFF%}"
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Time to earn those crowns! Men, get into positions!",
					function getResult( _event )
					{
						if (::World.State.getLastLocation() != null)
						{
							::World.State.getLastLocation().setVisited(false);
						}

						local p = ::World.State.getLocalCombatProperties(::World.State.getPlayer().getPos());
						p.LocationTemplate = clone ::Const.Tactical.LocationTemplate;
						p.Entities = [{
							ID = ::Const.EntityType.ZombieBoss,
							Variant = 0,
							Strength = 5000.0,
							Row = 3,
							Script = "scripts/entity/tactical/enemies/ghost_praetorian_boss",
							Name = ""
						}];

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
			Text = "[img]gfx/ui/events/event_99.png[/img]{As the dust settles and the echoes of battle fade, the once formidable specter lies vanquished, its cursed armor shattered and the ancient halberd now in your hands. The air grows still, as if the very walls of the keep recognize your triumph.\n\nThough many of the company bear wounds, there is a palpable sense of relief. The treasure of Kriegsgeist Castle is now yours, but at what cost? Only time will tell if the true prize was worth the bloodshed.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We survived, and are stronger for it.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Title = "After the battle...";

				this.List.push({
					id = 10,
					icon = "ui/items/weapons/melee/ssu_ghost_spear_70x70.png",
					text = "You gain [color=#456ca0]Specter\'s Requiem[/color]"
				});

				if (::World.State.getLastLocation() != null)
					::World.State.getLastLocation().die();
			}
		});
		this.m.Screens.push({
			ID = "Defeat",
			Text = "[img]gfx/ui/events/event_99.png[/img]The cold grip of defeat tightens as the last of your company falls, their bodies claimed by the haunted grounds of Kriegsgeist Castle. The spectral warrior looms over your broken form, its hollow laughter echoing through the desolate halls. The ancient halberd gleams in the gloom, untouched and unclaimed. Perhaps one day, another will be bold enough to challenge this cursed place—but today, it belongs to the dead.",
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
				{
					::World.State.getLastLocation().setVisited(false);
				}
			}
		});
	}

	function finishCombatInfo( _properties )
	{
		local f = ::World.FactionManager.getFactionOfType(::Const.FactionType.Zombies).getID();
		_properties.CombatID = "Kriegsgeist";
		//_properties.TerrainTemplate = "tactical.plains_camp";
		_properties.LocationTemplate.Template[0] = "tactical.ruins";
		_properties.LocationTemplate.Fortification = ::Const.Tactical.FortificationType.Walls;
		_properties.LocationTemplate.OwnedByFaction = ::Const.Faction.Player;
		_properties.LocationTemplate.CutDownTrees = true;
		_properties.LocationTemplate.AdditionalRadius = 4;
		_properties.PlayerDeploymentType = ::Const.Tactical.DeploymentType.Center;
		_properties.EnemyDeploymentType = ::Const.Tactical.DeploymentType.Circle;
		_properties.Music = ::Const.Music.UndeadTracks;

		for( local i = 0; i < _properties.Entities.len(); i = ++i )
		{
			_properties.Entities[i].Faction <- f;
		}

		_properties.AfterDeploymentCallback = function ()
		{
			// make the weather a bit bad
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
	}

});