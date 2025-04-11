::Const.World.Spawn.Zombies.MaxR = 521;
::Const.World.Spawn.Zombies.MinR = 35;
::Const.World.Spawn.Zombies.Troops = [
	{
		Weight = 20,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Zombie,
				Cost = 5
			}
		]
	},
	{
		Weight = 60,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.ZombieYeoman,
				MinR = 100,
				Cost = 20
			}
		]
	},
	{
		Weight = 20,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.ZombieKnight,
				MinR = 200,
				Cost = 40
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crFallenbetrayer,
				MinR = 350,
				Cost = 45
			}
		]
	}
];

::Const.World.Spawn.ZombiesLight.MaxR = 124;
::Const.World.Spawn.ZombiesLight.MinR = 36;
::Const.World.Spawn.ZombiesLight.Troops = [
	{
		Weight = 85,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Zombie,
				Cost = 5
			}
		]
	},
	{
		Weight = 15,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.ZombieYeoman,
				Cost = 15
			}
		]
	}
];

::Const.World.Spawn.ZombiesAndGhouls.MaxR = 441;
::Const.World.Spawn.ZombiesAndGhouls.MinR = 54;
::Const.World.Spawn.ZombiesAndGhouls.Troops = [
	{
		Weight = 12,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Zombie,
				Cost = 5
			}
		]
	},
	{
		Weight = 50,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.ZombieYeoman,
				MinR = 100,
				Cost = 20
			}
		]
	},
	{
		Weight = 25,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.ZombieKnight,
				MinR = 200,
				Cost = 40
			}
		]
	},
	{
		Weight = 15,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crFallenbetrayer,
				MinR = 350,
				Cost = 45
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crZombieswordmaster,
				MinR = 450,
				Cost = 45
			}
		]
	},
	{
		Weight = 20,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GhoulLOW,
				Cost = 9
			},
			{
				Type = this.Const.World.Spawn.Troops.Ghoul,
				MinR = 200,
				Cost = 19
			}
		]
	}
];

::Const.World.Spawn.ZombiesOrZombiesAndGhouls.MaxR = 441;
::Const.World.Spawn.ZombiesOrZombiesAndGhouls.MinR = 54;
::Const.World.Spawn.ZombiesOrZombiesAndGhouls.Troops = [
	{
		Weight = 12,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Zombie,
				Cost = 5
			}
		]
	},
	{
		Weight = 50,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.ZombieYeoman,
				MinR = 100,
				Cost = 20
			}
		]
	},
	{
		Weight = 25,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.ZombieKnight,
				MinR = 200,
				Cost = 40
			}
		]
	},
	{
		Weight = 15,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crFallenbetrayer,
				MinR = 350,
				Cost = 45
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crZombieswordmaster,
				MinR = 450,
				Cost = 45
			}
		]
	},
	{
		Weight = 20,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GhoulLOW,
				Cost = 9
			},
			{
				Type = this.Const.World.Spawn.Troops.Ghoul,
				MinR = 200,
				Cost = 19
			}
		]
	}
];

::Const.World.Spawn.ZombiesAndGhosts.MaxR = 441;
::Const.World.Spawn.ZombiesAndGhosts.MinR = 54;
::Const.World.Spawn.ZombiesAndGhosts.Troops = [
	{
		Weight = 12,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Zombie,
				Cost = 5
			}
		]
	},
	{
		Weight = 45,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.ZombieYeoman,
				MinR = 100,
				Cost = 20
			}
		]
	},
	{
		Weight = 25,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.ZombieKnight,
				MinR = 200,
				Cost = 30
			}
		]
	},
	{
		Weight = 15,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crFallenbetrayer,
				MinR = 350,
				Cost = 45
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crZombieswordmaster,
				MinR = 450,
				Cost = 45
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Ghost,
				Cost = 20
			}
		]
	},
	{
		Weight = 5,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.LegendDemonHound,
				MinR = 400,
				Cost = 40
			}
		]
	},
	{
		Weight = 5,
		MinR = 500,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.LegendBanshee,
				Cost = 70
			}
		]
	}
];

::Const.World.Spawn.ZombiesOrZombiesAndGhosts.MaxR = 441;
::Const.World.Spawn.ZombiesOrZombiesAndGhosts.MinR = 54;
::Const.World.Spawn.ZombiesOrZombiesAndGhosts.Troops = [
	{
		Weight = 12,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Zombie,
				Cost = 5
			}
		]
	},
	{
		Weight = 40,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.ZombieYeoman,
				MinR = 100,
				Cost = 20
			}
		]
	},
	{
		Weight = 25,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.ZombieKnight,
				MinR = 200,
				Cost = 40
			}
		]
	},
	{
		Weight = 15,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crFallenbetrayer,
				MinR = 350,
				Cost = 45
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crZombieswordmaster,
				MinR = 450,
				Cost = 45
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Ghost,
				Cost = 20
			}
		]
	},
	{
		Weight = 5,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.LegendDemonHound,
				MinR = 400,
				Cost = 40
			}
		]
	},
	{
		Weight = 5,
		MinR = 500,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.LegendBanshee,
				Cost = 70
			}
		]
	}
];

::Const.World.Spawn.Ghosts.MaxR = 460;
::Const.World.Spawn.Ghosts.MinR = 80;
::Const.World.Spawn.Ghosts.Troops = [
	{
		Weight = 80,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Ghost,
				Cost = 20
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.LegendDemonHound,
				MinR = 200,
				Cost = 40
			}
		]
	},
	{
		Weight = 10,
		MinR = 400,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.LegendBanshee,
				Cost = 70
			}
		]
	}
];


