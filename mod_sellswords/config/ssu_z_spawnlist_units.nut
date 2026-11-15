if (!("World" in ::Const))
{
	::Const.World <- {};
}

if (!("Spawn" in ::Const.World))
{
	::Const.World.Spawn <- {};
}

::Const.World.Spawn.SsuCaravanwithSellswords <- {
	Name = "SsuCaravanwithSellswords",
	IsDynamic = true,
	MovementSpeedMult = 0.5,
	VisibilityMult = 1.0,
	VisionMult = 0.25,
	Body = "cart_02",
	MaxR = 480,
	MinR = 120,
	Fixed = [
		{
			MinCount = 3,
			MaxCount = 5,
			Weight = 80,
			Type = this.Const.World.Spawn.Troops.CaravanDonkey,
			Cost = 0
		}
	],
	Troops = [
		{
			Weight = 75,
			Types = [
				{
					MaxR = 120,				
					Type = this.Const.World.Spawn.Troops.CaravanHand,
					Cost = 10
				},
				{
					MaxR = 180,				
					Type = this.Const.World.Spawn.Troops.CaravanGuard,
					Cost = 15
				},			
				{
					MaxR = 400,				
					Type = this.Const.World.Spawn.Troops.SsuMercenary,
					Cost = 25
				}				
			]
		},
		{
			Weight = 20,
			MaxR = 220,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuRetiredsoldier,
					Cost = 20,
				}				
			]
		},	
		{
			Weight = 20,
			MaxR = 220,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuRetiredsoldierpol,
					Cost = 20,
				}				
			]
		},			
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Wardog,
					Cost = 8
				}
			]
		},
		{
			Weight = 30,
			MinR = 400,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuSellsword,
					Cost = 40
				}				
			]
		},
		{
			Weight = 15,
			MinR = 400,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuSellswordPolearm,
					Cost = 40
				}				
			]
		},	
		{
			Weight = 10,
			MinR = 400,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuSellswordTank,
					Cost = 40
				}				
			]
		},
		{
			Weight = 15,
			Types = [
				{				
					Type = this.Const.World.Spawn.Troops.MercenaryRanged,
					MaxR = 450,						
					Cost = 35
				},
				{				
					Type = this.Const.World.Spawn.Troops.SsuSellswordRanger,
					MinR = 400,						
					Cost = 50
				},					
				{
					Type = this.Const.World.Spawn.Troops.MasterArcher,
					Cost = 40
				}
			]
		},	
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.HedgeKnight,
					Cost = 60,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 20,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.SsuSquireLow,
							Cost = 20,
							function Weight( scale )
							{
								return 100;
							}
						}
					]					
				},			
				{
					Type = this.Const.World.Spawn.Troops.Swordmaster,
					Cost = 40
				}
			]
		}		
	]
};
::Const.World.Spawn.SsuNoblewithbaron <- {
	Name = "SsuNoblewithbaron",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_player_legends_noble",
	MinR = 225,
	MaxR = 800,
	Fixed = [
		{
			Weight = 100,
			Type = this.Const.World.Spawn.Troops.SsuBaron,
			Cost = 10,
			MinGuards = 3,
			MaxGuards = 3,
			MaxGuardsWeight = 50,
			Guards = [
				{
					Type = this.Const.World.Spawn.Troops.StandardBearer,
					Cost = 0,
					function Weight( scale )
					{
						return 100;
					}

				}
			]			
		}
	],
	SsuFixed = [
		{
			Weight = 100,
			MinR = 250,			
			Type = this.Const.World.Spawn.Troops.Sergeant,
			Cost = 40,
			MinGuards = 1,
			MaxGuards = 2,
			MaxGuardsWeight = 50,
			Guards = [
				{
					Type = this.Const.World.Spawn.Troops.LegendHalberdier,
					Cost = 20,
					function Weight( scale )
					{
						return 100;
					}

				}
			]			
		}
	],
	SsuFixed2 = [
		{
			Weight = 100,
			MinR = 500,			
			Type = this.Const.World.Spawn.Troops.Sergeant,
			Cost = 40,
			MinGuards = 1,
			MaxGuards = 1,
			MaxGuardsWeight = 50,
			Guards = [
				{
					Type = this.Const.World.Spawn.Troops.StandardBearer,
					Cost = 20,
					function Weight( scale )
					{
						return 100;
					}

				}
			]			
		}
	],	
	SsuFixed3 = [
		{
			Weight = 100,
			MinR = 700,			
			Type = this.Const.World.Spawn.Troops.Sergeant,
			Cost = 40,
			MinGuards = 1,
			MaxGuards = 2,
			MaxGuardsWeight = 50,
			Guards = [
				{
					Type = this.Const.World.Spawn.Troops.LegendHalberdier,
					Cost = 20,
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
			Weight = 25,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendHalberdier,
					Cost = 40
				}
			]
		},
		{
			Weight = 60,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuKnight,
					Cost = 60,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 50,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.SsuSquire,
							Cost = 30,
							function Weight( scale )
							{
								local c = 100 - scale * 100;
								return this.Math.max(60, c);
							}

						},
						{
							Type = this.Const.World.Spawn.Troops.SsuSquireFencer,
							Cost = 30,
							function Weight( scale )
							{
								local c = 100 - (1.0 - scale) * 100;
								return this.Math.min(40, c);
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
					Type = this.Const.World.Spawn.Troops.SsuHonoraryknight,
					Cost = 60,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 50,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.SsuSquire,
							Cost = 30,
							function Weight( scale )
							{
								local c = 100 - scale * 100;
								return this.Math.max(20, c);
							}

						},
						{
							Type = this.Const.World.Spawn.Troops.SsuSquireFencer,
							Cost = 30,
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
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.ArmoredWardog,
					Cost = 5
				}
			]
		}	
	]
};
::Const.World.Spawn.SsuNobleCaravanwithSellswords <- {
	Name = "SsuNobleCaravanwithSellswords",
	IsDynamic = true,
	MovementSpeedMult = 0.5,
	VisibilityMult = 1.0,
	VisionMult = 0.25,
	Body = "cart_01",
	MinR = 110,
	MaxR = 480,
	Fixed = [
		{
			MinCount = 3,
			MaxCount = 5,
			Weight = 80,
			Type = this.Const.World.Spawn.Troops.CaravanDonkey,
			Cost = 0
		}
	],
	Troops = [
		{
			Weight = 50,
			Types = [				
				{
					Type = this.Const.World.Spawn.Troops.Footman,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.SsuMercenary,
					MaxR = 0.8 * 365					
					Cost = 20
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
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Billman,
					Cost = 10
				}
			]
		},
		{
			Weight = 8,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Arbalester,
					Cost = 10
				}
			]
		},
		{
			Weight = 20,
			MinR = 400,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuSellsword,
					Cost = 40
				}				
			]
		},
		{
			Weight = 10,
			MinR = 400,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuSellswordPolearm,
					Cost = 40
				}				
			]
		},	
		{
			Weight = 7,
			MinR = 400,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuSellswordTank,
					Cost = 40
				}				
			]
		},
		{
			Weight = 10,
			Types = [
				{				
					Type = this.Const.World.Spawn.Troops.MercenaryRanged,
					MaxR = 400,						
					Cost = 30
				},
				{				
					Type = this.Const.World.Spawn.Troops.SsuSellswordRanger,
					MinR = 450,						
					Cost = 60
				},				
				{
					Type = this.Const.World.Spawn.Troops.MasterArcher,
					Cost = 40
				}
			]
		},	
		{
			Weight = 3,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.HedgeKnight,
					Cost = 30,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 20,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.SsuSquireLow,
							Cost = 15,
							function Weight( scale )
							{
								return 100;
							}

						}
					]					
				},
				{
					Type = this.Const.World.Spawn.Troops.Swordmaster,
					Cost = 30
				}
			]
		},
		{
			Weight = 10,
			MinR = 0.5 * 365,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Sergeant,
					Cost = 30,
					Roll = true
				}
			]
		},
		{
			Weight = 4,
			MinR = 0.8 * 365,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Knight,
					Cost = 40,
					Roll = true
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 50,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.SsuSquire,
							Cost = 25,
							function Weight( scale )
							{
								return 100;
							}

						}
					]
				}
			]
		}			
	]
};
::Const.World.Spawn.SsuCaravanSouthernwithSellswords <- {
	Name = "SsuCaravanSouthernwithSellswords",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "cart_03",
	MaxR = 650,
	Fixed = [
		{
			MinCount = 3,
			MaxCount = 5,
			Weight = 80,
			Type = this.Const.World.Spawn.Troops.SouthernDonkey,
			Cost = 0
		}
	],
	Troops = [
		{
			Weight = 50,
			Types = [			
				{
					Type = this.Const.World.Spawn.Troops.Conscript,
					Cost = 20
				}				
			]
		},	
		{
			Weight = 3,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Slave,
					Cost = 5
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
					Cost = 25
				}
			]
		},
		{
			Weight = 8,
			Types = [
				{
					MinR = 0.3 * 560,					
					Type = this.Const.World.Spawn.Troops.Gunner,
					Cost = 20
				}
			]
		},
		{
			Weight = 20,
			MinR = 420,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuSellsword,
					Cost = 40
				}				
			]
		},
		{
			Weight = 10,
			MinR = 420,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuSellswordPolearm,
					Cost = 40
				}			
			]
		},	
		{
			Weight = 7,
			MinR = 420,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuSellswordTank,
					Cost = 40
				}				
			]
		},
		{
			Weight = 10,
			Types = [
				{				
					Type = this.Const.World.Spawn.Troops.MercenaryRanged,
					MaxR = 400,						
					Cost = 30
				},
				{				
					Type = this.Const.World.Spawn.Troops.SsuSellswordRanger,
					MinR = 480,						
					Cost = 50
				}				
			]
		},			
		{
			Weight = 10,
			MinR = 0.5 * 560,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Officer,
					Cost = 30,
				}
			]
		},
		{
			Weight = 4,
			MinR = 0.7 * 560,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Assassin,
					Cost = 30,
					Roll = true
				}
			]
		}	
	]
};
::Const.World.Spawn.SsuDesperados <- {
	Name = "SsuDesperados",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_player_03",
	Fixed = [
		{
			MinR = 240,
			MinCount = 1,
			MaxCount = 3,
			Weight = 50,
			Type = this.Const.World.Spawn.Troops.LegendPeasantMonk,
			Cost = 5
		}
	],
	SsuFixed = [
		{
			MinR = 480,
			MinCount = 1,
			MaxCount = 3,
			Weight = 50,
			Type = this.Const.World.Spawn.Troops.SsuPeasantminstrel,
			Cost = 5
		}
	],	
	MinR = 145,
	MaxR = 600,
	Troops = [
		{
			Weight = 50,
			MaxR = 225,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuDesperadoWeak,
					Cost = 18
				}
			]
		},
		{
			Weight = 50,
			MaxR = 400,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuDesperadoLow,
					Cost = 30
				}
			]
		},		
		{
			Weight = 50,
			MinR = 360,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuDesperado,
					Cost = 50
				}
			]
		},
		{
			Weight = 5,
			MinR = 600,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuDesperadoHigh,
					Cost = 80
				}
			]
		},
		{
			Weight = 3,
			MinR = 600,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuDesperadoHigh,
					Cost = 80,
					Roll = true
					MinGuards = 1,
					MaxGuards = 1,
					MaxGuardsWeight = 100,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.LegendPeasantMonk,
							Cost = 10,
							function Weight( scale )
							{
								return 100;
							}

						}
					]
				}
			]
		}		
	]
};
::Const.World.Spawn.SsuHashshashins <- {
	Name = "SsuHashshashins",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_player_legends_assassin",
	Fixed = [],
	MaxR = 600,
	Troops = [
		{
			Weight = 50,
			MaxR = 360,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuHashshashinLow,
					Cost = 25
				}
			]
		},
		{
			Weight = 50,
			MinR = 300,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuHashshashin,
					Cost = 40
				}
			]
		},		
		{
			Weight = 8,
			MinR = 500,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuHashshashinHigh,
					Cost = 75
				}
			]
		}		
	]
};

