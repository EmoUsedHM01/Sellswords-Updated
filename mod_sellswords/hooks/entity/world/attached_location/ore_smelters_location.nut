::Mod_Sellswords.HooksMod.hook("scripts/entity/world/attached_location/ore_smelters_location", function(q)
{
	q.onUpdateShopList = @(__original) function( _id, _list )
	{
		__original(_id, _list);

		if (_id == "building.weaponsmith")
		{
			_list.extend([
				{
					R = 60,
					P = 1.0,
					S = "weapons/spontoon03"
				},
				{
					R = 80,
					P = 1.0,
					S = "weapons/crpolehammer"
				},
				{
					R = 80,
					P = 1.0,
					S = "weapons/crlongaxe"
				},
				{
					R = 88,
					P = 1.0,
					S = "weapons/crranged_flail"
				}
			]);
		}
	}
});
