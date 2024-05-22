::mods_hookExactClass("skills/backgrounds/companion_1h_southern_background", function ( o )
{
	o.onAddEquipment = function ()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Hitpoints] = 2;
		talents[this.Const.Attributes.Fatigue] = 2;
		talents[this.Const.Attributes.Bravery] = 2;
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/oriental/firelance"));
		items.equip(this.new("scripts/items/shields/oriental/southern_light_shield"));
		local item = this.Const.World.Common.pickArmor([
			[
				1,
				"oriental/thick_nomad_robe"
			],
			[
				1,
				"oriental/padded_vest"
			],
			[
				1,
				"oriental/leather_nomad_robe"
			]
		]);
		items.equip(item);
		local helm = this.Const.World.Common.pickHelmet([
			[
				1,
				"oriental/leather_head_wrap"
			],
			[
				1,
				"oriental/leather_head_wrap"
			],
			[
				1,
				"oriental/southern_head_wrap",
				this.Math.rand(0, 1) == 1 ? 12 : 8
			]
		]);
		items.equip(helm);
	};
});