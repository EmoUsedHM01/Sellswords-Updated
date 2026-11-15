this.ssu_ss_camp_location <- this.inherit("scripts/entity/world/location", {
	m = {},
	function getDescription()
	{
		return ::Mod_Sellswords.Strings.ssu_ss_camp_location.Text;
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
		this.m.Name = ::Mod_Sellswords.text(::Mod_Sellswords.Strings.ssu_ss_camp_location.Name, this.Const.Strings.MercenaryCompanyNames[this.Math.rand(0, this.Const.Strings.MercenaryCompanyNames.len() - 1)]);
		::logInfo("Built Legendary Sellsword location");
		this.location.onSpawned();		
		for( local i = 0; i < 2; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.SsuSquireNormal
			}, false);
			i = ++i;
		}
		
		for( local i = 0; i < 2; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.SsuHedgeKnight
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
				Type = this.Const.World.Spawn.Troops.SsuSellsword
			}, false);
			i = ++i;
		}
		
		for( local i = 0; i < 2; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.SsuSellswordPolearm
			}, false);
			i = ++i;
		}

		for( local i = 0; i < 1; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.SsuSellswordTank
			}, false);
			i = ++i;
		}

		for( local i = 0; i < 2; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.SsuSellswordRanger
			}, false);
			i = ++i;
		}
		
		for( local i = 0; i < 3; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.SsuSellswordveteran
			}, false, 25);
			i = ++i;
		}
		
		for( local i = 0; i < 2; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.SsuSellswordveteranPolearm
			}, false, 25);
			i = ++i;
		}

		for( local i = 0; i < 1; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.SsuSellswordveteranTank
			}, false, 25);
			i = ++i;
		}

		for( local i = 0; i < 2; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.SsuSellswordveteranRanger
			}, false, 25);
			i = ++i;
		}		

		for( local i = 0; i < 1; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.SsuSellswordSergeant
			}, false);
			i = ++i;
		}

		for( local i = 0; i < 1; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.SsuSellswordLieutenant
			}, false, 25);
			i = ++i;
		}

		for( local i = 0; i < 1; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.SsuSellswordBanner
			}, false);
			i = ++i;
		}	

		for( local i = 0; i < 1; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.SsuSellswordElite
			}, false, 100);
			i = ++i;
		}		
	}

	function onDiscovered()
	{
		this.location.onDiscovered();
		::World.Flags.increment("LegendaryLocationsDiscovered", 1);

		if (::World.Flags.get("LegendaryLocationsDiscovered") >= 10)
			this.updateAchievement("FamedExplorer", 1, 1);
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
					Type = this.Const.World.Spawn.Troops.SsuSquireNormal
				}, false);
				i = ++i;
			}
			
			for( local i = 0; i < 2; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.SsuHedgeKnight
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
					Type = this.Const.World.Spawn.Troops.SsuSellsword
				}, false);
				i = ++i;
			}
			
			for( local i = 0; i < 2; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.SsuSellswordPolearm
				}, false);
				i = ++i;
			}

			for( local i = 0; i < 1; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.SsuSellswordTank
				}, false);
				i = ++i;
			}

			for( local i = 0; i < 2; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.SsuSellswordRanger
				}, false);
				i = ++i;
			}
			
			for( local i = 0; i < 3; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.SsuSellswordveteran
				}, false, 25);
				i = ++i;
			}
			
			for( local i = 0; i < 2; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.SsuSellswordveteranPolearm
				}, false, 25);
				i = ++i;
			}

			for( local i = 0; i < 1; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.SsuSellswordveteranTank
				}, false, 25);
				i = ++i;
			}

			for( local i = 0; i < 2; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.SsuSellswordveteranRanger
				}, false, 25);
				i = ++i;
			}		

			for( local i = 0; i < 1; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.SsuSellswordSergeant
				}, false);
				i = ++i;
			}

			for( local i = 0; i < 1; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.SsuSellswordLieutenant
				}, false, 25);
				i = ++i;
			}

			for( local i = 0; i < 1; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.SsuSellswordBanner
				}, false);
				i = ++i;
			}	

			for( local i = 0; i < 1; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.SsuSellswordElite
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
			"ssu_banquet_item"
		], _lootTable);
		this.dropTreasure(this.Math.rand(4, 6), [
			"trade/silk_item",
			"trade/silk_item",
			"trade/uncut_gems_item",
			"loot/valuable_furs_item",
			"loot/white_pearls_item"
		], _lootTable);
		_lootTable.push(::Legends.Items.pickArmor([
			[
				1,
				"legendary/legend_mountain_armor"
			]
		]));
		_lootTable.push(::Legends.Items.pickHelmet([
			[
				1,
				"legendary/legend_mountain_helmet"
			]
		]));			
	}

	function onInit()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("legend_ranger_tower");
	}

	function onCombatLost() {
		this.World.Flags.set("crss_camp_Defeated", true);
	}

});

