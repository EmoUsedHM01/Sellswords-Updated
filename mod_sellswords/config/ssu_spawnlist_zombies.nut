::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.Zombies, [
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuFallenbetrayer,
				MinR = 350,
				Cost = 45
			}
		]
	}
]);

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.ZombiesAndGhouls, [
	{
		Weight = 15,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuFallenbetrayer,
				MinR = 350,
				Cost = 45
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuZombieswordmaster,
				MinR = 450,
				Cost = 45
			}
		]
	}
]);

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.ZombiesOrZombiesAndGhouls, [
	{
		Weight = 15,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuFallenbetrayer,
				MinR = 350,
				Cost = 45
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuZombieswordmaster,
				MinR = 450,
				Cost = 45
			}
		]
	}
]);

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.ZombiesAndGhosts, [
	{
		Weight = 15,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuFallenbetrayer,
				MinR = 350,
				Cost = 45
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuZombieswordmaster,
				MinR = 450,
				Cost = 45
			}
		]
	}
]);

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.ZombiesOrZombiesAndGhosts, [
	{
		Weight = 15,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuFallenbetrayer,
				MinR = 350,
				Cost = 45
			}
		]
	},
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuZombieswordmaster,
				MinR = 450,
				Cost = 45
			}
		]
	}
]);

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.Necromancer, [
	{
		Weight = 20,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuFallenbetrayer,
				MinR = 350,
				Cost = 45
			}
		]
	},
	{
		Weight = 10,
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

::Mod_Sellswords.HookHelper.addTroops(::Const.World.Spawn.NecromancerSouthern, [
	{
		Weight = 10,
		Types = [
			{
				Type = this.Const.World.Spawn.Troops.SsuFallenbetrayer,
				MinR = 350,
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
	}
]);
