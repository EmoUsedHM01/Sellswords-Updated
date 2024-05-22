::mods_hookExactClass("factions/actions/send_citystate_army_action", function ( o )
{
	o.onExecute = function ( _faction )
	{
		local potential_origins = [];

		foreach( s in _faction.getSettlements() )
		{
			if (s.getLastSpawnTime() + 300.0 > this.Time.getVirtualTimeF())
			{
				continue;
			}

			potential_origins.push({
				D = s,
				P = s.getResources()
			});
		}

		if (potential_origins.len() == 0)
		{
			return;
		}

		local origin = this.pickWeightedRandom(potential_origins);
		local myTile = origin.getTile();
		local spawnpoints = [];
		spawnpoints.push(myTile);

		foreach( a in origin.getAttachedLocations() )
		{
			if (a.isActive() && a.isMilitary())
			{
				spawnpoints.push(a.getTile());
			}
		}

		local activeContract = this.World.Contracts.getActiveContract();
		local settlements = this.World.EntityManager.getSettlements();
		local lowest_distance = 99999;
		local best_settlement;

		foreach( s in settlements )
		{
			if (this.World.FactionManager.isAllied(_faction.getID(), s.getFaction()))
			{
				continue;
			}

			if (activeContract != null && (activeContract.getHome().getID() == s.getID() || activeContract.getOrigin().getID() == s.getID()))
			{
				continue;
			}

			if (s.getActiveAttachedLocations() == 0)
			{
				continue;
			}

			local d = myTile.getDistanceTo(s.getTile());

			if (d <= lowest_distance && !s.isIsolatedFromLocation(origin))
			{
				local skip = true;

				foreach( l in s.getAttachedLocations() )
				{
					if (l.isActive() && l.isUsable())
					{
						skip = false;
						break;
					}
				}

				if (skip)
				{
					continue;
				}

				lowest_distance = d;
				best_settlement = s;
			}
		}

		if (best_settlement == null)
		{
			return;
		}

		local locations = best_settlement.getAttachedLocations();
		local targets = [];

		foreach( l in locations )
		{
			if (l.isActive() && l.isUsable())
			{
				targets.push(l);
			}
		}
		local dc = this.World.getTime().Days;
		dc = this.Math.min(dc, 300);		

		for( local i = 0; i != this.Math.min(2, spawnpoints.len()); i = i )
		{
			local party;
			if (dc < 150)
			{
				party = _faction.spawnEntity(spawnpoints[i], "Regiment of " + _faction.getNameOnly(), true, this.Const.World.Spawn.Southern, this.Math.rand(80, 120) * this.getScaledDifficultyMult());
			}
			else if (dc >= 150)
			{
				party = _faction.spawnEntity(spawnpoints[i], "Regiment of " + _faction.getNameOnly(), true, this.Const.World.Spawn.Southernenhanced, this.Math.rand(80 + 0.1 * dc, 135) * this.getScaledDifficultyMult());
			}			
			party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + _faction.getBannerString());
			party.setDescription("Conscripted soldiers loyal to their city state.");
			party.setFootprintType(this.Const.World.FootprintsType.CityState);
			party.getFlags().set("IsRandomlySpawned", true);
			party.getLoot().Money = this.Math.rand(100, 300);
			party.getLoot().ArmorParts = this.Math.rand(10, 35);
			party.getLoot().Medicine = this.Math.rand(5, 15);
			party.getLoot().Ammo = this.Math.rand(10, 40);
			local r = this.Math.rand(1, 4);

			if (r <= 2)
			{
				party.addToInventory("supplies/rice_item");
			}
			else if (r == 3)
			{
				party.addToInventory("supplies/dates_item");
			}
			else if (r == 4)
			{
				party.addToInventory("supplies/dried_lamb_item");
			}

			local arr = [
				"trade/silk_item",
				"trade/silk_item",
				"trade/incense_item",
				"trade/spices_item"
			];

			for( local i = 0; i < this.Math.round(r / 2); i++ )
			{
				party.addToInventory(arr[r - 1]);
			}

			local c = party.getController();
			local target = targets[this.Math.rand(0, targets.len() - 1)];
			local move = this.new("scripts/ai/world/orders/move_order");
			move.setDestination(target.getTile());
			c.addOrder(move);
			local raid = this.new("scripts/ai/world/orders/raid_order");
			raid.setTime(40.0);
			raid.setTargetTile(target.getTile());
			c.addOrder(raid);
			local back = this.new("scripts/ai/world/orders/move_order");
			back.setDestination(spawnpoints[i]);
			c.addOrder(back);
			local despawn = this.new("scripts/ai/world/orders/despawn_order");
			c.addOrder(despawn);
			i = ++i;
		}

		origin.setLastSpawnTimeToNow();
		return true;
	};
	
});	