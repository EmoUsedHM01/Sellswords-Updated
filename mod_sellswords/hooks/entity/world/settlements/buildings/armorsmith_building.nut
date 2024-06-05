::Mod_Sellswords.HooksMod.hook("scripts/entity/world/settlements/buildings/armorsmith_building", function ( q ) {

	q.fillStash = @( __original ) function(_list, _stash, _priceMult, _allowDamagedEquipment = false)
	{
		_list.extend([
		{
			R = 90,
			P = 1.0,
			S = "legend_armor/cloth/legend_knightly_robe"
		},
		{
			R = 60,
			P = 1.0,
			S = "legend_armor/cloth/wanderers_coat"
		},
		{
			R = 70,
			P = 1.0,
			S = "legend_armor/armor_upgrades/legend_pauldron_upgrade"
		},
		{
			R = 70,
			P = 1.0,
			S = "legend_armor/armor_upgrades/legend_pauldron_strong_upgrade"
		},
		{
			R = 70,
			P = 1.0,
			S = "legend_armor/armor_upgrades/legend_pauldron_heavy_upgrade"
		},
		{
			R = 95,
			P = 1.0,
			S = "legend_helmets/helm/cr_knightly_fullhelm"
		}
		]);
		
		__original( _list, _stash, _priceMult, _allowDamagedEquipment = true );
	}		
});