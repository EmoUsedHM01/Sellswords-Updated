::Mod_Sellswords.HooksMod.hook("scripts/entity/world/locations/legendary/black_monolith_location", function ( q ) {

	q.onSpawned = @(__original) function()
	{
		this.m.Name = ::Mod_Sellswords.Strings.black_monolith_location.Name;
		this.location.onSpawned();

		for( local i = 0; i < 6; ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.SkeletonMedium
			}, false);
		}

		for( local i = 0; i < 5; ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.SkeletonMediumPolearm
			}, false)
		}

		for( local i = 0; i < 2; ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.LegendVampireLord
			}, false);
		}

		for( local i = 0; i < 4; ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.Vampire
			}, false);
		}

		for( local i = 0; i < 3; ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.VampireLOW
			}, false);
		}

		for( local i = 0; i < 13; ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.SkeletonHeavy
			}, false);
		}

		for( local i = 0; i < 11; ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.SkeletonHeavyPolearm
			}, false);
		}

		this.Const.World.Common.addTroop(this, {
			Type = this.Const.World.Spawn.Troops.SkeletonBoss
		}, false);

		for( local i = 0; i < 4; ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.SkeletonPriest
			}, false);
		}

		for( local i = 0; i < 6; ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.SkeletonHeavyBodyguard
			}, false);
		}

		for( local i = 0; i < 5; ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.LegendDemonHound
			}, false);
		}
	}
});