::Const.World.Spawn.SsuBabarianBerserkers <- {
	Name = "SsuBabarianBerserkers",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_wildman_02",
	Fixed = [],
	MaxR = 520,
	Troops = [
		{
			Weight = 100,
			Types = [
				{	
					MinR = 400,					
					Type = this.Const.World.Spawn.Troops.SsuBarbarianZerkerLow,
					Cost = 45
				},
				{
					MaxR = 550,					
					Type = this.Const.World.Spawn.Troops.SsuBarbarianZerkerHigh,
					Cost = 30
				}				
			]
		},

	]
};

::Const.World.Spawn.SsuBarbhunters <- {
	Name = "SsuBarbhunters",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	MaxR = 425,
	MinR = 80,
	Body = "figure_player_05",
	Troops = [
		{
			Weight = 30,
			MaxR = 275,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuBarbhunter,
					Cost = 25,
					MinGuards = 1,
					MaxGuards = 3,
					MaxGuardsWeight = 40,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.Warhound,
							Cost = 8,
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
			Weight = 60,
			MinR = 200,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuBarbhunter,
					Cost = 25,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 40,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.Direwolf,
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
			Weight = 30,
			MinR = 400,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuBarbhunter,
					Cost = 25,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 20,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.LegendBear,
							Cost = 40,
							function Weight( scale )
							{
								return 100;
							}
						}
					]					
				},				
			]
		},		
	]
};

