::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/noble_billman", function(q) {
	
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

		local weapons = [
			"weapons/billhook",
			"weapons/pike",
			"weapons/legend_voulge"
		];

		if (this.Const.DLC.Unhold)
		{
			weapons.extend([
				"weapons/polehammer"
			]);
		}
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));				
		if (dc <= 50)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crbillman_armor_low"],     // 110
				[1, "crbillman_armor_early"],        // 110				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[2, "crbillman_helmet_low"],               //~30
				[1, "crbillman_helmet_early"],               //~85   					
			]));
		}
		else if (dc <= 80)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[3, "crbillman_armor_low"],     // 110
				[3, "crbillman_armor_early"],        // 110	
				[1, "crbillman_armor_mid"],     // 140
				[1, "crbillman_armor_mid_mixed"],       // 130					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				                              				
				[1, "crbillman_helmet_early"],               //~85 					
			]));
		}			
		else if (dc <= 100)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crbillman_armor_low"],     // 110
				[1, "crbillman_armor_early"],        // 110	
				[2, "crbillman_armor_mid"],     // 140
				[2, "crbillman_armor_mid_mixed"],       // 130				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				                              				
				[1, "crbillman_helmet_early"],               //~85 
				[2, "crbillman_helmet_mid_chain"],               //~115  	
				[2, "crbillman_helmet_mid"],              //~110					
			]));
		}	
		else if (dc <= 125)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crbillman_armor_mid"],     // 140
				[1, "crbillman_armor_mid_mixed"],       // 130				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				                              				  	
				[2, "crbillman_helmet_mid_chain"],               //~115  	
				[2, "crbillman_helmet_mid"],              //~110
				[1, "crbillman_helmet_late_chain"],               //~140 
				[1, "crfootman_helmet_late"],               //~140  					
			]));
		}
		else if (dc <= 150)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crbillman_armor_mid"],     // 140
				[1, "crbillman_armor_mid_mixed"],       // 130
				[2, "crbillman_armor_late"],      // 150					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				                              				 	
				[1, "crbillman_helmet_mid_chain"],               //~115  	
				[1, "crbillman_helmet_mid"],              //~110
				[3, "crbillman_helmet_late_chain"],               //~140 
				[3, "crfootman_helmet_late"],               //~140  	
				[1, "crbillman_helmet_heavy"],              //~160					
			]));
		}
		else if (dc > 150)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crbillman_armor_late"],      // 150					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				                              				
				[1, "crbillman_helmet_late_chain"],               //~140 
				[1, "crfootman_helmet_late"],               //~140  	
				[4, "crbillman_helmet_heavy"],              //~160					
			]));
		}
	}
});