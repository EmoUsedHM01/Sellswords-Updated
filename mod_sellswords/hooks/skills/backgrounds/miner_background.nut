::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/miner_background", function ( q ) {

	q.onAddEquipment = @(__original) function()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/heavy_mining_pick"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"sackcloth"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
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