this.ssu_necro_kriegsgeist_castle_enter_event <- ::inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.location.ssu_necro_kriegsgeist_castle_enter";
		this.m.Title = ::Mod_Sellswords.Strings.ssu_necro_kriegsgeist_castle_enter_event.Title1;
		this.m.Cooldown = 999999.0 * ::World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = ::Mod_Sellswords.Strings.ssu_necro_kriegsgeist_castle_enter_event.Text1,
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_necro_kriegsgeist_castle_enter_event.Text2,
					function getResult( _event )
					{
						return "B";
					}
				}
				,{
					Text = ::Mod_Sellswords.Strings.ssu_necro_kriegsgeist_castle_enter_event.Text3,
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
			Text = ::Mod_Sellswords.Strings.ssu_necro_kriegsgeist_castle_enter_event.Text4
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_necro_kriegsgeist_castle_enter_event.Text5,
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
							Script = "scripts/entity/tactical/enemies/ssu_necro_ghost_praetorian_boss",
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
			Text = ::Mod_Sellswords.Strings.ssu_necro_kriegsgeist_castle_enter_event.Text6,
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_necro_kriegsgeist_castle_enter_event.Text7,
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Title = ::Mod_Sellswords.Strings.ssu_necro_kriegsgeist_castle_enter_event.Title2;

				this.List.push({
					id = 10,
					icon = "ui/items/weapons/melee/ssu_ghost_spear_70x70.png",
					text = ::Mod_Sellswords.Strings.ssu_necro_kriegsgeist_castle_enter_event.Tooltip
				});

				if (::World.State.getLastLocation() != null)
					::World.State.getLastLocation().die();
			}
		});
		this.m.Screens.push({
			ID = "Defeat",
			Text = ::Mod_Sellswords.Strings.ssu_necro_kriegsgeist_castle_enter_event.Text8,
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_necro_kriegsgeist_castle_enter_event.Text9,
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Title = ::Mod_Sellswords.Strings.ssu_necro_kriegsgeist_castle_enter_event.Title2;

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