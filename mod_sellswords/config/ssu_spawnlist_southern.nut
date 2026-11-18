::Const.World.Spawn.Southern.SsuFixed <- [
	{
		Weight = 100,
		MinR = 325,
		Type = this.Const.World.Spawn.Troops.Officer,
		Cost = 35
	}
];

::Const.World.Spawn.Southern.SsuFixed2 <- [
	{
		Weight = 100,
		MinR = 400,
		Type = this.Const.World.Spawn.Troops.Officer,
		Cost = 35
	}
];

::Const.World.Spawn.Southern.SsuFixed3 <- [
	{
		Weight = 100,
		MinR = 500,
		Type = this.Const.World.Spawn.Troops.Officer,
		Cost = 35
	}
];

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.Southern, [
	{
		Weight = 7,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuConscript,
				MinR = 200,
				Cost = 20
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuSolemner,
				MinR = 225,
				Cost = 30
			}
		]
	}
]);

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.CaravanSouthern, [
	{
		Weight = 5,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuConscript,
				Cost = 20
			}
		]
	},
	{
		Weight = 1,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuMercenary,
				Cost = 25
			}
		]
	}
]);
