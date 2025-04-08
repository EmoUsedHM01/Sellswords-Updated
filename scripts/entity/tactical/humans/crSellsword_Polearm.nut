this.crSellsword_Polearm <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crSellsword_Polearm;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crSellsword_Polearm.XP;
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
		b.setValues(this.Const.Tactical.Actor.crSellsword_Polearm);
		b.DamageTotalMult += 0.1;	
		b.IsSpecializedInThrowing = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");

		local perkpool = [
			[4, [::Legends.Perk.CripplingStrikes, ::Legends.Perk.CoupDeGrace], 2],
			[2, ::Legends.Perk.LegendMuscularity, 1],
			[3, ::Legends.Perk.Fearsome, 2],
			[1, ::Legends.Perk.LegendAlert, 2],
			[1, ::Legends.Perk.HeadHunter, 1],
			[1, ::Legends.Perk.LegendAssuredConquest, 1],
			[2, ::Legends.Perk.LegendOnslaught, 1],
			[2, ::Legends.Perk.SteelBrow, 1],
			[2, ::Legends.Perk.Anticipation, 1],
			[6, ::Legends.Perk.Colossus, 1],
			[8, ::Legends.Perk.Underdog, 1],
			[2, ::Legends.Perk.LegendLastStand, 1],
			[2, ::Legends.Perk.NineLives, 2],
			[1, ::Legends.Perk.LegendSecondWind, 1],
			[2, ::Legends.Perk.crBlocknormal, 1],
			[2, ::Legends.Perk.crTrumpcard, 1],
			[1, ::Legends.Perk.crBruiser, 1],
			[1, ::Legends.Perk.crRavager, 1],
			[1, ::Legends.Perk.crDiscipline, 1],
			[1, ::Legends.Perk.crAnchor, 1],
			[1, ::Legends.Perk.crBattlerhaposdy, 1],
		];

		if (::Is_PTR_Exist)
		{
			this.m.Skills.addPerkTree(this.Const.Perks.ThrowingTree);
			this.m.Skills.addPerkTree(this.Const.Perks.PolearmTree, 7);

			perkpool.extend([ // todo strings are not supported anymore, so is ptr...
				[4, "perk_ptr_unstoppable", 2],	
				[4, ["perk_ptr_menacing", "perk_ptr_bully"], 2],
				[3, "perk_ptr_vigorous_assault", 2],						
				//[4, "perk_ptr_fresh_and_furious", 2],
				[2, "perk_ptr_fruits_of_labor", 1],	
				[2, "perk_ptr_concussive_strikes", 1],
				[4, "perk_ptr_pattern_recognition", 2],
				[1, "perk_ptr_head_smasher", 1],
				[1, "perk_ptr_marksmanship", 1],
				[3, "perk_ptr_survival_instinct", 1],	
			])
		}

		perkpool = this.Const.World.Common.pickPerks(perkpool, 6);
		foreach(perk in perkpool)
		{
			::Legends.Perks.grant(this, perk);
		}
		
		if (this.Math.rand(1, 100) <= 35)
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
			if ( v <= 45)
			{
				weapons = [
					"weapons/legend_halberd",
					"weapons/legend_battle_glaive",
					"weapons/crlongaxe",
					"weapons/crpolehammer",			
				]
			}
			else if ( v <= 70)
			{
				weapons = [
					"weapons/crpolemace",	
					"weapons/crswordlance",						
				]
			}
			else if ( v <= 90)
			{
				weapons = [
					"weapons/crranged_flail",				
					"weapons/crswordlance",		
					"weapons/legend_swordstaff",						
				]
			}
			else if ( v <= 100)
			{
				weapons = [
					"weapons/greenskins/goblin_pike"						
				]
			}											
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));							
		}
		
		if (::Is_PTR_Exist)
		{
			//this.m.Skills.addTreeOfEquippedWeapon(7);
			this.m.Skills.addPerkTree(this.Const.Perks.TwoHandedTree);		
		}

		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);
		
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

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vigilant"));	
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

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_strength_in_numbers"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_exude_confidence"));
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

			this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));

			if (::Is_PTR_Exist)
			{
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

