::Const.World.Spawn.Noble.MinR = 75;
::Const.World.Spawn.Noble.MaxR = 680;
::Const.World.Spawn.Noble.Fixed = [
	{
		Weight = 100,
		Type = this.Const.World.Spawn.Troops.StandardBearer,
		Cost = 20
	}
];

::Const.World.Spawn.Noble.crFixed <- [
	{
		MinR = 400,
		Weight = 100,
		Type = this.Const.World.Spawn.Troops.Knight,
		Cost = 50,
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
];

::Const.World.Spawn.Noble.crrFixed <- [
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
];
::Const.World.Spawn.Noble.Troops = [
	{
		Weight = 45,
		MaxR = 625,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Footman,
				Cost = 15
			}
		]
	},
	{
		Weight = 20,
		MinR = 450,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.crInfantry,
				Cost = 30
			}
		]
	},
	{
		Weight = 25,
		MaxR = 625,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Billman,
				Cost = 15
			}
		]
	},
	{
		Weight = 8,
		MinR = 450,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.LegendHalberdier,
				Cost = 35
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Arbalester,
				Cost = 20
			}
		]
	},
	{
		Weight = 5,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Greatsword,
				Cost = 30
			}
		]
	},
	{
		Weight = 5,
		MinR = 400,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Greatsword,
				Cost = 40
			}
		]
	},
	{
		Weight = 3,
		MinR = 0.25 * 555,
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
		MinR = 450,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Sergeant,
				Cost = 40,
				Roll = true
			}
		]
	},
	{
		Weight = 5,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.ArmoredWardog,
				Cost = 8
			}
		]
	},
	{
		Weight = 5,
		MinR = 450,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Arbalester,
				Cost = 15
			}
		]
	},
	{
		Weight = 3,
		MinR = 0.5 * 555,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.LegendFencer,
				Cost = 60
			}
		]
	},
	{
		Weight = 4,
		MinR = 0.5 * 555,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.LegendSlinger,
				Cost = 60
			}
		]
	},
	{
		Weight = 2,
		MinR = 500,
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
	}
];


::Const.World.Spawn.NobleCaravan.MinR = 110;
::Const.World.Spawn.NobleCaravan.MaxR = 420;
::Const.World.Spawn.NobleCaravan.Fixed = [
	{
		MinCount = 1,
		MaxCount = 3,
		Weight = 30,
		Type = this.Const.World.Spawn.Troops.CaravanDonkey,
		Cost = 0
	}
];
::Const.World.Spawn.NobleCaravan.Troops = [
	{
		Weight = 62,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Footman,
				Cost = 20
			}
		]
	},
	{
		Weight = 17,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Billman,
				Cost = 15
			}
		]
	},
	{
		Weight = 15,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Arbalester,
				Cost = 20
			}
		]
	},
	{
		Weight = 2,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Greatsword,
				Cost = 25
			}
		]
	},
	{
		Weight = 2,
		MinR = 0.6 * 300,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.Sergeant,
				Cost = 40,
				Roll = true
			}
		]
	},
	{
		Weight = 1,
		MinR = 0.6 * 300,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.LegendHalberdier,
				Cost = 60
			}
		]
	},
	{
		Weight = 1,
		MinR = 0.5 * 300,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.LegendFencer,
				Cost = 60
			}
		]
	},
	{
		Weight = 1,
		MinR = 0.5 * 300,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.LegendSlinger,
				Cost = 60
			}
		]
	}
];

::Const.World.Spawn.MixedNobleCaravan <- {
	Name = "MixedNobleCaravan",
	IsDynamic = true,
	MovementSpeedMult = 0.5,
	VisibilityMult = 1.0,
	VisionMult = 0.25,
	Body = "cart_01",
	MinR = 110,
	MaxR = 420,
	Fixed = [
		{
			MinCount = 1,
			MaxCount = 3,
			Weight = 30,
			Type = this.Const.World.Spawn.Troops.CaravanDonkey,
			Cost = 0
		}
	],
	Troops = [
		{
			Weight = 42,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Footman,
					Cost = 20
				}
			]
		},
		{
			Weight = 20,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.crMercenary,
					Cost = 25
				}
			]
		},
		{
			Weight = 3,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Wardog,
					Cost = 8
				}
			]
		},
		{
			Weight = 15,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Billman,
					Cost = 15
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Arbalester,
					Cost = 20
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.MercenaryRanged,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.MasterArcher,
					Cost = 40
				}
			]
		},
		{
			Weight = 2,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Greatsword,
					Cost = 25
				}
			]
		},
		{
			Weight = 2,
			MinR = 0.6 * 365,			
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.HedgeKnight,
					Cost = 40,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 20,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.crSquireLow,
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
			Weight = 2,
			MinR = 0.6 * 365,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Swordmaster,
					Cost = 60
				}
			]
		},		
		{
			Weight = 2,
			MinR = 0.5 * 365,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Sergeant,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 1,
			MinR = 0.5 * 365,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendHalberdier,
					Cost = 60
				}
			]
		},
		{
			Weight = 1,
			MinR = 0.5 * 365,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendFencer,
					Cost = 60
				}
			]
		},
		{
			Weight = 1,
			MinR = 0.5 * 365,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendSlinger,
					Cost = 60
				}
			]
		}
	]
};
