::Mod_Sellswords.HooksMod.hook("scripts/entity/world/attached_location/plantation_location", function(q)
{
	q.onUpdateShopList = @(__original) function( _id, _list )
	{
		local before = _list.len();

		__original(_id, _list);

		local after = _list.len();

		if (before < after)
		{
			for (local i = after - 1; i >= before; --i)
			{
				if (_list[i].S != "supplies/dates_item") continue;

				_list[i].P += 1.1;
			}
		}

		if (_id == "building.marketplace")
		{
			local dc = this.World.getTime().Days;
			local raritymod = 1;
			if (dc >= 100)
			{
				raritymod = 0.9;
				if (dc >= 150)
				{	
					raritymod = 0.8;			
					if (dc >= 200)
					{
						raritymod = 0.7;
					}
				}	
			}

			_list.extend([
				{
					R = 20,
					P = 2.4,
					S = "supplies/salad_item"
				},
				{
					R = 80 * raritymod,
					P = 1.2,
					S = "accessory/berserker_mushrooms_item"
				},
				{
					R = 90 * raritymod,
					P = 1.4,
					S = "accessory/berserker_mushrooms_item"
				},
				{
					R = 90 * raritymod,
					P = 1.2,
					S = "accessory/legend_apothecary_mushrooms_item"
				},
			]);
		}
	}
});
