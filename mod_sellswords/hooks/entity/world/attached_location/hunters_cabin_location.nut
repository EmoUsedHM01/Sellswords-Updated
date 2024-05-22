::mods_hookExactClass("entity/world/attached_location/hunters_cabin_location", function(o) {
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
				case "supplies/cured_venison_item":
					_list[i].P += 1.1;
					break;

				case "supplies/legend_fresh_meat_item":
					_list[i].P += 0.9;
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
})
