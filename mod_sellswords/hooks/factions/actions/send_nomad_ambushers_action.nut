::mods_hookExactClass("factions/actions/send_nomad_ambushers_action", function ( o )
{
	o.onExecute = function ( _faction )
	{
		local settlements = [];

		foreach( s in _faction.getSettlements() )
		{
			if (s.getResources() == 0)
			{
				continue;
			}

			if (s.getLastSpawnTime() + 150.0 > this.Time.getVirtualTimeF())
			{
				continue;
			}

			local activeContract = this.World.Contracts.getActiveContract();
			if (activeContract != null && "Destination" in activeContract.m && activeContract.m.Destination == s)
			{
				continue;
			}

			settlements.push({
				D = s,
				P = 10
			});
		}

		local settlement = this.pickWeightedRandom(settlements);
		local mult = 1;
		settlement.setLastSpawnTimeToNow();
		
		local distanceToNextSettlement = this.getDistanceToSettlements(settlement.getTile());

		mult = mult * this.Math.max(distanceToNextSettlement / 28.0, 1);		
		
		local z = this.Math.rand(1, 100);
		local party;
		local dc = 10;
		
		if (this.World.getTime().Days >= 50)
		{
			dc += 10;
			if (this.World.getTime().Days >= 100)
			{
				dc += 7;
				if (this.World.getTime().Days >= 150)
				{
					dc += 8;
				}				
			}
		}
		
        if (z > dc)
		{		
			party = this.getFaction().spawnEntity(settlement.getTile(), "Nomads", false, this.Const.World.Spawn.NomadRaiders, this.Math.rand(80, 135) * this.getReputationToDifficultyLightMult());
		}	
		else if (z > 0.33 * dc)			
		{		
			party = this.getFaction().spawnEntity(settlement.getTile(), "Hashshashins", false, this.Const.World.Spawn.Hashshashins, (this.Math.rand(50, 60) + dc * 2.5) * this.getReputationToDifficultyLightMult());
		}	
		else if (z > 0)			
		{		
			party = this.getFaction().spawnEntity(settlement.getTile(), "Manhunters", false, this.Const.World.Spawn.Manhunters, this.Math.rand(80, 135) * this.getReputationToDifficultyLightMult());
		}		
		party.getSprite("banner").setBrush(settlement.getBanner());
		party.setDescription("A band of desert raiders preying on anyone trying to cross the seas of sand.");
		party.setFootprintType(this.Const.World.FootprintsType.Nomads);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().Money = this.Math.rand(50, 200);
		party.getLoot().ArmorParts = this.Math.rand(0, 10);
		party.getLoot().Medicine = this.Math.rand(0, 2);
		party.getLoot().Ammo = this.Math.rand(0, 20);
		local r = this.Math.rand(1, 4);

		if (r == 1)
		{
			party.addToInventory("supplies/bread_item");
		}
		else if (r == 2)
		{
			party.addToInventory("supplies/dates_item");
		}
		else if (r == 3)
		{
			party.addToInventory("supplies/rice_item");
		}
		else if (r == 4)
		{
			party.addToInventory("supplies/dried_lamb_item");
		}

		local c = party.getController();
		local ambush = this.new("scripts/ai/world/orders/ambush_order");
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(settlement.getTile());
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(ambush);
		c.addOrder(move);
		c.addOrder(despawn);
		return true;
	};
	
});	