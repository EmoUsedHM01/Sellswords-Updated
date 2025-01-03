local gt = this.getroottable();

if (!("World" in gt.Const))
{
	gt.Const.World <- {};
}

if (!("Spawn" in gt.Const.World))
{
	gt.Const.World.Spawn <- {};
}

gt.Const.World.Spawn.BanditRoamers <- {
	Name = "BanditRoamers",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	Fixed = [],
	MaxR = 300,
	Troops = [
		{
			Weight = 50,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditRabble,
					MaxR = 80,
					Cost = 5
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditThug,
					MaxR = 160,
					Cost = 8
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditRaiderLOW,
					MinR = 80,
					Cost = 16
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditRaider,
					MinR = 160,
					Cost = 20
				},
				{
					MinR = 420,
					Type = this.Const.World.Spawn.Troops.BanditVeteran,
					Cost = 30
				}
			]
		},
		{
			Weight = 10,
			MinR = 225,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crSquireLow,
					Cost = 25,
					Roll = true
				}
			]
		},		
		{
			Weight = 15,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Wardog,
					Cost = 5
				}
			]
		},
		{
			Weight = 20,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditRabblePoacher,
					MaxR = 70,
					Cost = 8
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditMarksmanLOW,
					Cost = 12
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditMarksman,
					MinR = 300,
					Cost = 18
				}
			]
		},
		{
			Weight = 20,
			MinR = 0.4 * 385,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crPeasantbutcher,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantminstrel,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantWoodsman,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMiner,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantgravedigger,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantherbalist,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantblacksmith,
					MinR = 0.7 * 385,					
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantPoacher,
					MinR = 0.6 * 385,					
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantWitchHunter,
					MinR = 0.6 * 385,					
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantjuggler,
					MinR = 0.6 * 385,					
					Cost = 20
				},	
				{
					Type = this.Const.World.Spawn.Troops.crPeasantkiller,
					Cost = 20
				},				
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantFarmhand,
					Cost = 20
				}
			]
		},
		{
			Weight = 5,
			MinR = 0.5 * 385,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMonk,
					Cost = 20,
					Roll = true					
				}
			]
		}		
	]
};
gt.Const.World.Spawn.BanditScouts <- {
	Name = "BanditScouts",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	MaxR = 400,
	Fixed = [],
	Troops = [
		{
			Weight = 60,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditRabble,
					MaxR = 75,
					Cost = 5
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditThug,
					MaxR = 150,
					Cost = 8
				},
				{
					MinR = 80,
					Type = this.Const.World.Spawn.Troops.BanditRaiderLOW,
					Cost = 16
				},
				{
					MinR = 150,
					Type = this.Const.World.Spawn.Troops.BanditRaider,
					Cost = 20
				},
				{
					MinR = 420,
					Type = this.Const.World.Spawn.Troops.BanditVeteran,
					Cost = 30
				}
			]
		},
		{
			Weight = 10,
			MinR = 225,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crSquireLow,
					Cost = 25,
					Roll = true
				}
			]
		},		
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Wardog,
					Cost = 5
				}
			]
		},
		{
			Weight = 20,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditRabblePoacher,
					MaxR = 75,
					Cost = 8
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditMarksmanLOW,
					Cost = 8
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditMarksman,
					MinR = 280,
					Cost = 15
				},
				{
					MinR = 400,
					Type = this.Const.World.Spawn.Troops.MasterArcher,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 20,
			MinR = 150,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crPeasantbutcher,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantminstrel,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantWoodsman,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMiner,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantgravedigger,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantherbalist,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantblacksmith,
					MinR = 0.7 * 385,					
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantPoacher,
					MinR = 0.6 * 385,					
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantWitchHunter,
					MinR = 0.6 * 385,					
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantjuggler,
					MinR = 0.6 * 385,					
					Cost = 20
				},	
				{
					Type = this.Const.World.Spawn.Troops.crPeasantkiller,
					Cost = 20
				},					
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantFarmhand,
					Cost = 20
				}
			]
		},
		{
			Weight = 5,
			MinR = 0.5 * 385,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMonk,
					Cost = 20,
					Roll = true					
				}
			]
		}		
	]
};
gt.Const.World.Spawn.BanditRaiders <- {
	Name = "BanditRaiders",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	Fixed = [
		{
			Weight = 100,
			MinR = 180,
			Type = this.Const.World.Spawn.Troops.LegendPeasantMonk,
			Cost = 20
		}
	],
	crFixed = [
		{
			Weight = 100,
			MinR = 250,
			Type = this.Const.World.Spawn.Troops.BanditLeader,
			Cost = 40
		}
	],
	crrFixed = [
		{
			Weight = 100,
			MinR = 400,
			Type = this.Const.World.Spawn.Troops.HedgeKnight,
			Cost = 60,
			Roll = true
			MinGuards = 1,
			MaxGuards = 2,
			MaxGuardsWeight = 30,
			Guards = [
				{
					Type = this.Const.World.Spawn.Troops.crSquireLow,
					Cost = 15,
					function Weight( scale )
					{
						return 100;
					}

				}
			]
		}
	],
	MaxR = 600,
	Troops = [
		{
			Weight = 60,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditRabble,
					MaxR = 75,
					Cost = 9
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditThug,
					MaxR = 160,
					Cost = 8
				},
				{
					MinR = 80,
					Type = this.Const.World.Spawn.Troops.BanditRaiderLOW,
					Cost = 16
				},
				{
					MinR = 160,
					Type = this.Const.World.Spawn.Troops.BanditRaider,
					Cost = 20
				},
				{
					MinR = 420,
					Type = this.Const.World.Spawn.Troops.BanditVeteran,
					Cost = 30
				}
			]
		},
		{
			Weight = 10,
			MinR = 225,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crSquireLow,
					Cost = 25,
					Roll = true
				}
			]
		},		
		{
			Weight = 20,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditRabblePoacher,
					MaxR = 95,
					Cost = 10
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditMarksmanLOW,
					Cost = 11
				},
				{
					MinR = 300,
					Type = this.Const.World.Spawn.Troops.BanditMarksman,
					Cost = 18
				},
				{
					MinR = 500,
					Type = this.Const.World.Spawn.Troops.MasterArcher,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Wardog,
					Cost = 5
				}
			]
		},
		{
			Weight = 3,
			MinR = 250,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditLeader,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 1,
			MinR = 500,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.HedgeKnight,
					Cost = 60,
					Roll = true,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 30,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.crSquireLow,
							Cost = 15,
							function Weight( scale )
							{
								return 100;
							}

						}
					]					
				}				
			]
		},
		{
			Weight = 2,
			MinR = 500,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Swordmaster,
					Cost = 60,
					Roll = true
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
			Weight = 20,
			MinR = 175,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crPeasantbutcher,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantminstrel,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantWoodsman,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMiner,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantgravedigger,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantherbalist,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantblacksmith,
					MinR = 0.7 * 385,					
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantPoacher,
					MinR = 0.6 * 385,					
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantWitchHunter,
					MinR = 0.6 * 385,					
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantjuggler,
					MinR = 0.6 * 385,					
					Cost = 20
				},	
				{
					Type = this.Const.World.Spawn.Troops.crOutlander,
					MinR = 0.6 * 385,					
					Cost = 20
				},				
				{
					Type = this.Const.World.Spawn.Troops.crPeasantkiller,
					Cost = 20
				},					
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantFarmhand,
					Cost = 20
				}
			]
		},
		{
			Weight = 2,
			MinR = 0.5 * 385,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMonk,
					Cost = 20,
					Roll = true					
				}
			]
		}		
	]
};
gt.Const.World.Spawn.BanditDefenders <- {
	Name = "BanditDefenders",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	Fixed = [
		{
			Weight = 100,
			MinR = 180,
			Type = this.Const.World.Spawn.Troops.LegendPeasantMonk,
			Cost = 20
		}
	],
	crFixed = [
		{
			Weight = 100,
			MinR = 250,
			Type = this.Const.World.Spawn.Troops.BanditLeader,
			Cost = 40
		}
	],
	crrFixed = [
		{
			Weight = 100,
			MinR = 400,
			Type = this.Const.World.Spawn.Troops.HedgeKnight,
			Cost = 60,
			Roll = true
			MinGuards = 1,
			MaxGuards = 2,
			MaxGuardsWeight = 30,
			Guards = [
				{
					Type = this.Const.World.Spawn.Troops.crSquireLow,
					Cost = 15,
					function Weight( scale )
					{
						return 100;
					}

				}
			]
		}
	],
	MaxR = 600,
	Troops = [
		{
			Weight = 60,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditRabble,
					MaxR = 90,
					Cost = 5
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditThug,
					MaxR = 160,
					Cost = 8
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditRaiderLOW,
					Cost = 16
				},
				{
					MinR = 160,
					Type = this.Const.World.Spawn.Troops.BanditRaider,
					Cost = 20
				},
				{
					MinR = 420,
					Type = this.Const.World.Spawn.Troops.BanditVeteran,
					Cost = 30
				}
			]
		},
		{
			Weight = 10,
			MinR = 225,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crSquireLow,
					Cost = 25,
					Roll = true
				}
			]
		},		
		{
			Weight = 20,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditRabblePoacher,
					MaxR = 95,
					Cost = 12
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditMarksmanLOW,
					Cost = 12
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditMarksman,
					MinR = 350,
					Cost = 18
				},
				{
					MinR = 600,
					Type = this.Const.World.Spawn.Troops.MasterArcher,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Wardog,
					Cost = 5
				}
			]
		},
		{
			Weight = 4,
			MinR = 400,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditLeader,
					Cost = 25,
					Roll = true
				}
			]
		},
		{
			Weight = 15,
			MinR = 130,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crPeasantbutcher,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantminstrel,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantWoodsman,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMiner,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantgravedigger,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantherbalist,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantblacksmith,
					MinR = 0.7 * 385,					
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantPoacher,
					MinR = 0.6 * 385,					
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantWitchHunter,
					MinR = 0.6 * 385,					
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantjuggler,
					MinR = 0.6 * 385,					
					Cost = 20
				},	
				{
					Type = this.Const.World.Spawn.Troops.crOutlander,
					MinR = 0.6 * 385,					
					Cost = 20
				},					
				{
					Type = this.Const.World.Spawn.Troops.crPeasantkiller,
					Cost = 20
				},					
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantFarmhand,
					Cost = 20
				}
			]
		},
		{
			Weight = 2,
			MinR = 0.5 * 385,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMonk,
					Cost = 20,
					Roll = true					
				}
			]
		},		
		{
			Weight = 1,
			MinR = 500,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.HedgeKnight,
					Cost = 80,
					Roll = true,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 40,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.crSquireLow,
							Cost = 15,
							function Weight( scale )
							{
								return 100;
							}

						}
					]					
				},
				{
					Type = this.Const.World.Spawn.Troops.crHedgeKnight,
					Cost = 80,
					Roll = true,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 40,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.crSquireLow,
							Cost = 15,
							function Weight( scale )
							{
								return 100;
							}

						}
					]					
				}				
			]
		},
		{
			Weight = 2,
			MinR = 500,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Swordmaster,
					Cost = 40,
					Roll = true
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
	]
};
gt.Const.World.Spawn.BanditBoss <- {
	Name = "BanditBoss",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	Fixed = [
		{
			Type = this.Const.World.Spawn.Troops.BanditLeader,
			Weight = 1,
			Cost = 25,
			Roll = true
		},
		{
			MinR = 500,
			Weight = 1,
			Type = this.Const.World.Spawn.Troops.BanditWarlord,
			Cost = 100,
			Roll = true
		}
	],
	crFixed = [
		{
			Weight = 100,
			MinR = 180,
			Type = this.Const.World.Spawn.Troops.LegendPeasantMonk,
			Cost = 40
		}
	],
	crrFixed = [
		{
			Weight = 100,
			MinR = 400,
			Type = this.Const.World.Spawn.Troops.HedgeKnight,
			Cost = 60,
			Roll = true
			MinGuards = 1,
			MaxGuards = 2,
			MaxGuardsWeight = 30,
			Guards = [
				{
					Type = this.Const.World.Spawn.Troops.crSquireLow,
					Cost = 15,
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
			MinR = 550,
			Type = this.Const.World.Spawn.Troops.Swordmaster,
			Cost = 40
		}
	],	
	MinR = 145,
	MaxR = 720,
	Troops = [
		{
			Weight = 65,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditThug,
					MaxR = 160,					
					Cost = 8
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditRaiderLOW,
					Cost = 16
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditRaider,
					MinR = 160,
					Cost = 20
				},
				{
					MinR = 420,
					Type = this.Const.World.Spawn.Troops.BanditVeteran,
					Cost = 30
				}
			]
		},
		{
			Weight = 10,
			MinR = 225,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crSquireLow,
					Cost = 25,
					Roll = true
				}
			]
		},		
		{
			Weight = 20,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditMarksmanLOW,
					Cost = 8
				},
				{
					MinR = 350,
					Type = this.Const.World.Spawn.Troops.BanditMarksman,
					Cost = 15
				},
				{
					MinR = 600,
					Type = this.Const.World.Spawn.Troops.MasterArcher,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Wardog,
					Cost = 5
				}
			]
		},
		{
			Weight = 2,
			MinR = 0.4 * 385,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMonk,
					Cost = 20,
					Roll = true					
				}
			]
		},			
		{
			Weight = 1,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.HedgeKnight,
					Cost = 40,
					Roll = true,					
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 20,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.crSquireLow,
							Cost = 20,
							function Weight( scale )
							{
								return 100;
							}

						}
					]					
				}				
			]
		},
		{
			Weight = 1,
			Types = [
				{
					MinR = 500,
					Type = this.Const.World.Spawn.Troops.Swordmaster,
					Cost = 40,
					Roll = true
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
	]
};
gt.Const.World.Spawn.BanditArmy <- {
	Name = "BanditArmy",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	Fixed = [
		{
			Type = this.Const.World.Spawn.Troops.BanditWarlord,
			Weight = 100,
			Cost = 10
		}
	],
	crFixed = [
		{
			MinR = 300,
			Weight = 100,
			Type = this.Const.World.Spawn.Troops.BanditLeader,
			Cost = 10
		}
	],	
	crrFixed = [
		{
			Weight = 100,
			MinR = 400,
			Type = this.Const.World.Spawn.Troops.HedgeKnight,
			Cost = 60,
			Roll = true
			MinGuards = 1,
			MaxGuards = 2,
			MaxGuardsWeight = 30,
			Guards = [
				{
					Type = this.Const.World.Spawn.Troops.crSquireLow,
					Cost = 15,
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
			MinR = 750,
			Weight = 100,
			Type = this.Const.World.Spawn.Troops.BanditLeader,
			Cost = 10
		}
	],
	MinR = 145,
	MaxR = 600,
	Troops = [
		{
			Weight = 45,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditThug,
					Cost = 8
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditRaiderLOW,
					Cost = 16
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditRaider,
					MinR = 160,
					Cost = 20
				},
				{
					MinR = 420,
					Type = this.Const.World.Spawn.Troops.BanditVeteran,
					Cost = 30
				}
			]
		},
		{
			Weight = 10,
			MinR = 225,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crSquireLow,
					Cost = 25,
					Roll = true
				}
			]
		},			
		{
			Weight = 20,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditMarksmanLOW,
					Cost = 8
				},
				{
					MinR = 300,
					Type = this.Const.World.Spawn.Troops.BanditMarksman,
					Cost = 15
				},
				{
					MinR = 550,
					Type = this.Const.World.Spawn.Troops.MasterArcher,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 3,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Wardog,
					Cost = 5
				}
			]
		},
		{
			Weight = 4,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditLeader,
					Cost = 25,
					Roll = true
				},
				{
					Type = this.Const.World.Spawn.Troops.HedgeKnight,
					Cost = 50,
					Roll = true,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 30,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.crSquireLow,
							Cost = 15,
							function Weight( scale )
							{
								return 100;
							}

						}
					]					
				},
			]
		},
		{
			Weight = 4,
			Types = [
				{
					MinR = 550,
					Type = this.Const.World.Spawn.Troops.Swordmaster,
					Cost = 40,
					Roll = true
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
			Weight = 15,
			MinR = 130,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crPeasantbutcher,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantminstrel,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantWoodsman,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMiner,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantgravedigger,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantherbalist,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantblacksmith,
					MinR = 0.7 * 385,					
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantPoacher,
					MinR = 0.6 * 385,					
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantWitchHunter,
					MinR = 0.6 * 385,					
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantjuggler,
					MinR = 0.6 * 385,					
					Cost = 20
				},	
				{
					Type = this.Const.World.Spawn.Troops.crOutlander,
					MinR = 0.6 * 385,					
					Cost = 20
				},					
				{
					Type = this.Const.World.Spawn.Troops.crPeasantkiller,
					Cost = 20
				},					
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantFarmhand,
					Cost = 20
				}
			]
		}		
	]
};
gt.Const.World.Spawn.BanditsDisguisedAsDirewolves <- {
	Name = "BanditsDisguisedAsDireWolves",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_werewolf_01",
	Fixed = [
		{
			MinR = 180,		
			Weight = 100,
			Type = this.Const.World.Spawn.Troops.crBanditleaderwolf,
			Cost = 20
		}
	],
	MaxR = 475,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditRaiderWolf,
					Cost = 25
				}
			]
		}
	]
};
gt.Const.World.Spawn.BanditVermes <- {
	Name = "BanditsVermes",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_werewolf_01",
	Fixed = [],
	MaxR = 475,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditVermes,
					Cost = 7
				}
			]
		}
	]
};

