::Mod_Sellswords.HooksMod.hook("scripts/entity/world/attached_location/beekeeper_location", function(q)
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
				if (_list[i].S != "supplies/mead_item") continue;

				_list[i].P += 0.75;
			}
		}
	}
});
