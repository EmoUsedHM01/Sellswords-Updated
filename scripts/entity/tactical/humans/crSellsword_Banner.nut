this.crSellsword_Banner <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crSellsword_Banner;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crSellsword_Banner.XP;
		this.human.create();
		this.m.Bodies = this.Const.Bodies.AllMale;
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.BeardChance = 60;
		this.m.Ethnicity = 1;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_standard_bearer_agent");
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
		b.setValues(this.Const.Tactical.Actor.crSellsword_Banner);
		b.DamageTotalMult += 0.1;			
		b.IsSpecializedInThrowing = true;
		b.TargetAttractionMult = 1.5;		
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		
		if (this.Math.rand(1, 100) <= 50)
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
		this.m.Skills.add(this.new("scripts/skills/perks/perk_inspiring_presence"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
		
		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_exude_confidence"));

			this.m.Skills.addPerkTree(this.Const.Perks.PolearmTree, 7);
		}

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));		
			this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));		
			this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));				
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));			
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			if (this.Math.rand(1, 100) <= 10)
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
		local v = this.Math.rand(1, 100);
		local banner;
		local banner = this.getFaction();
		banner -= 13;
		banner = this.Math.min(31, this.Math.max(1, banner));
		local weapon = this.new("scripts/items/tools/player_banner");
		weapon.setVariant(banner);
		weapon.m.IsDroppedAsLoot = false;
		this.m.Items.equip(weapon);
										
		if (v <= 45)				//northern
		{
			local r = this.Math.rand(1, 2);	
			if (r == 1)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "sellsword_armor_medium"],	  	  //165,-22
					[2, "sellsword_armor_medium_chain"],		  //190,-21	
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "sellsword_helmet_medium"],			   	//185,-9
				]));
			}
			else if (r == 2)				
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
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vigilant"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));	
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));
			}		
		}
		else if (v <= 70)					//southern
		{
			local r = this.Math.rand(1, 2);	
			if (r == 1)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "crGuardsman_armor_ichi"],		  //~200 -23
					[1, "crGuardsman_armor_ni"],	  //~225 -27
					[1, "crGuardsman_armor_sann"],	 //~205 -25	
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "crGuardsman_helmet"],			   //190, -10		  			
				]));
			}
			else if (r == 2)
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
		else if (v <= 85)				   //ancient
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
		else if (v <= 100)				 //goblin
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
	}

});

