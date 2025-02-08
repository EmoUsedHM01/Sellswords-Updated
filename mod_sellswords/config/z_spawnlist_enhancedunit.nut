if (!("World" in ::Const))
{
	::Const.World <- {};
}

if (!("Spawn" in ::Const.World))
{
	::Const.World.Spawn <- {};
}

::Const.World.Spawn.BountyHunterChasers <- {
	Name = "BountyHunterChasers",
	IsDynamic = true,
	MovementSpeedMult = 0.9,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_03",
	MaxR = 1000,
	MinR = 97,
	Fixed = [
		{
			MinR = 320,
			MinCount = 1,
			MaxCount = 1,
			Weight = 100,
			Type = this.Const.World.Spawn.Troops.crSellsword_Banner,
			Cost = 20,
			MinGuards = 1,
			MaxGuards = 1,
			MaxGuardsWeight = 100,
			Guards = [
				{
					Type = this.Const.World.Spawn.Troops.crSellsword_Sergeant,
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
			MinR = 500,
			Type = this.Const.World.Spawn.Troops.crSellsword_Sergeant,
			Cost = 40
		}
	],	
	crrFixed = [
		{
			Weight = 100,
			MinR = 700,
			Type = this.Const.World.Spawn.Troops.crSellsword_Elite,
			Cost = 40
		}
	],	
	crrrFixed = [
		{
			Weight = 100,
			MinR = 900,
			Type = this.Const.World.Spawn.Troops.crSellsword_Lieutenant,
			Cost = 40
		}
	],	
	Troops = [
		{
			Weight = 45,
			MaxR = 400,	
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crMercenary,
					Cost = 25,				
				}
			]
		},
		{
			Weight = 12,
			MinR = 200,
			MaxCount = 2,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Gunner,
					Cost = 30
				}
			]
		},
		{
			Weight = 15,
			MinR = 200,	
			MaxCount = 1,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crOathbringer,
					Cost = 40,				
				}
			]
		},
		{
			Weight = 30,
			MinR = 320,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crSellsword,
					Cost = 40
				},
				{
					MinR = 450,					
					Type = this.Const.World.Spawn.Troops.crSellswordveteran,
					Cost = 50
				}				
			]
		},
		{
			Weight = 15,
			MinR = 320,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crSellsword_Polearm,
					Cost = 40
				},
				{
					MinR = 450,					
					Type = this.Const.World.Spawn.Troops.crSellswordveteran_Polearm, 
					Cost = 50
				}				
			]
		},	
		{
			Weight = 15,
			MinR = 320,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crSellsword_Tank,
					Cost = 40
				},
				{
					MinR = 450,					
					Type = this.Const.World.Spawn.Troops.crSellswordveteran_Tank,
					Cost = 50
				}				
			]
		},
		{
			Weight = 1,
			MinR = 400,
			MaxCount = 1,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crLindwurm_slayer,
					Cost = 80,
					Roll = true
				}
			]
		},	
		{
			Weight = 15,
			Types = [
				{				
					Type = this.Const.World.Spawn.Troops.MercenaryRanged,
					MaxR = 450,						
					Cost = 30
				},
				{				
					Type = this.Const.World.Spawn.Troops.crSellsword_Ranger,
					MinR = 360,						
					Cost = 50
				},	
				{				
					Type = this.Const.World.Spawn.Troops.crSellswordveteran_Ranger,
					MinR = 500,						
					Cost = 60
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
					Type = this.Const.World.Spawn.Troops.Wardog,
					Cost = 5
				}
			]
		},
		{
			Weight = 5,
			MinR = 450,
			MaxCount = 1,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crHedgeKnight,
					Cost = 40,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 25,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.crSquire_normal,
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
			Weight = 6,
			MinR = 450,
			MaxCount = 2,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Swordmaster,
					Cost = 40
				}
			]
		}		
	]
};

