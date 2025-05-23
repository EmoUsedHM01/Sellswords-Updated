::Const.World.Spawn.NomadRoamers.Fixed = [];
::Const.World.Spawn.NomadRoamers.MaxR = 260;
::Const.World.Spawn.NomadRoamers.Troops = [
	{
		Weight = 50,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				MaxR = 110,
				Cost = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.NomadCutthroat,
				MinR = 125,
				Cost = 14
			},
			{
				Type = this.Const.World.Spawn.Troops.NomadOutlaw,
				MinR = 250,
				Cost = 20
			}
		]
	},
	{
		Weight = 18,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.NomadSlinger,
				Cost = 12
			},
			{
				Type = this.Const.World.Spawn.Troops.NomadArcher,
				MinR = 250,
				Cost = 30
			}
		]
	}
];

::Const.World.Spawn.NomadRaiders.MaxR = 600;
::Const.World.Spawn.NomadRaiders.Fixed = [
	{
		Weight = 100,
		MinR = 200,
		Type = this.Const.World.Spawn.Troops.NomadLeader,
		Cost = 40
	}
];
::Const.World.Spawn.NomadRaiders.crFixed <- [
	{
		Weight = 100,
		MinR = 350,
		Type = this.Const.World.Spawn.Troops.NomadLeader,
		Cost = 40
	}
];
::Const.World.Spawn.NomadRaiders.crrFixed <- [
	{
		Weight = 100,
		MinR = 500,
		Type = this.Const.World.Spawn.Troops.Executioner,
		Cost = 60
	}
];
::Const.World.Spawn.NomadRaiders.Troops = [
	{
		Weight = 65,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				MaxR = 130,
				Cost = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.NomadCutthroat,
				Cost = 15
			},
			{
				Type = this.Const.World.Spawn.Troops.NomadOutlaw,
				MinR = 100,
				Cost = 20
			}
		]
	},
	{
		Weight = 10,
		MaxR = 80,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Cost = 5,
				Roll = true
			}
		]
	},
	{
		Weight = 20,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.NomadSlinger,
				Cost = 15
			},
			{
				Type = this.Const.World.Spawn.Troops.NomadArcher,
				MinR = 120,
				Cost = 20
			},
			{
				Type = this.Const.World.Spawn.Troops.DesertStalker,
				MinR = 420,
				Cost = 65,
				Roll = true
			}
		]
	},
	{
		Weight = 4,
		MinR = 320,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.NomadLeader,
				Cost = 40,
				MinGuards = 2,
				MaxGuards = 4,
				MaxGuardsWeight = 25,
				Guards = [
					{
						Type = this.Const.World.Spawn.Troops.NomadOutlaw,
						Cost = 20,
						function Weight(scale) {
							return 100;
						}

					}
				]
			}
		]
	},
	{
		Weight = 2,
		MinR = 400,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Executioner,
				Cost = 65,
				Roll = true
				MinGuards = 1,
				MaxGuards = 2,
				MaxGuardsWeight = 25,
				Guards = [
					{
						Type = this.Const.World.Spawn.Troops.NomadOutlaw,
						Cost = 20,
						function Weight(scale) {
							return 100;
						}

					}
				]
			}
		]
	},
	{
		Weight = 1,
		MinR = 450,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.DesertDevil,
				Cost = 65,
				Roll = true
			}
		]
	}
];

::Const.World.Spawn.NomadDefenders.MaxR = 600;
::Const.World.Spawn.NomadDefenders.Fixed = [
	{
		Weight = 100,
		MinR = 200,
		Type = this.Const.World.Spawn.Troops.NomadLeader,
		Cost = 40
	}
];

::Const.World.Spawn.NomadDefenders.crFixed <- [
	{
		Weight = 100,
		MinR = 350,
		Type = this.Const.World.Spawn.Troops.NomadLeader,
		Cost = 40
	}
];

::Const.World.Spawn.NomadDefenders.crrFixed <- [
	{
		Weight = 100,
		MinR = 500,
		Type = this.Const.World.Spawn.Troops.Executioner,
		Cost = 60
	}
];

::Const.World.Spawn.NomadDefenders.Troops = [
	{
		Weight = 60,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.NomadCutthroat,
				Cost = 13
			},
			{
				Type = this.Const.World.Spawn.Troops.NomadOutlaw,
				Cost = 18
			}
		]
	},
	{
		Weight = 20,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.NomadSlinger,
				Cost = 12
			},
			{
				Type = this.Const.World.Spawn.Troops.NomadArcher,
				MinR = 120,
				Cost = 15
			},
			{
				Type = this.Const.World.Spawn.Troops.DesertStalker,
				MinR = 420,
				Cost = 45,
				Roll = true
			}
		]
	},
	{
		Weight = 5,
		MinR = 320,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.NomadLeader,
				Cost = 40,
				MinGuards = 2,
				MaxGuards = 4,
				MaxGuardsWeight = 25,
				Guards = [
					{
						Type = this.Const.World.Spawn.Troops.NomadOutlaw,
						Cost = 20,
						function Weight(scale) {
							return 100;
						}

					}
				]
			}
		]
	},
	{
		Weight = 3,
		MinR = 400,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Executioner,
				Cost = 55,
				Roll = true
				MinGuards = 1,
				MaxGuards = 2,
				MaxGuardsWeight = 25,
				Guards = [
					{
						Type = this.Const.World.Spawn.Troops.NomadOutlaw,
						Cost = 20,
						function Weight(scale) {
							return 100;
						}

					}
				]
			}
		]
	},
	{
		Weight = 2,
		MinR = 450,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.DesertDevil,
				Cost = 50,
				Roll = true
			}
		]
	}
];