::Const.World.Spawn.SsuBabarianChosens <- {
	Name = "SsuBabarianChosens",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_wildman_03",
	Fixed = [
		{
			MinCount = 1,
			MaxCount = 2,
			Weight = 70,
			Type = this.Const.World.Spawn.Troops.BarbarianDrummer,
			Cost = 20
		}
	],
	SsuFixed = [
		{
			MinR = 600,
			Weight = 100,
			Type = this.Const.World.Spawn.Troops.SsuBarbarianKing,
			Cost = 40
		}
	],	
	MaxR = 800,
	MinR = 180,
	Troops = [
		{
			Weight = 80,
			Types = [
				{					
					Type = this.Const.World.Spawn.Troops.BarbarianChampion,
					Cost = 35
				},
				{
					MinR = 450,
					Type = this.Const.World.Spawn.Troops.SsuImmortal,
					Cost = 45
				}					
			]
		},
		{
			Weight = 10,
			MinR = 560,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuBarbarianChampionhigh,
					Cost = 60
				}
			]
		},
		{
			Weight = 10,
			MinR = 450,
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
		}		
	]
};

::Const.World.Spawn.SsuBabarianChosenswithKing <- {
	Name = "SsuBabarianChosenswithKing",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_wildman_03",
	Fixed = [
		{
			MinCount = 1,
			MaxCount = 2,
			Weight = 70,
			Type = this.Const.World.Spawn.Troops.BarbarianDrummer,
			Cost = 20
		}
	],
	SsuFixed = [
		{
			MinR = 250,
			Weight = 100,
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
		}
	],	
	SsuFixed2 = [
		{
			MinR = 500,
			Weight = 100,
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
		}
	],	
	MaxR = 900,
	MinR = 180,
	Troops = [
		{
			Weight = 85,
			Types = [
				{					
					Type = this.Const.World.Spawn.Troops.BarbarianChampion,
					Cost = 35
				},
				{
					MinR = 450,
					Type = this.Const.World.Spawn.Troops.SsuImmortal,
					Cost = 45
				}					
			]
		},
		{
			Weight = 10,
			MinR = 560,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuBarbarianChampionhigh,
					Cost = 60
				}
			]
		},
		{
			Weight = 5,
			MinR = 450,
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
		}		
	]
};

