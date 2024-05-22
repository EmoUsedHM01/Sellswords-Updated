::mods_hookExactClass("factions/actions/send_bandit_ambushers_action", function ( o )
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

			if (s.getLastSpawnTime() + this.m.timeBetweenSpawnsPerSettlement > this.Time.getVirtualTimeF() || s.getFlags().get("isContractLocation")) //use to prevent patrols on camps that are marked by contracts.
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
		local mult = this.World.FactionManager.isCivilWar() ? 1.1 : 1.0;
		local distanceToNextSettlement = this.getDistanceToSettlements(settlement.getTile());
		settlement.setLastSpawnTimeToNow();

		if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			local mult = this.World.FactionManager.isCivilWar() ? 1.2 : 1.0;
		}
		
		if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue() && distanceToNextSettlement > 14)
		{
			mult *= distanceToNextSettlement / 14;
		}

		mult = mult * this.Math.max(distanceToNextSettlement / 14.0, distanceToNextSettlement / 28.0 + 1.5);

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
					dc += 6;
				}				
			}
		}
		
        if (z > dc)
		{
			party = this.getFaction().spawnEntity(settlement.getTile(), "Brigands", false, this.Const.World.Spawn.BanditRaiders, this.Math.rand(75, 120) * this.getScaledDifficultyMult() * mult);
		}
		else if (z > 0)		
		{
			party = this.getFaction().spawnEntity(settlement.getTile(), "Desperados", false, this.Const.World.Spawn.Desperados, (this.Math.rand(60, 90) + dc * 2) * this.getScaledDifficultyMult() * mult);
		}		
		
		party.getSprite("banner").setBrush(settlement.getBanner());
		party.setDescription("A rough and tough band of brigands preying on the weak.");
		party.setFootprintType(this.Const.World.FootprintsType.Brigands);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().Money = this.Math.rand(50, 200);
		party.getLoot().ArmorParts = this.Math.rand(0, 10);
		party.getLoot().Medicine = this.Math.rand(0, 2);
		party.getLoot().Ammo = this.Math.rand(0, 20);
		local r = this.Math.rand(1, 6);

		if (r == 1)
		{
			party.addToInventory("supplies/bread_item");
		}
		else if (r == 2)
		{
			party.addToInventory("supplies/roots_and_berries_item");
		}
		else if (r == 3)
		{
			party.addToInventory("supplies/dried_fruits_item");
		}
		else if (r == 4)
		{
			party.addToInventory("supplies/ground_grains_item");
		}
		else if (r == 5)
		{
			party.addToInventory("supplies/pickled_mushrooms_item");
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