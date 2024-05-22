::Mod_Sellswords.HooksMod.hook("entity/tactical/humans/legend_noble_fencer", function(q)
{
	q.onInit = @( __original ) function()
	{
		__original();
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 120)
		{
			this.m.BaseProperties.Initiative += 3;	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crBattlerhaposdy"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/effects/ptr_fresh_and_furious_effect"));
			}
			
			if (this.World.getTime().Days >= 160)
			{
				if (::Is_PTR_Exist)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_through_the_gaps"));
				}

				this.m.BaseProperties.Initiative += 3;	
				if (this.World.getTime().Days >= 200)
				{
					this.m.BaseProperties.Initiative += 4;	
					this.m.Skills.add(this.new("scripts/skills/perks/perk_crFoB"));												
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
		
		local r = this.Math.rand(0, 2);

		if (r <= 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_estoc"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/fencing_sword"));
		}
		//this.m.Skills.addTreeOfEquippedWeapon();	
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 5);		
		
		if (dc <= 60)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[3, "crarmor_hauberk_fencer_early"],		   //100,-11
				[1, "crarmor_hauberk_fencer_mid"],	   //120,-13 					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[3, "crbillman_helmet_low"],			//~30
				[1, "crbillman_helmet_early"],			   //~85,-5 						
			]));
		}
		else if (dc <= 90)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crarmor_hauberk_fencer_early"],		   //100,-11
				[3, "crarmor_hauberk_fencer_mid"],	   //120,-13 					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[1, "crbillman_helmet_early"],			   //~85,-5 
				[0, "crfencer_helmet_early"],			//~100,-5
				[0, "crfencer_helmet_mid"],		   //~130,-7					
				[0, "crfencer_helmet_late"],			   //~160,-6 						
			]));
		}			
		else if (dc <= 120)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crarmor_hauberk_fencer_mid"],	   //120,-13 
				[1, "crarmor_hauberk_fencer_late"],	 //130,-13
				[0, "crarmor_hauberk_fencer_late_patched"],	   //155,-13  
				[0, "crarmor_leather"],	 //155,-12 					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[1, "crbillman_helmet_early"],			   //~85,-5 
				[1, "crfencer_helmet_early"],			//~100,-5
				[0, "crfencer_helmet_mid"],		   //~130,-7					
				[0, "crfencer_helmet_late"],			   //~160,-6 						
			]));
		}	
		else if (dc <= 150)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crarmor_hauberk_fencer_late"],	 //130,-13
				[1, "crarmor_hauberk_fencer_late_patched"],	   //155,-13  
				[0, "crarmor_leather"],	 //155,-12 					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[1, "crfencer_helmet_early"],			//~100,-5
				[2, "crfencer_helmet_mid"],		   //~130,-7					
				[0, "crfencer_helmet_late"],			   //~160,-6 						
			]));
		}
		else if (dc <= 180)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[2, "crarmor_hauberk_fencer_late_patched"],	   //155,-13  
				[1, "crarmor_leather"],	 //155,-12 					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[1, "crfencer_helmet_mid"],		   //~130,-7					
				[1, "crfencer_helmet_late"],			   //~160,-6 						
			]));
		}
		else if (dc > 180)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crarmor_hauberk_fencer_late_patched"],	   //155,-13  
				[2, "crarmor_leather"],	 //155,-12 					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([								
				[1, "crfencer_helmet_late"],			   //~160,-6 						
			]));
		}			
	}
	q.makeMiniboss <- function()
	{
		if (!__original())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local r = this.Math.rand(1, 2);

		if (r == 1)
		{
			local rr = this.Math.rand(0, 2);

			if (rr <= 1)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/named/legend_named_estoc"));
			}
			else if (rr == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/named/named_fencing_sword"));
			}
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([ 
				[1, "crnamed_leather_jacket"],	 		//155,-12 used by fencers 				
			]));
		}
		this.m.Items.equip(this.Const.World.Common.pickHelmet([ 
			[1, "crfencer_helmet_champion"],	 		//170,-9 				
		]));			
		this.m.BaseProperties.Initiative += 10;				
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nine_lives"));					
		return true;
	}	
});
