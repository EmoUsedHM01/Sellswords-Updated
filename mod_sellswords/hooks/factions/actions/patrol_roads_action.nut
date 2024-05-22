::mods_hookExactClass("factions/actions/patrol_roads_action", function ( o )
{
	o.onExecute = function ( _faction )
	{
		local waypoints = [];

		for( local i = 0; i != 3; i = ++i )
		{
			local idx = this.Math.rand(0, this.m.Settlements.len() - 1);
			local wp = this.m.Settlements[idx];
			this.m.Settlements.remove(idx);
			waypoints.push(wp);
		}

		local r;
		local party;
		local z = this.Math.rand(1, 100);
		local dc = this.World.getTime().Days;
		dc = this.Math.min(dc, 250);
        if (z > 83)
        {		
			party = this.getFaction().spawnEntity(waypoints[0].getTile(), waypoints[0].getName() + " Noble man-at-arms", true, this.Const.World.Spawn.Noblewithbaron, this.Math.rand(180 + 0.4 * dc, 375) * this.getReputationToDifficultyLightMult());
			party.getSprite("body").setBrush("figure_player_noble");
			party.setDescription("Soldiers typically well-versed in the use of arms and served as a fully armoured heavy cavalryman.");
			party.setFootprintType(this.Const.World.FootprintsType.Nobles);
			party.getFlags().set("IsRandomlySpawned", true);
			party.getLoot().Money = this.Math.rand(500, 2000);
			party.getLoot().ArmorParts = this.Math.rand(20, 60);
			party.getLoot().Medicine = this.Math.rand(2, 6);
			party.getLoot().Ammo = this.Math.rand(20, 60);
			r = this.Math.rand(1, 4);
		}
		
		else if (z > 0)
        {		
			party = this.getFaction().spawnEntity(waypoints[0].getTile(), waypoints[0].getName() + " Company", true, this.Const.World.Spawn.Noble, this.Math.rand(120 + 0.4 * dc, 250) * this.getReputationToDifficultyLightMult());
			party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + _faction.getBannerString());
			party.setDescription("Professional soldiers in service to local lords.");
			party.setFootprintType(this.Const.World.FootprintsType.Nobles);
			party.getFlags().set("IsRandomlySpawned", true);
			party.getLoot().Money = this.Math.rand(50, 200);
			party.getLoot().ArmorParts = this.Math.rand(0, 25);
			party.getLoot().Medicine = this.Math.rand(0, 3);
			party.getLoot().Ammo = this.Math.rand(0, 30);
			r = this.Math.rand(1, 4);
		}		
		
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

		local c = party.getController();
		local move1 = this.new("scripts/ai/world/orders/move_order");
		move1.setRoadsOnly(true);
		move1.setDestination(waypoints[1].getTile());
		local wait1 = this.new("scripts/ai/world/orders/wait_order");
		wait1.setTime(20.0);
		local move2 = this.new("scripts/ai/world/orders/move_order");
		move2.setRoadsOnly(true);
		move2.setDestination(waypoints[2].getTile());
		local wait2 = this.new("scripts/ai/world/orders/wait_order");
		wait2.setTime(20.0);
		local move3 = this.new("scripts/ai/world/orders/move_order");
		move3.setRoadsOnly(true);
		move3.setDestination(waypoints[0].getTile());
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(move1);
		c.addOrder(wait1);
		c.addOrder(move2);
		c.addOrder(wait2);
		c.addOrder(move3);
		c.addOrder(despawn);
		this.m.Cooldown = this.World.FactionManager.isGreaterEvil() ? 200.0 : 400.0;
		return true;
	};
	
});	