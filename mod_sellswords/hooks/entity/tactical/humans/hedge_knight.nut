::mods_hookExactClass("entity/tactical/humans/hedge_knight", function(o) {
	local onInit = o.onInit;
	o.onInit = function()
	{
		onInit();
		this.m.Skills.removeByID("perk.perk.hold_out");	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crresilient"));			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_haspecialize"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));	

		if (::Is_PTR_Exist)
		{	
			this.m.Skills.removeByID("perk.ptr_vigorous_assault");
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_formidable_approach"));		
		}

		local dc = this.World.getTime().Days;			
		local blk = this.Math.rand(1, 100);
		if (dc > 220 && blk >= 90)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crBlockmaster"));
		}
		else if(dc > 180 && blk >= 75)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crBlockskilled"));
		}
		else if(dc > 140 && blk >= 60)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crBlocknormal"));
		}			
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 80)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_true_believer"));
			this.m.BaseProperties.Stamina += 5;
			if (this.World.getTime().Days >= 120)
			{
				if (::Is_PTR_Exist)
				{	
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vigorous_assault"));	
				}

				this.m.BaseProperties.Stamina += 5;						
				if (this.World.getTime().Days >= 150)
				{
					if (::Is_PTR_Exist)
					{	
						this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_sweeping_strikes"));					
						this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_wears_it_well"));	
					}

					this.m.Skills.add(this.new("scripts/skills/perks/perk_crHonorheritage"));							
					this.m.BaseProperties.MeleeSkill += 2;			
					this.m.BaseProperties.MeleeDefense += 2;			
					this.m.BaseProperties.RangedDefense += 2;				
					if (this.World.getTime().Days >= 180)
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
						this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));				
						this.m.BaseProperties.MeleeSkill += 3;	
						//this.m.BaseProperties.Initiative += 3;
						this.m.BaseProperties.Stamina += 5;							
						if (this.World.getTime().Days >= 210)
						{	
							if (::Is_PTR_Exist)
							{
								this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));		
							}
													
							this.m.BaseProperties.MeleeDefense += 3;	
							//this.m.BaseProperties.Initiative += 2;
							this.m.BaseProperties.RangedDefense += 3;								
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

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
		assignRandomEquipment();
		
		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 3);			
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/greatsword",
				"weapons/longsword03",					
				"weapons/greataxe",
				"weapons/two_handed_hammer",					
				"weapons/two_handed_flanged_mace",
				"weapons/two_handed_flail",					
				"weapons/bardiche"					
			];

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		
		if (dc <= 80)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "cr_plate_scale_early"],		 //280,-35				
				[2, "cr_plate_scale_early_patched"],	  //275,-36
				[1, "cr_plate_full_early_low"],		 //280,-35				
				[2, "cr_plate_scale_early_patched_low"],	  //275,-36					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "crknight_helmet_early_unadorned"],			//255 -16	310,-21				 					
				[2, "cr_enclave_kettle"],			//265,-18	
				[2, "cr_hedgeknight_low"],			//255,-16						
			]));
		}			
		else if (dc <= 110)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "cr_plate_scale_early"],		 //280,-35				
				[1, "cr_plate_scale_early_patched"],	  //275,-36
				[1, "cr_plate_full_early"],			//300,-40
				[1, "cr_plate_full_early_low"],		 //280,-35					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[2, "crknight_helmet_early_unadorned"],			//255 -16	310,-21				   					
				[1, "crknight_helmet_early_decorative"],			//310,-20   280,-17	
				[1, "cr_enclave_kettle"],			//265,-18	
				[1, "cr_hedgeknight_low"],			//255,-16							
			]));
		}
		else if (dc <= 140)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[2, "cr_plate_scale_early"],		 //280,-35				
				[1, "cr_plate_scale_early_patched"],	  //275,-36
				[3, "cr_plate_full_early"],			//300,-40
				[1, "cr_plate_scale_mid"],	  //315,-40
				[1, "cr_plate_full_mid"],		   //320,-41					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "crknight_helmet_early_unadorned"],			//255 -16	310,-21				  				
				[1, "crknight_helmet_early_decorative"],			//310,-20   280,-17
				[1, "crknight_helmet_mid_bread"],			//350,-23 
				[1, "crknight_helmet_mid_decorative"],		 //335,-22
				[1, "crknight_helmet_mid_unadorned"],			//325 -21
				[1, "cr_enclave_armet"],			   //330, -22  					 					
			]));
		}
		else if (dc <= 170)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "cr_plate_scale_mid"],	  //315,-40
				[1, "cr_plate_full_mid"],		   //320,-41
				[1, "cr_plate_full_mid_reinforced"],	 //335,-43					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[2, "crknight_helmet_mid_bread"],			//350,-23						350
				[2, "crknight_helmet_mid_decorative"],		 //335,-22
				[1, "crknight_helmet_mid_unadorned"],			//325 -21
				[1, "cr_enclave_armet"],			   //355,-24  	
				[1, "crknight_helmet_mid_bascinet_faceplate"],			   //385,-26  											
			]));
		}	
		else if (dc <= 200)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "cr_plate_full_mid"],		   //320,-41
				[1, "cr_plate_full_mid_reinforced"],	 //335,-43
				[1, "cr_plate_full_late"],	   //370,-50					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[1, "crknight_helmet_mid_bread"],			//350,-23			   370				 				
				[1, "cr_enclave_armet"],			   //355,-24  	
				[1, "crknight_helmet_mid_bascinet_faceplate"],			   //385,-26 											
			]));
		}	
		else if (dc <= 230)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "cr_plate_full_late"],	   //370,-50
				[1, "cr_plate_full_heavy"],	   //380,-49					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([					
				[1, "cr_enclave_great_bascinet"],			   //415,-29	
				[1, "cr_enclave_armet_late"],			   //400,-28
				[1, "crknight_helmet_late_mixed"],				//410, min 400	
				[1, "crknight_helmet_late_mixed_patched"],		//405, min 390					
			]));
		}	
		else if (dc <= 260)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "cr_plate_full_hedgeknight_midlate"],	   //405
				[1, "cr_plate_full_heavy"],	   //380,-49
				[1, "cr_plate_full_knight"]		 //415,-54						
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([					
				[2, "cr_enclave_great_bascinet_late"],			   //465,-32			 		  440
				[3, "cr_enclave_venitian_bascinet"],			   //460,-33		 
				[1, "cr_enclave_great_bascinet"],			   //415,-29	
				[1, "crknight_helmet_late_mixed"],				//410, min 400	
				[1, "crknight_helmet_late_mixed_patched"],		//405, min 390					
				[1, "crknight_helmet_late_enclave_ichi"],			   //420					
			]));
		}
		else if (dc > 260)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "cr_plate_full_heavy_late"],	   //435,-57
				[2, "cr_plate_full_hedgeknight"]		 //415,-54						
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([					
				[1, "cr_enclave_great_helm"],				//475,-36						
				[1, "cr_enclave_great_bascinet_late"],			  //465,-32
				[1, "crknight_helmet_late_enclave_ni"],			   //460
				[1, "crknight_helmet_late_enclave_sann"]			   //460					
			]));
		}			
	}
	o.makeMiniboss = function()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/named_axe",
			"weapons/named/named_cleaver",
			"weapons/named/named_greataxe",
			"weapons/named/named_greatsword",
			"weapons/named/named_mace",
			"weapons/named/named_sword",
			"weapons/named/named_longsword",
			"weapons/named/named_two_handed_hammer",
			"weapons/named/named_warbrand"
		];

		if (this.Const.DLC.Unhold)
		{
			weapons.extend([
				"weapons/named/named_two_handed_mace",
				"weapons/named/named_two_handed_flail"
			]);
		}

		if (this.Const.DLC.Wildmen)
		{
			weapons.extend([
				"weapons/named/named_bardiche"
			]);
		}
		
		local r = this.Math.rand(1, 3);
		if (r <= 2)
		{
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		else if (r == 3)	
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "cr_named_full_armor_cloth"],	
				[1, "cr_named_full_armor_chain"],		
				[1, "cr_named_full_armor_plate"],					
			]));
		}
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.addPerkTree(this.Const.Perks.OneHandedTree);	
		}
		return true;
	}	
});