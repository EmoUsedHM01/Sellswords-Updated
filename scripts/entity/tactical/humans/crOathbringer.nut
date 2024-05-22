this.crOathbringer <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crOathbringer;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crOathbringer.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.crOathbringer);
		b.TargetAttractionMult = 1.0;
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
		
		this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_second_wind"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_sundering_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_true_believer"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
		
		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_the_rush_of_battle"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bulwark"));					
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_know_their_weakness"));
		}
		
		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crHonorheritage"));
			
			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_man_of_steel"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_exude_confidence"));				
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_personal_armor"));
			}				
		}
		
		if (this.World.getTime().Days >= 125)
		{
			b.MeleeSkill += 2;
			b.Bravery += 5;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));	

			if (this.World.getTime().Days >= 175)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_muscularity"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_double_strike"));					
				b.MeleeDefense += 2;				

				if (this.World.getTime().Days >= 225)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_alert"));										
					b.MeleeSkill += 1;			
					b.MeleeDefense += 1;			
					b.Bravery += 5;		
				}
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
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/fighting_axe",
				"weapons/noble_sword",
				"weapons/winged_mace",
				"weapons/warhammer"
			];

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/greatsword",
					"weapons/longsword03",					
					"weapons/greataxe",
					"weapons/two_handed_hammer",
					"weapons/greataxe",
					"weapons/two_handed_hammer"					
				]);
			}

			if (this.Const.DLC.Unhold && this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/two_handed_flanged_mace",
					"weapons/two_handed_flail"
				]);
			}

			if (this.Const.DLC.Wildmen && this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/bardiche"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand) && this.Math.rand(1, 100) <= 60)
		{
			local shields = [
				"shields/heater_shield"
			];
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}
		else
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"adorned_mail_shirt_armor_heavy"
			],
			[
				2,
				"adorned_warriors_armor_armor_heavy"
			],
			[
				4,
				"adorned_heavy_mail_hauberk_armor"
			]
		]));
		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[
				4,
				"adorned_closed_flat_top_with_mail_helmet"
			],
			[
				8,
				"adorned_full_helm_helmet"
			],
			[
				1,
				"crknight_helmet_mid_bread"
				//350,-23
			],            
			[
				1,
				"crknight_helmet_mid_decorative"
				//335,-22
			],
			[
				1,
				"crknight_helmet_mid_unadorned"
				//325 -21
			],            
			[
				1,
				"cr_enclave_armet"
				//355,-24 
			],                			
		]));		

		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);		
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/named_axe",
			"weapons/named/named_greataxe",
			"weapons/named/named_greatsword",
			"weapons/named/named_mace",
			"weapons/named/named_sword",
			"weapons/named/named_two_handed_hammer"
		];

		if (this.Const.DLC.Unhold)
		{
			weapons.extend([
				"weapons/named/named_two_handed_mace",
				"weapons/named/named_two_handed_flail"
			]);
		}

		if (this.Const.DLC.Wildmen)
		{
			weapons.extend([
				"weapons/named/named_bardiche"
			]);
		}

		local shields = clone this.Const.Items.NamedShields;
		shields.extend([
			"shields/named/named_wing_shield",
			"shields/named/named_rider_on_horse_shield",
			"shields/named/named_golden_round_shield",
			"shields/named/named_full_metal_heater_shield"
		]);
		local armor = [
			"armor/named/golden_scale_armor",
			"armor/named/heraldic_mail_armor"
		];

		if (this.Const.DLC.Wildmen)
		{
			armor.extend([
				"armor/named/named_golden_lamellar_armor",
				"armor/named/named_sellswords_armor"
			]);
		}

		local r = this.Math.rand(1, 3);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}
		else
		{
			this.m.Items.equip(this.new("scripts/items/" + armor[this.Math.rand(0, armor.len() - 1)]));
		}
		
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		return true;
	}

});

