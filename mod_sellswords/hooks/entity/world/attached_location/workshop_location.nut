::mods_hookExactClass("entity/world/attached_location/workshop_location", function(o) {
	local ws_onUpdateShopList = o.onUpdateShopList;
	o.onUpdateShopList = function( _id, _list )
	{
		ws_onUpdateShopList(_id, _list);

		if (_id == "building.marketplace")
		{
			for (local i = 0; i < 3; ++i)
			{
				_list.push({
					R = 50,
					P = 1.0,
					S = "tools/throwing_net"
				});	
			}
		}
	}

})
