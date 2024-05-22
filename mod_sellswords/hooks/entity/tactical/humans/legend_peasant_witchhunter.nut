::Mod_Sellswords.HooksMod.hook("entity/tactical/humans/legend_peasant_witchhunter", function(q) {
	
	q.onInit = @( __original ) function()
	{
		__original();
		this.m.Skills.removeByID("perk.nimble");
		this.m.BaseProperties.Hitpoints -= 20;	
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		{
			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_through_the_ranks"));	
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_fluid_weapon"));	
			}

			if (this.World.getTime().Days >= 70)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));

				if (::Is_PTR_Exist)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_primal_fear"));		
				}

				if (this.World.getTime().Days >= 100)
				{
					this.m.BaseProperties.Hitpoints += 10;	
					this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));						
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_freedom_of_movement"));

					if (::Is_PTR_Exist)
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_concussive_strikes"));
						this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_tempo"));
					}
												
					if (this.World.getTime().Days >= 130)
					{
						if (::Is_PTR_Exist)
						{
							this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_muscle_memory"));	
							this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_small_target"));
						}
						
						this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));							
						this.m.BaseProperties.RangedSkill += 2;	
						this.m.BaseProperties.Initiative += 5;						
						if (this.World.getTime().Days >= 160)
						{
							this.m.BaseProperties.RangedSkill += 3;	
							this.m.BaseProperties.Bravery += 10;							
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
					"weapons/light_crossbow",
					"ammo/quiver_of_bolts"
				]
			];
		}
		else if (dc <= 100)
		{
			weapons = [
				[
					"weapons/light_crossbow",
					"ammo/quiver_of_bolts"
				],
				[
					"weapons/light_crossbow",
					"ammo/quiver_of_bolts"
				],					
				[
					"weapons/crossbow",
					"ammo/quiver_of_bolts"
				]					
			];
		}
		
		else if (dc <= 150)
		{
			weapons = [
				[
					"weapons/light_crossbow",
					"ammo/quiver_of_bolts"
				],
				[
					"weapons/crossbow",
					"ammo/quiver_of_bolts"
				],					
				[
					"weapons/crossbow",
					"ammo/quiver_of_bolts"
				]					
			];
		}	

		else if (dc > 150)
		{
			weapons = [
				[
					"weapons/crossbow",
					"ammo/quiver_of_bolts"
				]					
			];
		}			
		local n = this.Math.rand(0, weapons.len() - 1);

		foreach( w in weapons[n] )
		{
			this.m.Items.equip(this.new("scripts/items/" + w));
		}

		this.m.Items.addToBag(this.new("scripts/items/weapons/shortsword"));

		if (dc <= 25)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[8, "thick_tunic"],
				[1, "linen_tunic"]
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				if (this.Math.rand(1, 100) <= 50)
				{
					local helm = this.Const.World.Common.pickHelmet([
						[1, "peasant_helmet_early"]	
					])					
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
					[2, "peasant_helmet_early"],					
					[1, "peasant_helmet_mid"]						
				])						
				this.m.Items.equip(helm);				
			}
		}	
		else if (dc <= 60)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[2, "cr_peasant_armor_mid"],
				[1, "cr_peasant_armor_ranged"]
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				local helm = this.Const.World.Common.pickHelmet([
					[1, "peasant_helmet_early"],
					[2, "peasant_helmet_mid"]					
					
				])						
				this.m.Items.equip(helm);				
			}
		}
		else if (dc <= 90)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[2, "cr_peasant_armor_mid"],
				[1, "cr_peasant_armor_late"],
				[1, "cr_peasant_armor_ranged"]						
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				local helm = this.Const.World.Common.pickHelmet([
					[2, "peasant_ranged_mid"],
					[1, "peasant_ranged_late"]					
					
				])						
				this.m.Items.equip(helm);				
			}
		}	
		else if (dc > 90)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "cr_peasant_armor_ranged"],
					[2, "cr_peasant_armor_late"]					
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				local helm = this.Const.World.Common.pickHelmet([
					[1, "peasant_ranged_mid"],
					[3, "peasant_ranged_late"]						
				])						
				this.m.Items.equip(helm);				
			}
		}	
	}	
});	