::Const.World.Spawn.Southern.MaxR = 720;
::Const.World.Spawn.Southern.Fixed <- [
	{
		Weight = 100,
		Type = this.Const.World.Spawn.Troops.Officer,
		Cost = 40
	}
];

::Const.World.Spawn.Southern.crFixed <- [
	{
		Weight = 100,
		MinR = 325,
		Type = this.Const.World.Spawn.Troops.Officer,
		Cost = 35
	}
];

::Const.World.Spawn.Southern.crrFixed <- [
	{
		Weight = 100,
		MinR = 400,
		Type = this.Const.World.Spawn.Troops.Officer,
		Cost = 35
	}
];

::Const.World.Spawn.Southern.crrrFixed <- [
	{
		Weight = 100,
		MinR = 500,
		Type = this.Const.World.Spawn.Troops.Officer,
		Cost = 35
	}
];

::Const.World.Spawn.Southern.Troops = [
	{
		Weight = 50,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				MaxR = 400,
				Cost = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Cost = 18
			}
		]
	},
	{
		Weight = 15,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Cost = 20
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				MinR = 250,
				Cost = 20
			}
		]
	},
	{
		Weight = 7,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crConscript,
				MinR = 200,
				Cost = 20
			}
		]
	},
	{
		Weight = 8,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Cost = 10,
				MinR = 250,
				MinGuards = 1,
				MaxGuards = 1,
				MaxGuardsWeight = 100,
				Guards = [
					{
						Type = this.Const.World.Spawn.Troops.Mortar,
						Cost = 30,
						function Weight(scale) {
							return 100;
						}

					}
				]
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Solemner,
				MinR = 225,
				Cost = 30
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				MinR = 300,
				Cost = 35
			}
		]
	}
];

::Const.World.Spawn.CaravanSouthern.MaxR = 560;
::Const.World.Spawn.CaravanSouthern.Fixed = [
	{
		MinCount = 1,
		MaxCount = 3,
		Weight = 30,
		Type = this.Const.World.Spawn.Troops.SouthernDonkey,
		Cost = 0
	}
];

::Const.World.Spawn.CaravanSouthern.Troops = [
	{
		Weight = 58,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Cost = 20
			}
		]
	},
	{
		Weight = 24,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Cost = 28
			}
		]
	},
	{
		Weight = 5,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crConscript,
				Cost = 20
			}
		]
	},
	{
		Weight = 1,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crMercenary,
				Cost = 25
			}
		]
	},
	{
		Weight = 1,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.MercenaryRanged,
				Cost = 25
			}
		]
	},
	{
		Weight = 1,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Cost = 35
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Cost = 7
			}
		]
	}
];


::Const.World.Spawn.Slaves.MaxR = 210;
::Const.World.Spawn.Slaves.Troops = [
	{
		Weight = 100,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Cost = 7
			}
		]
	}
];

::Const.World.Spawn.NorthernSlaves.MaxR = 210;
::Const.World.Spawn.NorthernSlaves.Troops = [
	{
		Weight = 100,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.NorthernSlave,
				Cost = 7
			}
		]
	}
];

::Const.World.Spawn.Assassins.MaxR = 420;
::Const.World.Spawn.Assassins.Troops = [
	{
		Weight = 100,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Cost = 35
			}
		]
	}
];

