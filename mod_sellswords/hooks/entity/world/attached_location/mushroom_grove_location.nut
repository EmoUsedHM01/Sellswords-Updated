::mods_hookExactClass("entity/world/attached_location/mushroom_grove_location", function(o) {
	local ws_onUpdateShopList = o.onUpdateShopList;
	o.onUpdateShopList = function( _id, _list )
	{
		local before = _list.len();

		ws_onUpdateShopList(_id, _list);

		local after = _list.len();

		if (before < after)
		{
			for (local i = after - 1; i >= before; --i)
			{
				switch(_list[i].S)
				{
				case "supplies/pickled_mushrooms_item":
					_list[i].P += 1.1;
					break;

				case "accessory/berserker_mushrooms_item":
				case "accessory/legend_apothecary_mushrooms_item":
					_list[i].R += 10;
					break;
				}
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
					R = 60,
					P = 2.1,
					S = "supplies/salad_item"
				},
				{
					R = 70 * raritymod,
					P = 1.4,
					S = "accessory/berserker_mushrooms_item"
				},
				{
					R = 80 * raritymod,
					P = 1.6,
					S = "accessory/berserker_mushrooms_item"
				},
				{
					R = 90 * raritymod,
					P = 1.8,
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
})
