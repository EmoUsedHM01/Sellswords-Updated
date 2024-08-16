this.dryad_tree_location <- ::inherit("scripts/entity/world/location", {
	m = {},
	function getDescription()
	{
		return "An immensely tall ash tree. You can see things climbing between the giant branches as you gaze from afar.";
	}

	function create()
	{
		this.location.create();
		this.m.Name = "Yggdrasil";
		this.m.TypeID = "location.dryad_tree";
		this.m.LocationType = ::Const.World.LocationType.Lair | ::Const.World.LocationType.Unique;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = false;
		this.m.IsAttackable = true;
		this.m.VisibilityMult = 1.0;
		this.m.Resources = 500;
		this.m.OnEnter = "event.location.dryad_tree_enter";
	}

	function onSpawned()
	{
		::logInfo("Built Legendary Dryad location");
		this.location.onSpawned();
	}

	function onDiscovered()
	{
		this.location.onDiscovered();
		::World.Flags.increment("LegendaryLocationsDiscovered", 1);

		if (::World.Flags.get("LegendaryLocationsDiscovered") >= 10)
			this.updateAchievement("FamedExplorer", 1, 1);
	}

	function onDropLootForPlayer( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(::Math.rand(0, 0), _lootTable);
		this.dropTreasure(::Math.rand(8, 12), [
			"misc/legend_ancient_green_wood_item",
			"misc/glowing_resin_item",
			"misc/heart_of_the_forest_item",
			"misc/ancient_wood_item",
			"misc/legend_ancient_scroll_item"
		], _lootTable);
	}

	function onInit()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("world_dryad_legendary_location");
	}

});