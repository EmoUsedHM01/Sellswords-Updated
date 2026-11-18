::Const.World.Spawn.OrcRaiders.SsuLeader <- [
	{
		Weight = 100,
		MinR = 350,
		Type = this.Const.World.Spawn.Troops.SsuOrcPackleader,
		Cost = 40,
	}
];

::Const.World.Spawn.OrcRaiders.SsuFixed <- [
	{
		Weight = 100,
		MinR = 550,
		Type = this.Const.World.Spawn.Troops.SsuOrcPackleader,
		Cost = 40
	}
];

::Const.World.Spawn.OrcRaiders.SsuFixed2 <- [
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

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.OrcRaiders, [
	{
		Join = ::Const.World.Spawn.Troops.LegendOrcElite,
		Weight = 5,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuOrcWarlock,
				MinR = 550,
				Cost = 100,
				Roll = true
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
		Weight = 10,
		MinR = 650,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuOrcVanguard,
				Cost = 45
			}
		]
	}
]);

::Const.World.Spawn.OrcDefenders.SsuLeader <- [
	{
		Weight = 100,
		MinR = 300,
		Type = this.Const.World.Spawn.Troops.SsuOrcPackleader,
		Cost = 40,
	}
];

::Const.World.Spawn.OrcDefenders.SsuFixed <- [
	{
		Weight = 100,
		MinR = 500,
		Type = this.Const.World.Spawn.Troops.SsuOrcPackleader,
		Cost = 40
	}
];

::Const.World.Spawn.OrcDefenders.SsuFixed2 <- [
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

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.OrcDefenders, [
	{
		Join = ::Const.World.Spawn.Troops.LegendOrcElite,
		Weight = 5,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuOrcWarlock,
				MinR = 550,
				Cost = 100,
				Roll = true
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
		Weight = 10,
		MinR = 650,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuOrcVanguard,
				Cost = 45
			}
		]
	}
]);

::Const.World.Spawn.OrcBoss.SsuLeader <- [
	{
		Weight = 100
		Type = this.Const.World.Spawn.Troops.SsuOrcPackleader,
		Cost = 40
	}
];

::Const.World.Spawn.OrcBoss.SsuFixed <- [
	{
		Weight = 100,
		MinR = 400,
		Type = this.Const.World.Spawn.Troops.SsuOrcPackleader,
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

::Const.World.Spawn.OrcBoss.SsuFixed2 <- [
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
				Type = this.Const.World.Spawn.Troops.SsuOrcPackleader,
				Cost = 40,
				function Weight(scale) {
					return 100;
				}
			}
		]
	}
];

::Const.World.Spawn.OrcBoss.SsuFixed3 <- [
	{
		Weight = 100,
		MinR = 800,
		Type = this.Const.World.Spawn.Troops.SsuOrcPackleader,
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

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.OrcBoss, [
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
		Weight = 10,
		MinR = 650,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuOrcVanguard,
				Cost = 45
			}
		]
	}
]);

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.YoungOrcsAndBerserkers, [
	{
		Weight = 20,
		MinR = 500,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuOrcGrunt,
				Cost = 22
			}
		]
	},
	{
		Weight = 10,
		MinR = 650,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuOrcVanguard,
				Cost = 45
			}
		]
	}
]);

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.BerserkersOnly, [
	{
		Weight = 10,
		MinR = 650,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuOrcVanguard,
				Cost = 45
			}
		]
	}
]);
