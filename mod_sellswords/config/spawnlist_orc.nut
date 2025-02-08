local gt = this.getroottable();

if (!("World" in gt.Const))
{
	gt.Const.World <- {};
}

if (!("Spawn" in gt.Const.World))
{
	gt.Const.World.Spawn <- {};
}

gt.Const.World.Spawn.OrcRoamers <- {
	Name = "OrcRoamers",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	MaxR = 260,
	MinR = 64,
	Body = "figure_orc_02",
	Troops = [
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
	]
};
gt.Const.World.Spawn.OrcScouts <- {
	Name = "OrcScouts",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_orc_01",
	MaxR = 320,
	MinR = 52,
	Troops = [
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
	]
};
gt.Const.World.Spawn.OrcRaiders <-
{
	Name = "OrcRaiders",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_orc_01",
	MaxR = 822,
	MinR = 72,
	Fixed = [
		{
			Weight = 100,
			MinR = 350,
			Type = this.Const.World.Spawn.Troops.crOrcPackleader,
			Cost = 40,			
		}
	],
	crFixed = [
		{
			Weight = 100,
			MinR = 550,
			Type = this.Const.World.Spawn.Troops.crOrcPackleader,
			Cost = 40
		}
	],	
	crrFixed = [
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
					function Weight( scale )
					{
						return 50;
					}
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendOrcElite,
					Cost = 40,
					function Weight( scale )
					{
						return 50;
					}
				}
			]			
		}
	],	
	Troops = [
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
	]
};
gt.Const.World.Spawn.OrcDefenders <-
{
	Name = "OrcDefenders",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_orc_01",
	MaxR = 720,
	MinR = 52,	
	Fixed = [
		{
			Weight = 100,
			MinR = 300,
			Type = this.Const.World.Spawn.Troops.crOrcPackleader,
			Cost = 40,			
		}
	],
	crFixed = [
		{
			Weight = 100,
			MinR = 500,
			Type = this.Const.World.Spawn.Troops.crOrcPackleader,
			Cost = 40
		}
	],	
	crrFixed = [
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
					function Weight( scale )
					{
						return 50;
					}
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendOrcElite,
					Cost = 40,
					function Weight( scale )
					{
						return 50;
					}
				}
			]			
		}
	],			
	Troops = [
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
	]
};
gt.Const.World.Spawn.OrcBoss <-
{
	Name = "OrcBoss",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_orc_01",
	MaxR = 850,
	MinR = 164,
	Fixed = [
		{
			Weight = 100
			Type = this.Const.World.Spawn.Troops.crOrcPackleader,
			Cost = 40
		}
	],
	crFixed = [
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
					function Weight( scale )
					{
						return 50;
					}
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendOrcElite,
					Cost = 40,
					function Weight( scale )
					{
						return 50;
					}
				}
			]			
		}
	],	
	crrFixed = [
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
					function Weight( scale )
					{
						return 100;
					}
				}
			]			
		}
	],		
	crrrFixed = [
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
					function Weight( scale )
					{
						return 100;
					}
				}
			]			
		}
	],		
	Troops = [
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
	]
};
gt.Const.World.Spawn.YoungOrcsOnly <- {
	Name = "YoungOrcsOnly",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_orc_01",
	MaxR = 350,
	MinR = 50,
	Troops = [
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
	]
};
gt.Const.World.Spawn.YoungOrcsAndBerserkers <- {
	Name = "YoungOrcsAndBerserkers",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_orc_01",
	MaxR = 450,
	MinR = 50,
	Troops = [
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
	]
};
gt.Const.World.Spawn.BerserkersOnly <- {
	Name = "BerserkersOnly",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_orc_01",
	MaxR = 500,
	MinR = 50,
	Troops = [
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
	]
};
