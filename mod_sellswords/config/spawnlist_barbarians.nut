::Const.World.Spawn.Barbarians.MinR = 48;
::Const.World.Spawn.Barbarians.MaxR = 880;
::Const.World.Spawn.Barbarians.Fixed = [
	{
		MinR = 300,
		MinCount = 1,
		MaxCount = 2,
		Weight = 70,
		Type = this.Const.World.Spawn.Troops.BarbarianDrummer,
		Cost = 20
	}
];
::Const.World.Spawn.Barbarians.crFixed <- [
	{
		MinR = 650,
		Weight = 100,
		Type = this.Const.World.Spawn.Troops.crBarbarianKing,
		Cost = 40
	}
];
::Const.World.Spawn.Barbarians.Troops = [
	{
		Weight = 50,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.BarbarianThrall,
				Cost = 15
			},
			{
				MinR = 200,
				Type = this.Const.World.Spawn.Troops.BarbarianMarauder,
				Cost = 22
			},
			{
				MinR = 400,
				Type = this.Const.World.Spawn.Troops.BarbarianChampion,
				Cost = 35
			},
			{
				MinR = 550,
				Type = this.Const.World.Spawn.Troops.crImmortal,
				Cost = 45
			}
		]
	},
	{
		Weight = 10,
		MaxR = 150,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.BarbarianMarauder,
				Cost = 22
			}
		]
	},
	{
		Weight = 10,
		MinR = 300,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.BarbarianChampion,
				Cost = 35
			}
		]
	},
	{
		Weight = 5,
		MinR = 280,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crBarbblacksmith,
				Cost = 25,
				Roll = true
			}
		]
	},
	{
		Weight = 15,
		Types = [
			{
				MinR = 250,
				Type = this.Const.World.Spawn.Troops.crBarbarianZerker_High,
				Cost = 25
			},
			{
				MinR = 500,
				Type = this.Const.World.Spawn.Troops.crBarbarianZerker_Low,
				Cost = 40
			}
		]
	},
	{
		Weight = 1,
		MinR = 400,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crSlayer,
				Cost = 50,
				Roll = true
			}
		]
	},
	{
		Weight = 7,
		Types = [
			{
				MaxR = 350,
				Type = this.Const.World.Spawn.Troops.Warhound,
				Cost = 10
			},
			{
				MinR = 250,
				Type = this.Const.World.Spawn.Troops.Direwolf,
				Cost = 20
			},
			{
				MinR = 600,
				Type = this.Const.World.Spawn.Troops.LegendBear,
				Cost = 40
			}
		]
	},
	{
		Weight = 10,
		MinR = 650,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.BarbarianBeastmaster,
				Cost = 15,
				MinGuards = 1,
				MaxGuards = 2,
				MaxGuardsWeight = 50,
				Guards = [
					{
						Type = this.Const.World.Spawn.Troops.BarbarianUnhold,
						Cost = 50,
						function Weight( scale )
						{
							local c = 100 - scale * 100;
							return this.Math.max(20, c);
						}

					},
					{
						Type = this.Const.World.Spawn.Troops.BarbarianUnholdFrost,
						Cost = 70,
						function Weight( scale )
						{
							local c = 100 - (1.0 - scale) * 100;
							return this.Math.min(80, c);
						}

					}
				]
			}
		]
	},
	{
		Weight = 5,
		MinR = 600,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crBarbarianChampionhigh,
				Cost = 60
			}
		]
	}
];

::Const.World.Spawn.BarbarianHunters.MinR = 56;
::Const.World.Spawn.BarbarianHunters.MaxR = 300;
::Const.World.Spawn.BarbarianHunters.Fixed = [
	{
		MinR = 100,
		MinCount = 1,
		MaxCount = 3,
		Weight = 70,
		Type = this.Const.World.Spawn.Troops.BarbarianMarauder,
		Cost = 20
	}
];

::Const.World.Spawn.BarbarianHunters.Troops = [
	{
		Weight = 66,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.BarbarianThrall,
				Cost = 12
			}
		]
	},
	{
		Weight = 22,
		MinR = 250,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.BarbarianMarauder,
				Cost = 22
			}
		]
	},
	{
		Weight = 34,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Warhound,
				Cost = 10
			}
		]
	}
];
