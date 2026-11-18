::Const.World.Spawn.Barbarians.SsuFixed <- [
	{
		MinR = 650,
		Weight = 100,
		Type = this.Const.World.Spawn.Troops.SsuBarbarianKing,
		Cost = 40
	}
];

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.Barbarians, [
	{
		Join = ::Const.World.Spawn.Troops.BarbarianThrall,
		Weight = 50,
		Types = [
			{
				MinR = 550,
				Type = this.Const.World.Spawn.Troops.SsuImmortal,
				Cost = 45
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
		MinR = 600,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuBarbarianChampionhigh,
				Cost = 60
			}
		]
	}
]);
