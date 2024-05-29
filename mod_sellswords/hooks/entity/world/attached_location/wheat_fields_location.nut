::Mod_Sellswords.HooksMod.hook("scripts/entity/world/attached_location/wheat_fields_location", function(q)
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
				switch(_list[i].S)
				{
				case "supplies/ground_grains_item":
				case "supplies/legend_porridge_item":
				case "supplies/bread_item":
					_list[i].P += 1.1;
					break;
				}
			}
		}
	}
});
