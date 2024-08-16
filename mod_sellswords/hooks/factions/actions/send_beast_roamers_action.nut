::Mod_Sellswords.HooksMod.hook("scripts/factions/actions/send_beast_roamers_action", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		local beast;
		beast = function ( _action, _nearTile = null )
		{
			if (this.World.getTime().Days < 25 && _nearTile == null)
				return false;

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

			local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 20 - (_nearTile == null ? 0 : 11), 100, 1000, 3, 0, _nearTile, 0.1, 0.9);

			if (tile == null)
				return false;

			if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
				return false;

			local distanceToNextSettlement = _action.getDistanceToSettlements(tile);

			if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue())
				distanceToNextSettlement = distanceToNextSettlement * 2;

			local party = _action.getFaction().spawnEntity(tile, "Dryads", false, this.Const.World.Spawn.Dryads, this.Math.rand(80, 120) * _action.getScaledDifficultyMult() * this.Math.maxf(0.7, this.Math.minf(1.5, distanceToNextSettlement / 14.0)));
			party.getSprite("banner").setBrush("banner_beasts_01");
			party.setDescription("A group of Dryads, a blend between tree and man, patrolling the woods, protecting their ancient groves.");
			party.setFootprintType(this.Const.World.FootprintsType.Schrats);
			party.setSlowerAtNight(false);
			party.setUsingGlobalVision(false);
			party.setLooting(false);

			local roam = this.new("scripts/ai/world/orders/roam_order");
			roam.setNoTerrainAvailable();
			roam.setTerrain(this.Const.World.TerrainType.Forest, true);
			roam.setTerrain(this.Const.World.TerrainType.LeaveForest, true);
			roam.setTerrain(this.Const.World.TerrainType.AutumnForest, true);

			local r = this.Math.rand(1, 20);
			if (r == 1)
			{
				roam.setTerrain(this.Const.World.TerrainType.SnowyForest, true);
				roam.setTerrain(this.Const.World.TerrainType.SwampForest, true);
			}
			else if (r == 2)
			{
				roam.setTerrain(this.Const.World.TerrainType.SwampForest, true);
				roam.setTerrain(this.Const.World.TerrainType.SwampGreen, true);
			}
			else if (r == 3)
			{
				roam.setTerrain(this.Const.World.TerrainType.SnowyForest, true);
			}
			else if (r == 4)
			{
				roam.setTerrain(this.Const.World.TerrainType.SwampForest, true);
			}

			roam.setMinRange(1);
			roam.setMaxRange(4);
			party.getController().addOrder(roam);
			return true;
		};
		this.m.Options.push(beast);
		this.m.BeastsMedium.push(beast);
	}

});