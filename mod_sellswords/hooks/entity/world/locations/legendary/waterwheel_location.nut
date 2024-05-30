::Mod_Sellswords.HooksMod.hook("scripts/entity/world/locations/legendary/waterwheel_location", function( q ) {

	q.onSpawned = @(__original) function()
	{
		__original();

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
});
