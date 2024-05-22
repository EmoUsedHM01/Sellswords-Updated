::Mod_Sellswords.HooksMod.hook("entity/tactical/humans/legend_noble_slinger", function(q)
{
	q.onInit = @( __original ) function()
	{
		__original();
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 80)
		{
			this.m.BaseProperties.RangedSkill += 5;

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_ranged_supremacy"));			
			}

			if (this.World.getTime().Days >= 130)
			{
				this.m.BaseProperties.RangedSkill += 5;

				if (::Is_PTR_Exist)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_eyes_up"));
					
					if (this.World.getTime().Days >= 180)
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_marksmanship"));
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
		
		local r;
		local banner = 3;
		local dc = this.World.getTime().Days;				
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 3);
		if (!this.Tactical.State.isScenarioMode())
		{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		}
		else
		{
			banner = this.getFaction();
		}			

		this.m.Surcoat = banner;

		this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));

		this.m.Items.equip(this.new("scripts/items/weapons/legend_slingstaff"));

		r = this.Math.rand(1, 2);

		if (r == 1)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/dagger"));
		}
		else if (r == 2)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/knife"));
		}
		
		if (dc <= 80)
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
		else if (dc <= 130)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[3, "crarbalester_armor_early"],    				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				                              				
				[1, "crbillman_helmet_low"],               //~30 					
			]));
		}			
		else if (dc <= 180)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[3, "crarbalester_armor_mid"],   				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				                              				
				[1, "crbillman_helmet_early"],              //~85          				
			]));
		}	
		else if (dc > 180)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[3, "crarbalester_armor_late"],   				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				                              				  	
				[2, "crbillman_helmet_mid_chain"],               //~115  	
				[2, "crbillman_helmet_mid"],              //~110            					
			]));
		}			
	}
});
