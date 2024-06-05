::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/nomad_cutthroat", function( q ) {
	
	q.onInit = @( __original ) function()
	{
		__original();
		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getEconomicDifficulty() == this.Const.Difficulty.Legendary)
		{
			local dc = this.World.getTime().Days;
			local dca = this.Math.floor(dc/50) + this.Math.floor(dc/100) + this.Math.floor(dc/150) + this.Math.floor(dc/200);
			dca = this.Math.min(dca, 8 + this.Math.floor(dc/100));
			this.m.BaseProperties.MeleeSkill += dca;
			this.m.BaseProperties.MeleeDefense += 0.5 * dca;
			this.m.BaseProperties.RangedSkill += dca;
			this.m.BaseProperties.RangedDefense += 0.5 * dca;
			this.m.BaseProperties.Bravery += dca;
			this.m.BaseProperties.Hitpoints += 2 * dca;
		}
	}

	q.assignRandomEquipment = @( __original ) function()
	{
		__original();
		
		local weapons = [
			"weapons/oriental/saif",
			"weapons/oriental/saif",
			"weapons/oriental/nomad_mace",
			"weapons/oriental/nomad_mace",
			"weapons/wooden_stick",
			"weapons/militia_spear",
			"weapons/militia_spear",
			"weapons/bludgeon",
			"weapons/butchers_cleaver"
		];
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		if (this.Math.rand(1, 100) <= 33)
		{
			local shields = [
				"shields/oriental/southern_light_shield"
			];
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				2,
				"oriental/nomad_robe"
			],
			[
				2,
				"oriental/thick_nomad_robe"
			],
			[
				2,
				"oriental/cloth_sash"
			],
			[
				1,
				"leather_wraps"
			]
		]));
		local helmet = [
			[
				2,
				"oriental/nomad_head_wrap"
			],
			[
				1,
				"citrene_nomad_cutthroat_helmet_00"
			],
			[
				1,
				"citrene_nomad_cutthroat_helmet_01"
			],
			[
				2,
				"oriental/nomad_head_wrap"
			],
			[
				2,
				"oriental/leather_head_wrap"
			],
			[
				1,
				"oriental/nomad_leather_cap"
			],
			[
				6,
				"cr_cutthroat_helmet"
			]				
		];
		this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
	}

}); 