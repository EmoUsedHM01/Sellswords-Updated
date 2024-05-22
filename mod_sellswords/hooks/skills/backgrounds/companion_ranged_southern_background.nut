::mods_hookExactClass("skills/backgrounds/companion_ranged_southern_background", function ( o )
{
	o.onAddEquipment = function ()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.RangedSkill] = 2;
		talents[this.Const.Attributes.RangedDefense] = 2;
		talents[this.Const.Attributes.Initiative] = 2;
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/oriental/composite_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		items.addToBag(this.new("scripts/items/weapons/knife"));
		items.equip(this.Const.World.Common.pickArmor([
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
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"oriental/southern_head_wrap",
				this.Math.rand(0, 1) == 1 ? 12 : 8
			]
		]));
	};
});