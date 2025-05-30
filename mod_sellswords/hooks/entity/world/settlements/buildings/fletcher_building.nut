::Mod_Sellswords.HooksMod.hook("scripts/entity/world/settlements/buildings/fletcher_building", function( q ) {

	q.fillStash = @( __original ) function(_list, _stash, _priceMult, _allowDamagedEquipment = false)
	{
		_list.extend([
			{
				R = 50,
				P = 1.0,
				S = "ammo/quiver_of_fire_arrows"
			},
			{
				R = 50,
				P = 1.0,
				S = "ammo/quiver_of_freezing_arrows"
			},
			{
				R = 50,
				P = 1.0,
				S = "ammo/quiver_of_bleeding_arrows"
			},
			{
				R = 50,
				P = 1.0,
				S = "ammo/quiver_of_poisoned_arrows"
			},
			{
				R = 50,
				P = 1.0,
				S = "ammo/quiver_of_fire_bolts"
			},
			{
				R = 50,
				P = 1.0,
				S = "ammo/quiver_of_freezing_bolts"
			},
			{
				R = 50,
				P = 1.0,
				S = "ammo/quiver_of_bleeding_bolts"
			},
			{
				R = 50,
				P = 1.0,
				S = "ammo/quiver_of_poisoned_bolts"
			}
		]);

		__original(_list, _stash, _priceMult, _allowDamagedEquipment);
	}

});