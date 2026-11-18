::Const.World.Spawn.Noble.SsuFixed <- [
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
];

::Const.World.Spawn.Noble.SsuFixed2 <- [
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
];

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.Noble, [
	{
		Weight = 20,
		MinR = 450,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuInfantry,
				Cost = 30
			}
		]
	},
	{
		Weight = 2,
		MinR = 500,
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
	}
]);

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.MixedNobleCaravan, [
	{
		Weight = 20,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuMercenary,
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
						Type = this.Const.World.Spawn.Troops.SsuSquireLow,
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
]);
