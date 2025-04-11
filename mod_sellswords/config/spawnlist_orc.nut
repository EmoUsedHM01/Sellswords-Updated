::Const.World.Spawn.OrcRoamers.MaxR = 260;
::Const.World.Spawn.OrcRoamers.MinR = 64;
::Const.World.Spawn.OrcRoamers.Troops = [
	{
		Weight = 80,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.OrcYoungLOW,
				MaxR = 1.0 * 360,
				Cost = 13
			},
			{
				Type = this.Const.World.Spawn.Troops.OrcYoung,
				MinR = 200,
				Cost = 16
			}
		]
	},
	{
		Weight = 15,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.OrcBerserker,
				MinR = 200,
				Cost = 35
			}
		]
	},
	{
		Weight = 5,
		MinR = 0.5 * 260,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.LegendOrcBehemoth,
				MinR = 400,
				Cost = 60,
				Roll = true
			}
		]
	}
];

::Const.World.Spawn.OrcScouts.MaxR = 320;
::Const.World.Spawn.OrcScouts.MinR = 52;
::Const.World.Spawn.OrcScouts.Troops = [
	{
		Weight = 65,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.OrcYoungLOW,
				MaxR = 1.0 * 176,
				Cost = 13
			},
			{
				Type = this.Const.World.Spawn.Troops.OrcYoung,
				MinR = 200,
				Cost = 16
			}
		]
	},
	{
		Weight = 15,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.OrcWarriorLOW,
				MaxR = 1.0 * 176,
				Cost = 30
			},
			{
				Type = this.Const.World.Spawn.Troops.OrcWarrior,
				MinR = 300,
				Cost = 40
			}
		]
	}
];

::Const.World.Spawn.OrcRaiders.MaxR = 822;
::Const.World.Spawn.OrcRaiders.MinR = 72;
::Const.World.Spawn.OrcRaiders.Fixed <- [
	{
		Weight = 100,
		MinR = 350,
		Type = this.Const.World.Spawn.Troops.crOrcPackleader,
		Cost = 40,
	}
];
::Const.World.Spawn.OrcRaiders.crFixed <- [
	{
		Weight = 100,
		MinR = 550,
		Type = this.Const.World.Spawn.Troops.crOrcPackleader,
		Cost = 40
	}
];
::Const.World.Spawn.OrcRaiders.crrFixed <- [
	{
		Weight = 100,
		MinR = 750,
		Type = this.Const.World.Spawn.Troops.crOrcPackleader,
		Cost = 40,
		MinGuards = 1,
		MaxGuards = 1,
		MaxGuardsWeight = 50,
		Guards = [
			{
				Type = this.Const.World.Spawn.Troops.LegendOrcBehemoth,
				Cost = 40,
				function Weight(scale) {
					return 50;
				}
			},
			{
				Type = this.Const.World.Spawn.Troops.LegendOrcElite,
				Cost = 40,
				function Weight(scale) {
					return 50;
				}
			}
		]
	}
];

::Const.World.Spawn.OrcRaiders.Troops = [
	{
		Weight = 42,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.OrcYoungLOW,
				MaxR = 0.75 * 822
				Cost = 13
			},
			{
				Type = this.Const.World.Spawn.Troops.OrcYoung,
				MinR = 200,
				Cost = 16
			}
		]
	},
	{
		Weight = 28,
		MinR = 0.2 * 822,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.OrcWarriorLOW,
				MaxR = 0.80 * 822,
				Cost = 30
			},
			{
				Type = this.Const.World.Spawn.Troops.OrcWarrior,
				MinR = 400,
				Cost = 40
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.OrcBerserker,
				MinR = 200,
				Cost = 30
			}
		]
	},
	{
		Weight = 5,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.LegendOrcBehemoth,
				MinR = 550,
				Cost = 60,
				Roll = true
			},
			{
				Type = this.Const.World.Spawn.Troops.crOrcWarlock,
				MinR = 550,
				Cost = 100,
				Roll = true
			},
			{
				Type = this.Const.World.Spawn.Troops.LegendOrcElite,
				MinR = 500,
				Cost = 60,
				Roll = true
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
		Weight = 10,
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
];


