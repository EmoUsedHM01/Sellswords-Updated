this.crorc_fortress_location <- this.inherit("scripts/entity/world/location", {
	m = {},
	function getDescription()
	{
		return "A mighty fortress made from massive iron wood logs and covered in tribal paintings of war. The bloodthirsty shouts of orcs echoing behind the walls can be heard from afar.";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.crorc_fortress";
		this.m.LocationType = this.Const.World.LocationType.Lair | this.Const.World.LocationType.Unique;
		this.m.CombatLocation.CutDownTrees = true;
		this.m.IsShowingBanner = true;
		this.m.IsAttackable = true;		
		this.m.Resources = 500;
		this.m.NamedWeaponsList = this.Const.Items.NamedOrcWeapons;
		this.m.NamedShieldsList = this.Const.Items.NamedOrcShields;
		this.m.OnDestroyed = "event.location.crorc_fortress_destroyed";		
	}

	function onSpawned()
	{
		this.m.Name = "Fortress of the Warlord";
		this.location.onSpawned();		
		for( local i = 0; i < 10; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.OrcYoung
			}, false);
			i = ++i;
		}
		
		for( local i = 0; i < 4; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.crOrcGrunt
			}, false);
			i = ++i;
		}		

		for( local i = 0; i < 8; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.OrcBerserker
			}, false, 15);
			i = ++i;
		}

		for( local i = 0; i < 2; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.crOrcVanguard
			}, false);
			i = ++i;
		}

		for( local i = 0; i < 10; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.OrcWarrior
			}, false, 15);
			i = ++i;
		}

		for( local i = 0; i < 2; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.LegendOrcElite
			}, false, 25);
			i = ++i;
		}

		for( local i = 0; i < 2; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.LegendOrcBehemoth
			}, false, 25);
			i = ++i;
		}

		for( local i = 0; i < 3; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.crOrcPackleader
			}, false, 35);
			i = ++i;
		}	

		for( local i = 0; i < 1; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.OrcWarlord
			}, false, 100);
			i = ++i;
		}		
		
		for( local i = 0; i < 1; i = i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.crOrcWarlock
			}, false, 100);
			i = ++i;
		}		
	}
	
	function onBeforeCombatStarted()
	{
		this.location.onBeforeCombatStarted();
		if (this.m.Troops.len() > 45)
		{
			this.location.clearTroops();		
			for( local i = 0; i < 10; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.OrcYoung
				}, false);
				i = ++i;
			}

			for( local i = 0; i < 8; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.OrcBerserker
				}, false, 15);
				i = ++i;
			}

			for( local i = 0; i < 4; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.crOrcPillager
				}, false);
				i = ++i;
			}

			for( local i = 0; i < 10; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.OrcWarrior
				}, false, 15);
				i = ++i;
			}

			for( local i = 0; i < 2; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.LegendOrcElite
				}, false, 25);
				i = ++i;
			}

			for( local i = 0; i < 2; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.LegendOrcBehemoth
				}, false, 25);
				i = ++i;
			}

			for( local i = 0; i < 3; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.OrcWarlord
				}, false, 35);
				i = ++i;
			}	

			for( local i = 0; i < 1; i = i )
			{
				this.Const.World.Common.addTroop(this, {
					Type = this.Const.World.Spawn.Troops.crOrcWarlock
				}, false, 100);
				i = ++i;
			}
		}	
	}	

	function onDropLootForPlayer( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropArmorParts(this.Math.rand(25, 50), _lootTable);
		this.dropMedicine(this.Math.rand(0, 6), _lootTable);
		this.dropFood(this.Math.rand(4, 8), [
			"strange_meat_item"
		], _lootTable);
		this.dropTreasure(this.Math.rand(3, 4), [
			"trade/furs_item",
			"trade/furs_item",
			"trade/uncut_gems_item",
			"trade/dies_item",
			"loot/white_pearls_item"
		], _lootTable);
	}

	function onInit()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("world_orc_camp_04");
	}

});

