this.crBanditBillman <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crBanditBillman;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Billman.XP;
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
		b.setValues(this.Const.Tactical.Actor.Billman);
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
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));						
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_follow_up"));
		}

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_back_to_basics"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));										
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_clarity"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_sundering_strikes"));				
			this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));
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

		local weapons = [
			"weapons/billhook",
			"weapons/pike",
			"weapons/legend_voulge"
		];

		if (this.Const.DLC.Unhold)
		{
			weapons.extend([
				"weapons/polehammer"
			]);
		}
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));	

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
				[1, "crbillman_armor_low"],	 // 110
				[1, "crbillman_armor_early"],		// 110				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				
				[2, "crbillman_helmet_low"],			   //~30
				[1, "crbillman_helmet_early"],			   //~85   					
			]));
		}
		else if (dc <= 80)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[3, "crbillman_armor_low"],	 // 110
				[3, "crbillman_armor_early"],		// 110	
				[1, "crbillman_armor_mid"],	 // 140
				[1, "crbillman_armor_mid_mixed"],	   // 130					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([											  				
				[1, "crbillman_helmet_early"],			   //~85 					
			]));
		}			
		else if (dc <= 100)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crbillman_armor_low"],	 // 110
				[1, "crbillman_armor_early"],		// 110	
				[2, "crbillman_armor_mid"],	 // 140
				[2, "crbillman_armor_mid_mixed"],	   // 130				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([											  				
				[1, "crbillman_helmet_early"],			   //~85 
				[2, "crbillman_helmet_mid_chain"],			   //~115  	
				[2, "crbillman_helmet_mid"],			  //~110					
			]));
		}	
		else if (dc <= 125)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crbillman_armor_mid"],	 // 140
				[1, "crbillman_armor_mid_mixed"],	   // 130				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([											  				  	
				[2, "crbillman_helmet_mid_chain"],			   //~115  	
				[2, "crbillman_helmet_mid"],			  //~110
				[1, "crbillman_helmet_late_chain"],			   //~140 
				[1, "crfootman_helmet_late"],			   //~140  					
			]));
		}
		else if (dc <= 150)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crbillman_armor_mid"],	 // 140
				[1, "crbillman_armor_mid_mixed"],	   // 130
				[2, "crbillman_armor_late"],	  // 150					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([											  				 	
				[1, "crbillman_helmet_mid_chain"],			   //~115  	
				[1, "crbillman_helmet_mid"],			  //~110
				[3, "crbillman_helmet_late_chain"],			   //~140 
				[3, "crfootman_helmet_late"],			   //~140  	
				[1, "crbillman_helmet_heavy"],			  //~160					
			]));
		}
		else if (dc > 150)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crbillman_armor_late"],	  // 150					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([											  				
				[1, "crbillman_helmet_late_chain"],			   //~140 
				[1, "crfootman_helmet_late"],			   //~140  	
				[4, "crbillman_helmet_heavy"],			  //~160					
			]));
		}

		//if (::Is_PTR_Exist)
		//{
			if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
				//this.m.Skills.addTreeOfEquippedWeapon(7);
				::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);
			}	

			//this.m.Skills.addTreeOfEquippedWeapon(5);
			::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 5);
			this.m.Skills.removeByID("perk.ptr_bloodlust");
			this.m.Skills.removeByID("perk.ptr_dent_armor");	
		//}		
	}

});

