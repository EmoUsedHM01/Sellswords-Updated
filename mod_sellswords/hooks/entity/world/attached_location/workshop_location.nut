::Mod_Sellswords.HooksMod.hook("scripts/entity/world/attached_location/workshop_location", function(q)
{
	q.onUpdateShopList = @(__original) function( _id, _list )
	{
		__original(_id, _list);

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
});
