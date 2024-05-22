::mods_hookExactClass("factions/actions/build_zombie_camp_action", function ( o )
{
	o.onExecute = function ( _faction )
	{
		local camp;
		local r = this.Math.rand(1, 100);
		local dc = this.World.getTime().Days;
		dc = this.Math.min(this.Math.floor(dc/40), 5);				
		local minY = this.Const.DLC.Desert ? 0.2 : 0.0;

		if (_faction.getSettlements().len() == 0)
		{
			r = 1;
		}

		if (r <= 20 - dc)
		{
			local tile;

			if (this.World.FactionManager.isUndeadScourge())
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
					this.Const.World.TerrainType.Mountains,
					this.Const.World.TerrainType.Desert,
					this.Const.World.TerrainType.Oasis
				], 5, 11, 1000, 7, 7, null, minY);
			}
			else
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
					this.Const.World.TerrainType.Mountains,
					this.Const.World.TerrainType.Desert,
					this.Const.World.TerrainType.Oasis
				], 5, 11, 1000, 7, 7, null, minY);
			}

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/undead_graveyard_location", tile.Coords);   //130
			}
		}
		else if (r <= 40)
		{
			local tile;

			if (this.World.FactionManager.isUndeadScourge())
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
					this.Const.World.TerrainType.Mountains,
					this.Const.World.TerrainType.Desert,
					this.Const.World.TerrainType.Oasis
				], 8, 16, 1000, 7, 7, null, minY);
			}
			else
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
					this.Const.World.TerrainType.Mountains,
					this.Const.World.TerrainType.Desert,
					this.Const.World.TerrainType.Oasis
				], 8, 16, 1000, 7, 7, null, minY);
			}

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/undead_crypt_location", tile.Coords);    //180
			}
		}
		else if (r <= 60 - 2 * dc)
		{
			local tile;

			if (this.World.FactionManager.isUndeadScourge())
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
					this.Const.World.TerrainType.Mountains,
					this.Const.World.TerrainType.Desert
				], 6, 14, 1000, 7, 7, null, minY);
			}
			else
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
					this.Const.World.TerrainType.Mountains,
					this.Const.World.TerrainType.Desert
				], 7, 20, 1000, 7, 7, null, minY);
			}

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/undead_hideout_location", tile.Coords);  //80
			}
		}
		else if (r <= 80 - dc)
		{
			local tile;

			if (this.World.FactionManager.isUndeadScourge())
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
					this.Const.World.TerrainType.Mountains,
					this.Const.World.TerrainType.Desert
				], 8, 18, 1000, 7, 7, null, minY);
			}
			else
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
					this.Const.World.TerrainType.Mountains,
					this.Const.World.TerrainType.Desert
				], 10, 20, 1000, 7, 7, null, minY);
			}

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/undead_necromancers_lair_location", tile.Coords);    //150
			}
		}
		else if (r <= 100)
		{
			local tile;

			if (this.World.FactionManager.isUndeadScourge())
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
					this.Const.World.TerrainType.Mountains
				], 8, 18, 1000, 7, 7, null, minY);
			}
			else
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
					this.Const.World.TerrainType.Mountains
				], 10, 30, 1000, 7, 7, null, minY);
			}

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/undead_ruins_location", tile.Coords);    //180
			}
		}

		if (camp != null)
		{
			local banner = this.getAppropriateBanner(camp, _faction.getSettlements(), 15, this.Const.ZombieBanners);
			camp.onSpawned();
			camp.setBanner(banner);
			_faction.addSettlement(camp, false);
		}
	};
});	