::Mod_Sellswords.HooksMod.hook("scripts/entity/world/settlements/buildings/alchemist_building", function( q ) {

	q.onUpdateShopList = @(__original) function()
	{
		local list = [
			{
				R = 10,
				P = 1.0,
				S = "tools/daze_bomb_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "tools/daze_bomb_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "tools/fire_bomb_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "tools/fire_bomb_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "tools/smoke_bomb_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "tools/smoke_bomb_item"
			},
			{
				R = 50,
				P = 1.0,
				S = "tools/acid_flask_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "accessory/antidote_item"
			},
			{
				R = 30,
				P = 1.0,
				S = "accessory/antidote_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/oriental/firelance"
			},
			{
				R = 20,
				P = 1.0,
				S = "weapons/oriental/firelance"
			},
			{
				R = 35,
				P = 1.0,
				S = "weapons/oriental/handgonne"
			},
			{
				R = 0,
				P = 1.0,
				S = "ammo/powder_bag"
			},
			{
				R = 50,
				P = 1.0,
				S = "weapons/advancedfirelance"
			},
			{
				R = 99,
				P = 2.0,
				S = "weapons/named/named_handgonne"
			},
			{
				R = 95,
				P = 2.0,
				S = "weapons/named/alp_sequence_item"
			},
			{
				R = 95,
				P = 2.0,
				S = "weapons/named/direwolf_sequence_item"
			},
			{
				R = 95,
				P = 2.0,
				S = "weapons/named/goblin_sequence_item"
			},
			{
				R = 95,
				P = 2.0,
				S = "weapons/named/nachzehrer_sequence_item"
			},
			{
				R = 95,
				P = 2.0,
				S = "weapons/named/orc_sequence_item"
			},
			{
				R = 95,
				P = 2.0,
				S = "weapons/named/serpent_sequence_item"
			},
			{
				R = 95,
				P = 2.0,
				S = "weapons/named/unhold_sequence_item"
			},
			{
				R = 95,
				P = 2.0,
				S = "weapons/named/webknecht_sequence_item"
			}
		];

		if (this.Const.DLC.Unhold)
		{
			list.extend([
				{
					R = 40,
					P = 1.0,
					S = "accessory/cat_potion_item"
				},
				{
					R = 40,
					P = 1.0,
					S = "accessory/iron_will_potion_item"
				},
				{
					R = 40,
					P = 1.0,
					S = "accessory/lionheart_potion_item"
				},
				{
					R = 40,
					P = 1.0,
					S = "accessory/night_vision_elixir_item"
				},
				{
					R = 40,
					P = 1.0,
					S = "accessory/recovery_potion_item"
				},
				{
					R = 40,
					P = 1.0,
					S = "accessory/spider_poison_item"
				},
				{
					R = 40,
					P = 1.0,
					S = "misc/potion_of_knowledge_item"
				}
			]);
		}

		this.m.Settlement.onUpdateShopList(this.m.ID, list);
		this.fillStash(list, this.m.Stash, 1.0, false);
	}

});