::Const.World.Spawn.MercenariesHIGH <- {
	Name = "MercenariesHIGH",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_03",
	MaxR = 1000,
	MinR = 97,
	Fixed = [
		{
			MinR = 320,
			MinCount = 1,
			MaxCount = 1,
			Weight = 100,
			Type = this.Const.World.Spawn.Troops.crSellsword_Banner,
			Cost = 20,
			MinGuards = 1,
			MaxGuards = 1,
			MaxGuardsWeight = 100,
			Guards = [
				{
					Type = this.Const.World.Spawn.Troops.crSellsword_Sergeant,
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
			MinR = 500,
			Type = this.Const.World.Spawn.Troops.crSellsword_Sergeant,
			Cost = 40
		}
	],	
	crrFixed = [
		{
			Weight = 100,
			MinR = 700,
			Type = this.Const.World.Spawn.Troops.crSellsword_Elite,
			Cost = 40
		}
	],	
	crrrFixed = [
		{
			Weight = 100,
			MinR = 900,
			Type = this.Const.World.Spawn.Troops.crSellsword_Lieutenant,
			Cost = 40
		}
	],	
	Troops = [
		{
			Weight = 45,
			MaxR = 400,	
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crMercenary,
					Cost = 25,				
				}
			]
		},
		{
			Weight = 40,
			MinR = 320,	
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crOathbringer,
					Cost = 40,				
				}
			]
		},
		{
			Weight = 30,
			MinR = 320,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crSellsword,
					Cost = 40
				},
				{
					MinR = 450,					
					Type = this.Const.World.Spawn.Troops.crSellswordveteran,
					Cost = 50
				}				
			]
		},
		{
			Weight = 15,
			MinR = 320,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crSellsword_Polearm,
					Cost = 40
				},
				{
					MinR = 450,					
					Type = this.Const.World.Spawn.Troops.crSellswordveteran_Polearm, 
					Cost = 50
				}				
			]
		},	
		{
			Weight = 15,
			MinR = 320,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crSellsword_Tank,
					Cost = 40
				},
				{
					MinR = 450,					
					Type = this.Const.World.Spawn.Troops.crSellswordveteran_Tank,
					Cost = 50
				}				
			]
		},
		{
			Weight = 15,
			Types = [
				{				
					Type = this.Const.World.Spawn.Troops.MercenaryRanged,
					MaxR = 450,						
					Cost = 30
				},
				{				
					Type = this.Const.World.Spawn.Troops.crSellsword_Ranger,
					MinR = 360,						
					Cost = 50
				},	
				{				
					Type = this.Const.World.Spawn.Troops.crSellswordveteran_Ranger,
					MinR = 500,						
					Cost = 60
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
					Type = this.Const.World.Spawn.Troops.Wardog,
					Cost = 5
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crHedgeKnight,
					Cost = 40,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 25,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.crSquire_normal,
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
			Weight = 6,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Swordmaster,
					Cost = 40
				}
			]
		}		
	]
};

::Const.World.Spawn.MercenariesLOW <- {
	Name = "MercenariesLOW",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_03",
	MaxR = 1000,
	MinR = 97,
	Fixed = [
		{
			MinR = 750,
			MinCount = 1,
			MaxCount = 1,
			Weight = 100,
			Type = this.Const.World.Spawn.Troops.crSellsword_Banner,
			Cost = 20,
			MinGuards = 1,
			MaxGuards = 1,
			MaxGuardsWeight = 100,
			Guards = [
				{
					Type = this.Const.World.Spawn.Troops.crSellsword_Sergeant,
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
			Weight = 45,
			MaxR = 750,	
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crMercenary,
					Cost = 25,				
				}
			]
		},	
		{
			Weight = 15,
			MinR = 500,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crSellsword,
					Cost = 40
				}				
			]
		},
		{
			Weight = 5,
			MinR = 500,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crSellsword_Polearm,
					Cost = 40
				}			
			]
		},	
		{
			Weight = 5,
			MinR = 500,
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
					Cost = 30
				},				
				{
					Type = this.Const.World.Spawn.Troops.MasterArcher,
					Cost = 40
				}
			]
		},		
		{
			Weight = 2,
			MinR = 650,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crSellsword_Sergeant,
					Cost = 40
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
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crHedgeKnight,
					Cost = 40,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 25,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.crSquire_normal,
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
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Swordmaster,
					Cost = 40
				}
			]
		}		
	]
};

