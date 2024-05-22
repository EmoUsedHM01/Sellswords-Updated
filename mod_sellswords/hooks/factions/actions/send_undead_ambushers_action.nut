::mods_hookExactClass("factions/actions/send_undead_ambushers_action", function ( o )
{
	o.onExecute = function ( _faction )
	{
		local settlements = [];

		foreach( s in _faction.getSettlements() )
		{
			if (s.getLastSpawnTime() + this.m.timeBetweenSpawnsPerSettlement > this.Time.getVirtualTimeF() || s.getFlags().get("isContractLocation")) //use to prevent patrols on camps that are marked by contracts.
			{
				continue;
			}

			settlements.push({
				D = s,
				P = 10
			});
		}

		if (settlements.len() == 0)
		{
			return;
		}

		local settlement = this.pickWeightedRandom(settlements);
		settlement.setLastSpawnTimeToNow();
		local mult = this.World.FactionManager.isUndeadScourge() ? 1.1 : 1.0;

		if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			mult = this.World.FactionManager.isUndeadScourge() ? 1.2 : 1.0;
		}

		local rand = this.Math.rand(75, 120);
		local distanceToNextSettlement = this.getDistanceToSettlements(settlement.getTile());

		rand = rand * (distanceToNextSettlement / 14.0);
		
		local dc = this.World.getTime().Days;
		dc = this.Math.min(dc, 300);
		local party;
		if (dc < 150)
		{
		    party = _faction.spawnEntity(settlement.getTile(), "Undead", false, this.Const.World.Spawn.UndeadScourge, rand * this.getScaledDifficultyMult() * mult);
		}
		if (dc >= 150)
		{
		    party = _faction.spawnEntity(settlement.getTile(), "Undead", false, this.Const.World.Spawn.UndeadScourgeenhanced, rand * this.getScaledDifficultyMult() * mult);		
		}		
		party.getSprite("banner").setBrush(settlement.getBanner());
		party.setDescription("A legion of walking dead, back to claim from the living what was once theirs.");
		party.setFootprintType(this.Const.World.FootprintsType.Undead);
		party.setSlowerAtNight(false);
		party.setUsingGlobalVision(false);
		party.setLooting(false);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().ArmorParts = this.Math.rand(0, 15);
		local r = this.Math.rand(1, 3);

		if (r == 1)
		{
			party.addToInventory("loot/signet_ring_item");
		}

		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		local ambush = this.new("scripts/ai/world/orders/ambush_order");
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(settlement.getTile());
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(ambush);
		c.addOrder(move);
		c.addOrder(despawn);
		return true;
	}
	
});	