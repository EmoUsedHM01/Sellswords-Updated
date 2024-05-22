::mods_hookExactClass("factions/actions/build_undead_camp_action", function ( o )
{
	o.onExecute = function ( _faction )
	{
		local camp;
		local r = this.Math.rand(1, 100);
		local dc = this.World.getTime().Days;
		dc = this.Math.min(this.Math.floor(dc/40), 6);				

		if (r <= 13 - dc)     //13-7
		{
			local tile;

			if (this.World.FactionManager.isUndeadScourge())
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
					this.Const.World.TerrainType.Mountains,
					this.Const.World.TerrainType.Desert,
					this.Const.World.TerrainType.Oasis
				], 8, 16, 1000, 7, 7, null, this.Const.DLC.Desert ? 0.2 : 0.0);
			}
			else
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
					this.Const.World.TerrainType.Mountains,
					this.Const.World.TerrainType.Desert,
					this.Const.World.TerrainType.Oasis
				], 8, 16, 1000, 7, 7, null, this.Const.DLC.Desert ? 0.2 : 0.0);
			}

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/undead_crypt_location", tile.Coords);  //180
			}
		}
		else if (r <= 25)   //12-18
		{
			local tile;

			if (this.World.FactionManager.isUndeadScourge())
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
					this.Const.World.TerrainType.Mountains
				], 12, 30, 1000, 7, 7, null, 0.0, this.Const.DLC.Desert ? 0.9 : 1.0);
			}
			else
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
					this.Const.World.TerrainType.Mountains
				], 12, 1000, 1000, 7, 7, null, 0.0, this.Const.DLC.Desert ? 0.9 : 1.0);
			}

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/undead_mass_grave_location", tile.Coords);   //200
			}
		}
		else if (r <= 37 - dc) //12-6
		{
			local tile;

			if (this.World.FactionManager.isUndeadScourge())
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
					this.Const.World.TerrainType.Mountains
				], 8, 20);
			}
			else
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
					this.Const.World.TerrainType.Mountains
				], 10, 30);
			}

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/undead_ruins_location", tile.Coords);    //180
			}
		}
		else if (r <= 50 - dc) //13-13
		{
			local tile;

			if (this.World.FactionManager.isUndeadScourge())
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
					this.Const.World.TerrainType.Mountains
				], 15, 25, 1000, 7, 7, null, 0.0, this.Const.DLC.Desert ? 0.9 : 1.0);
			}
			else
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
					this.Const.World.TerrainType.Mountains
				], 15, 25, 1000, 7, 7, null, 0.0, this.Const.DLC.Desert ? 0.9 : 1.0);
			}

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/undead_vampire_coven_location", tile.Coords);   //250
			}
		}
		else if (r <= 62 + 2 * dc)  //12-30
		{
			local disallowTerrain = [];

			for( local i = 0; i != this.Const.World.TerrainType.COUNT; i = ++i )
			{
				if (i != this.Const.World.TerrainType.Snow && i != this.Const.World.TerrainType.Tundra)
				{
					disallowTerrain.push(i);
				}
			}

			local tile;

			if (this.World.FactionManager.isUndeadScourge())
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, disallowTerrain, 18, 30);
			}
			else
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, disallowTerrain, 20, 1000);
			}

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/undead_buried_castle_location", tile.Coords);   //350
			}
		}
		else if (r <= 75 + dc)   //13-7
		{
			local disallowTerrain = [];

			for( local i = 0; i != this.Const.World.TerrainType.COUNT; i = ++i )
			{
				if (i == this.Const.World.TerrainType.Desert)
				{
				}
				else
				{
					disallowTerrain.push(i);
				}
			}

			local tile;

			if (this.World.FactionManager.isUndeadScourge())
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, disallowTerrain, 8, 20);
			}
			else
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, disallowTerrain, 10, 30);
			}

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/undead_ruins_location", tile.Coords);       //180
			}
		}
		else if (r <= 87 + dc)  //12-12
		{
			local disallowTerrain = [];

			for( local i = 0; i != this.Const.World.TerrainType.COUNT; i = ++i )
			{
				if (i == this.Const.World.TerrainType.Desert)
				{
				}
				else
				{
					disallowTerrain.push(i);
				}
			}

			local tile;

			if (this.World.FactionManager.isUndeadScourge())
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, disallowTerrain, 11, 25, 1000, 7, 7);
			}
			else
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, disallowTerrain, 12, 25, 1000, 7, 7);
			}

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/undead_vampire_coven_location", tile.Coords);   //250
			}
		}
		else if (r <= 100)  //13-7
		{
			local disallowTerrain = [];

			for( local i = 0; i != this.Const.World.TerrainType.COUNT; i = ++i )
			{
				if (i == this.Const.World.TerrainType.Desert)
				{
				}
				else
				{
					disallowTerrain.push(i);
				}
			}

			local tile;

			if (this.World.FactionManager.isUndeadScourge())
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, disallowTerrain, 11, 30, 1000, 7, 7);
			}
			else
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, disallowTerrain, 12, 1000, 1000, 7, 7);
			}

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/undead_mass_grave_location", tile.Coords);    //200
			}
		}

		if (camp != null)
		{
			local banner = this.getAppropriateBanner(camp, _faction.getSettlements(), 15, this.Const.UndeadBanners);
			camp.onSpawned();
			camp.setBanner(banner);
			_faction.addSettlement(camp, false);
		}		
	};
});		