::Const.World.Spawn.OrcDefenders.MaxR = 720;
::Const.World.Spawn.OrcDefenders.MinR = 52;
::Const.World.Spawn.OrcDefenders.Fixed <- [
	{
		Weight = 100,
		MinR = 300,
		Type = this.Const.World.Spawn.Troops.crOrcPackleader,
		Cost = 40,
	}
];

::Const.World.Spawn.OrcDefenders.crFixed <- [
	{
		Weight = 100,
		MinR = 500,
		Type = this.Const.World.Spawn.Troops.crOrcPackleader,
		Cost = 40
	}
];

::Const.World.Spawn.OrcDefenders.crrFixed <- [
	{
		Weight = 100,
		MinR = 700,
		Type = this.Const.World.Spawn.Troops.OrcWarlord,
		Cost = 40,
		MinGuards = 1,
		MaxGuards = 1,
		MaxGuardsWeight = 50,
		Guards = [
			{
				Type = this.Const.World.Spawn.Troops.LegendOrcBehemoth,
				Cost = 40,
				function Weight(scale) {
					return 50;
				}
			},
			{
				Type = this.Const.World.Spawn.Troops.LegendOrcElite,
				Cost = 40,
				function Weight(scale) {
					return 50;
				}
			}
		]
	}
];

::Const.World.Spawn.OrcDefenders.Troops = [
	{
		Weight = 30,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.OrcYoungLOW,
				MaxR = 0.75 * 822
				Cost = 13
			},
			{
				Type = this.Const.World.Spawn.Troops.OrcYoung,
				MinR = 200,
				Cost = 16
			}
		]
	},
	{
		Weight = 12,
		MaxR = 600,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.OrcYoungLOW,
				MaxR = 0.75 * 822
				Cost = 13
			},
			{
				Type = this.Const.World.Spawn.Troops.OrcYoung,
				MinR = 200,
				Cost = 16
			}
		]
	},
	{
		Weight = 28,
		MinR = 0.2 * 822,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.OrcWarriorLOW,
				MaxR = 0.80 * 822,
				Cost = 30
			},
			{
				Type = this.Const.World.Spawn.Troops.OrcWarrior,
				MinR = 0.25 * 1115,
				Cost = 40
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.OrcBerserker,
				MinR = 200,
				Cost = 30
			}
		]
	},
	{
		Weight = 5,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.LegendOrcBehemoth,
				MinR = 550,
				Cost = 60,
				Roll = true
			},
			{
				Type = this.Const.World.Spawn.Troops.crOrcWarlock,
				MinR = 550,
				Cost = 100,
				Roll = true
			},
			{
				Type = this.Const.World.Spawn.Troops.LegendOrcElite,
				MinR = 500,
				Cost = 60,
				Roll = true
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
		Weight = 10,
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
];

::Const.World.Spawn.OrcBoss.MaxR = 850;
::Const.World.Spawn.OrcBoss.MinR = 164;
::Const.World.Spawn.OrcBoss.Fixed = [
	{
		Weight = 100
		Type = this.Const.World.Spawn.Troops.crOrcPackleader,
		Cost = 40
	}
];

::Const.World.Spawn.OrcBoss.crFixed <- [
	{
		Weight = 100,
		MinR = 400,
		Type = this.Const.World.Spawn.Troops.crOrcPackleader,
		Cost = 40,
		MinGuards = 1,
		MaxGuards = 1,
		MaxGuardsWeight = 50,
		Guards = [
			{
				Type = this.Const.World.Spawn.Troops.LegendOrcBehemoth,
				Cost = 40,
				function Weight(scale) {
					return 50;
				}
			},
			{
				Type = this.Const.World.Spawn.Troops.LegendOrcElite,
				Cost = 40,
				function Weight(scale) {
					return 50;
				}
			}
		]
	}
];