::Const.World.Spawn.Ssucrthieves <- {
	Name = "Ssucrthieves",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	Fixed = [
		{
			Weight = 100,
			MinR = 200,
			Type = this.Const.World.Spawn.Troops.LegendPeasantMonk,
			Cost = 20
		}
	],
	SsuFixed = [
		{
			Weight = 100,
			MinR = 280,
			Type = this.Const.World.Spawn.Troops.BanditLeader,
			Cost = 40
		}
	],
	SsuFixed2 = [
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
					Type = this.Const.World.Spawn.Troops.SsuSquireLow,
					Cost = 15,
					function Weight( scale )
					{
						return 100;
					}

				}
			]
		}
	],	
	MaxR = 400,
	Troops = [
		{
			Weight = 60,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditRabble,
					MaxR = 80,
					Cost = 9
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditThug,
					MaxR = 160,
					Cost = 12
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
					Type = this.Const.World.Spawn.Troops.BanditMarauder,
					Cost = 30
				}
			]
		},
		{
			Weight = 60,
			MaxR = 120,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditRabble,
					Cost = 8,
				}
			]
		},			
		{
			Weight = 10,
			MinR = 225,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuSquireLow,
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
					Cost = 11
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
			Weight = 2,
			MinR = 250,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditLeader,
					Cost = 60,
					Roll = true
				}
			]
		},		
		{
			Weight = 20,
			MinR = 175,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuPeasantbutcher,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.SsuPeasantminstrel,
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
					Type = this.Const.World.Spawn.Troops.SsuPeasantgravedigger,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.SsuPeasantherbalist,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.SsuPeasantblacksmith,
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
					Type = this.Const.World.Spawn.Troops.SsuPeasantjuggler,
					MinR = 0.6 * 385,					
					Cost = 20
				},	
				{
					Type = this.Const.World.Spawn.Troops.SsuPeasantkiller,
					Cost = 20
				},					
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantFarmhand,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.SsuOutlander,
					MinR = 0.6 * 385,					
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

