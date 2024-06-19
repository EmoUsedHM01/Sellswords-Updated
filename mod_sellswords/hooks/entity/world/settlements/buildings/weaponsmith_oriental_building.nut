::Mod_Sellswords.HooksMod.hook("scripts/entity/world/settlements/buildings/weaponsmith_oriental_building", function ( q ) {

	q.fillStash = @( __original ) function(_list, _stash, _priceMult, _allowDamagedEquipment = false)
	{
		_list.extend([
			{
				R = 80,
				P = 1.0,
				S = "weapons/spontoon01"
			},
			{
				R = 85,
				P = 1.0,
				S = "weapons/spontoon02"
			},
			{
				R = 90,
				P = 1.0,
				S = "weapons/spontoon03"
			},
			{
				R = 99,
				P = 2.0,
				S = "weapons/named/named_spontoon"
			},
			{
				R = 90,
				P = 1.0,
				S = "weapons/crpolemace"
			},
			{
				R = 90,
				P = 1.0,
				S = "weapons/crswordlance"
			},
			{
				R = 98,
				P = 2.0,
				S = "weapons/named/named_sling"
			}
		]);

		__original( _list, _stash, _priceMult, _allowDamagedEquipment = false );
	}

});