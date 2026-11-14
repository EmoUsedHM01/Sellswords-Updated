this.ssu_sellsword_tank <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.SsuSellswordTank;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.SsuSellswordTank.XP;
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
		b.setValues(this.Const.Tactical.Actor.SsuSellswordTank);
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
			[2, [::Legends.Perk.CripplingStrikes, ::Legends.Perk.CoupDeGrace], 2],
			[1, ::Legends.Perk.LegendMuscularity, 1],
			[1, ::Legends.Perk.Fearsome, 2],
			[1, ::Legends.Perk.LegendAlert, 1],
			[2, ::Legends.Perk.LegendAssuredConquest, 1],
			[2, ::Legends.Perk.LegendOnslaught, 1],
			[4, ::Legends.Perk.Steadfast, 1],
			[1, ::Legends.Perk.LoneWolf, 1],
			[2, ::Legends.Perk.Anticipation, 1],
			[8, ::Legends.Perk.Colossus, 1],
			[4, ::Legends.Perk.Stalwart, 1],
			[3, ::Legends.Perk.LegendLastStand, 1],
			[3, ::Legends.Perk.NineLives, 2],
			[4, ::Legends.Perk.LegendSecondWind, 1],
			[2, ::Legends.Perk.SsuBlocknormal, 1],
			[1, ::Legends.Perk.SsuDiscipline, 1],
			[1,::Legends.Perk.LegendAnchor, 1],
		];

		perkpool = this.Const.World.Common.pickPerks(perkpool, 10);
		foreach(perk in perkpool)
		{
			::Legends.Perks.grant(this, perk);
		}
		
		if (this.Math.rand(1, 100) <= 35)
		{
			this.setMoraleState(this.Const.MoraleState.Confident);
		}		
		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_battleheart"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_guardian"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_totalcover"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_furinkazan"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_strength_in_numbers"));			
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/traits/iron_jaw_trait"));
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

	function assignRandomEquipment()
	{
		local v = this.Math.rand(1, 100);	
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

			::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);	
		}

		local r = this.Math.rand(1, 5);
		local shield;
		
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
				this.m.Items.addToBag(this.new("scripts/items/tools/throwing_net"));
			}			
			else if (r == 5)
			{
				this.m.Items.addToBag(this.new("scripts/items/tools/throwing_net"));
			}			
		}

		if (v <= 40)				//northern
		{
			local r = this.Math.rand(1, 3);	
			if (r == 1)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "ssu_plate_scale_mid"],	  //315,-40							 320
					[1, "ssu_plate_full_mid"],		   //320,-41
					[1, "ssu_plate_full_mid_reinforced"],	 //335,-43	
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "ssu_enclave_armet"],			   //355,-24					 340
					[1, "ssu_knight_helmet_mid_bread"],			//350,-23 
					[1, "ssu_knight_helmet_mid_decorative"],		 //335,-22
					[1, "ssu_knight_helmet_mid_unadorned"],			//325 -21				
				]));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "ssu_sellsword_armor_medium"],	  	  //165,-22
					[2, "ssu_sellsword_armor_medium_chain"],		  //190,-21	
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "ssu_sellsword_helmet_medium"],			   	//185,-9
				]));
			}
			else if (r == 3)				
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "ssu_sellsword_armor_light"],	  //150,-11	 	
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "ssu_sellsword_helmet_light"],	   //140,-6				   				
				]));
			}
			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		}
		else if (v <= 45)					  //zombie
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[2, "ssu_sellsword_armor_undead"]		 //250,-30										
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "ssu_sellsword_helmet_undead"],			//235,-16					
			]));
			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		}
		else if (v <= 65)					//southern
		{
			local r = this.Math.rand(1, 3);	
			if (r == 1)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "ssu_solemner_late_medium_armor"],	  //290,-35 						
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "ssu_solemner_late_medium_helmet"],		   			
				]));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "ssu_guardsman_armor_ichi"],		  //~200 -23
					[1, "ssu_guardsman_armor_ni"],	  //~225 -27
					[1, "ssu_guardsman_armor_sann"],	 //~205 -25	
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "ssu_guardsman_helmet"],			   //190, -10		  			
				]));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[2, "ssu_guardsman_armor_light"],	  //~135 -11
					[1, "ssu_solemner_late_light_armor"],		   //120
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[2, "ssu_guardsman_helmet_light"],		   //155, -6 	   
					[1, "ssu_solemner_late_light_helmet"],			 				
				]));
			}

			this.m.Skills.add(this.new("scripts/skills/actives/throw_dirt_skill"));			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fortified_mind"));			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mind_over_body"));
		}	
		else if (v <= 75)				   //ancient
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "ssu_sellsword_armor_ancient"],		   	//250,-33				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[1, "ssu_sellsword_helmet_ancient"],			//235,-19				 				 					
			]));

			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_battleheart"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		}
		else if (v <= 80)				 //goblin
		{
			local r = this.Math.rand(1, 3);	
			if (r <= 2)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "ssu_sellsword_armor_light"],	  //150,-11	 	
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "ssu_sellsword_helmet_light"],	   //140,-6				   				
				]));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "ssu_guardsman_armor_light"],	  //~135 -11
					[1, "ssu_solemner_late_light_armor"],		   //120	
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "ssu_guardsman_helmet_light"],		   //155, -6 	   
					[1, "ssu_solemner_late_light_helmet"],		   			
				]));
			}
			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mastery_nets"));
		}
		else if (v <= 90)				 //orc
		{
			local r = this.Math.rand(1, 3);	
			if (r == 1)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "ssu_plate_scale_mid"],	  //315,-40							 320
					[1, "ssu_plate_full_mid"],		   //320,-41
					[1, "ssu_plate_full_mid_reinforced"],	 //335,-43	
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "ssu_enclave_armet"],			   //355,-24					 340
					[1, "ssu_knight_helmet_mid_bread"],			//350,-23 
					[1, "ssu_knight_helmet_mid_decorative"],		 //335,-22
					[1, "ssu_knight_helmet_mid_unadorned"],			//325 -21				
				]));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "ssu_solemner_late_medium_armor"],	  //290,-35 						
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "ssu_solemner_late_medium_helmet"],		   			
				]));
			}			
			else if (r == 3)	 
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "ssu_sellsword_armor_barb"],		   //320,-41				   				
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([				
					[1, "ssu_sellsword_helmet_barb"],			//350,-23		  					
				]));
			}
				
			this.m.Skills.add(this.new("scripts/skills/traits/iron_jaw_trait"));
		}
		else if (v <= 100)				 //barbarian
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "ssu_sellsword_armor_barb"],				//255,-38
				[1, "ssu_sellsword_armor_barb_medium"],		  //240,-31 				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[1, "ssu_sellsword_helmet_barb"],			//255,-18		  					
			]));
			
			this.m.Skills.add(this.new("scripts/skills/actives/barbarian_fury_skill"));
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
		}		
	}
});