::Const.World.Spawn.OrcBoss.crrFixed <- [
	{
		Weight = 100,
		MinR = 600,
		Type = this.Const.World.Spawn.Troops.OrcWarlord,
		Cost = 40,
		MinGuards = 1,
		MaxGuards = 1,
		MaxGuardsWeight = 50,
		Guards = [
			{
				Type = this.Const.World.Spawn.Troops.crOrcPackleader,
				Cost = 40,
				function Weight(scale) {
					return 100;
				}
			}
		]
	}
];

::Const.World.Spawn.OrcBoss.crrrFixed <- [
	{
		Weight = 100,
		MinR = 800,
		Type = this.Const.World.Spawn.Troops.crOrcPackleader,
		Cost = 40,
		MinGuards = 1,
		MaxGuards = 1,
		MaxGuardsWeight = 50,
		Guards = [
			{
				Type = this.Const.World.Spawn.Troops.LegendOrcElite,
				Cost = 40,
				function Weight(scale) {
					return 100;
				}
			}
		]
	}
];

::Const.World.Spawn.OrcBoss.Troops = [
	{
		Weight = 30,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.OrcYoung,
				Cost = 16
			}
		]
	},
	{
		Weight = 15,
		MaxR = 500,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.OrcYoung,
				Cost = 16
			}
		]
	},
	{
		Weight = 30,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.OrcWarrior,
				MinR = 200,
				Cost = 40
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.OrcWarrior,
				MinR = 500,
				Cost = 40
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.OrcBerserker,
				Cost = 30
			}
		]
	},
	{
		Weight = 5,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.LegendOrcBehemoth,
				MinR = 550,
				Cost = 60,
				Roll = true
			},
			{
				Type = this.Const.World.Spawn.Troops.LegendOrcElite,
				MinR = 500,
				Cost = 60,
				Roll = true
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
		Weight = 10,
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
];

::Const.World.Spawn.YoungOrcsOnly.MaxR = 350;
::Const.World.Spawn.YoungOrcsOnly.MinR = 50;
::Const.World.Spawn.YoungOrcsOnly.Troops = [
	{
		Weight = 100,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.OrcYoungLOW,
				Cost = 13
			},
			{
				Type = this.Const.World.Spawn.Troops.OrcYoung,
				MinR = 200,
				Cost = 16
			}
		]
	}
];

::Const.World.Spawn.YoungOrcsAndBerserkers.MaxR = 450;
::Const.World.Spawn.YoungOrcsAndBerserkers.MinR = 50;
::Const.World.Spawn.YoungOrcsAndBerserkers.Troops = [
	{
		Weight = 70,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.OrcYoungLOW,
				MaxR = 400,
				Cost = 13
			},
			{
				Type = this.Const.World.Spawn.Troops.OrcYoung,
				MinR = 200,
				Cost = 16
			}
		]
	},
	{
		Weight = 20,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.OrcBerserker,
				MinR = 200,
				Cost = 30
			}
		]
	},
	{
		Weight = 20,
		MinR = 400,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.LegendOrcBehemoth,
				MinR = 300,
				Cost = 80,
				Roll = true
			}
		]
	},
	{
		Weight = 20,
		MinR = 500,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crOrcGrunt,
				Cost = 22
			}
		]
	},
	{
		Weight = 10,
		MinR = 650,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crOrcVanguard,
				Cost = 45
			}
		]
	},
];


::Const.World.Spawn.BerserkersOnly.MaxR = 500;
::Const.World.Spawn.BerserkersOnly.MinR = 50;
::Const.World.Spawn.BerserkersOnly.Troops = [
	{
		Weight = 20,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.OrcYoungLOW,
				MaxR = 1.0 * 288,
				Cost = 13
			},
			{
				Type = this.Const.World.Spawn.Troops.OrcYoung,
				MinR = 200,
				Cost = 16
			}
		]
	},
	{
		Weight = 70,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.OrcBerserker,
				Cost = 30
			}
		]
	},
	{
		Weight = 10,
		MinR = 1.0 * 288,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.LegendOrcBehemoth,
				MinR = 300,
				Cost = 80,
				Roll = true
			}
		]
	},
	{
		Weight = 10,
		MinR = 650,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crOrcVanguard,
				Cost = 45
			}
		]
	}
];
