::mods_hookExactClass("factions/actions/build_unique_locations_action", function (o)
{
	o.m.Buildcrorc_fortress  <- true;
	o.m.Buildcrss_camp  <- true;	
	local updateBuildings = o.updateBuildings;		
	o.updateBuildings = function( )
	{	
		updateBuildings();
		local locations = this.World.EntityManager.getLocations();

		foreach( v in locations )
		{
			if (v.getTypeID() == "location.crorc_fortress")
			{
				this.m.Buildcrorc_fortress = false;
			}
			if (v.getTypeID() == "location.crss_camp")
			{
				this.m.Buildcrss_camp = false;
			}			
		}		
	}
	local onExecute = o.onExecute;		
	o.onExecute = function( _faction )
	{
		onExecute( _faction );
		local camp;
		local distanceToOthers = 15;		
		if (this.m.Buildcrss_camp)
		{
			local disallowedTerrain = [];

			for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = i )
			{
				if (i == this.Const.World.TerrainType.Forest || i == this.Const.World.TerrainType.LeaveForest || i == this.Const.World.TerrainType.AutumnForest)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}

				i = ++i;
			}

			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, disallowedTerrain, 30, 1000, 1001, distanceToOthers, distanceToOthers);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/crss_camp_location", tile.Coords);
			}

			if (camp != null)
			{
				local bandits = this.World.FactionManager.getFactionOfType(this.Const.FactionType.FreeCompany);				
				local banner = this.Const.PlayerBanners[this.Math.rand(0, this.Const.PlayerBanners.len() - 1)];
				camp.onSpawned();
				camp.setBanner(banner);	
				bandits.addSettlement(camp, false);				
			}
		}
		if (this.m.Buildcrorc_fortress)
		{
			local disallowedTerrain = [];

			for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = i )
			{
				i == this.Const.World.TerrainType.Hills || i == this.Const.World.TerrainType.Steppe || i == this.Const.World.TerrainType.Tundra || i;

				if (this.Const.World.TerrainType.Plains)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}

				i = ++i;
			}

			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, disallowedTerrain, 30, 1000, 1001, distanceToOthers, distanceToOthers);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/crorc_fortress_location", tile.Coords);
			}

			if (camp != null)
			{
				local orcs = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs);
				local banner = this.getAppropriateBanner(camp, orcs.getSettlements(), 15, this.Const.OrcBanners);
				camp.onSpawned();
				camp.setBanner(banner);
				orcs.addSettlement(camp, false);			
			}
		}			
	}		
})