::Const.World.Spawn.Mercenaries <- {
	Name = "Mercenaries",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_03",
	MaxR = 1000,
	MinR = 97,
	Fixed = [
		{
			MinR = 750,
			MinCount = 1,
			MaxCount = 1,
			Weight = 100,
			Type = this.Const.World.Spawn.Troops.crSellsword_Banner,
			Cost = 20,
			MinGuards = 1,
			MaxGuards = 1,
			MaxGuardsWeight = 100,
			Guards = [
				{
					Type = this.Const.World.Spawn.Troops.crSellsword_Sergeant,
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
			Weight = 45,
			MaxR = 650,	
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crMercenary,
					Cost = 25,				
				}
			]
		},	
		{
			Weight = 15,
			MinR = 500,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crSellsword,
					Cost = 40
				},
				{
					MinR = 650,					
					Type = this.Const.World.Spawn.Troops.crSellswordveteran,
					Cost = 50
				}				
			]
		},
		{
			Weight = 5,
			MinR = 500,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crSellsword_Polearm,
					Cost = 40
				},
				{
					MinR = 650,					
					Type = this.Const.World.Spawn.Troops.crSellswordveteran_Polearm, 
					Cost = 50
				}				
			]
		},	
		{
			Weight = 5,
			MinR = 500,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crSellsword_Tank,
					Cost = 40
				},
				{
					MinR = 650,					
					Type = this.Const.World.Spawn.Troops.crSellswordveteran_Tank,
					Cost = 50
				}				
			]
		},
		{
			Weight = 5,
			Types = [
				{				
					Type = this.Const.World.Spawn.Troops.MercenaryRanged,
					MaxR = 650,						
					Cost = 30
				},
				{				
					Type = this.Const.World.Spawn.Troops.crSellsword_Ranger,
					MinR = 525,						
					Cost = 50
				},	
				{				
					Type = this.Const.World.Spawn.Troops.crSellswordveteran_Ranger,
					MinR = 700,						
					Cost = 60
				},				
				{
					Type = this.Const.World.Spawn.Troops.MasterArcher,
					Cost = 40
				}
			]
		},		
		{
			Weight = 2,
			MinR = 600,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crSellsword_Sergeant,
					Cost = 40
				},
				{
					MinR = 700,					
					Type = this.Const.World.Spawn.Troops.crSellsword_Lieutenant,
					Cost = 50
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
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crHedgeKnight,
					Cost = 40,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 25,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.crSquire_normal,
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
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Swordmaster,
					Cost = 40
				}
			]
		}		
	]
};

::Const.World.Spawn.Nobleenhanced <- {
	Name = "Nobleenhanced",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_noble_01",
	MinR = 75,
	MaxR = 1050,
	Fixed = [
		{
			MinCount = 2,
			MaxCount = 3,
			Weight = 80,
			Type = this.Const.World.Spawn.Troops.StandardBearer,
			Cost = 20
		}		
	],
	crFixed = [
		{
			MinR = 400,			
			Weight = 100,
			Type = this.Const.World.Spawn.Troops.Knight,
			Cost = 40,
			MinGuards = 1,
			MaxGuards = 2,
			MaxGuardsWeight = 50,
			Guards = [
				{
					Type = this.Const.World.Spawn.Troops.crSquire,
					Cost = 30,
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
			MinR = 625,			
			Weight = 100,
			Type = this.Const.World.Spawn.Troops.Knight,
			Cost = 40,
			MinGuards = 1,
			MaxGuards = 2,
			MaxGuardsWeight = 50,
			Guards = [
				{
					Type = this.Const.World.Spawn.Troops.crSquire,
					Cost = 30,
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
			Weight = 50,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Footman,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.crInfantry,
					MinR = 600,					
					Cost = 30
				}				
			]
		},
		{
			Weight = 30,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Billman,				
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendHalberdier,
					MinR = 600,							
					Cost = 40
				}				
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Arbalester,
					Cost = 20,
					MinGuards = 1,
					MaxGuards = 1,
					MaxGuardsWeight = 100,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.ArmoredWardog,
							Cost = 5,
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
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Greatsword,
					Cost = 30
				}				
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendFencer,
					Cost = 40,
					Roll = true
				}
			]
		},		
		{
			Weight = 8,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Sergeant,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 3,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Knight,
					Cost = 60,
					Roll = true
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
								return this.Math.max(80, c);
							}

						},
						{
							Type = this.Const.World.Spawn.Troops.crSquireFencer,
							Cost = 30,
							function Weight( scale )
							{
								local c = 100 - (1.0 - scale) * 100;
								return this.Math.min(20, c);
							}

						}
					]
				}				
			]
		},	
		{
			Weight = 3,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crHonoraryknight,
					Cost = 60,
					Roll = true,
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
								return this.Math.max(50, c);
							}

						},
						{
							Type = this.Const.World.Spawn.Troops.crSquireFencer,
							Cost = 30,
							function Weight( scale )
							{
								local c = 100 - (1.0 - scale) * 100;
								return this.Math.min(50, c);
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
					Type = this.Const.World.Spawn.Troops.LegendSlinger,
					Cost = 60
				}
			]
		}		
	]
};

