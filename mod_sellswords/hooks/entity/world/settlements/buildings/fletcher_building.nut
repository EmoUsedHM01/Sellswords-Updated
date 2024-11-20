::Mod_Sellswords.HooksMod.hook("scripts/entity/world/settlements/buildings/fletcher_building", function( q ) {

	q.fillStash = @( __original ) function(_list, _stash, _priceMult, _allowDamagedEquipment = false)
	{
		_list.extend([
			{
				R = 20,
				P = 1.0,
				S = "weapons/crossbow_chukonu"
			},
			{
				R = 20,
				P = 1.0,
				S = "weapons/crossbow_chukonu"
			},
			{
				R = 0,
				P = 1.0,
				S = "ammo/chukonu_ammo"
			}
		]);

		__original( _list, _stash, _priceMult, _allowDamagedEquipment = false );
	}

});