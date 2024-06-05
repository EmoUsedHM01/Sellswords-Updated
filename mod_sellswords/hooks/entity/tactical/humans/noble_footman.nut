::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/noble_footman", function(q) {
	
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
			local crstrength = this.World.State.getPlayer().getStrength();
			crstrength = this.Math.floor(this.Math.max((crstrength - 300 - dc)/50, 0));
			local crroll = this.Math.rand(1, 20);
			if (crstrength >= crroll)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_lithe"));					
			}
			if (dc >= 150)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_crTotalcover"));	
			}	
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

		r = this.Math.rand(1, 4);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/military_pick"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/arming_sword"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
		}

		r = this.Math.rand(1, 2);
		local shield;

		if (r == 1)
		{
			shield = this.new("scripts/items/shields/faction_kite_shield");
		}
		else if (r == 2)
		{
			shield = this.new("scripts/items/shields/faction_heater_shield");
		}

		shield.setFaction(banner);
		this.m.Items.equip(shield);
		if (dc <= 50)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crfootman_armor_early"],		   // 160
				[1, "crfootman_armor_low"],		   // 130					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[1, "crfootman_helmet_early"],			//~135
				[1, "crfootman_helmet_mid"],			   //~150 					
			]));
		}
		else if (dc <= 80)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crfootman_armor_early"],		   // 160			
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([											  				
				[1, "crfootman_helmet_mid"],			   //~150  	
				[1, "crfootman_helmet_mid_reinforced"],			   //~175 					
			]));
		}			
		else if (dc <= 100)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[2, "crfootman_armor_early"],		   // 160
				[1, "crfootman_armor_mid_plate"],	   //185
				[1, "crfootman_armor_mid_patched"],	 // 185				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([											  				
				[1, "crfootman_helmet_mid"],			   //~150  	
				[1, "crfootman_helmet_mid_reinforced"],			   //~175 					
			]));
		}	
		else if (dc <= 125)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crfootman_armor_mid_chain"],	 // 185
				[1, "crfootman_armor_mid_plate"],	   //185
				[1, "crfootman_armor_mid_patched"],	 // 185				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([											  				  	
				[1, "crfootman_helmet_mid_reinforced"],			   //~175 
				[1, "crfootman_helmet_late_kettle"],			  //~200 					
			]));
		}
		else if (dc <= 150)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crfootman_armor_mid_chain"],	 // 185
				[1, "crfootman_armor_mid_plate"],	   //185
				[1, "crfootman_armor_mid_patched"],	 // 185
				[2, "crfootman_armor_late_ichi"],	  // 195
				[2, "crfootman_armor_late_ni"],	  // 200					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([											  				 	
				[1, "crfootman_helmet_mid_reinforced"],			   //~175 
				[1, "crfootman_helmet_late"],			   //~175  	
				[2, "crfootman_helmet_late_kettle"],			  //~200 
				[1, "crfootman_helmet_late_heavy"],			   //~200					
			]));
		}
		else if (dc > 150)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crfootman_armor_late_ichi"],	  // 195
				[1, "crfootman_armor_late_ni"],	  // 200					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([											  				
				[2, "crfootman_helmet_late_kettle_reinforced"],			 //~225 	
				[1, "crfootman_helmet_late_kettle"],			  //~200 
				[1, "crfootman_helmet_late_heavy"],			   //~200					
			]));
		}			
	}
});	