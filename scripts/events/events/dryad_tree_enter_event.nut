this.dryad_tree_enter_event <- ::inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.location.dryad_tree_enter";
		this.m.Title = "As you approach...";
		this.m.Cooldown = 999999.0 * ::World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/legend_heartwood.png[/img]{TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE TREE \n\n%randombrother% approaches you.%SPEECH_ON%Cap\'n? Why do you want to enter TREE? Surely nothing good can come from us TREE.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [/*
				{
					Text = "The legendary greatsword",
					function getResult( _event )
					{
						return "Sword";
					}
				},
				{
					Text = "The skull-like artifact",
					function getResult( _event )
					{
						return "Skull";
					}
				},
				{
					Text = "Both of them",
					function getResult( _event )
					{
						return "Both";
					}
				},*/
				{
					Text = "Let\'s not disturb the TREE.",
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

		});/*
		this.m.Screens.push({
			ID = "Sword",
			Text = "[img]gfx/ui/events/event_89.png[/img]{%SPEECH_START%Trespassers, you shouldn\'t have come here. Now pay your foolishness with your life!%SPEECH_OFF%}"
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
						p.Entities = [{
							ID = ::Const.EntityType.ZombieBoss,
							Variant = 0,
							Strength = 5000.0,
							Row = 3,
							Script = "scripts/entity/tactical/enemies/mod_ghost_knight_boss",
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
			ID = "Skull",
			Text = "[img]gfx/ui/events/event_89.png[/img]{%SPEECH_START%Trespassers, you shouldn\'t have come here. Now pay your foolishness with your life!%SPEECH_OFF%}",
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
						p.Entities = [{
							ID = ::Const.EntityType.SkeletonLichMirrorImage,
							Variant = 0,
							Strength = 5000.0,
							Row = 3,
							Script = "scripts/entity/tactical/enemies/mod_ghost_mage_boss",
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
			ID = "Both",
			Text = "[img]gfx/ui/events/event_89.png[/img]{%SPEECH_START%Trespassers, you shouldn\'t have come here. Now pay your foolishness with your life!%SPEECH_OFF%}",
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
								ID = ::Const.EntityType.ZombieBoss,
								Variant = 0,
								Strength = 5000.0,
								Row = 3,
								Script = "scripts/entity/tactical/enemies/mod_ghost_knight_boss",
								Name = ""
							},
							{
								ID = ::Const.EntityType.SkeletonLichMirrorImage,
								Variant = 0,
								Strength = 5000.0,
								Row = 3,
								Script = "scripts/entity/tactical/enemies/mod_ghost_mage_boss",
								Name = ""
							},
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
			Text = "[img]gfx/ui/events/event_65.png[/img]{}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We have survived",
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
					::World.State.getLastLocation().die();
				}
			}

		});
		this.m.Screens.push({
			ID = "Defeat",
			Text = "[img]gfx/ui/events/event_99.png[/img]",
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

		});*/
	}

	/*
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
	}*/

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