::Const.World.Spawn.SsuRomaLegion <- {
	Name = "SsuRomaLegion",
	IsDynamic = true,
	MovementSpeedMult = 0.9,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_skeleton_01",
	MaxR = 900,
	MinR = 52,
	Troops = [
		{
			Weight = 50,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SkeletonMedium,
					MaxR = 500,					
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.SkeletonHeavy,
					MinR = 250,
					Cost = 35
				},
				{
					Type = this.Const.World.Spawn.Troops.SsuSkeleton,
					MinR = 500,
					Cost = 60
				}				
			]
		},
		{
			Weight = 35,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SkeletonMediumPolearm,
					MaxR = 500,					
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.SkeletonHeavyPolearm,
					MinR = 200,
					Cost = 35
				},
				{
					Type = this.Const.World.Spawn.Troops.SkeletonGladiator,
					MinR = 350,
					Cost = 40
				},
				{
					Type = this.Const.World.Spawn.Troops.SsuSkeletonPol,
					MinR = 500,
					Cost = 60
				}				
			]
		},
		{
			Weight = 3,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SkeletonPriest,
					Cost = 40,
					Roll = true,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 33,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.SkeletonHeavyBodyguard,
							Cost = 30,
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
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.VampireLOW,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.Vampire,
					MinR = 450,
					Cost = 50
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendVampireLord,
					MinR = 650,
					Cost = 70,
					Roll = true
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendDemonHound,
					Cost = 40
				}
			]
		}
	]
};

