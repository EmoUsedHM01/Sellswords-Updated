::Const.World.Spawn.GoblinRoamers.MaxR = 480;
::Const.World.Spawn.GoblinRoamers.MinR = 50;
::Const.World.Spawn.GoblinRoamers.Troops = [
	{
		Weight = 20,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GoblinSkirmisherLOW,
				Cost = 22
			},
			{
				Type = this.Const.World.Spawn.Troops.GoblinSkirmisher,
				MinR = 400,
				Cost = 30
			}
		]
	},
	{
		Weight = 30,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GoblinAmbusherLOW,
				Cost = 30
			},
			{
				Type = this.Const.World.Spawn.Troops.GoblinAmbusher,
				MinR = 400,
				Cost = 38
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crGoblinwarrior,
				MinR = 300,
				Cost = 35
			}
		]
	},
	{
		Weight = 49,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GoblinWolfrider,
				MinR = 800,
				Cost = 60
			}
		]
	}
];


::Const.World.Spawn.GoblinScouts.MinR = 75;
::Const.World.Spawn.GoblinScouts.MaxR = 400;
::Const.World.Spawn.GoblinScouts.Troops = [
	{
		Weight = 30,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GoblinSkirmisherLOW,
				Cost = 22
			},
			{
				Type = this.Const.World.Spawn.Troops.GoblinSkirmisher,
				MinR = 400,
				Cost = 30
			}
		]
	},
	{
		Weight = 40,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GoblinAmbusherLOW,
				Cost = 30
			},
			{
				Type = this.Const.World.Spawn.Troops.GoblinAmbusher,
				MinR = 400,
				Cost = 38
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crGoblinwarrior,
				MinR = 300,
				Cost = 35
			}
		]
	},
	{
		Weight = 30,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GoblinWolfrider,
				MinR = 800,
				Cost = 60
			}
		]
	}
];

::Const.World.Spawn.GoblinRaiders.MinR = 55;
::Const.World.Spawn.GoblinRaiders.MaxR = 695;
::Const.World.Spawn.GoblinRaiders.Troops = [
	{
		Weight = 45,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GoblinSkirmisherLOW,
				Cost = 22
			},
			{
				Type = this.Const.World.Spawn.Troops.GoblinSkirmisher,
				MinR = 400,
				Cost = 30
			}
		]
	},
	{
		Weight = 25,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GoblinAmbusherLOW,
				Cost = 30
			},
			{
				Type = this.Const.World.Spawn.Troops.GoblinAmbusher,
				MinR = 400,
				Cost = 38
			}
		]
	},
	{
		Weight = 25,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GoblinWolfrider,
				MinR = 800,
				Cost = 60
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crGoblinwarrior,
				MinR = 300,
				Cost = 35
			}
		]
	},
	{
		Weight = 4,
		MinR = 1000,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GoblinOverseer,
				Cost = 55
			}
		]
	},
	{
		Weight = 4,
		MinR = 1200,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GoblinShaman,
				Cost = 55
			}
		]
	}
];

::Const.World.Spawn.GoblinDefenders.MinR = 40;
::Const.World.Spawn.GoblinDefenders.MaxR = 585;
::Const.World.Spawn.GoblinDefenders.Troops = [
	{
		Weight = 50,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GoblinSkirmisherLOW,
				Cost = 22
			},
			{
				Type = this.Const.World.Spawn.Troops.GoblinSkirmisher,
				MinR = 400,
				Cost = 30
			}
		]
	},
	{
		Weight = 30,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GoblinAmbusherLOW,
				Cost = 30
			},
			{
				Type = this.Const.World.Spawn.Troops.GoblinAmbusher,
				MinR = 400,
				Cost = 38
			}
		]
	},
	{
		Weight = 15,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GoblinWolfrider,
				MinR = 800,
				Cost = 60
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crGoblinwarrior,
				MinR = 300,
				Cost = 35
			}
		]
	},
	{
		Weight = 4,
		MinR = 1000,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GoblinOverseer,
				Cost = 55
			}
		]
	},
	{
		Weight = 4,
		MinR = 1200,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GoblinShaman,
				Cost = 55
			}
		]
	}
];

::Const.World.Spawn.GoblinBoss.MinR = 215;
::Const.World.Spawn.GoblinBoss.MaxR = 585;
::Const.World.Spawn.GoblinBoss.Fixed = [
	{
		Type = this.Const.World.Spawn.Troops.GoblinOverseer,
		Weight = 0,
		Cost = 55
	}
];
::Const.World.Spawn.GoblinBoss.Troops = [
	{
		Weight = 55,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GoblinSkirmisher,
				Cost = 22
			}
		]
	},
	{
		Weight = 30,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GoblinAmbusher,
				Cost = 30
			}
		]
	},
	{
		Weight = 8,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GoblinWolfrider,
				MinR = 400,
				Cost = 60
			}
		]
	},
	{
		Weight = 8,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crGoblinwarrior,
				MinR = 300,
				Cost = 35
			}
		]
	},
	{
		Weight = 4,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GoblinOverseer,
				Cost = 55
			}
		]
	},
	{
		Weight = 4,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GoblinShaman,
				MinR = 600,
				Cost = 55
			}
		]
	}
];