::Const.World.Spawn.UndeadArmy <-
{
	Name = "UndeadArmy",
	IsDynamic = true,
	MovementSpeedMult = 0.9,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_skeleton_01",
	MaxR = 800,
	MinR = 52,
	Troops = [
		{
			Weight = 50,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SkeletonLight,
					Cost = 13
				},
				{
					MinR = 200,
					Type = this.Const.World.Spawn.Troops.SkeletonMedium,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.SkeletonHeavy,
					MinR = 400,
					Cost = 35
				},
				{
					Type = this.Const.World.Spawn.Troops.crSkeleton,
					MinR = 650,
					Cost = 60
				},				
			]
		},
		{
			Weight = 35,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SkeletonMediumPolearm,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.SkeletonHeavyPolearm,
					MinR = 380,
					Cost = 35
				},
				{
					Type = this.Const.World.Spawn.Troops.crSkeleton_pol,
					MinR = 650,
					Cost = 60
				},					
				{
					Type = this.Const.World.Spawn.Troops.SkeletonGladiator,
					MinR = 600,
					Cost = 45
				},			
			]
		},
		{
			Weight = 3,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SkeletonPriest,
					Cost = 40,
					Roll = true
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 33,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.SkeletonHeavyBodyguard,
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
			Weight = 5
			MinR = 150,			
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

::Const.World.Spawn.VampiresAndSkeletons <- {
	Name = "VampiresAndSkeletons",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_vampire_01",
	MaxR = 600,
	MinR = 108,
	Troops = [
		{
			Weight = 65,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SkeletonLight,
					Cost = 13
				},
				{
					Type = this.Const.World.Spawn.Troops.SkeletonMedium,
					MinR = 200,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.SkeletonHeavy,
					MinR = 400,
					Cost = 35
				},
				{
					Type = this.Const.World.Spawn.Troops.crSkeleton,
					MinR = 650,
					Cost = 60
				},				
			]
		},
		{
			Weight = 20,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SkeletonMediumPolearm,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.SkeletonHeavyPolearm,
					MinR = 380,
					Cost = 35
				},
				{
					Type = this.Const.World.Spawn.Troops.crSkeleton_pol,
					MinR = 650,
					Cost = 60
				},					
				{
					Type = this.Const.World.Spawn.Troops.SkeletonGladiator,
					MinR = 600,
					Cost = 45
				},			
			]
		},		
		{
			Weight = 30,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.VampireLOW,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.Vampire,
					MinR = 400,
					Cost = 40
				},
				{
					MinR = 600,
					Type = this.Const.World.Spawn.Troops.LegendVampireLord,
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
					MinR = 800,
					Cost = 40
				}
			]
		}
	]
};

::Const.World.Spawn.Vampires <-
{
	Name = "Vampires",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_vampire_02",
	MaxR = 650,
	MinR = 40,
	Troops = [
		{
			Weight = 90,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.VampireLOW,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.Vampire,
					Cost = 50
					MinR = 450,
				}
			]
		},
		{
			Weight = 10,
			MinR = 650,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendVampireLord,
					Cost = 70,
					Roll = true
				}
			]
		}
	]
};