::Const.World.Spawn.SsuBanditMilitary <- {
	Name = "SsuBanditMilitary",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_player_02",
	Fixed = [
		{
			Type = this.Const.World.Spawn.Troops.BanditLeader,
			Weight = 1,
			Cost = 25,
			Roll = true
		}
	],
	SsuFixed = [
		{
			Weight = 100,
			MinR = 250,
			Type = this.Const.World.Spawn.Troops.SsuBanditSergeant,
			Cost = 40
		}
	],
	SsuFixed2 = [
		{
			Weight = 100,
			MinR = 400,
			Type = this.Const.World.Spawn.Troops.SsuBanditSergeant,
			Cost = 40
		}
	],
	SsuFixed3 = [
		{
			Weight = 100,
			MinR = 650,
			Type = this.Const.World.Spawn.Troops.SsuBanditSergeant,
			Cost = 40
		}
	],	
	MinR = 145,
	MaxR = 720,
	Troops = [
		{
			Weight = 20,
			Types = [
				{
					MinR = 160,
					Type = this.Const.World.Spawn.Troops.BanditRaider,
					Cost = 20
				},
				{
					MinR = 420,
					Type = this.Const.World.Spawn.Troops.BanditMarauder,
					Cost = 30
				}
			]
		},
		{
			Weight = 30,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuBanditFootman,
					Cost = 20
				}
			]
		},	
		{
			Weight = 15,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuBanditBillman,
					Cost = 20
				}
			]
		},		
		{
			Weight = 10,
			Types = [
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
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuBanditArbalester,
					Cost = 20,
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
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuBanditZweihander,
					Cost = 25,
				}
			]
		},
		{
			Weight = 5,
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
							Type = this.Const.World.Spawn.Troops.SsuSquireLow,
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
			Weight = 20,
			MinR = 175,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuPeasantbutcher,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.SsuPeasantminstrel,
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
					Type = this.Const.World.Spawn.Troops.SsuPeasantgravedigger,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.SsuPeasantherbalist,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.SsuPeasantblacksmith,
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
					Type = this.Const.World.Spawn.Troops.SsuPeasantjuggler,
					MinR = 0.6 * 385,					
					Cost = 20
				},	
				{
					Type = this.Const.World.Spawn.Troops.SsuOutlander,
					MinR = 0.6 * 385,					
					Cost = 20
				},				
				{
					Type = this.Const.World.Spawn.Troops.SsuPeasantkiller,
					Cost = 20
				},					
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantFarmhand,
					Cost = 20
				}
			]
		},
		{
			Weight = 3,
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

::Const.World.Spawn.SsuBarbarianMilitary <- {
	Name = "SsuBarbarianMilitary",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_player_05",
	MinR = 48,
	MaxR = 880,
	Fixed = [
		{
			MinR = 300,
			MinCount = 1,
			MaxCount = 2,
			Weight = 70,
			Type = this.Const.World.Spawn.Troops.BarbarianDrummer,
			Cost = 20
		}
	],	
	SsuFixed = [
		{
			Weight = 100,
			MinR = 250,
			Type = this.Const.World.Spawn.Troops.SsuBarbarianSergeant,
			Cost = 40
		}
	],
	SsuFixed2 = [
		{
			Weight = 100,
			MinR = 500,
			MinCount = 1,
			MaxCount = 2,			
			Type = this.Const.World.Spawn.Troops.SsuBarbarianSergeant,
			Cost = 40
		}
	],
	SsuFixed3 = [
		{
			MinR = 650,
			Weight = 100,
			Type = this.Const.World.Spawn.Troops.SsuBarbarianKing,
			Cost = 40
		}
	],	
	Troops = [
		{
			Weight = 20,
			Types = [
				{
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
					Type = this.Const.World.Spawn.Troops.SsuImmortal,
					Cost = 45
				}				
			]
		},
		{
			Weight = 30,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuBarbarianFootman,
					Cost = 20,
				}
			]
		},
		{
			Weight = 15,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuBarbarianBillman,
					Cost = 20,
				}
			]
		},			
		{
			Weight = 5,
			MinR = 280,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuBarbblacksmith,
					Cost = 25,
					Roll = true
				}
			]
		},	
		{
			Weight = 1,
			MinR = 400,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuSlayer,
					Cost = 50,
					Roll = true
				}
			]
		},		
		{
			Weight = 10,
			Types = [
				{
					MinR = 250,
					Type = this.Const.World.Spawn.Troops.SsuBarbarianZerkerHigh,
					Cost = 25
				},				
				{
					MinR = 500,
					Type = this.Const.World.Spawn.Troops.SsuBarbarianZerkerLow,
					Cost = 40
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuBarbarianArbalester,
					Cost = 20,
				}
			]
		},		
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuBarbarianZweihander,
					Cost = 25,
				}
			]
		},		
		{
			Weight = 6,
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
					Type = this.Const.World.Spawn.Troops.SsuBarbarianChampionhigh,
					Cost = 60
				}
			]
		}		
	]
};
::Const.World.Spawn.SsuNomadMilitary <- {
	Name = "SsuNomadMilitary",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_player_14",
	Fixed = [
		{
			Weight = 100,
			Type = this.Const.World.Spawn.Troops.NomadLeader,
			Cost = 40
		}
	],
	SsuFixed = [
		{
			Weight = 100,
			MinR = 250,
			Type = this.Const.World.Spawn.Troops.SsuNomadSergeant,
			Cost = 40
		}
	],
	SsuFixed2 = [
		{
			Weight = 100,
			MinR = 450,
			Type = this.Const.World.Spawn.Troops.SsuNomadSergeant,
			Cost = 40
		}
	],
	SsuFixed3 = [
		{
			Weight = 100,
			MinR = 650,
			Type = this.Const.World.Spawn.Troops.SsuNomadSergeant,
			Cost = 40
		}
	],	
	MaxR = 600,
	Troops = [
		{
			Weight = 20,
			Types = [
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
			Weight = 30,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuNomadFootman,
					Cost = 20,
				}
			]
		},	
		{
			Weight = 15,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuNomadBillman,
					Cost = 20,
				}
			]
		},		
		{
			Weight = 15,
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
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuNomadArbalester,
					Cost = 20,
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuNomadZweihander,
					Cost = 30,
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
			Weight = 4,
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
			MinR = 450,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.DesertDevil,
					Cost = 65,
					Roll = true
				}
			]
		}
	]
};

