::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/companion_1h_background", function ( q ) {

	q.onAddEquipment = @(__original) function()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Hitpoints] = 2;
		talents[this.Const.Attributes.Fatigue] = 2;
		talents[this.Const.Attributes.Bravery] = 2;
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/militia_spear"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		items.equip(::Legends.Items.pickArmor([
			[
				1,
				"ragged_surcoat"
			],
			[
				1,
				"padded_surcoat"
			],
			[
				1,
				"gambeson"
			]
		]));
		local item = ::Legends.Items.pickHelmet([
			[
				1,
				"aketon_cap"
			],
			[
				1,
				"open_leather_cap"
			],
			[
				1,
				"full_aketon_cap"
			],
			[
				1,
				"full_leather_cap"
			]
		]);
		items.equip(item);
	};
});
