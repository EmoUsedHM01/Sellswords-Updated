this.crSellswordveteran_Tank <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crSellswordveteran_Tank;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crSellswordveteran_Tank.XP;
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
		b.setValues(this.Const.Tactical.Actor.crSellswordveteran_Tank);
		b.DamageTotalMult += 0.2;	
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

		if (this.Math.rand(1, 100) <= 50)
		{
			this.setMoraleState(this.Const.MoraleState.Confident);
		}
		
		local perkpool = [
			[2, ["perk_crippling_strikes", "perk_coup_de_grace"], 2],			
			[1, "perk_fearsome", 2],
			[2, ["perk_legend_alert","perk_legend_onslaught"], 2],
			[2, ["perk_stalwart", "perk_steadfast"], 2],
			[1, ["perk_lone_wolf", "perk_anticipation"], 2],			
			[1, "perk_head_hunter", 1],													
			[2, "perk_nine_lives", 2],			
			[2, "perk_crBlocknormal", 1],
			[2, "perk_crIronsideweak", 1],		
		]

		if (::Is_PTR_Exist)
		{
			perkpool.extend([
				[1, ["perk_ptr_menacing", "perk_ptr_bully"], 2],
				[1, "perk_ptr_primal_fear", 1],			
				[1, "perk_ptr_vigorous_assault", 2],						
				//[1, "perk_ptr_fresh_and_furious", 2],
				[4, ["perk_ptr_wears_it_well", "perk_ptr_fruits_of_labor"], 2],
				[4, "perk_ptr_strength_in_numbers", 1],		
			]);

			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_offhand_training"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_strength_in_numbers"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_the_rush_of_battle"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_str_phalanx"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_str_cover_ally"))	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_str_line_breaker"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_str_cover_ally"));
		}

		perkpool = this.Const.World.Common.pickPerks(perkpool, 10);
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
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_battleheart"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crGuardian"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crTotalcover"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crFurinkazan"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_last_stand"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_second_wind"));	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));		
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));			
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
		local r = this.Math.rand(1, 100);
		local rt = this.Math.rand(1, 4);		
		if (r <= 45)
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
		else if (r <= 80)
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
		else if (r <= 100)
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
	}

	function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{	
			local weapons = [
					"weapons/fighting_spear",
					"weapons/fighting_spear",
					"weapons/fighting_spear",
					"weapons/fighting_spear",	
					"weapons/fighting_spear",
					"weapons/fighting_spear",					
					"weapons/shamshir",
					"weapons/shamshir",	
					"weapons/shamshir",					
					"weapons/noble_sword",
					"weapons/noble_sword",	
					"weapons/noble_sword",						
					"weapons/fighting_axe",									
					"weapons/military_cleaver",										
					"weapons/warhammer",	
					"weapons/winged_mace",
					"weapons/three_headed_flail",				
					"weapons/oriental/heavy_southern_mace",					
				];		
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

			//if (::Is_PTR_Exist)
			//{
			//	this.m.Skills.addTreeOfEquippedWeapon(7);	
			//}	
			::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);		
		}

		local r = this.Math.rand(1, 5);
		local shield;
		//local banner = this.getFaction();	
		//banner -= 2;		

		if (r == 1)
		{
			shield = this.new("scripts/items/shields/special/craftable_schrat_shield");
		}
		else if (r == 2)
		{
			shield = this.new("scripts/items/shields/special/craftable_lindwurm_shield");			
		}
		else if (r == 3)
		{
			shield = this.new("scripts/items/shields/special/craftable_kraken_shield");			
		}		
		else if (r >= 4)
		{
			shield = this.new("scripts/items/shields/legend_tower_shield");	
			//shield.setVariant(banner);				
		}
		this.m.Items.equip(shield);		
		
		if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 80)
		{
			r = this.Math.rand(1, 5);

			if (r == 1)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
			}			
			else if (r == 2)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
			}			
			else if (r == 3)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_spear"));
			}
			else if (r == 4)
			{
				this.m.Items.addToBag(this.new("scripts/items/tools/reinforced_throwing_net"));
			}			
			else if (r == 5)
			{
				this.m.Items.addToBag(this.new("scripts/items/tools/reinforced_throwing_net"));
			}			
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
		
		local shields = clone this.Const.Items.NamedShields;
		shields = this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]);
		local n = this.Math.rand(1, 100);		
		if (n <= 10)
		{
			shields = this.new("scripts/items/shields/special/legend_craftable_greenwood_schrat_shield");			
		}
		else if (n <= 20)
		{
			shields = this.new("scripts/items/shields/named/named_lindwurm_shield");		
		}	
		this.m.Items.equip(shields);		
		//this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));		

		n = this.Math.rand(1, 3);
		if (n == 1)
		{
			local weapons = [
				"weapons/named/legend_named_gladius",
				"weapons/named/named_warhammer",	
				"weapons/named/named_axe",											
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
				"weapons/named/named_sword",	
				"weapons/named/named_three_headed_flail",	
				"weapons/named/named_spear",
				"weapons/named/named_spear",
				"weapons/named/named_spear",	
				"weapons/named/named_spear",					
			];						
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			
			if (::Is_PTR_Exist)
			{
				this.m.Skills.addPerkTree(this.Const.Perks.OneHandedTree);
			}			
		}
		
		else if (n == 2)
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
			else if (this.m.Skills.hasSkill("perk.legend_lithe"))
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
			else if (this.m.Skills.hasSkill("perk.nimble"))				
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
		
		else if (n == 3)
		{
			if (this.m.Skills.hasSkill("perk.legend_lithe"))		
			{
				this.m.Items.equip(this.Const.World.Common.pickHelmet([				
					[1, "crsellsword_named_helmet_bascinet"],			//250,-9  
					[1, "crsellsword_named_helmet_italo_norman"],			//215,-8
					[1, "crsellsword_named_helmet_deep_sallet"],			//290,-13
					[1, "crsellsword_named_helmet_kettle"],			//250,-12
					[1, "crsellsword_named_helmet_tailed_conic"],			//260,-12
					[1, "crsellsword_named_helmet_wallace"],			 //275,-11						
				]));	
			}
			else if (this.m.Skills.hasSkill("perk.battle_forged"))
			{
				this.m.Items.equip(this.Const.World.Common.pickHelmet([				
					[2, "crsellsword_named_helmet_stag"],			//235,-19
					[1, "crbarbarian_champion_heavy"],			//375,-24					
				]));			
			}			
			else if (this.m.Skills.hasSkill("perk.nimble"))  		
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