::Const.World.Spawn.Militia <-
{
	Name = "Militia",
	IsDynamic = true,
	MovementSpeedMult = 0.899999976,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_militia_01",
	MaxR = 326,
	MinR = 60,
	Troops = [
		{
			Weight = 70,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Militia,
					MaxR = 200,					
					Cost = 10
				},
				{
					Type = this.Const.World.Spawn.Troops.MilitiaVeteran,
					MaxR = 280,						
					Cost = 12
				}
			]
		},
		{
			Weight = 30,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.MilitiaRanged,
					Cost = 10
				}
			]
		},
		{
			Weight = 15,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crSquireLow,
					Cost = 25,
					Roll = true					
				}
			]
		},		
		{
			Weight = 40,
			MinR = 200,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crRetiredsoldier,
					Cost = 20,
				}				
			]
		},	
		{
			Weight = 20,
			MinR = 200,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crRetiredsoldierpol,
					Cost = 20,
				}				
			]
		},			
		{
			Weight = 15,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.MilitiaCaptain,
					Cost = 20,
					Roll = true
				}
			]
		},
		{
			Weight = 15,
			MinR = 220,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.MilitiaCaptain,
					Cost = 20,
					Roll = true
				}
			]
		},		
		{
			Weight = 10,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.crPeasantbutcher,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantminstrel,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantherbalist,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.crPeasantblacksmith,
					Cost = 15
				},	
				{
					Type = this.Const.World.Spawn.Troops.crPeasantjuggler,
					Cost = 15
				},					
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMinstrel,
					Cost = 15,
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantWoodsman,
					Cost = 15,
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMiner,
					Cost = 15,
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMonk,
					Cost = 15,
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantFarmhand,
					Cost = 15,
				}
			]
		},
		{
			Weight = 10,
			MinR = 0.8 * 326,			
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

::Const.World.Spawn.Caravan <-
{
	Name = "Caravan",
	IsDynamic = true,
	MovementSpeedMult = 0.5,
	VisibilityMult = 1.0,
	VisionMult = 0.25,
	Body = "cart_02",
	MaxR = 350,
	MinR = 30,
	Fixed = [
		{
			MinCount = 1,
			MaxCount = 3,
			Weight = 30 //percentage chance after min count is met
			Type = this.Const.World.Spawn.Troops.CaravanDonkey,
			Cost = 0
		}
	],
	Troops = [
		{
			Weight = 60,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.CaravanHand,
					MaxR = 200,						
					Cost = 10
				},
				{
					Type = this.Const.World.Spawn.Troops.CaravanGuard,
					MaxR = 280,						
					Cost = 15
				}
			]
		},
		{
			Weight = 40,
			MinR = 200,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crRetiredsoldier,
					Cost = 20,
				}				
			]
		},	
		{
			Weight = 20,
			MinR = 200,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crRetiredsoldierpol,
					Cost = 20,
				}				
			]
		}			
	]
};

