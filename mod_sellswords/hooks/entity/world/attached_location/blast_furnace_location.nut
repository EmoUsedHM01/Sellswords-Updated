::mods_hookExactClass("entity/world/attached_location/blast_furnace_location", function(o) {
	local ws_onUpdateShopList = o.onUpdateShopList;
	o.onUpdateShopList = function( _id, _list )
	{
		ws_onUpdateShopList(_id, _list);

		if (_id == "building.armorsmith")
		{
			_list.extend([
				{
					R = 30,
					P = 1.0,
					S = "armor/crknight_armor"
				},
				{
					R = 30,
					P = 1.0,
					S = "armor/crhedgeknight_armor"
				},
				{
					R = 25,
					P = 1.0,
					S = "helmets/crknight_helmet"
				},
				{
					R = 25,
					P = 1.0,
					S = "helmets/crhedgeknight_helmet"
				},
				{
					R = 85,
					P = 1.0,
					S = "helmets/cr_lion_helm"
				}
			]);
		}
	}
})
