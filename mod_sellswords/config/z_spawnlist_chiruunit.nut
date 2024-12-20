if (!("World" in ::Const))
{
	::Const.World <- {};
}

if (!("Spawn" in ::Const.World))
{
	::Const.World.Spawn <- {};
}

::Const.World.Spawn.CaravanwithSellswords <- {
	Name = "CaravanwithSellswords",
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
					Type = this.Const.World.Spawn.Troops.crMercenary,
					Cost = 25
				}				
			]
		},
		{
			Weight = 20,
			MaxR = 220,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crRetiredsoldier,
					Cost = 20,
				}				
			]
		},	
		{
			Weight = 20,
			MaxR = 220,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crRetiredsoldierpol,
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
					Type = this.Const.World.Spawn.Troops.crSellsword,
					Cost = 40
				}				
			]
		},
		{
			Weight = 15,
			MinR = 400,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crSellsword_Polearm,
					Cost = 40
				}				
			]
		},	
		{
			Weight = 10,
			MinR = 400,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crSellsword_Tank,
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
					Type = this.Const.World.Spawn.Troops.crSellsword_Ranger,
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
							Type = this.Const.World.Spawn.Troops.crSquireLow,
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
::Const.World.Spawn.Noblewithbaron <- {
	Name = "Noblewithbaron",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_player_noble",
	MinR = 225,
	MaxR = 800,
	Fixed = [
		{
			Weight = 100,
			Type = this.Const.World.Spawn.Troops.crBaron,
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
	crFixed = [
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
	crrFixed = [
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
	crrrFixed = [
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
					Type = this.Const.World.Spawn.Troops.crKnight,
					Cost = 60,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 50,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.crSquire,
							Cost = 30,
							function Weight( scale )
							{
								local c = 100 - scale * 100;
								return this.Math.max(60, c);
							}

						},
						{
							Type = this.Const.World.Spawn.Troops.crSquireFencer,
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
					Type = this.Const.World.Spawn.Troops.crHonoraryknight,
					Cost = 60,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 50,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.crSquire,
							Cost = 30,
							function Weight( scale )
							{
								local c = 100 - scale * 100;
								return this.Math.max(20, c);
							}

						},
						{
							Type = this.Const.World.Spawn.Troops.crSquireFencer,
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
::Const.World.Spawn.NobleCaravanwithSellswords <- {
	Name = "NobleCaravanwithSellswords",
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
					Type = this.Const.World.Spawn.Troops.crMercenary,
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
					Type = this.Const.World.Spawn.Troops.crSellsword,
					Cost = 40
				}				
			]
		},
		{
			Weight = 10,
			MinR = 400,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crSellsword_Polearm,
					Cost = 40
				}				
			]
		},	
		{
			Weight = 7,
			MinR = 400,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crSellsword_Tank,
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
					Type = this.Const.World.Spawn.Troops.crSellsword_Ranger,
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
							Type = this.Const.World.Spawn.Troops.crSquire,
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
::Const.World.Spawn.CaravanSouthernwithSellswords <- {
	Name = "CaravanSouthernwithSellswords",
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
					Type = this.Const.World.Spawn.Troops.crSellsword,
					Cost = 40
				}				
			]
		},
		{
			Weight = 10,
			MinR = 420,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crSellsword_Polearm,
					Cost = 40
				}			
			]
		},	
		{
			Weight = 7,
			MinR = 420,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crSellsword_Tank,
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
					Type = this.Const.World.Spawn.Troops.crSellsword_Ranger,
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
::Const.World.Spawn.Desperados <- {
	Name = "Desperados",
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
	crFixed = [
		{
			MinR = 480,
			MinCount = 1,
			MaxCount = 3,
			Weight = 50,
			Type = this.Const.World.Spawn.Troops.crPeasantminstrel,
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
					Type = this.Const.World.Spawn.Troops.crDesperado_Weak,
					Cost = 18
				}
			]
		},
		{
			Weight = 50,
			MaxR = 400,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crDesperado_Low,
					Cost = 30
				}
			]
		},		
		{
			Weight = 50,
			MinR = 360,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crDesperado,
					Cost = 50
				}
			]
		},
		{
			Weight = 5,
			MinR = 600,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crDesperado_High,
					Cost = 80
				}
			]
		},
		{
			Weight = 3,
			MinR = 600,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crDesperado_High,
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
::Const.World.Spawn.Hashshashins <- {
	Name = "Hashshashins",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_player_assassin",
	Fixed = [],
	MaxR = 600,
	Troops = [
		{
			Weight = 50,
			MaxR = 360,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crHashshashin_Low,
					Cost = 25
				}
			]
		},
		{
			Weight = 50,
			MinR = 300,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crHashshashin,
					Cost = 40
				}
			]
		},		
		{
			Weight = 8,
			MinR = 500,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crHashshashin_High,
					Cost = 75
				}
			]
		}		
	]
};

