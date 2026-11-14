::Mod_Sellswords.HooksMod.hook("scripts/entity/world/settlements/buildings/marketplace_building", function ( q ) {

	q.fillStash = @( __original ) function( _list, _stash, _priceMult, _allowDamagedEquipment = true )
	{
		if (this.m.Settlement.getSize() >= 2)
		{
			_list.extend([
				{
					R = 80,
					P = 2.1,
					S = "supplies/ssu_banquet_item"
				},
				{
					R = 60,
					P = 2.1,
					S = "supplies/cured_rations_item"
				}
			]);
		}

		local miningLocations = [
			"attached_location.gem_mine",
			"attached_location.gold_mine",
			"attached_location.salt_mine",
			"attached_location.surface_copper_vein",
			"attached_location.surface_iron_vein"
		];

		foreach (id in miningLocations)
		{
			if (this.m.Settlement.hasAttachedLocation(id))
			{
				_list.extend([
					{
						R = 40,
						P = 1.0,
						S = "weapons/ssu_heavy_mining_pick"
					}
				]);
			}
		}

		_list.extend([
			{
				R = 70,
				P = 1.0,
				S = "ammo/ssu_quiver_of_fire_arrows"
			},
			{
				R = 70,
				P = 1.0,
				S = "ammo/ssu_quiver_of_freezing_arrows"
			},
			{
				R = 70,
				P = 1.0,
				S = "ammo/ssu_quiver_of_bleeding_arrows"
			},
			{
				R = 70,
				P = 1.0,
				S = "ammo/ssu_quiver_of_poisoned_arrows"
			},
			{
				R = 70,
				P = 1.0,
				S = "ammo/ssu_quiver_of_fire_bolts"
			},
			{
				R = 70,
				P = 1.0,
				S = "ammo/ssu_quiver_of_freezing_bolts"
			},
			{
				R = 70,
				P = 1.0,
				S = "ammo/ssu_quiver_of_bleeding_bolts"
			},
			{
				R = 70,
				P = 1.0,
				S = "ammo/ssu_quiver_of_poisoned_bolts"
			},
			{
				R = 25,
				P = 1.0,
				S = "accessory/ssu_militia_armband_item"
			}
		]);

		__original(_list, _stash, _priceMult, _allowDamagedEquipment);
	}

});