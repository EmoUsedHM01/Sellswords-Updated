::Mod_Sellswords.HooksMod.hook("scripts/entity/world/locations/barbarian_shelter_location", function( q ) {

	q.create = @(__original) function()
	{
		__original();

		local r = this.Math.rand(1, 100);
		if (r <= 20)
		{
			this.setDefenderSpawnList(this.Const.World.Spawn.BabarianBerserkers);
		}
		else if (r > 20)
		{
			this.setDefenderSpawnList(this.Const.World.Spawn.Barbarians);
		}	
	}
});