::Const.World.Spawn.SsuZombieMilitary <- {
	Name = "SsuZombieMilitary",
	IsDynamic = true,
	MovementSpeedMult = 0.8,
	VisibilityMult = 1.0,
	VisionMult = 0.8,
	Body = "figure_zombie_01",
	MaxR = 706,
	MinR = 102,
	Fixed = [
		{
			MinCount = 1,
			MaxCount = 1,
			Weight = 100,
			Type = this.Const.World.Spawn.Troops.SsuNecromancer,
			Cost = 10			
		}
	],
	SsuFixed = [
		{
			Type = this.Const.World.Spawn.Troops.Necromancer,
			Cost = 30,
			MinGuards = 1,
			MaxGuards = 2,
			MaxGuardsWeight = 25,
			MinR = 300,
			Weight = 100,
			Guards = [
				{
					Type = this.Const.World.Spawn.Troops.ZombieBodyguard,
					MaxR = 125,
					Cost = 6,
					function Weight( scale )
					{
						local c = 100 - scale * 100;
						return this.Math.max(0, c);
					}

				},
				{
					Type = this.Const.World.Spawn.Troops.ZombieYeomanBodyguard,
					MinR = 100,
					Cost = 12,
					function Weight( scale )
					{
						local c = 100 - scale * 100;
						return this.Math.max(0, c);
					}

				},
				{
					Type = this.Const.World.Spawn.Troops.ZombieKnightBodyguard,
					MinR = 200,
					Cost = 25,
					function Weight( scale )
					{
						local c = 100 - (1.0 - scale) * 100;
						return this.Math.min(100, c);
					}

				}
			]
		}
	],
	SsuFixed2 = [
		{
			Type = this.Const.World.Spawn.Troops.Necromancer,
			Cost = 30,
			MinGuards = 1,
			MaxGuards = 2,
			MaxGuardsWeight = 25,
			MinR = 500,
			Weight = 100,
			Guards = [
				{
					Type = this.Const.World.Spawn.Troops.ZombieBodyguard,
					MaxR = 125,
					Cost = 6,
					function Weight( scale )
					{
						local c = 100 - scale * 100;
						return this.Math.max(0, c);
					}

				},
				{
					Type = this.Const.World.Spawn.Troops.ZombieYeomanBodyguard,
					MinR = 100,
					Cost = 12,
					function Weight( scale )
					{
						local c = 100 - scale * 100;
						return this.Math.max(0, c);
					}

				},
				{
					Type = this.Const.World.Spawn.Troops.ZombieKnightBodyguard,
					MinR = 200,
					Cost = 25,
					function Weight( scale )
					{
						local c = 100 - (1.0 - scale) * 100;
						return this.Math.min(100, c);
					}

				}
			]
		}
	],	
	SsuFixed3 = [
		{
			Type = this.Const.World.Spawn.Troops.Necromancer,
			Cost = 30,
			MinGuards = 1,
			MaxGuards = 2,
			MaxGuardsWeight = 25,
			MinR = 700,
			Weight = 100,
			Guards = [
				{
					Type = this.Const.World.Spawn.Troops.ZombieBodyguard,
					MaxR = 125,
					Cost = 6,
					function Weight( scale )
					{
						local c = 100 - scale * 100;
						return this.Math.max(0, c);
					}

				},
				{
					Type = this.Const.World.Spawn.Troops.ZombieYeomanBodyguard,
					MinR = 100,
					Cost = 12,
					function Weight( scale )
					{
						local c = 100 - scale * 100;
						return this.Math.max(0, c);
					}

				},
				{
					Type = this.Const.World.Spawn.Troops.ZombieKnightBodyguard,
					MinR = 200,
					Cost = 25,
					function Weight( scale )
					{
						local c = 100 - (1.0 - scale) * 100;
						return this.Math.min(100, c);
					}

				}
			]
		}
	],		
	Troops = [
		{
			Weight = 20,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.ZombieYeoman,
					MinR = 100,
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
			Weight = 8,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuFallenbetrayer,
					MinR = 350,
					Cost = 45
				}
			]
		},	
		{
			Weight = 25,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuZombieFootman,
					Cost = 25
				}
			]
		},
		{
			Weight = 18,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuZombieBillman,
					Cost = 25
				}
			]
		},	
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuZombieArbalester,
					Cost = 30
				}
			]
		},	
		{
			Weight = 8,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuZombieZweihander,
					MinR = 250,					
					Cost = 35
				}
			]
		},		
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuZombieswordmaster,
					MinR = 450,
					Cost = 45
				}
			]
		},			
		{
			Weight = 4,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Ghost,
					MinR = 300,					
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
		}
	]
};

