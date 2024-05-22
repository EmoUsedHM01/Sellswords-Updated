::mods_hookExactClass("factions/actions/send_supplies_action", function ( o )
{
	o.onExecute = function ( _faction )
	{
		local spawnParty = this.Const.World.Spawn.NobleCaravan;
		local r = this.Math.rand(1, 100);
		local z;

		if (r > 85)
		{
			spawnParty = this.Const.World.Spawn.MercenariesLOW;
			z = 1; 
		}
		else if (r > 75)
		{
			spawnParty = this.Const.World.Spawn.NobleCaravanwithSellswords;
			z = 3;
		}		
		else if (r > 50)
		{
			spawnParty = this.Const.World.Spawn.MixedNobleCaravan;
			z = 2;
		}
		else if (r > 0)
		{
			z = 1;
		}		

		r = this.Math.rand(100, 200) * 0.01;
		local party = _faction.spawnEntity(this.m.Start.getTile(), "Supply Caravan", false, spawnParty, r * 100 + (0.25 * z + 0.75) * this.Math.round(0.1 * this.m.Start.getResources()));
		party.getSprite("body").setBrush(this.Const.World.Spawn.NobleCaravan.Body);
		party.getSprite("base").Visible = false;
		party.setMirrored(true);
		party.setDescription("A caravan with armed escorts transporting provisions, supplies and equipment between settlements.");
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
			local produce = 3 * z;

			produce = this.Math.max(3 * z, 3 * z + z * this.Math.round(0.05 * this.m.Start.getResources()));

			for( local j = 0; j < produce; j = j )
			{
				party.addToInventory(this.m.Start.getProduce()[this.Math.rand(0, this.m.Start.getProduce().len() - 1)]);
				j = ++j;
			}
		}

		party.getLoot().Money = this.Math.floor(this.Math.rand(0, 100) * r);
		local r = this.Math.rand(1, 3);

		if (r == 1)
		{
			party.getLoot().ArmorParts = this.Math.rand(15 * r * z, 30 * r * z);
		}
		else if (r == 2)
		{
			party.getLoot().Medicine = this.Math.rand(10 * r * z, 20 * r * z);
		}
		else if (r == 3)
		{
			party.getLoot().Ammo = this.Math.rand(25 * r * z, 50 * r * z);
		}

		local resources = this.Math.max(1, this.Math.round(0.05 * this.m.Start.getResources()));
		this.m.Start.setResources(this.m.Start.getResources() - resources);
		party.setResources(resources);
		local r = this.Math.rand(3 * z , 6 * z);

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