::Const.World.Spawn.GreenskinHorde.SsuLeader <- [
	{
		MinR = 400,
		Weight = 100,
		Type = this.Const.World.Spawn.Troops.SsuOrcPackleader,
		Cost = 40
	}
];

::Const.World.Spawn.GreenskinHorde.SsuFixed <- [
	{
		Weight = 100,
		MinR = 500,
		Type = this.Const.World.Spawn.Troops.GoblinOverseer,
		Cost = 40
	}
];

::Const.World.Spawn.GreenskinHorde.SsuFixed2 <- [
	{
		Weight = 100,
		MinR = 750,
		Type = this.Const.World.Spawn.Troops.SsuOrcPackleader,
		Cost = 40
	}
];

::Const.World.Spawn.GreenskinHorde.SsuFixed3 <- [
	{
		Weight = 100,
		MinR = 1000,
		Type = this.Const.World.Spawn.Troops.OrcWarlord,
		Cost = 60
	}
];

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.GreenskinHorde, [
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
	}
]);
