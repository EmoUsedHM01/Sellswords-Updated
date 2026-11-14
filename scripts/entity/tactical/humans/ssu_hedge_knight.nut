this.ssu_hedge_knight <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.SsuHedgeKnight;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.SsuHedgeKnight.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.SsuHedgeKnight);
		b.TargetAttractionMult = 1.0;
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_armor_mastery_heavy"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_devastating_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_resilient"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_flux"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_second_wind"));				
				
		local dc = this.World.getTime().Days;			
		local blk = this.Math.rand(1, 100);
		if (dc > 220 && blk >= 90)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_blockmaster"));
		}
		else if(dc > 180 && blk >= 75)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_blockskilled"));
		}
		else if(dc > 140 && blk >= 60)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_blocknormal"));
		}
		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_ravager"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_feint"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_bloody_harvest"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));
		}

		if (this.World.getTime().Days >= 75)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_true_believer"));
			this.m.BaseProperties.Stamina += 5;
			if (this.World.getTime().Days >= 100)
			{
						
				this.m.BaseProperties.Stamina += 5;						
				if (this.World.getTime().Days >= 125)
				{
					
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_honorheritage"));					
					this.m.BaseProperties.MeleeSkill += 2;			
					this.m.BaseProperties.MeleeDefense += 2;			
					this.m.BaseProperties.RangedDefense += 2;				
					if (this.World.getTime().Days >= 150)
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));				
						this.m.BaseProperties.MeleeSkill += 3;	
						this.m.BaseProperties.Stamina += 5;							
						if (this.World.getTime().Days >= 175)
						{	
															
							this.m.BaseProperties.MeleeDefense += 3;	
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

		if (::Mod_Sellswords.EnableHostileSequences)
		{
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 15.0)
				::Mod_Sellswords.add_unhold(this.actor, true);
		}
	}

	function onDeath(_killer, _skill, _tile, _fatalityType)
	{
		if (::Mod_Sellswords.EnableHostileSequences)
			::Mod_Sellswords.doHostileSequencePotionDrop(_killer, _skill, _tile, _fatalityType, this.actor);
		this.human.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function assignRandomEquipment()
	{
		local dc = this.World.getTime().Days;			
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/greatsword",
				"weapons/ssu_kriegsmesser",				
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
				[1, "ssu_plate_scale_early"],		 //280,-35				
				[1, "ssu_plate_scale_early_patched"],	  //275,-36
				[1, "ssu_plate_full_early"],			//300,-40
				[1, "ssu_plate_full_early_low"],		 //280,-35					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[2, "ssu_knight_helmet_early_unadorned"],			//255 -16	310,-21				   					
				[1, "ssu_knight_helmet_early_decorative"],			//310,-20   280,-17	
				[1, "ssu_enclave_kettle"],			//265,-18	
				[1, "ssu_hedgeknight_low"],			//255,-16							
			]));
		}
		else if (dc <= 100)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[2, "ssu_plate_scale_early"],		 //280,-35				
				[1, "ssu_plate_scale_early_patched"],	  //275,-36
				[3, "ssu_plate_full_early"],			//300,-40
				[1, "ssu_plate_scale_mid"],	  //315,-40
				[1, "ssu_plate_full_mid"],		   //320,-41					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "ssu_knight_helmet_early_unadorned"],			//255 -16	310,-21				  				
				[1, "ssu_knight_helmet_early_decorative"],			//310,-20   280,-17
				[1, "ssu_knight_helmet_mid_bread"],			//350,-23 
				[1, "ssu_knight_helmet_mid_decorative"],		 //335,-22
				[1, "ssu_knight_helmet_mid_unadorned"],			//325 -21
				[1, "ssu_enclave_armet"],			   //330, -22  					 					
			]));
		}
		else if (dc <= 130)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "ssu_plate_scale_mid"],	  //315,-40
				[1, "ssu_plate_full_mid"],		   //320,-41
				[1, "ssu_plate_full_mid_reinforced"],	 //335,-43					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[2, "ssu_knight_helmet_mid_bread"],			//350,-23						350
				[2, "ssu_knight_helmet_mid_decorative"],		 //335,-22
				[1, "ssu_knight_helmet_mid_unadorned"],			//325 -21
				[1, "ssu_enclave_armet"],			   //355,-24  	
				[1, "ssu_knight_helmet_mid_bascinet_faceplate"],			   //385,-26  											
			]));
		}	
		else if (dc <= 160)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "ssu_plate_full_mid"],		   //320,-41
				[1, "ssu_plate_full_mid_reinforced"],	 //335,-43
				[1, "ssu_plate_full_late"],	   //370,-50					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[1, "ssu_knight_helmet_mid_bread"],			//350,-23			   370				 				
				[1, "ssu_enclave_armet"],			   //355,-24  	
				[1, "ssu_knight_helmet_mid_bascinet_faceplate"],			   //385,-26 											
			]));
		}	
		else if (dc <= 190)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "ssu_plate_full_late"],	   //370,-50
				[1, "ssu_plate_full_heavy"],	   //380,-49					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([					
				[1, "ssu_enclave_great_bascinet"],			   //415,-29	
				[1, "ssu_enclave_armet_late"],			   //400,-28
				[1, "ssu_knight_helmet_late_mixed"],				//410, min 400	
				[1, "ssu_knight_helmet_late_mixed_patched"],		//405, min 390					
			]));
		}	
		else if (dc <= 220)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "ssu_plate_full_hedgeknight_midlate"],	   //405
				[1, "ssu_plate_full_heavy"],	   //380,-49
				[1, "ssu_plate_full_knight"]		 //415,-54						
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([					
				[2, "ssu_enclave_great_bascinet_late"],			   //465,-32			 		  440
				[3, "ssu_enclave_venitian_bascinet"],			   //460,-33		 
				[1, "ssu_enclave_great_bascinet"],			   //415,-29	
				[1, "ssu_knight_helmet_late_mixed"],				//410, min 400	
				[1, "ssu_knight_helmet_late_mixed_patched"],		//405, min 390					
				[1, "ssu_knight_helmet_late_enclave_ichi"],			   //420					
			]));
		}
		else if (dc > 220)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "ssu_plate_full_heavy_late"],	   //435,-57
				[2, "ssu_plate_full_hedgeknight"]		 //415,-54						
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([					
				[1, "ssu_enclave_great_helm"],				//475,-36						
				[1, "ssu_enclave_great_bascinet_late"],			  //465,-32
				[1, "ssu_knight_helmet_late_enclave_ni"],			   //460
				[1, "ssu_knight_helmet_late_enclave_sann"]			   //460					
			]));
		}

		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);
	}

	function makeMiniboss()
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
			"weapons/named/legend_named_longsword",
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
				[1, "ssu_named_full_armor_cloth"],	
				[1, "ssu_named_full_armor_chain"],		
				[1, "ssu_named_full_armor_plate"],					
			]));
		}
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
			
		return true;
	}

});

