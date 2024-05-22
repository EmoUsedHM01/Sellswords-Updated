::mods_hookExactClass("entity/world/locations/legendary/waterwheel_location", function(o) {
	local ws_onSpawned = o.onSpawned;
	o.onSpawned = function()
	{
		ws_onSpawned();

		for( local i = 0; i < 4; ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.crFallenbetrayer
			}, false, 100);
		}

		for( local i = 0; i < 4; ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.crZombieswordmaster
			}, false, 33);
		}

		for( local i = 0; i < 1; ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.crDeathknight
			}, false, 100);
		}	
	}
})