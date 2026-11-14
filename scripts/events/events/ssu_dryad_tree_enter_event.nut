this.ssu_dryad_tree_enter_event <- ::inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.location.ssu_dryad_tree_enter";
		this.m.Title = ::Mod_Sellswords.Strings.ssu_dryad_tree_enter_event.Title1;
		this.m.Cooldown = 999999.0 * ::World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = ::Mod_Sellswords.Strings.ssu_dryad_tree_enter_event.Text1,
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_dryad_tree_enter_event.Text2,
					function getResult( _event )
					{
						return ::Mod_Sellswords.Strings.ssu_dryad_tree_enter_event.Text3;
					}
				},
				{
					Text = ::Mod_Sellswords.Strings.ssu_dryad_tree_enter_event.Text4,
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
			Text = ::Mod_Sellswords.Strings.ssu_dryad_tree_enter_event.Text5
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_dryad_tree_enter_event.Text6,
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
								ID = ::Const.EntityType.SsuDryadWolf,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/enemies/ssu_dryad_wolf",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.SsuDryadWolf,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/enemies/ssu_dryad_wolf",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.SsuDryadSnake,
								Variant = 0,
								Row = 1,
								Script = "scripts/entity/tactical/enemies/ssu_dryad_snake",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.SsuDryadSnake,
								Variant = 0,
								Row = 1,
								Script = "scripts/entity/tactical/enemies/ssu_dryad_snake",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.SsuDryadUnhold,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/enemies/ssu_dryad_unhold",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.SsuDryadUnhold,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/enemies/ssu_dryad_unhold",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.SsuDryadLindy,
								Variant = 0,
								Row = 1,
								Script = "scripts/entity/tactical/enemies/ssu_dryad_lindy",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.SsuDryadWarrior,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/enemies/ssu_dryad_enemy_warrior",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.SsuDryadWarrior,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/enemies/ssu_dryad_enemy_warrior",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.SsuDryadGrunt,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/enemies/ssu_dryad_enemy_grunt",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.SsuDryadGrunt,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/enemies/ssu_dryad_enemy_grunt",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.SsuDryadArcher,
								Variant = 0,
								Row = 1,
								Script = "scripts/entity/tactical/enemies/ssu_dryad_enemy_archer",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.SsuDryadArcher,
								Variant = 0,
								Row = 1,
								Script = "scripts/entity/tactical/enemies/ssu_dryad_enemy_archer",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.SsuDryadArcher,
								Variant = 0,
								Row = 1,
								Script = "scripts/entity/tactical/enemies/ssu_dryad_enemy_archer",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.SsuDryadShaman,
								Variant = 0,
								Row = 2,
								Script = "scripts/entity/tactical/enemies/ssu_dryad_enemy_shaman",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.SsuDryadShaman,
								Variant = 0,
								Row = 2,
								Script = "scripts/entity/tactical/enemies/ssu_dryad_enemy_shaman",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.SsuDryadTamer,
								Variant = 0,
								Row = 2,
								Script = "scripts/entity/tactical/enemies/ssu_dryad_enemy_tamer",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.SsuDryadTamer,
								Variant = 0,
								Row = 2,
								Script = "scripts/entity/tactical/enemies/ssu_dryad_enemy_tamer",
								Faction = this.Const.Faction.Enemy
							},
							{
								ID = ::Const.EntityType.SsuDryadBoss,
								Variant = 10,
								Row = 1,
								Script = "scripts/entity/tactical/enemies/ssu_dryad_enemy_boss",
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
			Text = ::Mod_Sellswords.Strings.ssu_dryad_tree_enter_event.Text7,
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_dryad_tree_enter_event.Text8,
					function getResult( _event )
					{
						return ::Mod_Sellswords.Strings.ssu_dryad_tree_enter_event.Text9;
					}

				},
				{
					Text = ::Mod_Sellswords.Strings.ssu_dryad_tree_enter_event.Text10,
					function getResult( _event )
					{
						return ::Mod_Sellswords.Strings.ssu_dryad_tree_enter_event.Text11;
					}

				}
			],
			function start( _event )
			{
				_event.m.Title = ::Mod_Sellswords.Strings.ssu_dryad_tree_enter_event.Title2;

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
					Text = ::Mod_Sellswords.Strings.ssu_dryad_tree_enter_event.Text12,
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Title = ::Mod_Sellswords.Strings.ssu_dryad_tree_enter_event.Title2;

				if (::World.State.getLastLocation() != null)
					::World.State.getLastLocation().setVisited(false);
			}

		});
		this.m.Screens.push({
			ID = "Recruit",
			Text = ::Mod_Sellswords.Strings.ssu_dryad_tree_enter_event.Text13,
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_dryad_tree_enter_event.Text14,
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
				_event.m.Dude.setTitle(::Mod_Sellswords.Strings.ssu_dryad_tree_enter_event.Title3);
				_event.m.Dude.getBackground().m.RawDescription = ::Mod_Sellswords.Strings.ssu_dryad_tree_enter_event.RawDescription;
				_event.m.Dude.getBackground().buildDescription(true);

				this.Characters.push(_event.m.Dude.getImagePath());

				_event.m.Title = ::Mod_Sellswords.Strings.ssu_dryad_tree_enter_event.Title4;
				if (::World.State.getLastLocation() != null)
					::World.State.getLastLocation().die();
			}

		});
		this.m.Screens.push({
			ID = "Deny",
			Text = ::Mod_Sellswords.Strings.ssu_dryad_tree_enter_event.Text15,
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = ::Mod_Sellswords.Strings.ssu_dryad_tree_enter_event.Text16,
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Title = ::Mod_Sellswords.Strings.ssu_dryad_tree_enter_event.Title4;
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