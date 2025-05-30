::Mod_Sellswords.HooksMod.hook("scripts/entity/world/settlements/buildings/alchemist_building", function( q ) {
	q.fillStash = @( __original ) function(_list, _stash, _priceMult, _allowDamagedEquipment = false)
	{
		_list.extend([
			{
				R = 50,
				P = 1.0,
				S = "weapons/advancedfirelance"
			},
			{
				R = 95,
				P = 1.0,
				S = "misc/anatomist/alp_sequence_item"
			},
			{
				R = 95,
				P = 1.0,
				S = "misc/anatomist/direwolf_sequence_item"
			},
			{
				R = 95,
				P = 1.0,
				S = "misc/anatomist/goblin_sequence_item"
			},
			{
				R = 95,
				P = 1.0,
				S = "misc/anatomist/nachzehrer_sequence_item"
			},
			{
				R = 95,
				P = 1.0,
				S = "misc/anatomist/orc_sequence_item"
			},
			{
				R = 95,
				P = 1.0,
				S = "misc/anatomist/serpent_sequence_item"
			},
			{
				R = 95,
				P = 1.0,
				S = "misc/anatomist/unhold_sequence_item"
			},
			{
				R = 95,
				P = 1.0,
				S = "misc/anatomist/webknecht_sequence_item"
			}
		]);

		__original(_list, _stash, _priceMult, _allowDamagedEquipment);
	}

});