::Const.World.Spawn.UndeadScourge <-
{
	Name = "UndeadScourge",
	IsDynamic = true,
	MovementSpeedMult = 0.9,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_skeleton_01",
	MaxR = 1214,
	MinR = 76,
	Troops = [
		{
			Weight = 25,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SkeletonLight,
					Cost = 13
				},
				{
					Type = this.Const.World.Spawn.Troops.SkeletonMedium,
					Cost = 20
				},
				{
					MinR = 400
					Type = this.Const.World.Spawn.Troops.SkeletonHeavy,
					Cost = 35
				}
			]
		},
		{
			MinR = 250,
			Weight = 20,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SkeletonMediumPolearm,
					Cost = 25
				},
				{
					MinR = 400
					Type = this.Const.World.Spawn.Troops.SkeletonHeavyPolearm,
					Cost = 35
				}
			]
		},
		{
			Weight = 5,
			MinR = 600,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SkeletonPriest,
					Cost = 40,
					Roll = true
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 33,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.SkeletonHeavyBodyguard,
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
			Weight = 25,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Zombie,
					Cost = 5
				},
				{
					Type = this.Const.World.Spawn.Troops.ZombieYeoman,
					Cost = 12
				},
				{
					MinR = 400,
					Type = this.Const.World.Spawn.Troops.ZombieKnight,
					Cost = 25
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crFallenbetrayer,
					MinR = 400,					
					Cost = 45
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
			Weight = 5
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.VampireLOW,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.Vampire,
					Cost = 40
				},
				{
					MinR = 600,
					Type = this.Const.World.Spawn.Troops.LegendVampireLord,
					Cost = 70,
					Roll = true
				}
			]
		},
		{
			Weight = 5
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Ghost,
					Cost = 20
				},
				{
					MinR = 350,
					Type = this.Const.World.Spawn.Troops.LegendBanshee,
					Cost = 70
				}
			]
		},
		{
			Weight = 5
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendMummyLight,
					Cost = 23
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendMummyMedium,
					MinR = 200,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendMummyHeavy,
					MinR = 600,
					Cost = 45
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Necromancer,
					Cost = 30,
					Roll = true,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 50,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.ZombieYeomanBodyguard,
							Cost = 12,
							function Weight(scale) {
								local c = 100 - (scale * 100);
								return this.Math.max(0, c);
							}
						},
						{
							Type = this.Const.World.Spawn.Troops.ZombieKnightBodyguard,
							Cost = 25,
							function Weight(scale) {
								local c = 100 - ((1.0 - scale) * 100);
								return this.Math.min(100, c);
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
					Type = this.Const.World.Spawn.Troops.GhoulLOW,
					Cost = 9
				},
				{
					Type = this.Const.World.Spawn.Troops.Ghoul,
					Cost = 19
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendDemonHound,
					Cost = 20
				}
			]
		},
		{
			Weight = 1,
			MinR = 600,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crDeathknight,
					Cost = 80
				}
			]
		}		
	]
};

::Const.World.Spawn.Southernenhanced <- {
	Name = "Southernenhanced",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_southern_01",
	MaxR = 1050,
	Fixed = [
		{
			Weight = 100,
			MinR = 250,
			Type = this.Const.World.Spawn.Troops.Officer,
			Cost = 35
		}
	],
	crFixed = [
		{
			Weight = 100,
			MinR = 325,
			Type = this.Const.World.Spawn.Troops.Officer,
			Cost = 35
		}
	],
	crrFixed = [
		{
			Weight = 100,
			MinR = 400,
			Type = this.Const.World.Spawn.Troops.Officer,
			Cost = 35
		}
	],
	crrrFixed = [
		{
			Weight = 100,
			MinR = 500,
			Type = this.Const.World.Spawn.Troops.Officer,
			Cost = 35
		}
	],	
	Troops = [
		{
			Weight = 60,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Conscript,
					MaxR = 600,					
					Cost = 20
				},			
				{
					Type = this.Const.World.Spawn.Troops.crGuardsman,
					Cost = 30
				}
			]
		},
		{
			Weight = 20,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.ConscriptPolearm, 
					MaxR = 600,					
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.crGuardsman_pol,
					Cost = 30
				}				
			]
		},
		{
			Weight = 12,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Gunner,
					Cost = 20
				}
			]
		},
		{
			Weight = 8,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crConscript,
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
					MinGuards = 1,
					MaxGuards = 1,
					MaxGuardsWeight = 100,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.Mortar,
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
			Weight = 15,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Solemner,
					Cost = 30
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Officer,
					Cost = 35
				}
			]
		},		
		{
			Weight = 20,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Assassin,
					Cost = 35,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 55,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.crGuardsman,
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
	]
};

