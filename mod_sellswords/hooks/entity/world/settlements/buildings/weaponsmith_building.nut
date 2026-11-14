::Mod_Sellswords.HooksMod.hook("scripts/entity/world/settlements/buildings/weaponsmith_building", function ( q ) {

	q.fillStash = @( __original ) function(_list, _stash, _priceMult, _allowDamagedEquipment = false)
	{
		_list.extend([
			{
				R = 80,
				P = 1.0,
				S = "weapons/ssu_spontoon01"
			},
			{
				R = 85,
				P = 1.0,
				S = "weapons/ssu_spontoon02"
			},
			{
				R = 90,
				P = 1.0,
				S = "weapons/ssu_spontoon03"
			},
			{
				R = 95,
				P = 1.0,
				S = "weapons/ssu_polehammer"
			},
			{
				R = 95,
				P = 1.0,
				S = "weapons/ssu_longaxe"
			},
			{
				R = 95,
				P = 1.0,
				S = "weapons/ssu_ranged_flail"
			},
			{
				R = 97,
				P = 2.0,
				S = "weapons/named/ssu_named_goedendag"
			},
			{
				R = 98,
				P = 2.0,
				S = "weapons/named/legend_named_northern_sling"
			}
		]);

		__original(_list, _stash, _priceMult, _allowDamagedEquipment);
	}

});