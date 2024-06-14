::Mod_Sellswords.HooksMod.hook("scripts/entity/world/settlements/buildings/marketplace_building", function ( q ) {

	q.fillStash = @( __original ) function( _list, _stash, _priceMult, _allowDamagedEquipment = true )
	{
		if (this.m.Settlement.getSize() >= 2)
		{
			_list.extend([
				{
					R = 80,
					P = 2.1,
					S = "supplies/banquet_item"
				},
				{
					R = 60,
					P = 2.1,
					S = "supplies/cured_rations_item"
				},
				{
					R = 50,
					P = 1.0,
					S = "misc/cr_pack"
				}
			]);
		}

		if (this.m.Settlement.hasAttachedLocation("attached_location.gem_mine_location") || this.m.Settlement.hasAttachedLocation("attached_location.gold_mine_location"))
		{
			list.extend({
				R = 40,
				P = 1.0,
				S = "weapon/heavy_mining_pick"
			});
		}

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
				R = 95,
				P = 1.0,
				S = "ammo/quiver_of_phantom_arrows"
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
			},
			{
				R = 95,
				P = 1.0,
				S = "ammo/quiver_of_phantom_bolts"
			},
		]);

		__original( _list, _stash, _priceMult, _allowDamagedEquipment = true );
	}

});