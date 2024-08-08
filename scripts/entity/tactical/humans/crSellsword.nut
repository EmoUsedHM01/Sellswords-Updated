this.crSellsword <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crSellsword;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crSellsword.XP;
		this.human.create();
		this.m.Bodies = this.Const.Bodies.AllMale;
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.BeardChance = 60;
		this.m.Ethnicity = 1;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_melee_agent");
		this.m.AIAgent.setActor(this);
		if (this.Math.rand(1, 100) <= 15)
		{
			this.setGender(1);
		}		
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.crSellsword);
		b.DamageTotalMult += 0.1;		
		b.IsSpecializedInThrowing = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");

		if (this.Math.rand(1, 100) <= 15)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			this.getSprite("eye_rings").Visible = true;
		}
		
		local perkpool = [
			[4, ["perk_crippling_strikes", "perk_coup_de_grace"], 2],
			[2, "perk_legend_muscularity", 1],		
			[3, "perk_fearsome", 2],				
			[1, "perk_legend_alert", 2],		
			[1, "perk_head_hunter", 1],	
			[1, "perk_legend_assured_conquest", 1],				
			[2, "perk_legend_onslaught", 1],			
			[2, "perk_steadfast", 1],
			[1, "perk_lone_wolf", 1],
			[2, "perk_steel_brow", 1],
			[2, "perk_anticipation", 1],
			[6, "perk_colossus", 1],
			[1, "perk_stalwart", 1],
			[8, "perk_underdog", 1],			
			[2, "perk_last_stand", 1],
			[2, "perk_nine_lives", 2],			
			[1, "perk_legend_second_wind", 1],	
			[2, "perk_crBlocknormal", 1],
			[2, "perk_crTrumpcard", 1],
			[1, "perk_crBruiser", 1],
			[1, "perk_crRavager", 1],
			[1, "perk_crDiscipline", 1],
			[1, "perk_crAnchor", 1],
			[1, "perk_crBattlerhaposdy", 1],			
		]

		if (::Is_PTR_Exist)
		{
			this.m.Skills.addPerkTree(this.Const.Perks.ThrowingTree);

			perkpool.extend([
				//[4, "perk_ptr_fresh_and_furious", 2],
				[4, "perk_ptr_unstoppable", 2],	
				[4, ["perk_ptr_menacing", "perk_ptr_bully"], 2],
				[1, "perk_ptr_primal_fear", 1],			
				[3, "perk_ptr_vigorous_assault", 2],
				[2, "perk_ptr_fruits_of_labor", 1],	
				[2, "perk_ptr_wears_it_well", 1],
				[4, "perk_ptr_pattern_recognition", 2],	
				[3, "perk_ptr_survival_instinct", 1],
				[1, "perk_ptr_marksmanship", 1],
			])
		}

		perkpool = this.Const.World.Common.pickPerks(perkpool, 16);
		foreach(perk in perkpool)
		{
			this.m.Skills.add(perk);	
		}

		if (this.Math.rand(1, 100) <= 30)
		{
			this.setMoraleState(this.Const.MoraleState.Confident);
		}		
		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));		

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));			
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));

			if (::Is_PTR_Exist && this.Math.rand(1, 100) <= 0.25 * this.World.getTime().Days)
			{
				this.m.Skills.add(this.new("scripts/skills/effects/ptr_fresh_and_furious_effect"));				
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
			if (roll <= 3.0)
				::Mod_Sellswords.add_serpent(this.actor, false);
			else if (roll <= 6.0)
				::Mod_Sellswords.add_spider(this.actor, false);
			else if (roll <= 9.0)
				::Mod_Sellswords.add_direwolf(this.actor, false);
			else if (roll <= 12.0)
				::Mod_Sellswords.add_ghoul(this.actor, false);
			else if (roll <= 15.0)
				::Mod_Sellswords.add_orc(this.actor, false);
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
		local r;
		local v = this.Math.rand(1, 100);

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons;
			if (v <= 45)
			{
				weapons = [
					"weapons/greataxe",
					"weapons/legend_battle_glaive",
					"weapons/legend_military_goedendag",
					"weapons/legend_heavy_goedendag",			
					"weapons/two_handed_flanged_mace",
					"weapons/two_handed_hammer",							
					"weapons/military_cleaver",
					"weapons/noble_sword",
					"weapons/warhammer",	
					"weapons/fighting_axe",	
					"weapons/spontoon03",				
				]
			}
			else if (v <= 65)
			{
				weapons = [
					"weapons/bardiche",		
					"weapons/battle_whip",						
					"weapons/two_handed_flanged_mace",
					"weapons/two_handed_hammer",			
					"weapons/fighting_spear",
					"weapons/legend_katar",					
					"weapons/shamshir",
					"weapons/three_headed_flail",				
					"weapons/oriental/heavy_southern_mace",
					"weapons/oriental/qatal_dagger",					
					"weapons/oriental/two_handed_scimitar",
					"weapons/spontoon03",					
				]
			}
			else if (v <= 75)
			{
				weapons = [
					"weapons/ancient/legend_great_khopesh",
					"weapons/ancient/legend_khopesh",
					"weapons/ancient/legend_fan_axe",						
				]
			}
			else if (v <= 80)
			{
				weapons = [
					"weapons/greenskins/goblin_falchion",	
					"weapons/greenskins/goblin_spear",						
				]
			}
			else if (v <= 90)
			{
				weapons = [
					"weapons/greenskins/legend_man_mangler",				
					"weapons/greenskins/legend_skullbreaker",	
					"weapons/greenskins/orc_cleaver",	
					"weapons/greenskins/orc_axe_2h",	
					"weapons/greenskins/orc_axe",						
				]
			}	
			else if (v <= 100)
			{
				weapons = [
					"weapons/barbarians/heavy_rusty_axe",	
					"weapons/barbarians/rusty_warblade",
					"weapons/barbarians/twinaxes_t1",
					"weapons/barbarians/twincleavers_t1",					
				]
			}										
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));							
		}
		
		if (::Is_PTR_Exist)
		{
			//this.m.Skills.addTreeOfEquippedWeapon(7);

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
			{
				this.m.Skills.addPerkTree(this.Const.Perks.TwoHandedTree);
			}	
		}
		
		else if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
					
			if (this.Math.rand(1, 100) <= 66)
			{
				r = this.Math.rand(0, 2);

				if (r == 0)
				{
					this.m.Items.equip(this.new("scripts/items/tools/fire_bomb_item"));
				}
				else if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/tools/daze_bomb_item"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/tools/acid_flask_item"));
				}
			}
			else
			{
				r = this.Math.rand(0, 1);

				if (r == 0)
				{
					this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));
				}
				else if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/tools/reinforced_throwing_net"));
				}
			}
		}
		
		local mainhandItem = this.getMainhandItem();		
		if (mainhandItem != null && mainhandItem.isItemType(this.Const.Items.ItemType.OneHanded))
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_double_strike"));
			
			if (::Is_PTR_Exist)
			{
				this.m.Skills.addPerkTree(this.Const.Perks.OneHandedTree);		
			}
		}		

		if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 80)
		{
			r = this.Math.rand(1, 6);

			if (r == 1)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
			}
			else if (r == 2)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/barbarians/heavy_throwing_axe"));
			}			
			else if (r == 3)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
			}
			else if (r == 4)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/barbarians/heavy_javelin"));
			}
			else if (r == 5)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/goblin_spiked_balls"));
			}			
			else if (r == 6)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_spear"));
			}

		}

		if (v <= 40)				//northern
		{
			local r = this.Math.rand(1, 3);	
			if (r == 1)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "cr_plate_scale_mid"],	  //315,-40							 320
					[1, "cr_plate_full_mid"],		   //320,-41
					[1, "cr_plate_full_mid_reinforced"],	 //335,-43	
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "cr_enclave_armet"],			   //355,-24					 340
					[1, "crknight_helmet_mid_bread"],			//350,-23 
					[1, "crknight_helmet_mid_decorative"],		 //335,-22
					[1, "crknight_helmet_mid_unadorned"],			//325 -21				
				]));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "sellsword_armor_medium"],	  	  //165,-22
					[2, "sellsword_armor_medium_chain"],		  //190,-21	
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[5, "sellsword_helmet_medium"],			   	//185,-9
					[1, "crfeathered_helmet"],			   	// 210,-9 ~ 220,-10					
				]));
			}
			else if (r == 3)				
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "sellsword_armor_light"],	  //150,-11	 	
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "sellsword_helmet_light"],	   //140,-6				   				
				]));
			}
			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
			
			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));	
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vigilant"));
			}		
		}
		else if (v <= 45)					  //zombie
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[2, "sellsword_armor_undead"]		 //250,-30										
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "sellsword_helmet_undead"],			//235,-16					
			]));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bear_down"));
				local wearDownPerk = this.new("scripts/skills/perks/perk_ptr_wear_them_down");
				wearDownPerk.m.IsForceEnabled = true;
				this.m.Skills.add(wearDownPerk);	
			}
			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));			
		}
		else if (v <= 65)					//southern
		{
			local r = this.Math.rand(1, 3);	
			if (r == 1)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "solemner_late_medium_armor"],	  //290,-35 						
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "solemner_late_medium_helmet"],		   			
				]));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "crGuardsman_armor_ichi"],		  //~200 -23
					[1, "crGuardsman_armor_ni"],	  //~225 -27
					[1, "crGuardsman_armor_sann"],	 //~205 -25	
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[5, "crGuardsman_helmet"],			   //190, -10
					[1, "crfeathered_helmet"],			   	// 210,-9 ~ 220,-10			  			
				]));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[2, "crGuardsman_armor_light"],	  //~135 -11
					[1, "solemner_late_light_armor"],		   //120
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[2, "crGuardsman_helmet_light"],		   //155, -6 	   
					[1, "solemner_late_light_helmet"],			 				
				]));
			}
			this.m.Skills.add(this.new("scripts/skills/actives/throw_dirt_skill"));			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fortified_mind"));			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mind_over_body"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_exude_confidence"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_strength_in_numbers"));
			}		
		}	
		else if (v <= 75)				   //ancient
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "sellsword_armor_ancient"],		   	//250,-33				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[1, "sellsword_helmet_ancient"],			//235,-19				 				 					
			]));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_battleheart"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_man_of_steel"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_personal_armor"));	
			}
		}
		else if (v <= 80)				 //goblin
		{
			local r = this.Math.rand(1, 3);	
			if (r <= 2)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "sellsword_armor_light"],	  //150,-11	 	
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "sellsword_helmet_light"],	   //140,-6				   				
				]));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "crGuardsman_armor_light"],	  //~135 -11
					[1, "solemner_late_light_armor"],		   //120	
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "crGuardsman_helmet_light"],		   //155, -6 	   
					[1, "solemner_late_light_helmet"],		   			
				]));
			}

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_strength_in_numbers"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_tempo"));
				local kata = this.new("scripts/skills/perks/perk_ptr_kata");
				kata.m.IsForceEnabled = true;
				this.m.Skills.add(kata);
			}
			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mastery_nets"));
			
		}
		else if (v <= 90)				 //orc
		{
			local r = this.Math.rand(1, 3);	
			if (r == 1)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "cr_plate_scale_mid"],	  //315,-40							 320
					[1, "cr_plate_full_mid"],		   //320,-41
					[1, "cr_plate_full_mid_reinforced"],	 //335,-43	
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "cr_enclave_armet"],			   //355,-24					 340
					[1, "crknight_helmet_mid_bread"],			//350,-23 
					[1, "crknight_helmet_mid_decorative"],		 //335,-22
					[1, "crknight_helmet_mid_unadorned"],			//325 -21				
				]));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "solemner_late_medium_armor"],	  //290,-35 						
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "solemner_late_medium_helmet"],		   			
				]));
			}			
			else if (r == 3)	 
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "sellsword_armor_barb"],		   //320,-41				   				
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([				
					[1, "sellsword_helmet_barb"],			//350,-23		  					
				]));
			}

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_unstoppable"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_man_of_steel"));	
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_savage_strength"));		
			}
			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));			
			this.m.Skills.add(this.new("scripts/skills/traits/iron_jaw_trait"));			
		}
		else if (v <= 100)				 //barbarian
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "sellsword_armor_barb"],				//255,-38
				[1, "sellsword_armor_barb_medium"],		  //240,-31 				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[1, "sellsword_helmet_barb"],			//255,-18		  					
			]));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/effects/ptr_fresh_and_furious_effect"));	
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vigorous_assault"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_unstoppable"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_savage_strength"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_feral_rage"));
			}
			this.m.Skills.add(this.new("scripts/skills/actives/barbarian_fury_skill"));	
			this.m.Skills.removeByID("perk.rotation");			
		}
		
		local fat = 0;
		local body = this.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local head = this.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		if (body != null)
		{
			fat = fat + body.getStaminaModifier();
		}

		if (head != null)
		{
			fat = fat + head.getStaminaModifier();
		}
		fat = this.Math.abs(fat);
		
		if (fat <= 24)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));			
			this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));		
		}
		if (fat <= 40 && fat >= 20)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_lithe"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_balance"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_perfect_fit"));			
		}
		if (fat >= 25)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bulwark"));	
			}
		}
		
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);	
	}
});

