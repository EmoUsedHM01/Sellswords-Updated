if (!("World" in ::Const))
{
	::Const.World <- {};
}

if (!("Spawn" in ::Const.World))
{
	::Const.World.Spawn <- {};
}

::Const.World.Spawn.Dryads <- {
	Name = "Dryads",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_ss_dryad_enemy",
	MaxR = 1000,
	MinR = 97,
	Fixed = [
		{
			MinR = 50,
			MinCount = 1,
			MaxCount = 1,
			Weight = 100,
			Type = this.Const.World.Spawn.Troops.DryadShaman,
			Cost = 80,
			MinGuards = 2,
			MaxGuards = 3,
			MaxGuardsWeight = 100,
			Guards = [
				{
					Type = this.Const.World.Spawn.Troops.DryadGrunt,
					Cost = 25,
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
			Weight = 40,
			MinR = 50,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.DryadGrunt,
					Cost = 25,
				}
			]
		},
		{
			Weight = 25,
			MinR = 150,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.DryadWarrior,
					Cost = 35,
				}
			]
		},
		{
			Weight = 25,
			MinR = 150,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.DryadArcher,
					Cost = 35
				}
			]
		},
		{
			Weight = 15,
			MinR = 150,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.DryadWolf,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.DryadSnake, 
					Cost = 40
				}
			]
		},
		{
			Weight = 10,
			MinR = 250,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.DryadUnhold,
					Cost = 70
				}
			]
		},
		{
			Weight = 10,
			MinR = 250,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Schrat,
					Cost = 70
				}
			]
		},
		{
			Weight = 10,
			MinR = 250,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.DryadShaman,
					Cost = 80
				}
			]
		},
		{
			Weight = 10,
			MinR = 300,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.DryadTamer,
					Cost = 50
				}
			]
		},
		{
			Weight = 2,
			MinR = 600,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.DryadLindy,
					Cost = 300
				}
			]
		}
	]
};