::mods_hookExactClass("skills/backgrounds/companion_2h_southern_background", function ( o )
{
	o.onAddEquipment = function ()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.MeleeDefense] = 2;
		talents[this.Const.Attributes.Bravery] = 2;
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 0);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/two_handed_wooden_hammer"));
		}

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