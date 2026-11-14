this.ssu_zombie_footman <- this.inherit("scripts/entity/tactical/enemies/zombie", {
	m = {},
	function create()
	{
		this.zombie.create();
		this.m.Type = this.Const.EntityType.SsuZombieFootman;
		this.m.BloodType = this.Const.BloodType.Dark;
		this.m.MoraleState = this.Const.MoraleState.Ignore;
		this.m.XP = this.Const.Tactical.Actor.Arbalester.XP;
		this.m.ResurrectionValue = 3.0;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/ssu_zombie_footman";		
	}

	function onInit()
	{
		this.zombie.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Footman);
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries =true;
		b.IsImmuneToBleeding = true;
		b.FatigueDealtPerHitMult = 1.25;
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInCleavers = true;
		b.FatigueEffectMult = 0.0;
		b.MoraleEffectMult = 0.0;			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		this.m.BaseProperties.IsImmuneToPoison = true;
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_strength_in_numbers"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));

			
		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mastery_shields"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smashing_shields"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_bash"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));							
			this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));										
			this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));				
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_return_favor"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_clarity"));
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
		b.MeleeSkill -= 10;
		b.MeleeDefense -= 5;
		b.Hitpoints *= 2;	
		b.Initiative -= 50;	
		this.m.ActionPoints = 7;
		this.m.BaseProperties.ActionPoints = 7;
		this.m.Skills.update();		
	}

	function assignRandomEquipment()
	{
		local r;
		local banner = 3;
		local dc = this.World.getTime().Days;			

		if (!this.Tactical.State.isScenarioMode())
		{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		}
		else
		{
			banner = this.getFaction();
		}
		
		this.m.Surcoat = banner;

		this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));

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

		local shield = this.new("scripts/items/shields/faction_wooden_shield");
		shield.setFaction(banner);
		this.m.Items.equip(shield);
		
		if (dc <= 50)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "ssu_footman_armor_early"],		   // 160
				[1, "ssu_footman_armor_low"],		   // 130					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[1, "ssu_footman_helmet_early"],			//~135
				[1, "ssu_footman_helmet_mid"],			   //~150 					
			]));
		}
		else if (dc <= 80)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "ssu_footman_armor_early"],		   // 160			
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([											  				
				[1, "ssu_footman_helmet_mid"],			   //~150  	
				[1, "ssu_footman_helmet_mid_reinforced"],			   //~175 					
			]));
		}			
		else if (dc <= 100)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[2, "ssu_footman_armor_early"],		   // 160
				[1, "ssu_footman_armor_mid_plate"],	   //185
				[1, "ssu_footman_armor_mid_patched"],	 // 185				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([											  				
				[1, "ssu_footman_helmet_mid"],			   //~150  	
				[1, "ssu_footman_helmet_mid_reinforced"],			   //~175 					
			]));
		}	
		else if (dc <= 125)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "ssu_footman_armor_mid_chain"],	 // 185
				[1, "ssu_footman_armor_mid_plate"],	   //185
				[1, "ssu_footman_armor_mid_patched"],	 // 185				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([											  				  	
				[1, "ssu_footman_helmet_mid_reinforced"],			   //~175 
				[1, "ssu_footman_helmet_late_kettle"],			  //~200 					
			]));
		}
		else if (dc <= 150)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "ssu_footman_armor_mid_chain"],	 // 185
				[1, "ssu_footman_armor_mid_plate"],	   //185
				[1, "ssu_footman_armor_mid_patched"],	 // 185
				[2, "ssu_footman_armor_late_ichi"],	  // 195
				[2, "ssu_footman_armor_late_ni"],	  // 200					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([											  				 	
				[1, "ssu_footman_helmet_mid_reinforced"],			   //~175 
				[1, "ssu_footman_helmet_late"],			   //~175  	
				[2, "ssu_footman_helmet_late_kettle"],			  //~200 
				[1, "ssu_footman_helmet_late_heavy"],			   //~200					
			]));
		}
		else if (dc > 150)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "ssu_footman_armor_late_ichi"],	  // 195
				[1, "ssu_footman_armor_late_ni"],	  // 200					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([											  				
				[2, "ssu_footman_helmet_late_kettle_reinforced"],			 //~225 	
				[1, "ssu_footman_helmet_late_kettle"],			  //~200 
				[1, "ssu_footman_helmet_late_heavy"],			   //~200					
			]));
		}

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 6);				
		}
		else
		{
			::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 4);
		}	
			
	}
});

