::Mod_Sellswords.HooksMod.hook("scripts/factions/actions/send_barbarian_roamers_action", function ( q ) {

	q.onExecute = @(__original) function( _faction )
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
		local rand = this.Math.rand(60, 110);
		local distanceToNextSettlement = this.getDistanceToSettlements(settlement.getTile());

		rand = rand * this.Math.max(distanceToNextSettlement / 14.0, distanceToNextSettlement / 28.0 + 1.2);			
		
		local z = this.Math.rand(1, 100);
		local party;
		local dc = 10;
		
		if (this.World.getTime().Days >= 50)
		{
			dc += 10;
			if (this.World.getTime().Days >= 100)
			{
				dc += 10;
				if (this.World.getTime().Days >= 150)
				{
					dc += 10;
				}				
			}
		}	
		
		if (z > 80 - 0.25 * dc)
		{
			party = this.getFaction().spawnEntity(settlement.getTile(), "Barbarians Hunters", false, this.Const.World.Spawn.BarbarianHunters, this.Math.min(settlement.getResources(), rand));
		}				
		else if (z > 0)
		{
			party = this.getFaction().spawnEntity(settlement.getTile(), "Barbarians", false, this.Const.World.Spawn.Barbarians, this.Math.min(settlement.getResources(), rand));
		}
		party.getSprite("banner").setBrush(settlement.getBanner());
		party.setDescription("A band of barbarians out to hunt game.");
		party.setFootprintType(this.Const.World.FootprintsType.Barbarians);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().ArmorParts = this.Math.rand(0, 5);
		party.getLoot().Medicine = this.Math.rand(0, 3);
		party.getLoot().Ammo = this.Math.rand(10, 30);

		if (this.Math.rand(1, 100) <= 25)
		{
			party.addToInventory("loot/bone_figurines_item");
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			party.addToInventory("loot/bead_necklace_item");
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			party.addToInventory("loot/valuable_furs_item");
		}

		local numFood = this.Math.rand(1, 2);

		for( local i = 0; i != numFood; i = i )
		{
			if (this.Math.rand(1, 100) <= 50)
			{
				party.addToInventory("supplies/cured_venison_item");
			}
			else
			{
				party.addToInventory("supplies/roots_and_berries_item");
			}

			i = ++i;
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
