this.crSellswordveteran <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crSellswordveteran;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crSellswordveteran.XP;
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
		b.setValues(this.Const.Tactical.Actor.crSellswordveteran);
		b.IsSpecializedInThrowing = true;
		b.DamageTotalMult += 0.2;
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
		
		if (this.Math.rand(1, 100) <= 50)
		{
			this.setMoraleState(this.Const.MoraleState.Confident);
		}
				
		local perkpool = [
			[4, ["perk_crippling_strikes", "perk_coup_de_grace"], 2],
			[2, ["perk_legend_muscularity", "perk_crGrandslam"], 2],				
			[3, "perk_fearsome", 2],
			[2, ["perk_legend_alert","perk_legend_onslaught"], 2],
			[2, ["perk_steel_brow", "perk_stalwart"], 2],	
			[2, ["perk_colossus", "perk_steadfast"], 2],
			[2, ["perk_lone_wolf", "perk_anticipation"], 2],			
			[1, "perk_head_hunter", 1],													
			[2, "perk_last_stand", 1],
			[2, "perk_nine_lives", 2],			
			[2, "perk_crBlocknormal", 1],
			[2, "perk_crTrumpcard", 1],
			[1, "perk_crBruiser", 1],
			[1, "perk_crRavager", 1],
			[1, "perk_crIronsideweak", 1],
			[1, "perk_crBattlerhaposdy", 1]			
		];

		if (::Is_PTR_Exist)
		{
			perkpool.extend([
				[1, "perk_ptr_primal_fear", 1],			
				[3, "perk_ptr_vigorous_assault", 2],						
				//[4, "perk_ptr_fresh_and_furious", 2],
				[1, ["perk_ptr_wears_it_well", "perk_ptr_fruits_of_labor"], 2],	
				[1, "perk_ptr_strength_in_numbers", 1],	
				[1, "perk_ptr_marksmanship", 1],
				[3, ["perk_ptr_menacing", "perk_ptr_bully"], 2],
			]);

			this.m.Skills.addPerkTree(this.Const.Perks.ThrowingTree);

			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_unstoppable"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));
		}

		perkpool = this.Const.World.Common.pickPerks(perkpool, 16);
		foreach(perk in perkpool)
		{
			this.m.Skills.add(perk);	
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
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_second_wind"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));		

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mastery_nets"));			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));		
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/traits/iron_jaw_trait"));

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
		local r = this.Math.rand(1, 3);
		local rt = this.Math.rand(1, 4);
		if (r == 1)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_man_of_steel"));
			}			
			if (rt == 1)
			{	
				this.getSprite("accessory_special").setBrush("orc_trophy");		
			}
			else if (rt == 2)
			{
				this.getSprite("accessory_special").setBrush("legend_pack_large");	
			}
			else if (rt == 3)
			{
				this.getSprite("accessory_special").setBrush("undead_trophy");			
			}			
		}
		else if (r == 2)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_lithe"));
			if (rt == 1)
			{
				this.getSprite("accessory_special").setBrush("nachzehrer_trophy");			
			}
			else if (rt == 2)
			{	
				this.getSprite("accessory_special").setBrush("hexe_trophy");	
			}
			else if (rt == 3)
			{	
				this.getSprite("accessory_special").setBrush("hexe_leader_trophy");	
			}			
		}
		else if (r == 3)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
			if (rt == 1)
			{	
				this.getSprite("accessory_special").setBrush("goblin_trophy");	
			}
			else if (rt == 2)
			{
				this.getSprite("accessory_special").setBrush("alp_trophy");
			}
			else if (rt == 3)
			{
				this.getSprite("accessory_special").setBrush("wolfsbane_necklace");	
			}			
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

	function assignRandomEquipment()
	{
		local r;
		local v = this.Math.rand(1, 100);

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			r = this.Math.rand(1, 100);
			local weapons;
			if (r <= 50)
			{
				weapons = [
					"weapons/greataxe",
					"weapons/legend_battle_glaive",
					"weapons/legend_military_goedendag",
					"weapons/legend_heavy_goedendag",			
					"weapons/two_handed_flanged_mace",
					"weapons/two_handed_hammer",							
					"weapons/ancient/legend_great_khopesh",
					"weapons/ancient/legend_fan_axe",				
					"weapons/bardiche",					
					"weapons/two_handed_flanged_mace",
					"weapons/two_handed_hammer",				
					"weapons/oriental/two_handed_scimitar",					
					"weapons/greenskins/legend_man_mangler",				
					"weapons/greenskins/legend_skullbreaker",		
					"weapons/greenskins/orc_axe_2h",	
					"weapons/barbarians/heavy_rusty_axe",	
					"weapons/barbarians/rusty_warblade",
					"weapons/spontoon03",						
				]
				this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));	

				if (::Is_PTR_Exist)
				{
					this.m.Skills.addPerkTree(this.Const.Perks.TwoHandedTree);				
					local attack = this.getSkills().getAttackOfOpportunity();	
					if (attack != null && attack.isDuelistValid())
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
					}	
				}
			}	
			else
			{
				weapons = [
					"weapons/military_cleaver",
					"weapons/noble_sword",
					"weapons/warhammer",	
					"weapons/fighting_axe",					
					"weapons/battle_whip",						
					"weapons/fighting_spear",
					"weapons/legend_katar",					
					"weapons/shamshir",
					"weapons/three_headed_flail",				
					"weapons/oriental/heavy_southern_mace",
					"weapons/oriental/qatal_dagger",
					"weapons/greenskins/orc_axe",
					"weapons/greenskins/orc_cleaver",					
					"weapons/greenskins/goblin_falchion",	
					"weapons/greenskins/goblin_spear",						
				]
			}
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));				
		}
				
		//if (::Is_PTR_Exist)
		//{
		//	this.m.Skills.addTreeOfEquippedWeapon(7);	
		//}	
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);	
			
		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
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
				this.m.Items.equip(this.new("scripts/items/tools/reinforced_throwing_net"));
			}
		}
		
		local mainhandItem = this.getMainhandItem();		
		if (::Is_PTR_Exist && mainhandItem != null && mainhandItem.isItemType(this.Const.Items.ItemType.OneHanded))
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_double_strike"));
			this.m.Skills.addPerkTree(this.Const.Perks.OneHandedTree);	
		}		

		r = this.Math.rand(1, 4);

		if (r == 1)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/barbarians/heavy_throwing_axe"));
		}			
		else if (r == 2)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/barbarians/heavy_javelin"));
		}
		else if (r == 3)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/goblin_spiked_balls"));
		}			
		else if (r == 4)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_spear"));
		}
	
		if (this.m.Skills.hasSkill("perk.battle_forged"))
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "sellsword_armor_heavy_northern"],	 //400					  
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "cr_enclave_great_helm"],				//475,-36						
				[1, "cr_enclave_great_bascinet_late"],			  //465,-32
				[2, "cr_enclave_venitian_bascinet"],			   //460,-33				
			]));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.addPerkTree(this.Const.Perks.HeavyArmorTree);
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_personal_armor"));
			}							
		}
		else if (this.m.Skills.hasSkill("perk.legend_lithe"))
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "sellsword_armor_medium_high_ichi"],	  	  //230,-22
				[2, "sellsword_armor_medium_high_ni"],		  //260,-22
				[2, "sellsword_armor_medium_high_sann"],		  //250,-22	
				[2, "sellsword_armor_medium_high_yonn"],		   //220,-20					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[4, "sellsword_helmet_medium_high"],			   //215,-9
				[2, "sellsword_helmet_medium_gladitor"],			   //225,-9
				[1, "crfeathered_helmet"],			   	// 210,-9 ~ 220,-10					
			]));
			
			if (::Is_PTR_Exist)
			{
				this.m.Skills.addPerkTree(this.Const.Perks.MediumArmorTree);
			}			
		}
		else if (this.m.Skills.hasSkill("perk.nimble"))				
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "sellsword_armor_light_high_ichi"],	  //160,-9
				[1, "sellsword_armor_light_high_ni"],	  //140,-9				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "sellsword_helmet_light_high"],		//170,-5				   				
			]));
			
			if (::Is_PTR_Exist)
			{
				this.m.Skills.addPerkTree(this.Const.Perks.LightArmorTree);
			}		
		}				
	}
	
	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");

		local n = this.Math.rand(1, 3);
		if (n != 1)
		{
			local weapons;
			local r = this.Math.rand(1, 2);			
			if (r == 1)
			{
				weapons = [
					"weapons/named/legend_named_military_goedendag",
					"weapons/named/legend_named_glaive",
					"weapons/named/named_bardiche",
					"weapons/named/named_greataxe",
					"weapons/named/named_heavy_rusty_axe",
					"weapons/named/named_legend_great_khopesh",							
					"weapons/named/named_orc_axe_2h",
					"weapons/named/named_orc_flail_2h",
					"weapons/named/named_rusty_warblade",
					"weapons/named/named_skullhammer",
					"weapons/named/named_two_handed_flail",
					"weapons/named/named_two_handed_hammer",
					"weapons/named/named_two_handed_mace",
					"weapons/named/named_two_handed_scimitar",				
					"weapons/named/named_two_handed_spiked_mace",					
				];

				if (::Is_PTR_Exist)
				{
					this.m.Skills.addPerkTree(this.Const.Perks.TwoHandedTree);	
				}
			}	
			else if (r == 2)	
			{
				weapons = [
					"weapons/named/legend_named_gladius",
					"weapons/named/named_warhammer",	
					"weapons/named/named_axe",					
					"weapons/named/named_battle_whip",						
					"weapons/named/named_cleaver",
					"weapons/named/named_crypt_cleaver",					
					"weapons/named/named_flail",
					"weapons/named/named_goblin_falchion",				
					"weapons/named/named_goblin_spear",
					"weapons/named/named_heavy_southern_mace",
					"weapons/named/named_khopesh",
					"weapons/named/named_mace",					
					"weapons/named/named_orc_axe",	
					"weapons/named/named_orc_cleaver",
					"weapons/named/named_qatal_dagger",
					"weapons/named/named_spear",					
					"weapons/named/named_sword",	
					"weapons/named/named_three_headed_flail",
					"weapons/named/named_spontoon",					
				];

				this.m.Skills.add(this.new("scripts/skills/perks/perk_double_strike"));
				
				if (::Is_PTR_Exist)
				{
					this.m.Skills.addPerkTree(this.Const.Perks.OneHandedTree);		
				}
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

			if (::Is_PTR_Exist)
			{
				local attack = this.getSkills().getAttackOfOpportunity();	
				if (attack != null && attack.isDuelistValid())
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
				}
			}		
		}
		
		if (n != 2)
		{
			if (this.m.Skills.hasSkill("perk.battle_forged"))
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "crsellsword_named_armor_heavy_cloth"],		   					
					[1, "crsellsword_named_armor_heavy_chain"],		   	
					[1, "crsellsword_named_armor_heavy_plate"],		   	 
					[1, "crsellsword_barbarian_bronze"],		   	  				
				]));			
			}
			if (this.m.Skills.hasSkill("perk.legend_lithe"))
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "crsellsword_named_armor_medium_cloth"],		   	//255,-24				
					[1, "crsellsword_named_armor_medium_chain"],		   	//275,-24
					[1, "crsellsword_named_armor_medium_plate"],		   	//310,-24
					[1, "crsellsword_named_armor_medium_plate02"],		   //275,-26
					[1, "crsellsword_barbarian_fur"],		   	 //270,-25				
					[1, "crsellsword_barbarian_skull"],		   	//275,-24				
				]));			
			}
			if (this.m.Skills.hasSkill("perk.nimble"))				
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "crsellsword_named_armor_light_chain"],			//180,-12
					[1, "crsellsword_named_armor_light_plate_01"],			//180,-10 
					[1, "crsellsword_named_armor_light_plate_02"],			//185,-10
					[1, "crsellsword_named_armor_light_plate_03"],			//160,-9 	
					[1, "crsellsword_named_armor_light_cloth"],			//160,-9 			
				]));			
			}	
			this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 30;
			this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 30;			
		}
		
		if (n != 3)
		{
			if (this.m.Skills.hasSkill("perk.battle_forged"))
			{
				this.m.Items.equip(this.Const.World.Common.pickHelmet([				
					[4, "crsellsword_named_helmet_stag"],			//400
					[1, "crsellsword_named_helmet_nordic"],			//350,-20					
					[2, "crbarbarian_champion_heavy"],			//375,-24					
				]));			
			}
			if (this.m.Skills.hasSkill("perk.legend_lithe"))		
			{
				this.m.Items.equip(this.Const.World.Common.pickHelmet([				
					[1, "crsellsword_named_helmet_bascinet"],			//250,-9 
					[1, "crsellsword_named_helmet_steppe"],			//220,-9					
					[1, "crsellsword_named_helmet_italo_norman"],			//215,-8
					[1, "crsellsword_named_helmet_deep_sallet"],			//290,-13
					[1, "crsellsword_named_helmet_kettle"],			//250,-12
					[1, "crsellsword_named_helmet_tailed_conic"],			//260,-12	
					[1, "crsellsword_named_helmet_wallace"],			 //275,-11						
				]));	
			}
			if (this.m.Skills.hasSkill("perk.nimble"))  		
			{
				this.m.Items.equip(this.Const.World.Common.pickHelmet([				
					[1, "crsellsword_named_helmet_dentist"],			 //145,-5  
					[1, "crsellsword_named_helmet_barbute"],			//145,-4
					[1, "crsellsword_named_helmet_southern_conic"],			//150,-4								 					
				]));			
			}
			this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 30;
			this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 30;				
		}
		
		if (this.Math.rand(1, 100) <= 33)
		{
			local r = this.Math.rand(1, 2);

			if (r == 1)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/named/named_javelin"));
			}			
			else if (r == 2)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/named/named_throwing_axe"));
			}			
		}
		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_adrenalin"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steadfast"));	
				
		return true;
	}
	
});

