::mods_hookExactClass("factions/actions/send_caravan_action", function ( o )
{
	o.onExecute = function ( _faction )
	{
		local party;
		local z = this.Math.rand(1, 100);
		local y;
		local dc = 10;
		
		if (this.World.getTime().Days >= 75)
		{
			dc += 10;
			if (this.World.getTime().Days >= 150)
			{
				dc += 10;
				if (this.World.getTime().Days >= 225)
				{
					dc += 10;
					if (this.World.getTime().Days >= 300)
					{
						dc += 10;
					}					
				}				
			}
		}
		   

		if (_faction.hasTrait(this.Const.FactionTrait.OrientalCityState))
		{
		    if (z > 75)
			{
				party = _faction.spawnEntity(this.m.Start.getTile(), "Trading Convoy", false, this.Const.World.Spawn.CaravanSouthernwithSellswords, 50 + this.m.Start.getResources() * (80 + dc) * 0.01 + 7 * dc);			
				y = 2 + 0.03 * dc;
			}
			else if (z > 0)
			{
				party = _faction.spawnEntity(this.m.Start.getTile(), "Trading Caravan", false, this.Const.World.Spawn.CaravanSouthern, this.m.Start.getResources() * 0.6 + 5 * dc);
				y = 1 + 0.01 * dc;
			}			
		}
		else
		{
		    if (z > 75)
			{
				party = _faction.spawnEntity(this.m.Start.getTile(), "Trading Convoy", false, this.Const.World.Spawn.CaravanwithSellswords, 50 + this.m.Start.getResources() * (60 + dc) * 0.01 + 7 * dc);
				y = 2 + 0.03 * dc;
			}
			else if (z > 60)
			{
				party = _faction.spawnEntity(this.m.Start.getTile(), "Trading Caravan", false, this.Const.World.Spawn.Caravan, this.m.Start.getResources() * 0.5 + 6 * dc + 50);
				y = 1.5 + 0.01 * dc;
			}			
			else if (z > 0)
			{
				party = _faction.spawnEntity(this.m.Start.getTile(), "Trading Caravan", false, this.Const.World.Spawn.Caravan, this.m.Start.getResources() * 0.5 + 5 * dc);
				y = 1 + 0.01 * dc;
			}			
		}

		party.getSprite("banner").Visible = false;
		party.getSprite("base").Visible = false;
		party.setMirrored(true);
		party.setDescription("A trading caravan from " + this.m.Start.getName() + " that is transporting all manner of goods between settlements.");
		party.setFootprintType(this.Const.World.FootprintsType.Caravan);
		party.getFlags().set("IsCaravan", true);
		party.getFlags().set("IsRandomlySpawned", true);

		if (this.World.Assets.m.IsBrigand && this.m.Start.getTile().getDistanceTo(this.World.State.getPlayer().getTile()) <= 70)
		{
			party.setVisibleInFogOfWar(true);
			party.setImportant(true);
			party.setDiscovered(true);
		}

		if (this.m.Start.getProduce().len() != 0)
		{
			local produce = 3 * y;

			produce = this.Math.max(3 * y, 3 * y + y * this.Math.round(0.025 * this.m.Start.getResources()));

			for( local j = 0; j < produce; j = j )
			{
				party.addToInventory(this.m.Start.getProduce()[this.Math.rand(0, this.m.Start.getProduce().len() - 1)]);
				j = ++j;
			}
		}

		party.getLoot().Money = this.Math.rand(0, 100);

		if (this.Math.rand(1, 100) <= 50)
		{
			party.getLoot().ArmorParts = this.Math.rand(0, 10 * y);
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			party.getLoot().Medicine = this.Math.rand(0, 10 * y);
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			party.getLoot().Ammo = this.Math.rand(0, 25 * y);
		}

		local resources = this.Math.max(1, this.Math.round(0.025 * this.m.Start.getResources()));
		this.m.Start.setResources(this.m.Start.getResources() - resources);
		party.setResources(resources);
		local r = this.Math.rand(1 * y, 3 * y);

		for( local j = 0; j < r; j = j )
		{
			local items = [
				[
					0,
					"supplies/bread_item"
				],
				[
					0,
					"supplies/roots_and_berries_item"
				],
				[
					0,
					"supplies/dried_fruits_item"
				],
				[
					0,
					"supplies/ground_grains_item"
				],
				[
					0,
					"supplies/dried_fish_item"
				],
				[
					0,
					"supplies/beer_item"
				],
				[
					0,
					"supplies/goat_cheese_item"
				],
				[
					1,
					"supplies/legend_fresh_fruit_item"
				],
				[
					1,
					"supplies/legend_fresh_meat_item"
				],
				[
					1,
					"supplies/legend_pie_item"
				],
				[
					1,
					"supplies/legend_porridge_item"
				],
				[
					1,
					"supplies/legend_pudding_item"
				],
				[
					0,
					"supplies/mead_item"
				],
				[
					0,
					"supplies/medicine_item"
				],
				[
					0,
					"supplies/pickled_mushrooms_item"
				],
				[
					0,
					"supplies/preserved_mead_item"
				],
				[
					0,
					"supplies/smoked_ham_item"
				],
				[
					0,
					"supplies/wine_item"
				]
			];
			local item = this.Const.World.Common.pickItem(items);
			party.addToInventory(item);
			j = ++j;
		}

		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(this.m.Dest.getTile());
		move.setRoadsOnly(true);
		local unload = this.new("scripts/ai/world/orders/unload_order");
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(move);
		c.addOrder(unload);
		c.addOrder(despawn);
	};
	
});	