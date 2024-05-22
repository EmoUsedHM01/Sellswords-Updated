::mods_hookExactClass("entity/world/locations/barbarian_sanctuary_location", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

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
})