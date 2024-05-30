::Mod_Sellswords.HooksMod.hook("scripts/entity/world/locations/barbarian_sanctuary_location", function( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		local r = this.Math.rand(1, 100);
		if (r <= 25)
		{
			this.setDefenderSpawnList(this.Const.World.Spawn.BabarianChosens);
		}
		else if (r > 25)
		{
			this.setDefenderSpawnList(this.Const.World.Spawn.Barbarians);
		}	
	}
});
