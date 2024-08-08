this.crSellsword_Lieutenant <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crSellsword_Lieutenant;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crSellsword_Lieutenant.XP;
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
		b.setValues(this.Const.Tactical.Actor.crSellsword_Lieutenant);
		b.DamageTotalMult += 0.2;		
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		this.getSprite("accessory_special").setBrush("sergeant_trophy");

		if (this.Math.rand(1, 100) <= 75)
		{
			this.setMoraleState(this.Const.MoraleState.Confident);
		}		
		
		this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
		this.m.Skills.add(this.new("scripts/skills/actives/rally_the_troops"));
		this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_clarity"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crFoB"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crTotalcover"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.addPerkTree(this.Const.Perks.TacticianClassTree);	

			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_exude_confidence"));		
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vengeful_spite"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_str_line_breaker"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_str_cover_ally"));
		}

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));		
			this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));				
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fortified_mind"));			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mind_over_body"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_true_believer"));			
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));

			if (::Is_PTR_Exist)
			{
				local inspiringPresencePerk = this.new("scripts/skills/perks/perk_inspiring_presence");
				inspiringPresencePerk.m.IsForceEnabled = true;
				this.m.Skills.add(inspiringPresencePerk);			
			}

			if (this.Math.rand(1, 100) <= 35)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_nine_lives"));			
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
		if (r <= 2)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_man_of_steel"));
			}
		}
		else if (r == 3)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_lithe"));	
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
			::Mod_Sellswords.doHostileSequencePotionDrop(_killer, _skill, _tile, _fatalityType, this.getContainer().getActor());
		this.human.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{	
			local weapons = [
					"weapons/fighting_axe",					
					"weapons/fighting_spear",				
					"weapons/military_cleaver",				
					"weapons/noble_sword",						
					"weapons/warhammer",	
					"weapons/winged_mace",
					"weapons/shamshir",
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

		this.m.Items.equip(this.new("scripts/items/shields/legend_tower_shield"));			
		
		if (this.m.Skills.hasSkill("perk.legend_lithe"))
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "sellsword_armor_medium_high_ichi"],	  	  //230,-22
				[2, "sellsword_armor_medium_high_ni"],		  //260,-22
				[2, "sellsword_armor_medium_high_sann"],		  //250,-22	
				[2, "sellsword_armor_medium_high_yonn"],		   //220,-20
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[2, "sellsword_helmet_medium_high"],			   //215,-9
			]));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.addPerkTree(this.Const.Perks.MediumArmorTree);	
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
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_wears_it_well"));
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
				
		if (this.m.Skills.hasSkill("perk.battle_forged"))
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crsellsword_named_armor_heavy_cloth"],		   					
				[1, "crsellsword_named_armor_heavy_chain"],		   	
				[1, "crsellsword_named_armor_heavy_plate"],		   	 
				[1, "crsellsword_barbarian_bronze"],		   	  				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[2, "crsellsword_named_helmet_stag"],			//235,-19
				[1, "crbarbarian_champion_heavy"],			//375,-24					
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
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[1, "crsellsword_named_helmet_bascinet"],			//250,-9  
				[1, "crsellsword_named_helmet_italo_norman"],			//215,-8
				[1, "crsellsword_named_helmet_deep_sallet"],			//290,-13
				[1, "crsellsword_named_helmet_kettle"],			//250,-12
				[1, "crsellsword_named_helmet_tailed_conic"],			//260,-12
				[1, "crsellsword_named_helmet_wallace"],			 //275,-11					
			]));			
		}	
		this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 30;
		this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 30;			
		this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 30;
		this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 30;				
				
		this.m.Skills.add(this.new("scripts/skills/perks/perk_adrenalin"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steadfast"));	
				
		return true;
	}
});

