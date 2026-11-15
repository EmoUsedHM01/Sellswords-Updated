// SSU legendary locations
// Legends now builds every entry of this table once per campaign and retries the ones it could not place
::Legends.World.LegendaryLocations.SsuSellswordTower <- {
	ID = "location.crss_camp",
	Script = "scripts/entity/world/locations/ssu_ss_camp_location",
	AllowedTerrainTypes = [
		::Const.World.TerrainType.Forest,
		::Const.World.TerrainType.LeaveForest,
		::Const.World.TerrainType.AutumnForest
	],
	MinDistToSettlements = 30,
	OnSpawned = function( _action, _camp, _tile )
	{
		local faction = ::World.FactionManager.getFactionOfType(::Const.FactionType.FreeCompany);
		local banner = ::Const.PlayerBanners[::Math.rand(0, ::Const.PlayerBanners.len() - 1)];
		_camp.setBanner(banner);
		faction.addSettlement(_camp, false);
	}
};

::Legends.World.LegendaryLocations.SsuOrcFortress <- {
	ID = "location.crorc_fortress",
	Script = "scripts/entity/world/locations/ssu_orc_fortress_location",
	MinDistToSettlements = 30,
	OnSpawned = function( _action, _camp, _tile )
	{
		local orcs = ::World.FactionManager.getFactionOfType(::Const.FactionType.Orcs);
		local banner = _action.getAppropriateBanner(_camp, orcs.getSettlements(), 15, ::Const.OrcBanners);
		_camp.setBanner(banner);
		orcs.addSettlement(_camp, false);
	}
};

::Legends.World.LegendaryLocations.SsuUndeadStronghold <- {
	ID = "location.kriegsgeist_castle",
	Script = "scripts/entity/world/locations/ssu_necro_kriegsgeist_location",
	MinDistToSettlements = 30
};

::Legends.World.LegendaryLocations.SsuDryadTree <- {
	ID = "location.dryad_tree",
	Script = "scripts/entity/world/locations/ssu_dryad_tree_location",
	AllowedTerrainTypes = [
		::Const.World.TerrainType.Forest,
		::Const.World.TerrainType.LeaveForest,
		::Const.World.TerrainType.AutumnForest
	],
	MinDistToSettlements = 40
};

::Legends.World.LegendaryLocations.Order.extend([
	"SsuSellswordTower",
	"SsuOrcFortress",
	"SsuUndeadStronghold",
	"SsuDryadTree"
]);
