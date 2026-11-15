::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/miner_background", function ( q ) {

	q.onAddEquipment = @(__original) function()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/ssu_heavy_mining_pick"));
		items.equip(::Legends.Items.pickArmor([
			[
				1,
				"sackcloth"
			]
		]));
		items.equip(::Legends.Items.pickHelmet([
			[
				1,
				""
			],
			[
				1,
				"mouth_piece"
			]
		]));
	}

});