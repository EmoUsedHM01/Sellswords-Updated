::mods_hookExactClass("factions/actions/build_goblin_camp_action", function ( o )
{
	o.onExecute = function ( _faction )
	{
		local camp;
		local r;
		local dc = this.World.getTime().Days;
		dc = this.Math.min(this.Math.floor(dc/20), 12);				
		local minY = this.Const.DLC.Desert ? 0.2 : 0.0;

		if (_faction.getSettlements().len() == 0)
		{
			r = 101;
		}
		else if (this.World.FactionManager.isGreenskinInvasion())
		{
			r = this.Math.rand(1, 68);
		}
		else
		{
			r = this.Math.rand(21, 100);
		}

		if (r <= 36 - dc)
		{
			local tile;

			if (this.World.FactionManager.isGreenskinInvasion())
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
					this.Const.World.TerrainType.Mountains
				], 8, 20, 20, 7, 7, null, minY);
			}
			else
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
					this.Const.World.TerrainType.Mountains
				], 15, 1000, 20, 7, 7, null, minY);
			}

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/goblin_camp_location", tile.Coords);
			}
		}
		else if (r <= 52  - 1.33 * dc)
		{
			local tile;

			if (this.World.FactionManager.isGreenskinInvasion())
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
					this.Const.World.TerrainType.Mountains
				], 12, 30, 20, 7, 7, null, minY);
			}
			else
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
					this.Const.World.TerrainType.Mountains
				], 20, 1000, 20, 7, 7, null, minY);
			}

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/goblin_outpost_location", tile.Coords);
			}
		}
		else if (r <= 68 - 1.67 * dc)
		{
			local tile;

			if (this.World.FactionManager.isGreenskinInvasion())
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
					this.Const.World.TerrainType.Mountains
				], 8, 18, 20, 7, 7, null, minY);
			}
			else
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
					this.Const.World.TerrainType.Mountains
				], 14, 30, 20, 7, 7, null, minY);
			}

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/goblin_ruins_location", tile.Coords);
			}
		}
		else if (r <= 84 - 2 * dc)
		{
			local tile;

			if (this.World.FactionManager.isGreenskinInvasion())
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
					this.Const.World.TerrainType.Mountains
				], 6, 14, 30, 7, 7, null, minY);
			}
			else
			{
				tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
					this.Const.World.TerrainType.Mountains
				], 10, 20, 30, 7, 7, null, minY);
			}

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/goblin_hideout_location", tile.Coords);
			}
		}
		else if (r <= 101)
		{
			local disallowedTerrain = [];

			for( local i = 0; i != this.Const.World.TerrainType.COUNT; i = ++i )
			{
				if (i == this.Const.World.TerrainType.Mountains || i == this.Const.World.TerrainType.Hills)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}
			}

			local tile;

			if (this.World.FactionManager.isGreenskinInvasion())
			{
				tile = this.getTileToSpawnLocation(r == 6 ? 1000 : this.Const.Factions.BuildCampTries, disallowedTerrain, 20, 40, 20, minY);
			}
			else
			{
				tile = this.getTileToSpawnLocation(r == 6 ? 1000 : this.Const.Factions.BuildCampTries, disallowedTerrain, 25, 1000, 20, minY);
			}

			if (tile != null && _faction.getSettlements().len() == 0)
			{
				local orcs = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getSettlements();

				foreach( s in orcs )
				{
					if (s.getTile().getDistanceTo(tile) <= 25)
					{
						return;
					}
				}
			}

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/goblin_settlement_location", tile.Coords);
			}
		}

		if (camp != null)
		{
			local banner = this.getAppropriateBanner(camp, _faction.getSettlements(), 15, this.Const.GoblinBanners);
			camp.onSpawned();
			camp.setBanner(banner);
			_faction.addSettlement(camp, false);
		}		
	};
});	