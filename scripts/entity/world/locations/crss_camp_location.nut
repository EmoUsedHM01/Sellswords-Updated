this.crss_camp_location <- this.inherit("scripts/entity/world/location", {
	m = {},
	function getDescription()
	{
		return "A magnificent tower blending into the surroundings without lacking coordination.";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.crss_camp";
		this.m.LocationType = this.Const.World.LocationType.Lair | this.Const.World.LocationType.Unique;
		this.m.CombatLocation.Template[0] = "tactical.human_camp";
		this.m.CombatLocation.Fortification = this.Const.Tactical.FortificationType.Palisade;		
		this.m.CombatLocation.CutDownTrees = true;		
		this.m.IsShowingBanner = true;
		this.m.IsAttackable = true;		
		this.m.Resources = 500;
	}

	function onSpawned()
	{
		this.m.Name = this.Const.Strings.MercenaryCompanyNames[this.Math.rand(0, this.Const.Strings.MercenaryCompanyNames.len() - 1)] + "’s Tower";
		this.location.onSpawned();		
		for( local i = 0; i < 2; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.crSquire_normal
			}, false);
			i = ++i;
		}
		
		for( local i = 0; i < 2; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.crHedgeKnight
			}, false, 25);
			i = ++i;
		}		
		
		for( local i = 0; i < 2; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.Swordmaster
			}, false, 25);
			i = ++i;
		}

		for( local i = 0; i < 2; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.MasterArcher
			}, false, 25);
			i = ++i;
		}		

		for( local i = 0; i < 3; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.crSellsword
			}, false);
			i = ++i;
		}
		
		for( local i = 0; i < 2; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.crSellsword_Polearm
			}, false);
			i = ++i;
		}

		for( local i = 0; i < 1; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.crSellsword_Tank
			}, false);
			i = ++i;
		}

		for( local i = 0; i < 2; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.crSellsword_Ranger
			}, false);
			i = ++i;
		}
		
		for( local i = 0; i < 3; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.crSellswordveteran
			}, false, 25);
			i = ++i;
		}
		
		for( local i = 0; i < 2; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.crSellswordveteran_Polearm
			}, false, 25);
			i = ++i;
		}

		for( local i = 0; i < 1; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.crSellswordveteran_Tank
			}, false, 25);
			i = ++i;
		}

		for( local i = 0; i < 2; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.crSellswordveteran_Ranger
			}, false, 25);
			i = ++i;
		}		

		for( local i = 0; i < 1; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.crSellsword_Sergeant
			}, false);
			i = ++i;
		}

		for( local i = 0; i < 1; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.crSellsword_Lieutenant
			}, false, 25);
			i = ++i;
		}

		for( local i = 0; i < 1; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.crSellsword_Banner
			}, false);
			i = ++i;
		}	

		for( local i = 0; i < 1; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.crSellsword_Elite
			}, false, 100);
			i = ++i;
		}		
	}
	
	function onBeforeCombatStarted()
	{
		this.location.onBeforeCombatStarted();
		if (this.m.Troops.len() > 40)
		{
			this.location.clearTroops();		
			for( local i = 0; i < 2; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.crSquire_normal
				}, false);
				i = ++i;
			}
			
			for( local i = 0; i < 2; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.crHedgeKnight
				}, false, 25);
				i = ++i;
			}		
			
			for( local i = 0; i < 2; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.Swordmaster
				}, false, 25);
				i = ++i;
			}

			for( local i = 0; i < 2; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.MasterArcher
				}, false, 25);
				i = ++i;
			}		

			for( local i = 0; i < 3; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.crSellsword
				}, false);
				i = ++i;
			}
			
			for( local i = 0; i < 2; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.crSellsword_Polearm
				}, false);
				i = ++i;
			}

			for( local i = 0; i < 1; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.crSellsword_Tank
				}, false);
				i = ++i;
			}

			for( local i = 0; i < 2; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.crSellsword_Ranger
				}, false);
				i = ++i;
			}
			
			for( local i = 0; i < 3; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.crSellswordveteran
				}, false, 25);
				i = ++i;
			}
			
			for( local i = 0; i < 2; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.crSellswordveteran_Polearm
				}, false, 25);
				i = ++i;
			}

			for( local i = 0; i < 1; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.crSellswordveteran_Tank
				}, false, 25);
				i = ++i;
			}

			for( local i = 0; i < 2; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.crSellswordveteran_Ranger
				}, false, 25);
				i = ++i;
			}		

			for( local i = 0; i < 1; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.crSellsword_Sergeant
				}, false);
				i = ++i;
			}

			for( local i = 0; i < 1; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.crSellsword_Lieutenant
				}, false, 25);
				i = ++i;
			}

			for( local i = 0; i < 1; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.crSellsword_Banner
				}, false);
				i = ++i;
			}	

			for( local i = 0; i < 1; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.crSellsword_Elite
				}, false, 100);
				i = ++i;
			}	
		}	
	}		

	function onDropLootForPlayer( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropArmorParts(this.Math.rand(40, 60), _lootTable);
		this.dropMedicine(this.Math.rand(10, 20), _lootTable);
		this.dropFood(this.Math.rand(1, 3), [
			"banquet_item"
		], _lootTable);
		this.dropTreasure(this.Math.rand(4, 6), [
			"trade/silk_item",
			"trade/silk_item",
			"trade/uncut_gems_item",
			"loot/valuable_furs_item",
			"loot/white_pearls_item"
		], _lootTable);
		_lootTable.push(this.Const.World.Common.pickArmor([
			[
				1,
				"crmountain_armor"
			]
		]));
		_lootTable.push(this.Const.World.Common.pickHelmet([
			[
				1,
				"crmountain_helmet"
			]
		]));			
	}

	function onInit()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("legend_ranger_tower");
	}

});