::Const.World.Spawn.Manhunters <- {
	Name = "Manhunters",
	IsDynamic = true,
	MovementSpeedMult = 0.8,
	VisibilityMult = 1.0,
	VisionMult = 0.8,
	Body = "figure_nomad_03",
	MaxR = 706,
	MinR = 102,
	Fixed = [
		{
			MinCount = 1,
			MaxCount = 1,
			Weight = 100,
			Type = this.Const.World.Spawn.Troops.SsuSlaveowner,
			Cost = 20			
		}
	],
	SsuFixed = [
		{
			Weight = 100,
			MinR = 300,
			Type = this.Const.World.Spawn.Troops.SsuSlaveowner,
			Cost = 40
		}
	],
	SsuFixed2 = [
		{
			Weight = 100,
			MinR = 500,
			Type = this.Const.World.Spawn.Troops.SsuSlaveowner,
			Cost = 40
		}
	],	
	Troops = [
		{
			Weight = 50,
			Types = [
				{
					MaxR = 360,				
					Type = this.Const.World.Spawn.Troops.SsuAbjectfighter,
					Cost = 8
				},
				{
					MinR = 240,				
					Type = this.Const.World.Spawn.Troops.SsuAbjectgladiator,
					Cost = 22
				}							
			]
		},
		{
			Weight = 20,
			MaxR = 480,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuAbjectfighter,
					Cost = 8
				}
			]
		},
		{
			Weight = 20,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Gladiator,
					MinR = 420,						
					Cost = 35
				}
			]
		},		
		{
			Weight = 8,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuWarden,
					Cost = 20
				}
			]
		},
		{
			Weight = 22,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuManhunter,
					Cost = 30
				}
			]
		}		
	]
};

::Const.World.Spawn.SsuSAEbandits <- {
	Name = "SsuSAEbandits",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	Fixed = [
		{
			Type = this.Const.World.Spawn.Troops.LegendPeasantMonk,
			Weight = 100,
			Cost = 10
		}
	],
	SsuFixed = [
		{
			MinR = 300,
			Weight = 100,
			Type = this.Const.World.Spawn.Troops.BanditLeader,
			Cost = 10
		}
	],	
	SsuFixed2 = [
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
					Type = this.Const.World.Spawn.Troops.SsuSquireLow,
					Cost = 15,
					function Weight( scale )
					{
						return 100;
					}

				}
			]
		}
	],	
	SsuFixed3 = [
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
			Weight = 30,
			Types = [
				{
					MinR = 420,
					Type = this.Const.World.Spawn.Troops.BanditMarauder,
					Cost = 30
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuSquireLow,
					Cost = 25,
					Roll = true
				}
			]
		},
		{
			Weight = 15,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuDesperado,
					Cost = 40,
					Roll = true
				}
			]
		},		
		{
			Weight = 3,
			MinR = 600,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuDesperadoHigh,
					Cost = 80,
					Roll = true
					MinGuards = 1,
					MaxGuards = 1,
					MaxGuardsWeight = 100,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.LegendPeasantMonk,
							Cost = 10,
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
			Weight = 20,
			Types = [
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
							Type = this.Const.World.Spawn.Troops.SsuSquireLow,
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
					Type = this.Const.World.Spawn.Troops.SsuSlayer,
					Cost = 50,
					Roll = true
				}
			]
		}		
	]
};

::Const.World.Spawn.SsuSAEassasins <- {
	Name = "SsuSAEassasins",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_player_legends_assassin",
	Fixed = [],
	MaxR = 600,
	Troops = [
		{
			Weight = 70,		
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuHashshashin,
					Cost = 40
				}
			]
		},
		{
			Weight = 25,		
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.DesertStalker,
					Cost = 40
				}
			]
		},		
		{
			Weight = 5,
			MinR = 500,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuHashshashinHigh,
					Cost = 75
				}
			]
		}		
	]
};

::Const.World.Spawn.SsusoloHedgeKnight <- {
	Name = "SsusoloHedgeKnight",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_player_03",
	MaxR = 600,
	Fixed = [
		{
			Weight = 100,
			MinR = 750,
			Type = this.Const.World.Spawn.Troops.HedgeKnight,
			Cost = 20,
			Roll = true
			MinGuards = 1,
			MaxGuards = 2,
			MaxGuardsWeight = 30,
			Guards = [
				{
					Type = this.Const.World.Spawn.Troops.SsuSquireLow,
					Cost = 10,
					function Weight( scale )
					{
						return 100;
					}

				}
			]
		}
	],		
	Troops = []
};