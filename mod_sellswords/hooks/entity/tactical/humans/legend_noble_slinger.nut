::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/legend_noble_slinger", function( q ) {

	q.onInit = @( __original ) function()
	{
		__original();
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 80)
		{
			this.m.BaseProperties.RangedSkill += 5;

			if (this.World.getTime().Days >= 130)
			{
				this.m.BaseProperties.RangedSkill += 5;
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

		this.m.Items.equip(this.new("scripts/items/weapons/legend_northern_sling"));

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
			this.m.Items.equip(::Legends.Items.pickArmor([
				[1, "padded_surcoat"],	
				[1, "gambeson"],						
			]));
			this.m.Items.equip(::Legends.Items.pickHelmet([				
				[2, "mail_coif"],			   
				[1, "aketon_cap"],  
				[1, "open_leather_cap"], 
				[1, "headscarf"], 
				[1, ""], 					
			]));
		}
		else if (dc <= 130)
		{
			this.m.Items.equip(::Legends.Items.pickArmor([
				[3, "ssu_arbalester_armor_early"],					
			]));
			this.m.Items.equip(::Legends.Items.pickHelmet([											  				
				[1, "ssu_billman_helmet_low"],			   //~30 					
			]));
		}			
		else if (dc <= 180)
		{
			this.m.Items.equip(::Legends.Items.pickArmor([
				[3, "ssu_arbalester_armor_mid"],   				
			]));
			this.m.Items.equip(::Legends.Items.pickHelmet([											  				
				[1, "ssu_billman_helmet_early"],			  //~85		  				
			]));
		}	
		else if (dc > 180)
		{
			this.m.Items.equip(::Legends.Items.pickArmor([
				[3, "ssu_arbalester_armor_late"],   				
			]));
			this.m.Items.equip(::Legends.Items.pickHelmet([											  				  	
				[2, "ssu_billman_helmet_mid_chain"],			   //~115  	
				[2, "ssu_billman_helmet_mid"],			  //~110								
			]));
		}			
	}

});