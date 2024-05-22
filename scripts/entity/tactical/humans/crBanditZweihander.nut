this.crBanditZweihander <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crBanditZweihander;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Greatsword.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Greatsword);
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
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_sweeping_strikes"));		
			}		
		}
	}

	function assignRandomEquipment()
	{
		local r;
		local dc = this.World.getTime().Days;

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
	
	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local r = this.Math.rand(1, 3);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/named/named_greatsword"));
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([ 
				[1, "crnamed_leather_brigandine"],	 		//250,-21 used by zweihanders  				
			]));
		}

		this.m.Skills.add(this.new("scripts/skills/perks/perk_sundering_strikes"));	

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));	
		}				
		return true;
	}	

});

