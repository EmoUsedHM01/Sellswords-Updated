::mods_hookExactClass("entity/world/locations/barbarian_camp_location", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		local r = this.Math.rand(1, 100);
		if (r <= 15)
		{
			this.setDefenderSpawnList(this.Const.World.Spawn.BabarianChosens);
		}
		else if (r <= 30)
		{
			this.setDefenderSpawnList(this.Const.World.Spawn.BabarianBerserkers);
		}
		else if (r > 30)
		{
			this.setDefenderSpawnList(this.Const.World.Spawn.Barbarians);
		}
	}
})