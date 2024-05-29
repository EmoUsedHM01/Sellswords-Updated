::mods_hookExactClass("entity/tactical/humans/desert_devil", function(o) {
	local onInit = o.onInit;
	o.onInit = function()
	{
		onInit();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/effects/ptr_fresh_and_furious_effect"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_unstoppable"));
		}

		local dc = this.World.getTime().Days;			
		local blk = this.Math.rand(1, 100);
		if (dc > 180 && blk >= 80)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crBlockmaster"));
		}
		else if(dc > 140 && blk >= 60)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crBlockskilled"));
		}
		else if(dc > 100 && blk >= 40)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crBlocknormal"));
		}			
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

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
		assignRandomEquipment();
		
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/shamshir"					
			];

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/crswordlance",
					"weapons/crswordlance"						
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"oriental/assassin_robe"
			],
			[
				1,
				"blade_dancer_armor_00"
			]
		]));

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local helm = this.Const.World.Common.pickHelmet([
				[
					1,
					"oriental/blade_dancer_head_wrap"
				],
				[
					1,
					"blade_dancer_helmet_00"
				]
			]);
			this.m.Items.equip(helm);
		}
	}

	local makeMiniboss = o.makeMiniboss;
	o.makeMiniboss = function()
	{
		local ret = makeMiniboss();
		if (ret)
		{
			if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
				this.m.Skills.removeByID("perk.underdog");					
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_battleheart"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_perfect_fit"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_second_wind"));

				if (::Is_PTR_Exist)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));
				}					
			}
		}

		return ret;
	}
}); 