::mods_hookExactClass("factions/actions/build_bandit_camp_action", function ( o )
{
	o.onExecute = function ( _faction )
	{
		local camp;
		local r = this.Math.rand(1, 100);
		local dc = this.World.getTime().Days;
		dc = this.Math.min(this.Math.floor(dc/25), 10);			
		local minY = this.Const.DLC.Desert ? 0.2 : 0.0;
		local maxY = this.Const.DLC.Wildmen ? 0.75 : 1.0;

		if (r <= 10 - dc)
		{
			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
				this.Const.World.TerrainType.Mountains,
				this.Const.World.TerrainType.Snow
			], 6, 12, 1000, 7, 7, null, minY, maxY);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/bandit_ruins_location", tile.Coords);
			}
		}
		else if (r <= 25)
		{
			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
				this.Const.World.TerrainType.Mountains,
				this.Const.World.TerrainType.Snow
			], 10, 20, 1000, 7, 7, null, minY, maxY);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/crbandit_camp_location", tile.Coords);
			}
		}
		else if (r <= 50 - 0.5 * dc)
		{
			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
				this.Const.World.TerrainType.Mountains,
				this.Const.World.TerrainType.Snow
			], 6, 12, 1000, 7, 7, null, minY, maxY);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/bandit_hideout_location", tile.Coords);
			}
		}
		else if (r <= 75 - 0.5 * dc)
		{
			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
				this.Const.World.TerrainType.Mountains,
				this.Const.World.TerrainType.Snow
			], 10, 20, 1000, 7, 7, null, minY, maxY);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/crbandit_ruins_location", tile.Coords);
			}
		}
		else if (r <= 100)
		{
			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
				this.Const.World.TerrainType.Mountains,
				this.Const.World.TerrainType.Snow
			], 7, 16, 1000, 7, 7, null, minY, maxY);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/bandit_camp_location", tile.Coords);
			}
		}

		if (camp != null)
		{
			local banner = this.getAppropriateBanner(camp, _faction.getSettlements(), 15, this.Const.BanditBanners);
			camp.onSpawned();
			camp.setBanner(banner);
			_faction.addSettlement(camp, false);
		}
	};
});