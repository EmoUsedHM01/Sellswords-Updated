if (!("World" in ::Const))
{
	::Const.World <- {};
}

if (!("Spawn" in ::Const.World))
{
	::Const.World.Spawn <- {};
}

::Const.World.Spawn.SsuBountyHunterChasers <- {
	Name = "SsuBountyHunterChasers",
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
			Type = this.Const.World.Spawn.Troops.SsuSellswordBanner,
			Cost = 20,
			MinGuards = 1,
			MaxGuards = 1,
			MaxGuardsWeight = 100,
			Guards = [
				{
					Type = this.Const.World.Spawn.Troops.SsuSellswordSergeant,
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
			MinR = 500,
			Type = this.Const.World.Spawn.Troops.SsuSellswordSergeant,
			Cost = 40
		}
	],	
	SsuFixed2 = [
		{
			Weight = 100,
			MinR = 700,
			Type = this.Const.World.Spawn.Troops.SsuSellswordElite,
			Cost = 40
		}
	],	
	SsuFixed3 = [
		{
			Weight = 100,
			MinR = 900,
			Type = this.Const.World.Spawn.Troops.SsuSellswordLieutenant,
			Cost = 40
		}
	],	
	Troops = [
		{
			Weight = 45,
			MaxR = 400,	
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuMercenary,
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
					Type = this.Const.World.Spawn.Troops.SsuOathbringer,
					Cost = 40,				
				}
			]
		},
		{
			Weight = 30,
			MinR = 320,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuSellsword,
					Cost = 40
				},
				{
					MinR = 450,					
					Type = this.Const.World.Spawn.Troops.SsuSellswordveteran,
					Cost = 50
				}				
			]
		},
		{
			Weight = 15,
			MinR = 320,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuSellswordPolearm,
					Cost = 40
				},
				{
					MinR = 450,					
					Type = this.Const.World.Spawn.Troops.SsuSellswordveteranPolearm, 
					Cost = 50
				}				
			]
		},	
		{
			Weight = 15,
			MinR = 320,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuSellswordTank,
					Cost = 40
				},
				{
					MinR = 450,					
					Type = this.Const.World.Spawn.Troops.SsuSellswordveteranTank,
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
					Type = this.Const.World.Spawn.Troops.SsuLindwurmSlayer,
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
					Type = this.Const.World.Spawn.Troops.SsuSellswordRanger,
					MinR = 360,						
					Cost = 50
				},	
				{				
					Type = this.Const.World.Spawn.Troops.SsuSellswordveteranRanger,
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
					Type = this.Const.World.Spawn.Troops.SsuHedgeKnight,
					Cost = 40,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 25,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.SsuSquireNormal,
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

::Const.World.Spawn.SsuMercenariesHIGH <- {
	Name = "SsuMercenariesHIGH",
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
			Type = this.Const.World.Spawn.Troops.SsuSellswordBanner,
			Cost = 20,
			MinGuards = 1,
			MaxGuards = 1,
			MaxGuardsWeight = 100,
			Guards = [
				{
					Type = this.Const.World.Spawn.Troops.SsuSellswordSergeant,
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
			MinR = 500,
			Type = this.Const.World.Spawn.Troops.SsuSellswordSergeant,
			Cost = 40
		}
	],	
	SsuFixed2 = [
		{
			Weight = 100,
			MinR = 700,
			Type = this.Const.World.Spawn.Troops.SsuSellswordElite,
			Cost = 40
		}
	],	
	SsuFixed3 = [
		{
			Weight = 100,
			MinR = 900,
			Type = this.Const.World.Spawn.Troops.SsuSellswordLieutenant,
			Cost = 40
		}
	],	
	Troops = [
		{
			Weight = 45,
			MaxR = 400,	
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuMercenary,
					Cost = 25,				
				}
			]
		},
		{
			Weight = 40,
			MinR = 320,	
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuOathbringer,
					Cost = 40,				
				}
			]
		},
		{
			Weight = 30,
			MinR = 320,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuSellsword,
					Cost = 40
				},
				{
					MinR = 450,					
					Type = this.Const.World.Spawn.Troops.SsuSellswordveteran,
					Cost = 50
				}				
			]
		},
		{
			Weight = 15,
			MinR = 320,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuSellswordPolearm,
					Cost = 40
				},
				{
					MinR = 450,					
					Type = this.Const.World.Spawn.Troops.SsuSellswordveteranPolearm, 
					Cost = 50
				}				
			]
		},	
		{
			Weight = 15,
			MinR = 320,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuSellswordTank,
					Cost = 40
				},
				{
					MinR = 450,					
					Type = this.Const.World.Spawn.Troops.SsuSellswordveteranTank,
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
					Type = this.Const.World.Spawn.Troops.SsuSellswordRanger,
					MinR = 360,						
					Cost = 50
				},	
				{				
					Type = this.Const.World.Spawn.Troops.SsuSellswordveteranRanger,
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
					Type = this.Const.World.Spawn.Troops.SsuHedgeKnight,
					Cost = 40,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 25,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.SsuSquireNormal,
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

::Const.World.Spawn.SsuMercenariesLOW <- {
	Name = "SsuMercenariesLOW",
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
			Type = this.Const.World.Spawn.Troops.SsuSellswordBanner,
			Cost = 20,
			MinGuards = 1,
			MaxGuards = 1,
			MaxGuardsWeight = 100,
			Guards = [
				{
					Type = this.Const.World.Spawn.Troops.SsuSellswordSergeant,
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
					Type = this.Const.World.Spawn.Troops.SsuMercenary,
					Cost = 25,				
				}
			]
		},	
		{
			Weight = 15,
			MinR = 500,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuSellsword,
					Cost = 40
				}				
			]
		},
		{
			Weight = 5,
			MinR = 500,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuSellswordPolearm,
					Cost = 40
				}			
			]
		},	
		{
			Weight = 5,
			MinR = 500,
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
					Type = this.Const.World.Spawn.Troops.SsuSellswordSergeant,
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
					Type = this.Const.World.Spawn.Troops.SsuHedgeKnight,
					Cost = 40,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 25,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.SsuSquireNormal,
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

::Const.World.Spawn.Mercenaries.SsuLeader <- [
	{
		MinR = 750,
		MinCount = 1,
		MaxCount = 1,
		Weight = 100,
		Type = this.Const.World.Spawn.Troops.SsuSellswordBanner,
		Cost = 20,
		MinGuards = 1,
		MaxGuards = 1,
		MaxGuardsWeight = 100,
		Guards = [
			{
				Type = this.Const.World.Spawn.Troops.SsuSellswordSergeant,
				Cost = 40,
				function Weight( scale )
				{
					return 100;
				}

			}
		]
	}
];

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.Mercenaries, [
	{
		Weight = 45,
		MaxR = 650,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuMercenary,
				Cost = 25,
			}
		]
	},
	{
		Weight = 15,
		MinR = 500,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuSellsword,
				Cost = 40
			},
			{
				MinR = 650,
				Type = this.Const.World.Spawn.Troops.SsuSellswordveteran,
				Cost = 50
			}
		]
	},
	{
		Weight = 5,
		MinR = 500,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuSellswordPolearm,
				Cost = 40
			},
			{
				MinR = 650,
				Type = this.Const.World.Spawn.Troops.SsuSellswordveteranPolearm,
				Cost = 50
			}
		]
	},
	{
		Weight = 5,
		MinR = 500,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuSellswordTank,
				Cost = 40
			},
			{
				MinR = 650,
				Type = this.Const.World.Spawn.Troops.SsuSellswordveteranTank,
				Cost = 50
			}
		]
	},
	{
		Join = ::Const.World.Spawn.Troops.MercenaryRanged,
		Weight = 5,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuSellswordRanger,
				MinR = 525,
				Cost = 50
			},
			{
				Type = this.Const.World.Spawn.Troops.SsuSellswordveteranRanger,
				MinR = 700,
				Cost = 60
			}
		]
	},
	{
		Weight = 2,
		MinR = 600,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuSellswordSergeant,
				Cost = 40
			},
			{
				MinR = 700,
				Type = this.Const.World.Spawn.Troops.SsuSellswordLieutenant,
				Cost = 50
			}
		]
	},
	{
		Weight = 5,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuHedgeKnight,
				Cost = 40,
				MinGuards = 1,
				MaxGuards = 2,
				MaxGuardsWeight = 25,
				Guards = [
					{
						Type = this.Const.World.Spawn.Troops.SsuSquireNormal,
						Cost = 20,
						function Weight( scale )
						{
							return 100;
						}
					}
				]
			}
		]
	}
]);

