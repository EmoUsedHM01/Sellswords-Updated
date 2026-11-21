::Mod_Sellswords.HooksMod.hook("scripts/entity/world/settlements/buildings/alchemist_building", function( q ) {
	q.fillStash = @( __original ) function(_list, _stash, _priceMult, _allowDamagedEquipment = false)
	{
		_list.extend([
			{
				R = 50,
				P = 1.0,
				S = "weapons/ssu_advancedfirelance"
			},
			{
				R = 95,
				P = 1.0,
				S = "misc/anatomist/ssu_alp_sequence_item"
			},
			{
				R = 95,
				P = 1.0,
				S = "misc/anatomist/ssu_basilisk_sequence_item"
			},
			{
				R = 95,
				P = 1.0,
				S = "misc/anatomist/ssu_direwolf_sequence_item"
			},
			{
				R = 95,
				P = 1.0,
				S = "misc/anatomist/ssu_goblin_sequence_item"
			},
			{
				R = 95,
				P = 1.0,
				S = "misc/anatomist/ssu_hyena_sequence_item"
			},
			{
				R = 95,
				P = 1.0,
				S = "misc/anatomist/ssu_nachzehrer_sequence_item"
			},
			{
				R = 95,
				P = 1.0,
				S = "misc/anatomist/ssu_orc_sequence_item"
			},
			{
				R = 95,
				P = 1.0,
				S = "misc/anatomist/ssu_serpent_sequence_item"
			},
			{
				R = 95,
				P = 1.0,
				S = "misc/anatomist/ssu_unhold_sequence_item"
			},
			{
				R = 95,
				P = 1.0,
				S = "misc/anatomist/ssu_webknecht_sequence_item"
			}
		]);

		__original(_list, _stash, _priceMult, _allowDamagedEquipment);
	}

});