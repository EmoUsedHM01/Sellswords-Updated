::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/legend_peasant_miner", function( q ) {

	q.onInit = @( __original ) function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendPeasantMiner);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(0, 255);
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_pickaxe_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_pickaxe_damage"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smackdown"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_hammer"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.addPerkTree(this.Const.Perks.MinerProfessionTree);
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_rattle"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_deep_impact"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_strength_in_numbers"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_fruits_of_labor"));
		}

		this.getSprite("socket").setBrush("bust_base_militia");

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Hitpoints = b.Hitpoints * 1.4;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_indomitable"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_dent_armor"));
			}
		}			
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_muscularity"));

			if (this.World.getTime().Days >= 70)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
				this.m.BaseProperties.Hitpoints -= 15;						

				if (this.World.getTime().Days >= 100)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));				
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_freedom_of_movement"));										
					if (this.World.getTime().Days >= 130)
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_vengeance"));
						this.m.BaseProperties.MeleeSkill += 2;	
						this.m.BaseProperties.Initiative += 2;						
						if (this.World.getTime().Days >= 160)
						{
							this.m.BaseProperties.MeleeDefense += 2;	
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
		
		local dc = this.World.getTime().Days;		
		local r;
		if (dc <= 60) 
		{
			this.m.Items.equip(this.new("scripts/items/weapons/pickaxe"));
		}
		else if (dc <= 120) 
		{
			r = this.Math.rand(1, 4);

			if (r <= 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/pickaxe"));
			}
			if (r >= 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/two_handed_wooden_hammer"));
			}
		}
		else if (dc > 120) 
		{
			r = this.Math.rand(1, 4);

			if (r <= 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/two_handed_wooden_hammer"));
			}
			if (r >= 4)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/barbarians/skull_hammer"));
			}
		}	
		//this.m.Skills.addTreeOfEquippedWeapon(4);
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 4);
		
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
						[1, "peasant_helmet_early"]
					]);
					this.m.Items.equip(helm);				
				}
			}
		}
		else if (dc <= 40)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[4, "cr_peasant_armor"],
				[1, "cr_peasant_armor_mid"]
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				local helm = this.Const.World.Common.pickHelmet([
					[1, "peasant_helmet_early"],
					[2, "peasant_helmet_mid"]					
					
				]);
				this.m.Items.equip(helm);				
			}
		}	
		else if (dc <= 60)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "cr_peasant_armor_late"],
				[4, "cr_peasant_armor_mid"]
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				local helm = this.Const.World.Common.pickHelmet([
					[1, "peasant_helmet_late"],
					[2, "peasant_helmet_mid"]					
					
				]);
				this.m.Items.equip(helm);				
			}
		}
		else if (dc <= 90)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[5, "cr_peasant_armor_late"],
				[1, "ragged_surcoat"],
				[1, "padded_leather"],
				[1, "worn_mail_shirt"],
				[1, "leather_lamellar"],
				[1, "patched_mail_shirt"]				
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				local helm = this.Const.World.Common.pickHelmet([
					[1, "peasant_helmet_late"]					
					
				]);
				this.m.Items.equip(helm);				
			}
		}	
		else if (dc <= 120)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[3, "cr_peasant_armor_late"],
				[3, "cr_peasant_armor_verylate"],
				[1, "cr_peasant_armor_heavy"]					
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				local helm = this.Const.World.Common.pickHelmet([
					[1, "peasant_helmet_late"],					
					[1, "peasant_helmet_verylate"]						
				]);
				this.m.Items.equip(helm);				
			}
		}
		else if (dc > 120)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[3, "cr_peasant_armor_verylate"],
				[1, "cr_peasant_armor_heavy"]					
			]));


			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				local helm = this.Const.World.Common.pickHelmet([
					[1, "peasant_helmet_late_heavy"],					
					[3, "peasant_helmet_verylate"]						
				]);
				this.m.Items.equip(helm);				
			}
		}				
	}
			
});