::Const.World.Spawn.BabarianBerserkers <- {
	Name = "BabarianBerserkers",
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
					Type = this.Const.World.Spawn.Troops.crBarbarianZerker_Low,
					Cost = 45
				},
				{
					MaxR = 550,					
					Type = this.Const.World.Spawn.Troops.crBarbarianZerker_High,
					Cost = 30
				}				
			]
		},

	]
};

::Const.World.Spawn.Barbhunters <- {
	Name = "Barbhunters",
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
					Type = this.Const.World.Spawn.Troops.crBarbhunter,
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
					Type = this.Const.World.Spawn.Troops.crBarbhunter,
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
					Type = this.Const.World.Spawn.Troops.crBarbhunter,
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

::Const.World.Spawn.BabarianChosens <- {
	Name = "BabarianChosens",
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
	crFixed = [
		{
			MinR = 600,
			Weight = 100,
			Type = this.Const.World.Spawn.Troops.crBarbarianKing,
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
					Type = this.Const.World.Spawn.Troops.crImmortal,
					Cost = 45
				}					
			]
		},
		{
			Weight = 10,
			MinR = 560,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crBarbarianChampionhigh,
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

::Const.World.Spawn.BabarianChosenswithKing <- {
	Name = "BabarianChosenswithKing",
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
	crFixed = [
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
	crrFixed = [
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
					Type = this.Const.World.Spawn.Troops.crImmortal,
					Cost = 45
				}					
			]
		},
		{
			Weight = 10,
			MinR = 560,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crBarbarianChampionhigh,
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

::Const.World.Spawn.crthieves <- {
	Name = "crthieves",
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
	crFixed = [
		{
			Weight = 100,
			MinR = 280,
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
					Type = this.Const.World.Spawn.Troops.BanditVeteran,
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
				},
				{
					Type = this.Const.World.Spawn.Troops.crOutlander,
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

::Const.World.Spawn.RomaLegion <- {
	Name = "RomaLegion",
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
					Type = this.Const.World.Spawn.Troops.crSkeleton,
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
					Type = this.Const.World.Spawn.Troops.crSkeleton_pol,
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

::Const.World.Spawn.BanditMilitary <- {
	Name = "BanditMilitary",
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
	crFixed = [
		{
			Weight = 100,
			MinR = 250,
			Type = this.Const.World.Spawn.Troops.crBanditSergeant,
			Cost = 40
		}
	],
	crrFixed = [
		{
			Weight = 100,
			MinR = 400,
			Type = this.Const.World.Spawn.Troops.crBanditSergeant,
			Cost = 40
		}
	],
	crrrFixed = [
		{
			Weight = 100,
			MinR = 650,
			Type = this.Const.World.Spawn.Troops.crBanditSergeant,
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
					Type = this.Const.World.Spawn.Troops.BanditVeteran,
					Cost = 30
				}
			]
		},
		{
			Weight = 30,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crBanditFootman,
					Cost = 20
				}
			]
		},	
		{
			Weight = 15,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crBanditBillman,
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
					Type = this.Const.World.Spawn.Troops.crBanditArbalester,
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
					Type = this.Const.World.Spawn.Troops.crBanditZweihander,
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

::Const.World.Spawn.BarbarianMilitary <- {
	Name = "BarbarianMilitary",
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
	crFixed = [
		{
			Weight = 100,
			MinR = 250,
			Type = this.Const.World.Spawn.Troops.crBarbarianSergeant,
			Cost = 40
		}
	],
	crrFixed = [
		{
			Weight = 100,
			MinR = 500,
			MinCount = 1,
			MaxCount = 2,			
			Type = this.Const.World.Spawn.Troops.crBarbarianSergeant,
			Cost = 40
		}
	],
	crrrFixed = [
		{
			MinR = 650,
			Weight = 100,
			Type = this.Const.World.Spawn.Troops.crBarbarianKing,
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
					Type = this.Const.World.Spawn.Troops.crImmortal,
					Cost = 45
				}				
			]
		},
		{
			Weight = 30,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crBarbarianFootman,
					Cost = 20,
				}
			]
		},
		{
			Weight = 15,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crBarbarianBillman,
					Cost = 20,
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
			Weight = 10,
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
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crBarbarianArbalester,
					Cost = 20,
				}
			]
		},		
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crBarbarianZweihander,
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
					Type = this.Const.World.Spawn.Troops.crBarbarianChampionhigh,
					Cost = 60
				}
			]
		}		
	]
};
::Const.World.Spawn.NomadMilitary <- {
	Name = "NomadMilitary",
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
	crFixed = [
		{
			Weight = 100,
			MinR = 250,
			Type = this.Const.World.Spawn.Troops.crNomadSergeant,
			Cost = 40
		}
	],
	crrFixed = [
		{
			Weight = 100,
			MinR = 450,
			Type = this.Const.World.Spawn.Troops.crNomadSergeant,
			Cost = 40
		}
	],
	crrrFixed = [
		{
			Weight = 100,
			MinR = 650,
			Type = this.Const.World.Spawn.Troops.crNomadSergeant,
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
					Type = this.Const.World.Spawn.Troops.crNomadFootman,
					Cost = 20,
				}
			]
		},	
		{
			Weight = 15,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crNomadBillman,
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
					Type = this.Const.World.Spawn.Troops.crNomadArbalester,
					Cost = 20,
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crNomadZweihander,
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

::Const.World.Spawn.ZombieMilitary <- {
	Name = "ZombieMilitary",
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
			Type = this.Const.World.Spawn.Troops.crNecromancer,
			Cost = 10			
		}
	],
	crFixed = [
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
	crrFixed = [
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
	crrrFixed = [
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
					Type = this.Const.World.Spawn.Troops.crFallenbetrayer,
					MinR = 350,
					Cost = 45
				}
			]
		},	
		{
			Weight = 25,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crZombieFootman,
					Cost = 25
				}
			]
		},
		{
			Weight = 18,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crZombieBillman,
					Cost = 25
				}
			]
		},	
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crZombieArbalester,
					Cost = 30
				}
			]
		},	
		{
			Weight = 8,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crZombieZweihander,
					MinR = 250,					
					Cost = 35
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
			Type = this.Const.World.Spawn.Troops.crSlaveowner,
			Cost = 20			
		}
	],
	crFixed = [
		{
			Weight = 100,
			MinR = 300,
			Type = this.Const.World.Spawn.Troops.crSlaveowner,
			Cost = 40
		}
	],
	crrFixed = [
		{
			Weight = 100,
			MinR = 400,
			Type = this.Const.World.Spawn.Troops.crSlaveowner,
			Cost = 40
		}
	],
	crrFixed = [
		{
			Weight = 100,
			MinR = 500,
			Type = this.Const.World.Spawn.Troops.crSlaveowner,
			Cost = 40
		}
	],	
	Troops = [
		{
			Weight = 50,
			Types = [
				{
					MaxR = 360,				
					Type = this.Const.World.Spawn.Troops.crAbjectfighter,
					Cost = 8
				},
				{
					MinR = 240,				
					Type = this.Const.World.Spawn.Troops.crAbjectgladiator,
					Cost = 22
				}							
			]
		},
		{
			Weight = 20,
			MaxR = 480,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crAbjectfighter,
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
					Type = this.Const.World.Spawn.Troops.crWarden,
					Cost = 20
				}
			]
		},
		{
			Weight = 22,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crManhunter,
					Cost = 30
				}
			]
		}		
	]
};

::Const.World.Spawn.SAEbandits <- {
	Name = "SAEbandits",
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
			Weight = 30,
			Types = [
				{
					MinR = 420,
					Type = this.Const.World.Spawn.Troops.BanditVeteran,
					Cost = 30
				}
			]
		},
		{
			Weight = 5,
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
					Type = this.Const.World.Spawn.Troops.crDesperado,
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
					Type = this.Const.World.Spawn.Troops.crDesperado_High,
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
		}		
	]
};

::Const.World.Spawn.SAEassasins <- {
	Name = "SAEassasins",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_player_assassin",
	Fixed = [],
	MaxR = 600,
	Troops = [
		{
			Weight = 70,		
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crHashshashin,
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
					Type = this.Const.World.Spawn.Troops.crHashshashin_High,
					Cost = 75
				}
			]
		}		
	]
};

::Const.World.Spawn.soloHedgeKnight <- {
	Name = "soloHedgeKnight",
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
					Type = this.Const.World.Spawn.Troops.crSquireLow,
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