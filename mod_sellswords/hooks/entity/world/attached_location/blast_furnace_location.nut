::Mod_Sellswords.HooksMod.hook("scripts/entity/world/attached_location/blast_furnace_location", function(q)
{
	q.onUpdateShopList = @(__original) function( _id, _list )
	{
		__original(_id, _list);

		if (_id == "building.armorsmith")
		{
			_list.extend([
				{
					R = 30,
					P = 1.0,
					S = "armor/ssu_knight_armor"
				},
				{
					R = 30,
					P = 1.0,
					S = "armor/ssu_hedgeknight_armor"
				},
				{
					R = 25,
					P = 1.0,
					S = "helmets/ssu_knight_helmet"
				},
				{
					R = 25,
					P = 1.0,
					S = "helmets/ssu_hedgeknight_helmet"
				},
				{
					R = 85,
					P = 1.0,
					S = "helmets/ssu_lion_helm"
				}
			]);
		}
	}
});
