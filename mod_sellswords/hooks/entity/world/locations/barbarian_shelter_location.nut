::mods_hookExactClass("entity/world/locations/barbarian_shelter_location", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

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
})