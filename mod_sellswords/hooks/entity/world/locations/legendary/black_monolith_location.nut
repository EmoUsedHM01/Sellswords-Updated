::Mod_Sellswords.HooksMod.hook("scripts/entity/world/locations/legendary/black_monolith_location", function ( q ) {

	q.onSpawned = @(__original) function()
	{
		this.m.Name = "Black Monolith";
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

	q.onDropLootForPlayer = @(__original) function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropArmorParts(this.Math.rand(0, 60), _lootTable);
		this.dropTreasure(this.Math.rand(3, 4), [
			"loot/white_pearls_item",
			"loot/jeweled_crown_item",
			"loot/gemstones_item",
			"loot/golden_chalice_item",
			"loot/ancient_gold_coins_item",
			"misc/legend_ancient_scroll_item",
			"misc/legend_masterwork_metal",
			"misc/legend_masterwork_fabric",
			"misc/legend_masterwork_tools"
		], _lootTable);
		_lootTable.push(this.Const.World.Common.pickArmor([
			[
				1,
				"cremperors_armor"
			]
		]));
	}
});