::Const.World.Spawn.SsuNobleenhanced <- {
	Name = "SsuNobleenhanced",
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
	SsuFixed = [
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
					Type = this.Const.World.Spawn.Troops.SsuSquire,
					Cost = 30,
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
			MinR = 625,			
			Weight = 100,
			Type = this.Const.World.Spawn.Troops.Knight,
			Cost = 40,
			MinGuards = 1,
			MaxGuards = 2,
			MaxGuardsWeight = 50,
			Guards = [
				{
					Type = this.Const.World.Spawn.Troops.SsuSquire,
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
					Type = this.Const.World.Spawn.Troops.SsuInfantry,
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
							Type = this.Const.World.Spawn.Troops.SsuSquire,
							Cost = 30,
							function Weight( scale )
							{
								local c = 100 - scale * 100;
								return this.Math.max(80, c);
							}

						},
						{
							Type = this.Const.World.Spawn.Troops.SsuSquireFencer,
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
					Type = this.Const.World.Spawn.Troops.SsuHonoraryknight,
					Cost = 60,
					Roll = true,
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
								return this.Math.max(50, c);
							}

						},
						{
							Type = this.Const.World.Spawn.Troops.SsuSquireFencer,
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

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.UndeadArmy, [
	{
		Join = ::Const.World.Spawn.Troops.SkeletonLight,
		Weight = 50,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuSkeleton,
				MinR = 650,
				Cost = 60
			}
		]
	},
	{
		Join = ::Const.World.Spawn.Troops.SkeletonMediumPolearm,
		Weight = 35,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuSkeletonPol,
				MinR = 650,
				Cost = 60
			}
		]
	}
]);

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.VampiresAndSkeletons, [
	{
		Join = ::Const.World.Spawn.Troops.SkeletonLight,
		Weight = 65,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuSkeleton,
				MinR = 650,
				Cost = 60
			}
		]
	},
	{
		Weight = 20,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuSkeletonPol,
				MinR = 650,
				Cost = 60
			}
		]
	}
]);

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.Militia, [
	{
		Weight = 15,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuSquireLow,
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
				Type = this.Const.World.Spawn.Troops.SsuRetiredsoldier,
				Cost = 20,
			}
		]
	},
	{
		Weight = 20,
		MinR = 200,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuRetiredsoldierpol,
				Cost = 20,
			}
		]
	},
	{
		Join = ::Const.World.Spawn.Troops.LegendPeasantMinstrel,
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuPeasantbutcher,
				Cost = 15
			},
			{
				Type = this.Const.World.Spawn.Troops.SsuPeasantminstrel,
				Cost = 15
			},
			{
				Type = this.Const.World.Spawn.Troops.SsuPeasantherbalist,
				Cost = 15
			},
			{
				Type = this.Const.World.Spawn.Troops.SsuPeasantblacksmith,
				Cost = 15
			},
			{
				Type = this.Const.World.Spawn.Troops.SsuPeasantjuggler,
				Cost = 15
			}
		]
	}
]);

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.Caravan, [
	{
		Weight = 40,
		MinR = 200,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuRetiredsoldier,
				Cost = 20,
			}
		]
	},
	{
		Weight = 20,
		MinR = 200,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuRetiredsoldierpol,
				Cost = 20,
			}
		]
	}
]);

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.UndeadScourge, [
	{
		Weight = 5,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuFallenbetrayer,
				MinR = 400,
				Cost = 45
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
		Weight = 1,
		MinR = 600,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuDeathknight,
				Cost = 80
			}
		]
	}
]);

