::Mod_Sellswords.HooksMod.hook("scripts/entity/world/locations/barbarian_camp_location", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		local r = this.Math.rand(1, 100);
		if (r <= 15)
		{
			this.setDefenderSpawnList(this.Const.World.Spawn.SsuBabarianChosens);
		}
		else if (r <= 30)
		{
			this.setDefenderSpawnList(this.Const.World.Spawn.SsuBabarianBerserkers);
		}
		else if (r > 30)
		{
			this.setDefenderSpawnList(this.Const.World.Spawn.Barbarians);
		}
	}
});
