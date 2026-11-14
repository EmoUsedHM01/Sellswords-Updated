::Mod_Sellswords.HooksMod.hook("scripts/entity/world/settlements/buildings/marketplace_oriental_building", function ( q ) {

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

		__original(_list, _stash, _priceMult, _allowDamagedEquipment);
	}

});