::mods_hookExactClass("factions/actions/send_nomad_roamers_action", function ( o )
{
	o.onExecute = function ( _faction )
	{
		local settlements = [];

		foreach( s in _faction.getSettlements() )
		{
			if (s.getLastSpawnTime() + 300.0 > this.Time.getVirtualTimeF())
			{
				continue;
			}

			settlements.push({
				D = s,
				P = 10
			});
		}

		local settlement = this.pickWeightedRandom(settlements);
		settlement.setLastSpawnTimeToNow();
		local party;
		if (this.Math.rand(0, 100) <= 70)
		{
			party = this.getFaction().spawnEntity(settlement.getTile(), "Nomads", false, this.Const.World.Spawn.NomadRoamers, this.Math.min(settlement.getResources(), this.Math.rand(60, 110)));
		}
		else
		{
			party = this.getFaction().spawnEntity(settlement.getTile(), "Manhunters", false, this.Const.World.Spawn.Manhunters, this.Math.min(settlement.getResources(), this.Math.rand(100, 160)));
		}		
		party.getSprite("banner").setBrush(settlement.getBanner());
		party.setDescription("A band of nomads scouting the area.");
		party.setFootprintType(this.Const.World.FootprintsType.Nomads);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().Money = this.Math.rand(0, 100);
		party.getLoot().ArmorParts = this.Math.rand(0, 5);
		party.getLoot().Medicine = this.Math.rand(0, 3);
		party.getLoot().Ammo = this.Math.rand(10, 30);
		local numFood = this.Math.rand(1, 2);

		for( local i = 0; i != numFood; i = ++i )
		{
			party.addToInventory("supplies/rice_item");
		}

		local c = party.getController();
		local roam = this.new("scripts/ai/world/orders/roam_order");
		roam.setAllTerrainAvailable();
		roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
		roam.setTerrain(this.Const.World.TerrainType.Mountains, false);
		roam.setPivot(settlement);
		roam.setAvoidHeat(true);
		roam.setTime(this.World.getTime().SecondsPerDay * 2);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(settlement.getTile());
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(roam);
		c.addOrder(move);
		c.addOrder(despawn);
		return true;
	};
	
});	