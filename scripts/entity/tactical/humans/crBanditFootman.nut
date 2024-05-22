this.crBanditFootman <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crBanditFootman;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Footman.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Footman);
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
		this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_strength_in_numbers"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_the_rush_of_battle"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));

			if (this.Math.rand(1,100) <= 25)
			{
				if (this.Math.rand(1,100) > 50)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_str_line_breaker"));
				}
				else
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_str_cover_ally"));
				}
			}	
		}
	
		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_shield_skill"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_shield_push"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smashing_shields"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_bash"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));							
			this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));										
			this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));				
			this.m.Skills.add(this.new("scripts/skills/perks/perk_return_favor"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_clarity"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vigilant"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));
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

	function assignRandomEquipment()
	{
		local r;
		local dc = this.World.getTime().Days;			
		r = this.Math.rand(1, 4);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/military_pick"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/arming_sword"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
		}

		r = this.Math.rand(1, 2);
		local shield;

		if (r == 1)
		{
			shield = this.new("scripts/items/shields/kite_shield");
		}
		else if (r == 2)
		{
			shield = this.new("scripts/items/shields/heater_shield");
		}		

		this.m.Items.equip(shield);
		
		if (this.Math.rand(1, 100) <= 25)
		{
			local weapons = [
				"weapons/throwing_axe",
				"weapons/javelin"
			];
			this.m.Items.addToBag(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));			
		}
		
		if (dc <= 50)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crfootman_armor_early"],           // 160
				[1, "crfootman_armor_low"],           // 130					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[1, "crfootman_helmet_early"],            //~135
				[1, "crfootman_helmet_mid"],               //~150 					
			]));
		}
		else if (dc <= 80)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crfootman_armor_early"],           // 160			
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				                              				
				[1, "crfootman_helmet_mid"],               //~150  	
				[1, "crfootman_helmet_mid_reinforced"],               //~175 					
			]));
		}			
		else if (dc <= 100)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[2, "crfootman_armor_early"],           // 160
				[1, "crfootman_armor_mid_plate"],       //185
				[1, "crfootman_armor_mid_patched"],     // 185				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				                              				
				[1, "crfootman_helmet_mid"],               //~150  	
				[1, "crfootman_helmet_mid_reinforced"],               //~175 					
			]));
		}	
		else if (dc <= 125)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crfootman_armor_mid_chain"],     // 185
				[1, "crfootman_armor_mid_plate"],       //185
				[1, "crfootman_armor_mid_patched"],     // 185				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				                              				  	
				[1, "crfootman_helmet_mid_reinforced"],               //~175 
				[1, "crfootman_helmet_late_kettle"],              //~200 					
			]));
		}
		else if (dc <= 150)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crfootman_armor_mid_chain"],     // 185
				[1, "crfootman_armor_mid_plate"],       //185
				[1, "crfootman_armor_mid_patched"],     // 185
				[2, "crfootman_armor_late_ichi"],      // 195
				[2, "crfootman_armor_late_ni"],      // 200					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				                              				 	
				[1, "crfootman_helmet_mid_reinforced"],               //~175 
				[1, "crfootman_helmet_late"],               //~175  	
				[2, "crfootman_helmet_late_kettle"],              //~200 
				[1, "crfootman_helmet_late_heavy"],               //~200					
			]));
		}
		else if (dc > 150)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crfootman_armor_late_ichi"],      // 195
				[1, "crfootman_armor_late_ni"],      // 200					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				                              				
				[2, "crfootman_helmet_late_kettle_reinforced"],             //~225 	
				[1, "crfootman_helmet_late_kettle"],              //~200 
				[1, "crfootman_helmet_late_heavy"],               //~200					
			]));
		}

		//if (::Is_PTR_Exist)
		//{
			//this.m.Skills.addTreeOfEquippedWeapon(4);

			if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
				//this.m.Skills.addTreeOfEquippedWeapon(6);
				::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 6);				
			}
			else
			{
				::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 4);
			}		
		//}
	}

});

