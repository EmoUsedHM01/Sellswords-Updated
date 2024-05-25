::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/master_archer", function(q)
{
	q.onInit = @( __original ) function()
	{
		__original();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));	

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_eyes_up"));
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
		
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			if (this.Math.rand(1, 100) <= 66)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
			}
			else
			{
				this.m.Items.equip(this.new("scripts/items/weapons/heavy_crossbow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
			}
		}

		local weapons = [
			"weapons/dagger",
			"weapons/scramasax",
			"weapons/hatchet"
		];
		this.m.Items.addToBag(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		
		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 3);			
		if (dc <= 60)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "padded_surcoat"],    
				[1, "gambeson"],        				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[2, "mail_coif"],               
				[1, "aketon_cap"],  
				[1, "open_leather_cap"], 
				[1, "headscarf"], 
				[1, ""], 					
			]));
		}
		else if (dc <= 90)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[3, "crarbalester_armor_early"],    				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				                              				
				[1, "crbillman_helmet_low"],               //~30 					
			]));
		}			
		else if (dc <= 120)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[3, "crarbalester_armor_mid"],   				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				                              				
				[1, "crbillman_helmet_early"],              //~85          				
			]));
		}	
		else if (dc <= 150)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[2, "crarbalester_armor_late"], 
				[1, "crmasterarcher_armor"], 					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				                              				  	
				[1, "crbillman_helmet_mid_chain"],               //~115  	
				[1, "crbillman_helmet_mid"],              //~110            					
			]));
		}	
		else if (dc > 150)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crarbalester_armor_late"], 
				[3, "crmasterarcher_armor"], 					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				                              				  	
				[4, "crmasterarcher_helmet"],               //~115  	
				[1, "crbillman_helmet_mid"],              //~110 
				[1, "crbillman_helmet_mid_chain"],               //~115 					
			]));
		}			

		//if (::Is_PTR_Exist)
		//{
		//	this.m.Skills.addTreeOfEquippedWeapon();
		//}

		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);
	}		
});