::Const.World.Spawn.GreenskinHordeenhanced <- {
	Name = "GreenskinHordeenhanced",
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_orc_02",
	MinR = 136,
	MaxR = 1350,
	Fixed = [
		{
			MinR = 350,		
			Weight = 100,
			Type = this.Const.World.Spawn.Troops.crOrcPackleader,
			Cost = 40
		}
	],
	crFixed = [
		{
			Weight = 100,
			MinR = 500,
			Type = this.Const.World.Spawn.Troops.GoblinOverseer,
			Cost = 30,
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
	crrrFixed = [
		{
			Weight = 100,
			MinR = 900,
			Type = this.Const.World.Spawn.Troops.OrcWarlord,
			Cost = 40
		}
	],	
	Troops = [
		{
			Weight = 15,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.GoblinSkirmisher,
					Cost = 20
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
					Type = this.Const.World.Spawn.Troops.GoblinAmbusher,
					Cost = 30
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.GoblinWolfrider,
					Cost = 50
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.GoblinOverseer,
					Cost = 50
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.GoblinShaman,
					Cost = 50
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.OrcYoung,
					Cost = 15
				}
			]
		},
		{
			Weight = 22,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.OrcWarrior,
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
			Weight = 15,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.OrcBerserker,
					Cost = 30
				}
			]
		},
	]
};

::Const.World.Spawn.UndeadScourgeenhanced <- {
	Name = "UndeadScourgeenhanced",
	IsDynamic = true,
	MovementSpeedMult = 0.9,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_skeleton_01",
	MaxR = 1350,
	MinR = 76,
	Troops = [
		{
			Weight = 20,
			Types = [
				{
					MinR = 400,
					Type = this.Const.World.Spawn.Troops.SkeletonHeavy,
					Cost = 35
				},
				{
					Type = this.Const.World.Spawn.Troops.crSkeleton,
					MinR = 650,
					Cost = 60
				},				
			]
		},
		{
			Weight = 30,
			Types = [
				{
					MinR = 400,
					Type = this.Const.World.Spawn.Troops.SkeletonHeavyPolearm,
					Cost = 35
				},
				{
					Type = this.Const.World.Spawn.Troops.crSkeleton_pol,
					MinR = 650,
					Cost = 60
				},				
			]
		},
		{
			Weight = 10,
			MinR = 600,
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
			Weight = 15,
			Types = [
				{
					MinR = 400,
					Type = this.Const.World.Spawn.Troops.ZombieKnight,
					Cost = 25
				}
			]
		},		
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crFallenbetrayer,				
					Cost = 45
				}
			]
		},	
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crZombieswordmaster,				
					Cost = 45
				}
			]
		},	
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Vampire,
					Cost = 40
				},
				{
					MinR = 600,
					Type = this.Const.World.Spawn.Troops.LegendVampireLord,
					Cost = 70,
					Roll = true
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Ghost,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendBanshee,
					Cost = 70
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendMummyMedium,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendMummyHeavy,
					MinR = 600,
					Cost = 45
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Necromancer,
					Cost = 30,
					Roll = true,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 50,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.ZombieKnightBodyguard,
							Cost = 25,
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
					Type = this.Const.World.Spawn.Troops.GhoulLOW,
					Cost = 9
				},
				{
					Type = this.Const.World.Spawn.Troops.Ghoul,
					Cost = 19
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendDemonHound,
					Cost = 20
				}
			]
		},
		{
			Weight = 1,
			MinR = 600,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crDeathknight,
					Cost = 80
				}
			]
		}		
	]
};

::Const.World.Spawn.BarbariansArmy <- {
	Name = "BarbariansArmy",
	IsDynamic = true,
	MovementSpeedMult = 1.5,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_wildman_01",
	MinR = 150,
	MaxR = 950,
	Fixed = [
		{
			MinR = 300,
			MinCount = 2,
			MaxCount = 3,
			Weight = 70,
			Type = this.Const.World.Spawn.Troops.BarbarianDrummer,
			Cost = 20
		}
	],
	crFixed = [
		{
			MinR = 650,
			Weight = 100,
			Type = this.Const.World.Spawn.Troops.crBarbarianKing,
			Cost = 40
		}
	],	
	Troops = [
		{
			Weight = 50,
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
			Weight = 15,
			Types = [
				{
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

::Const.World.Spawn.BarbarianswithKing <- {
	Name = "BarbarianswithKing",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_wildman_01",
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
	Troops = [
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
			Weight = 10,
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