::Const.World.Spawn.SsuSouthernenhanced <- {
	Name = "SsuSouthernenhanced",
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
	SsuFixed = [
		{
			Weight = 100,
			MinR = 325,
			Type = this.Const.World.Spawn.Troops.Officer,
			Cost = 35
		}
	],
	SsuFixed2 = [
		{
			Weight = 100,
			MinR = 400,
			Type = this.Const.World.Spawn.Troops.Officer,
			Cost = 35
		}
	],
	SsuFixed3 = [
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
					Type = this.Const.World.Spawn.Troops.SsuGuardsman,
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
					Type = this.Const.World.Spawn.Troops.SsuGuardsmanPol,
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
					Type = this.Const.World.Spawn.Troops.SsuConscript,
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
					Type = this.Const.World.Spawn.Troops.SsuSolemner,
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
							Type = this.Const.World.Spawn.Troops.SsuGuardsman,
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

::Const.World.Spawn.SsuGreenskinHordeenhanced <- {
	Name = "SsuGreenskinHordeenhanced",
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
			Type = this.Const.World.Spawn.Troops.SsuOrcPackleader,
			Cost = 40
		}
	],
	SsuFixed = [
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
					Type = this.Const.World.Spawn.Troops.SsuOrcPackleader,
					Cost = 40,
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
			MinR = 750,
			Type = this.Const.World.Spawn.Troops.SsuOrcPackleader,
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
	SsuFixed3 = [
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
					Type = this.Const.World.Spawn.Troops.SsuGoblinwarrior,
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
					Type = this.Const.World.Spawn.Troops.SsuOrcGrunt,
					Cost = 22
				}
			]
		},
		{
			Weight = 5,
			MinR = 650,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuOrcVanguard,
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

::Const.World.Spawn.SsuUndeadScourgeenhanced <- {
	Name = "SsuUndeadScourgeenhanced",
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
					Type = this.Const.World.Spawn.Troops.SsuSkeleton,
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
					Type = this.Const.World.Spawn.Troops.SsuSkeletonPol,
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
					Type = this.Const.World.Spawn.Troops.SsuFallenbetrayer,				
					Cost = 45
				}
			]
		},	
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SsuZombieswordmaster,				
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
					Type = this.Const.World.Spawn.Troops.SsuDeathknight,
					Cost = 80
				}
			]
		}		
	]
};

::Const.World.Spawn.SsuBarbariansArmy <- {
	Name = "SsuBarbariansArmy",
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
	SsuFixed = [
		{
			MinR = 650,
			Weight = 100,
			Type = this.Const.World.Spawn.Troops.SsuBarbarianKing,
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
					Type = this.Const.World.Spawn.Troops.SsuImmortal,
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
			Weight = 15,
			Types = [
				{
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

::Const.World.Spawn.SsuBarbarianswithKing <- {
	Name = "SsuBarbarianswithKing",
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
					Type = this.Const.World.Spawn.Troops.SsuImmortal,
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
					Type = this.Const.World.Spawn.Troops.SsuSlayer,
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
					Type = this.Const.World.Spawn.Troops.SsuBarbblacksmith,
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
