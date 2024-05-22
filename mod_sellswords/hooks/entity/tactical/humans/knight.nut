::mods_hookExactClass("entity/tactical/humans/knight", function(o) {
	local onInit = o.onInit;
	o.onInit = function()
	{
		onInit();
		this.m.Skills.removeByID("perk.perk.hold_out");	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crresilient"));			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_haspecialize"));					
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crSignaturemove"));
		local dc = this.World.getTime().Days;			
		local blk = this.Math.rand(1, 100);
		if (dc > 210 && blk >= 85)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crBlockmaster"));
		}
		else if(dc > 175 && blk >= 70)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crBlockskilled"));
		}
		else if(dc > 140 && blk >= 55)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crBlocknormal"));
		}			
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 80)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_true_believer"));								
			this.m.BaseProperties.Stamina += 5;
			if (this.World.getTime().Days >= 120)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_crFoB"));	
				this.m.Skills.add(this.new("scripts/skills/perks/perk_crHonorheritage"));						
				this.m.BaseProperties.Stamina += 5;	
				if (this.World.getTime().Days >= 150)
				{
					if (::Is_PTR_Exist)
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_wears_it_well"));	
						this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));	
					}
																		
					this.m.BaseProperties.MeleeSkill += 2;			
					this.m.BaseProperties.MeleeDefense += 2;			
					this.m.BaseProperties.RangedDefense += 2;
					if (this.World.getTime().Days >= 180)
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_crTotalcover"));
						this.m.Skills.add(this.new("scripts/skills/perks/perk_last_stand"));							
						this.m.BaseProperties.MeleeSkill += 3;	
						//this.m.BaseProperties.Initiative += 3;
						this.m.BaseProperties.Stamina += 5;							
						if (this.World.getTime().Days >= 210)
						{
							if (::Is_PTR_Exist)
							{
								this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_the_rush_of_battle"));		
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
		
		local r;
		local banner = 4;
		local dc = this.World.getTime().Days;			
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 3);
		if (("State" in this.Tactical) && this.Tactical.State != null && !this.Tactical.State.isScenarioMode())
		{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		}
		else
		{
			banner = this.getFaction();
		}			

		this.m.Surcoat = banner;

		this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/fighting_axe",
				"weapons/noble_sword",
				"weapons/winged_mace",
				"weapons/warhammer"
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
		{
			r = this.Math.rand(1, 2);
			local shield;
			local rr = this.Math.rand(1, 200);
			if (rr > dc)
			{
				if (r == 1)
				{
					shield = this.new("scripts/items/shields/faction_heater_shield");
				}
				else if (r == 2)
				{
					shield = this.new("scripts/items/shields/faction_kite_shield");
				}
			}
			else if (rr <= dc)
			{
				shield = this.new("scripts/items/shields/legend_faction_tower_shield");				
			}

			shield.setFaction(banner);
			this.m.Items.equip(shield);
		}
		
		if (dc <= 80)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[2, "cr_plate_scale_early"],         //280,-35				           280
				[1, "cr_plate_scale_early_patched"],      //275,-36
				[1, "cr_plate_full_early"],            //300,-40
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[2, "crknight_helmet_early_unadorned"],            //255 -16    310,-21        300,6/8
				[2, "faction_helm",banner],                     //265,-16					
				[1, "crknight_helmet_early_decorative"],            //310,-20   280,-17	
				[2, "crknight_faction_helm_great_helm_heavy",banner],          		    //305,-20  	
				[1, "crknight_faction_helm_great_helm_armet",banner],           		//305,-19  					
			]));
		}
		else if (dc <= 105)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[2, "cr_plate_scale_early"],         //280,-35				         300
				[1, "cr_plate_scale_early_patched"],      //275,-36
				[3, "cr_plate_full_early"],            //300,-40
				[1, "cr_plate_scale_mid"],      //315,-40
				[1, "cr_plate_full_mid"],           //320,-41					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "crknight_helmet_early_unadorned"],            //255 -16    310,-21           330,9/15 
				[3, "faction_helm",banner],                     //265,-16					
				[1, "crknight_helmet_early_decorative"],            //310,-20   280,-17
				[1, "crknight_helmet_mid_bread"],            //350,-23 
				[1, "crknight_helmet_mid_decorative"],         //335,-22
				[1, "crknight_helmet_mid_unadorned"],            //325 -21
				[1, "crknight_faction_helm_enclave_armet",banner],  //355,-24
				[1, "cr_enclave_armet"],               //355,-24  					
				[2, "crknight_faction_helm_great_helm_faceplate_01",banner],    		//340,-24 
				[1, "crknight_faction_helm_great_helm_armet_heavy",banner],     		//345,-23 
				[2, "crknight_faction_helm_great_helm_frogmouth",banner],       		//340,-22 					
			]));
		}
		else if (dc <= 130)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "cr_plate_scale_mid"],      //315,-40                             320
				[1, "cr_plate_full_mid"],           //320,-41
				[1, "cr_plate_full_mid_reinforced"],     //335,-43					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[2, "crknight_helmet_mid_bread"],            //350,-23                        350,10/16
				[2, "crknight_helmet_mid_decorative"],         //335,-22
				[1, "crknight_helmet_mid_unadorned"],            //325 -21
				[4, "crknight_faction_helm_enclave_armet",banner],  //355,-24 
				[1, "cr_enclave_armet"],               //355,-24  	
				[1, "crknight_faction_helm_great_helm_faceplate_01",banner],    		//340,-24 
				[3, "crknight_faction_helm_great_helm_armet_heavy",banner],     		//345,-23 
				[2, "crknight_faction_helm_great_helm_frogmouth",banner],       		//340,-22 					 					
			]));
		}	
		else if (dc <= 160)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "cr_plate_full_mid"],           //320,-41                    340
				[2, "cr_plate_full_mid_reinforced"],     //335,-43
				[1, "cr_plate_full_late"],       //370,-50					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[1, "crknight_helmet_mid_bread"],            //350,-23               370,8/12                 				
				[2, "crknight_faction_helm_enclave_armet",banner],  //355,-24 
				[1, "cr_enclave_armet"],               //355,-24  	
				[2, "crknight_helmet_mid_bascinet_faceplate"],               //385,-26
				[2, "crknight_faction_helm_great_helm_faceplate_02",banner],    		//365,-23					
				[2, "crknight_faction_helm_great_helm_frogmouth_heavy",banner],  		//380,-26 
				[2, "crknight_faction_helm_great_helm_faceplate_heavy_01",banner],      //385,-30 					
			]));
		}	
		else if (dc <= 185)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "cr_plate_full_late"],       //370,-50                 375
				[1, "cr_plate_full_heavy"],       //380,-49					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([	   					 	
				[3, "crknight_faction_helm_enclave_great_bascinet",banner],  //415,-29          410,6/10
				[1, "cr_enclave_great_bascinet"],               //415,-29	
				[1, "cr_enclave_armet_late"],               //400,-28
				[1, "crknight_helmet_late_mixed"],                //410, min 400	
				[1, "crknight_helmet_late_mixed_patched"],        //405, min 390 
				[3, "crknight_faction_helm_great_helm_faceplate_heavy_02",banner],      //410,-32 					
			]));
		}	
		else if (dc <= 210)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "cr_plate_full_late"],       //370,-50             
				[2, "cr_plate_full_heavy"],       //380,-49          380
				[1, "cr_plate_full_knight"]		 //430,-56						
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([					
				[2, "cr_enclave_great_bascinet_late"],               //465,-32			 	      440,9/18
				[5, "crknight_faction_helm_enclave_venitian_bascinet",banner],   //460,-33
				[3, "cr_enclave_venitian_bascinet"],               //460,-33	
				[1, "crknight_faction_helm_enclave_great_bascinet",banner],  //415,-29       
				[1, "cr_enclave_great_bascinet"],               //415,-29	
				[1, "crknight_helmet_late_mixed"],                //410, min 400	
				[1, "crknight_helmet_late_mixed_patched"],        //405, min 390					
				[1, "crknight_helmet_late_enclave_ichi"],               //420
				[3, "crknight_faction_helm_frogmouth_faceplate",banner],  //440,-30					
			]));
		}
		else if (dc <= 235)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "cr_plate_full_heavy_late"],       //435,-57         410
				[1, "cr_plate_full_heavy"],       //380,-49
				[1, "cr_plate_full_knight"]		 //430,-56						
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([												
				[4, "crknight_faction_helm_enclave_great_helm",banner],    //475,-36       480,4/8
				[1, "cr_enclave_great_helm"],                //475,-36						
				[1, "cr_enclave_great_bascinet_late"],              //465,-32
				[1, "crknight_helmet_late_enclave_ni"],               //460
				[1, "crknight_helmet_late_enclave_sann"]               //460					
			]));
		}
		else if (dc > 235)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[2, "cr_plate_full_knight_late"],        //465,-58          450
				[1, "cr_plate_full_knight"]		 //430,-56						
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([						
				[1, "cr_enclave_venitian_bascinet_late"],               //490,-31			       500,4/8			
				[4, "crknight_faction_helm_enclave_great_helm_late",banner],    //515
				[1, "cr_enclave_great_helm"],                //475,-36	
				[2, "cr_enclave_great_helm_late"],               //515
				[1, "cr_lion_helmet"],               //515					
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
			"weapons/named/named_greatsword",
			"weapons/named/named_mace",
			"weapons/named/named_sword",
			"weapons/named/named_longsword"
		];
		local shields = clone this.Const.Items.NamedShields;
		local r = this.Math.rand(1, 4);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}
		else if (r == 3)	
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "cr_named_full_armor_cloth"],	
				[1, "cr_named_full_armor_chain"],		
				[1, "cr_named_full_armor_plate"],					
			]));
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[
					1,
					"cr_named_full_helmet"
				]
			]));
		}
		this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		return true;
	}
});	