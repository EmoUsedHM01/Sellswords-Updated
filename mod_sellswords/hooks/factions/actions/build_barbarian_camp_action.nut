::mods_hookExactClass("factions/actions/build_barbarian_camp_action", function ( o )
{
	o.onExecute = function ( _faction )
	{
		local camp;
		local r = this.Math.rand(1, 100);
		local dc = this.World.getTime().Days;
		dc = this.Math.min(this.Math.floor(dc/15), 16);				

		if (r <= 33 - 1.5 * dc)
		{
			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
				this.Const.World.TerrainType.Mountains
			], 7, 20, 1000, 7, 7, null, 0.75);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/barbarian_shelter_location", tile.Coords);
			}
		}
		else if (r <= 66 - dc)
		{
			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
				this.Const.World.TerrainType.Mountains
			], 9, 25, 1000, 7, 7, null, 0.75);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/barbarian_camp_location", tile.Coords);
			}
		}
		else if (r <= 100)
		{
			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
				this.Const.World.TerrainType.Mountains
			], 13, 35, 1000, 7, 7, null, 0.75);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/barbarian_sanctuary_location", tile.Coords);
			}
		}

		if (camp != null)
		{
			local banner = this.getAppropriateBanner(camp, _faction.getSettlements(), 15, this.Const.BarbarianBanners);
			camp.onSpawned();
			camp.setBanner(banner);
			_faction.addSettlement(camp, false);
		}		
	};
});	