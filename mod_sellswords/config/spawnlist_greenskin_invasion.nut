::Const.World.Spawn.GreenskinHorde.MinR = 136;
::Const.World.Spawn.GreenskinHorde.MaxR = 1115;

::Const.World.Spawn.GreenskinHorde.Fixed <- [
	{
		MinR = 400,
		Weight = 100,
		Type = this.Const.World.Spawn.Troops.crOrcPackleader,
		Cost = 40
	}
];

::Const.World.Spawn.GreenskinHorde.crFixed <- [
	{
		Weight = 100,
		MinR = 500,
		Type = this.Const.World.Spawn.Troops.GoblinOverseer,
		Cost = 40
	}
];

::Const.World.Spawn.GreenskinHorde.crrFixed <- [
	{
		Weight = 100,
		MinR = 750,
		Type = this.Const.World.Spawn.Troops.crOrcPackleader,
		Cost = 40
	}
];

::Const.World.Spawn.GreenskinHorde.crrrFixed <- [
	{
		Weight = 100,
		MinR = 1000,
		Type = this.Const.World.Spawn.Troops.OrcWarlord,
		Cost = 60
	}
];

::Const.World.Spawn.GreenskinHorde.Troops = [
	{
		Weight = 15,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GoblinSkirmisherLOW,
				Cost = 15
			},
			{
				Type = this.Const.World.Spawn.Troops.GoblinSkirmisher,
				Cost = 22
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crGoblinwarrior,
				Cost = 30
			}
		]
	},
	{
		Weight = 20,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GoblinAmbusherLOW,
				Cost = 22
			},
			{
				Type = this.Const.World.Spawn.Troops.GoblinAmbusher,
				Cost = 30
			}
		]
	},
	{
		Weight = 5,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GoblinWolfrider,
				Cost = 50
			}
		]
	},
	{
		Weight = 2,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GoblinOverseer,
				Cost = 60
			}
		]
	},
	{
		Weight = 3,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.GoblinShaman,
				Cost = 60
			}
		]
	},
	{
		Weight = 20,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.OrcYoungLOW,
				Cost = 13
			},
			{
				Type = this.Const.World.Spawn.Troops.OrcYoung,
				Cost = 16
			}
		]
	},
	{
		Weight = 20,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.OrcWarriorLOW,
				Cost = 30
			},
			{
				Type = this.Const.World.Spawn.Troops.OrcWarrior,
				MinR = 0.15 * 1115,
				Cost = 40
			}
		]
	},
	{
		Weight = 10,
		MinR = 500,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crOrcGrunt,
				Cost = 22
			}
		]
	},
	{
		Weight = 5,
		MinR = 650,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crOrcVanguard,
				Cost = 45
			}
		]
	},
	{
		Weight = 5,
		MinR = 750,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.LegendOrcBehemoth,
				Cost = 60,
				Roll = true
			},
			{
				Type = this.Const.World.Spawn.Troops.LegendOrcElite,
				Cost = 60,
				Roll = true
			}
		]
	},
	{
		Weight = 5,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.OrcBerserker,
				Cost = 30
			}
		]
	}
];
