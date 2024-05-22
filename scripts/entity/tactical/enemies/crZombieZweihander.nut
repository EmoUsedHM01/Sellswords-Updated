this.crZombieZweihander <- this.inherit("scripts/entity/tactical/enemies/zombie", {
	m = {},
	function create()
	{
		this.zombie.create();
		this.m.Type = this.Const.EntityType.crZombieZweihander;
		this.m.BloodType = this.Const.BloodType.Dark;
		this.m.MoraleState = this.Const.MoraleState.Ignore;
		this.m.XP = this.Const.Tactical.Actor.Arbalester.XP;
		this.m.ResurrectionValue = 3.0;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/crZombieZweihander";		
	}

	function onInit()
	{
		this.zombie.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Greatsword);
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
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_greatsword"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bloody_harvest"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_fluid_weapon"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_kata"));
		}		

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));									
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));													
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_versatile_weapon"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_exploit_opening"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_tempo"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_en_garde"));
				//this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_man_of_steel"));				
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_sweeping_strikes"));	
			}		
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

		if (dc <= 75)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/longsword"));
		}
		else if (dc <= 125)
		{
			local r = this.Math.rand(1, 2);
			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/longsword"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/greatsword"));
			}				
		}
		else if (dc > 125)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/greatsword"));
		}			

		if (dc <= 80)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crarmor_hauberk_medium_patched"],	//170,-20 
				[1, "crarmor_hauberk_medium"],			//170,-20 				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "crgreatsword_helmet_early"],		//~165,-10					
			]));
		}
		else if (dc <= 120)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crarmor_hauberk_medium_patched"],	//170,-20 
				[1, "crarmor_hauberk_medium"],			//170,-20 
				[2, "crarmor_hauberk_late"],	 		//200,-24  				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "crgreatsword_helmet_early"],		//~165,-10
				[1, "crgreatsword_helmet_mid"],		 	//~210,-11
				[1, "crgreatsword_helmet_mid_low"],		//~205,-12				
			]));
		}				
		else if (dc <= 160)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[4, "crarmor_hauberk_late"],	 		//200,-24 
				[1, "crarmor_scale_ichi"],				//250,-29
				[1, "crarmor_scale_ni"],				//240,-29 				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "crgreatsword_helmet_mid"],		 	//~210,-11
				[1, "crgreatsword_helmet_mid_low"],		//~205,-12
				[3, "crgreatsword_helmet_late"],		//~225,-12
				[1, "crgreatsword_helmet_heavy"],		//~270,-16						
			]));
		}
		else if (dc <= 200)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([ 
				[8, "crarmor_hauberk_late"],	 		//200,-24 
				[2, "crarmor_scale_ichi"],				//250,-29
				[2, "crarmor_scale_ni"],				//240,-29
				[1, "crarmor_scale_ichi_patched"],		//265,-32				
				[1, "crarmor_scale_ni_patched"],		//275,-32 				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "crgreatsword_helmet_heavy"],		//~270,-16					
			]));
		}
		else if (dc > 200)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([ 
				[2, "crarmor_hauberk_late"],	 		//200,-24 
				[1, "crarmor_scale_ichi"],				//250,-29
				[1, "crarmor_scale_ni"],				//240,-29
				[1, "crarmor_scale_ichi_patched"],		//265,-32				
				[1, "crarmor_scale_ni_patched"],		//275,-32 				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "crgreatsword_helmet_heavy"],		//~270,-16					
			]));
		}			
	}
});

