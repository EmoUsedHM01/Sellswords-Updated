::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.BanditRoamers, [
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
		MinR = 0.4 * 385,
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
				Type = this.Const.World.Spawn.Troops.SsuPeasantjuggler,
				MinR = 0.6 * 385,
				Cost = 20
			},
			{
				Type = this.Const.World.Spawn.Troops.SsuPeasantkiller,
				Cost = 20
			}
		]
	}
]);

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.BanditScouts, [
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
		MinR = 150,
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
				Type = this.Const.World.Spawn.Troops.SsuPeasantjuggler,
				MinR = 0.6 * 385,
				Cost = 20
			},
			{
				Type = this.Const.World.Spawn.Troops.SsuPeasantkiller,
				Cost = 20
			}
		]
	}
]);

::Const.World.Spawn.BanditRaiders.SsuFixed <- [
	{
		Weight = 100,
		MinR = 250,
		Type = this.Const.World.Spawn.Troops.BanditLeader,
		Cost = 40
	}
];

::Const.World.Spawn.BanditRaiders.SsuFixed2 <- [
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
];

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.BanditRaiders, [
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
						Type = this.Const.World.Spawn.Troops.SsuSquireLow,
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
			}
		]
	}
]);

::Const.World.Spawn.BanditDefenders.SsuFixed <- [
	{
		Weight = 100,
		MinR = 250,
		Type = this.Const.World.Spawn.Troops.BanditLeader,
		Cost = 40
	}
];

::Const.World.Spawn.BanditDefenders.SsuFixed2 <- [
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
];

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.BanditDefenders, [
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
		Weight = 15,
		MinR = 130,
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
				Type = this.Const.World.Spawn.Troops.SsuHedgeKnight,
				Cost = 80,
				Roll = true,
				MinGuards = 1,
				MaxGuards = 2,
				MaxGuardsWeight = 40,
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
]);

::Const.World.Spawn.BanditBoss.SsuFixed <- [
	{
		Weight = 100,
		MinR = 180,
		Type = this.Const.World.Spawn.Troops.LegendPeasantMonk,
		Cost = 40
	}
];

::Const.World.Spawn.BanditBoss.SsuFixed2 <- [
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
];

::Const.World.Spawn.BanditBoss.SsuFixed3 <- [
	{
		Weight = 100,
		MinR = 550,
		Type = this.Const.World.Spawn.Troops.Swordmaster,
		Cost = 40
	}
];

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.BanditBoss, [
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
]);

::Const.World.Spawn.BanditArmy.SsuFixed <- [
	{
		MinR = 300,
		Weight = 100,
		Type = this.Const.World.Spawn.Troops.BanditLeader,
		Cost = 10
	}
];

::Const.World.Spawn.BanditArmy.SsuFixed2 <- [
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
];

::Const.World.Spawn.BanditArmy.SsuFixed3 <- [
	{
		MinR = 750,
		Weight = 100,
		Type = this.Const.World.Spawn.Troops.BanditLeader,
		Cost = 10
	}
];

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.BanditArmy, [
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
		Join = ::Const.World.Spawn.Troops.BanditLeader,
		Weight = 4,
		Types = [
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
		MinR = 130,
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
			}
		]
	}
]);

::Const.World.Spawn.BanditsDisguisedAsDirewolves.SsuLeader <- [
	{
		MinR = 180,
		Weight = 100,
		Type = this.Const.World.Spawn.Troops.SsuBanditleaderwolf,
		Cost = 20
	}
];
