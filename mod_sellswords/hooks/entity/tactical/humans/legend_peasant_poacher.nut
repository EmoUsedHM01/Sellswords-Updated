::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/legend_peasant_poacher", function( q ) {
	
	q.onInit = @( __original ) function()
	{
		__original();
		this.m.BaseProperties.Hitpoints *= 0.6667;	
	
		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_eyes_up"));	
		}

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days <= 60) 
		{
			this.m.Skills.add(this.new("scripts/skills/traits/legend_pragmatic_trait"));
		}
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		{
			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_through_the_ranks"));	
			}

			if (this.World.getTime().Days >= 70)
			{			
				this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
	
				if (::Is_PTR_Exist)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_small_target"));	
				}				

				if (this.World.getTime().Days >= 100)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_freedom_of_movement"));		
					this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));

					if (::Is_PTR_Exist)
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_death_from_afar"));	
					}

					if (this.World.getTime().Days >= 130)
					{
						if (::Is_PTR_Exist)
						{
							this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_flaming_arrows"));
						}	

						this.m.BaseProperties.RangedSkill += 2;	
						this.m.BaseProperties.Initiative += 2;						
						if (this.World.getTime().Days >= 160)
						{
							this.m.BaseProperties.RangedSkill += 3;	
							this.m.BaseProperties.Bravery += 5;							
						}						
					}		
				}
			}
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

	q.assignRandomEquipment = @( __original ) function()
	{
		__original();
		
		local weapons;
		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 4);			
		if (dc <= 50)
		{
			weapons = [
				[
					"weapons/short_bow",
					"ammo/quiver_of_arrows"
				],
				[
					"weapons/short_bow",
					"ammo/quiver_of_arrows"
				]
			];
		}
		else if (dc <= 100)
		{
			weapons = [
				[
					"weapons/greenskins/goblin_bow",
					"ammo/quiver_of_arrows"
				],
				[
					"weapons/greenskins/goblin_bow",
					"ammo/quiver_of_arrows"
				],					
				[
					"weapons/oriental/composite_bow",
					"ammo/quiver_of_arrows"
				],
				[
					"weapons/short_bow",
					"ammo/quiver_of_arrows"
				]					
			];
		}
		
		else if (dc <= 150)
		{
			weapons = [
				[
					"weapons/greenskins/goblin_bow",
					"ammo/quiver_of_arrows"
				],
				[
					"weapons/hunting_bow",
					"ammo/quiver_of_arrows"
				],					
				[
					"weapons/oriental/composite_bow",
					"ammo/quiver_of_arrows"
				],
				[
					"weapons/hunting_bow",
					"ammo/quiver_of_arrows"
				]					
			];
		}	

		else if (dc > 150)
		{
			weapons = [
				[
					"weapons/greenskins/goblin_heavy_bow",
					"ammo/quiver_of_arrows"
				],				
				[
					"weapons/hunting_bow",
					"ammo/quiver_of_arrows"
				],	
				[
					"weapons/hunting_bow",
					"ammo/quiver_of_arrows"
				],					
				[
					"weapons/oriental/composite_bow",
					"ammo/quiver_of_arrows"
				]					
			];
		}			
		local n = this.Math.rand(0, weapons.len() - 1);

		foreach( w in weapons[n] )
		{
			this.m.Items.equip(this.new("scripts/items/" + w));
		}

		this.m.Items.addToBag(this.new("scripts/items/weapons/knife"));

		if (dc <= 25)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "sackcloth"],
				[1, "thick_tunic"],
				[8, "linen_tunic"]
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				if (this.Math.rand(1, 100) <= 50)
				{
					local helm = this.Const.World.Common.pickHelmet([
						[1, "hood"]
					]);
					this.m.Items.equip(helm);				
				}
			}
		}
		else if (dc <= 40)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "cr_peasant_armor"]
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				local helm = this.Const.World.Common.pickHelmet([
					[1, "peasant_helmet_early"]					
					
				]);
				this.m.Items.equip(helm);				
			}
		}	
		else if (dc <= 60)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[2, "cr_peasant_armor"],
				[1, "cr_peasant_armor_ranged"]
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				local helm = this.Const.World.Common.pickHelmet([
					[2, "peasant_helmet_early"],
					[1, "peasant_helmet_mid"]					
					
				]);
				this.m.Items.equip(helm);				
			}
		}
		else if (dc <= 90)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[2, "cr_peasant_armor"],
				[1, "cr_peasant_armor_mid"],
				[1, "cr_peasant_armor_ranged"]						
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				local helm = this.Const.World.Common.pickHelmet([
					[2, "peasant_ranged_mid"],
					[1, "peasant_ranged_late"]					
					
				]);
				this.m.Items.equip(helm);				
			}
		}	
		else if (dc > 90)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
					[2, "cr_peasant_armor_ranged"],
					[1, "cr_peasant_armor_mid"]					
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				local helm = this.Const.World.Common.pickHelmet([
					[1, "peasant_ranged_mid"],
					[3, "peasant_ranged_late"]						
				]);
				this.m.Items.equip(helm);				
			}
		}							
	}

});