::Const.World.Spawn.Necromancer.MaxR = 706;
::Const.World.Spawn.Necromancer.MinR = 102;
::Const.World.Spawn.Necromancer.Fixed = [
	{
		Type = this.Const.World.Spawn.Troops.Necromancer,
		Cost = 30,
		MinGuards = 1,
		MaxGuards = 2,
		MaxGuardsWeight = 25,
		Weight = 0,
		Guards = [
			{
				Type = this.Const.World.Spawn.Troops.ZombieBodyguard,
				MaxR = 125,
				Cost = 6,
				function Weight(scale) {
					local c = 100 - scale * 100;
					return this.Math.max(0, c);
				}

			},
			{
				Type = this.Const.World.Spawn.Troops.ZombieYeomanBodyguard,
				MinR = 100,
				Cost = 12,
				function Weight(scale) {
					local c = 100 - scale * 100;
					return this.Math.max(0, c);
				}

			},
			{
				Type = this.Const.World.Spawn.Troops.ZombieKnightBodyguard,
				MinR = 200,
				Cost = 25,
				function Weight(scale) {
					local c = 100 - (1.0 - scale) * 100;
					return this.Math.min(100, c);
				}

			}
		]
	}
];
::Const.World.Spawn.Necromancer.Troops = [
	{
		Weight = 15,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Zombie,
				Cost = 5
			}
		]
	},
	{
		Weight = 45,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.ZombieYeoman,
				MinR = 100,
				Cost = 20
			}
		]
	},
	{
		Weight = 25,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.ZombieKnight,
				MinR = 200,
				Cost = 30
			}
		]
	},
	{
		Weight = 20,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crFallenbetrayer,
				MinR = 350,
				Cost = 45
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crZombieswordmaster,
				MinR = 450,
				Cost = 45
			}
		]
	},
	{
		Weight = 5,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Necromancer,
				Cost = 30,
				Roll = true,
				MinGuards = 1,
				MaxGuards = 2,
				MaxGuardsWeight = 50,
				Guards = [
					{
						Type = this.Const.World.Spawn.Troops.ZombieYeomanBodyguard,
						Cost = 12,
						function Weight(scale) {
							local c = 100 - scale * 100;
							return this.Math.max(0, c);
						}

					},
					{
						Type = this.Const.World.Spawn.Troops.ZombieKnightBodyguard,
						Cost = 25,
						function Weight(scale) {
							local c = 100 - (1.0 - scale) * 100;
							return this.Math.min(100, c);
						}

					}
				]
			}
		]
	},
	{
		Weight = 4,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Ghost,
				Cost = 20
			}
		]
	},
	{
		Weight = 4,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.LegendDemonHound,
				MinR = 400,
				Cost = 40
			}
		]
	},
	{
		Weight = 2,
		MinR = 500,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.LegendBanshee,
				Cost = 70
			}
		]
	},
	{
		Weight = 1,
		MinR = 600,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crDeathknight,
				Cost = 80
			}
		]
	}
];

::Const.World.Spawn.NecromancerSouthern.MaxR = 706;
::Const.World.Spawn.NecromancerSouthern.MinR = 102;
::Const.World.Spawn.NecromancerSouthern.Fixed = [
	{
		Type = this.Const.World.Spawn.Troops.Necromancer,
		Cost = 30,
		MinGuards = 1,
		MaxGuards = 2,
		MaxGuardsWeight = 25,
		Weight = 100,
		Guards = [
			{
				Type = this.Const.World.Spawn.Troops.ZombieNomadBodyguard,
				MinR = 100,
				Cost = 6,
				function Weight(scale) {
					local c = 100 - scale * 100;
					return this.Math.max(0, c);
				}

			},
			{
				Type = this.Const.World.Spawn.Troops.ZombieKnightBodyguard,
				MinR = 200,
				Cost = 24,
				function Weight(scale) {
					local c = 100 - (1.0 - scale) * 100;
					return this.Math.min(100, c);
				}

			}
		]
	}
];

::Const.World.Spawn.NecromancerSouthern.Troops = [
	{
		Weight = 25,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.ZombieNomad,
				Cost = 10
			}
		]
	},
	{
		Weight = 35,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.ZombieYeoman,
				Cost = 10
			}
		]
	},
	{
		Weight = 18,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.ZombieNomadBodyguard,
				MinR = 125,
				Cost = 20
			}
		]
	},
	{
		Weight = 15,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.ZombieKnight,
				MinR = 200,
				Cost = 30
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crFallenbetrayer,
				MinR = 350,
				Cost = 45
			}
		]
	},
	{
		Weight = 5,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crZombieswordmaster,
				MinR = 450,
				Cost = 45
			}
		]
	},
	{
		Weight = 5,
		MinR = 220,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Necromancer,
				Cost = 30,
				Roll = true,
				MinGuards = 1,
				MaxGuards = 2,
				MaxGuardsWeight = 50,
				Guards = [
					{
						Type = this.Const.World.Spawn.Troops.ZombieNomadBodyguard,
						Cost = 6,
						function Weight(scale) {
							local c = 100 - scale * 100;
							return this.Math.max(0, c);
						}
					},
					{
						Type = this.Const.World.Spawn.Troops.ZombieKnightBodyguard,
						Cost = 24,
						function Weight(scale) {
							local c = 100 - (1.0 - scale) * 100;
							return this.Math.min(100, c);
						}
					}
				]
			}
		]
	}
];
