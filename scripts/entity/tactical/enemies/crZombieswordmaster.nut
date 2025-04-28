this.crZombieswordmaster <- this.inherit("scripts/entity/tactical/enemies/zombie", {
	m = {},
	function create()
	{
		this.zombie.create();
		this.m.Type = this.Const.EntityType.crZombieswordmaster;
		this.m.BloodType = this.Const.BloodType.Dark;
		this.m.MoraleState = this.Const.MoraleState.Ignore;
		this.m.XP = this.Const.Tactical.Actor.crZombieswordmaster.XP;
		this.m.Name = this.Const.Strings.EntityName[this.m.Type];
		this.m.IsResurrectingOnFatality = true;
		this.m.ResurrectionValue = 2.0;
		this.m.ResurrectionChance = 75;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/crZombieswordmaster";	
	}

	function onDamageReceived( _attacker, _skill, _hitInfo )
	{
		if (this.m.IsHeadless)
		{
			_hitInfo.BodyPart = this.Const.BodyPart.Body;
		}

		return this.actor.onDamageReceived(_attacker, _skill, _hitInfo);
	}

	function onInit()
	{
		this.zombie.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.crZombieswordmaster);
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

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 90)
		{
			b.MeleeSkill += 5;
			b.DamageTotalMult += 0.1;
		}

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;

		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_push_the_advantage"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nine_lives"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crFoB"));	
		this.m.Skills.add(this.new("scripts/skills/effects/cr_clarity_effect_permanent"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_strength_in_numbers"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_lithe"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));		
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_last_stand"));			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_small_target"));
			}	
		}

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bear_down"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_exploit_opening"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_soft_metal"));
			this.m.Skills.addPerkTree(this.Const.Perks.OneHandedTree);
			local intimidatePerk = this.new("scripts/skills/perks/perk_ptr_intimidate");
			intimidatePerk.m.IsForceEnabled = true;
			this.m.Skills.add(intimidatePerk);
			local maulerPerk = this.new("scripts/skills/perks/perk_ptr_mauler");
			maulerPerk.m.IsForceEnabled = true;
			this.m.Skills.add(maulerPerk);
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_concussive_strikes"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_push_it"));
		}			
		
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 150)
		{
			b.MeleeSkill += 1;
			b.RangedSkill += 1;			
			b.Bravery += 2;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));			
			b.DamageTotalMult += 0.05;
			if (this.World.getTime().Days >= 200)
			{
				b.MeleeDefense += 1;
				b.RangedDefense += 1;

				if (::Is_PTR_Exist)
				{
					this.m.Skills.add(this.new("scripts/skills/effects/ptr_fresh_and_furious_effect"));		
				}

				if (this.World.getTime().Days >= 250)
				{					
					b.MeleeSkill += 1;			
					b.RangedDefense += 1;			
					b.Bravery += 2;
					if (this.World.getTime().Days >= 300)
					{
						b.MeleeSkill += 1;
						b.RangedSkill += 1;							
						b.Initiative += 5;

						if (::Is_PTR_Exist)
						{
							this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));	
						}
													
						if (this.World.getTime().Days >= 350)
						{
							b.MeleeDefense += 1;
							b.RangedDefense += 1;							
							b.Initiative += 5;
							b.Bravery += 1;							
						}						
					}		
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

	function onResurrected( _info )
	{
		this.zombie.onResurrected(_info);

		if (!_info.IsHeadAttached)
		{
			this.m.IsHeadless = true;
			this.m.Name = "Headless " + this.Const.Strings.EntityName[this.m.Type];
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [];
			this.m.Sound[this.Const.Sound.ActorEvent.Death] = [];
			this.m.Sound[this.Const.Sound.ActorEvent.Resurrect] = [];
			this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [];
			this.getSprite("head").setBrush("zombify_no_head");
			this.getSprite("head").Saturation = 1.0;
			this.getSprite("head").Color = this.createColor("#ffffff");
			this.getSprite("injury").Visible = false;
			this.getSprite("hair").resetBrush();
			this.getSprite("beard").resetBrush();
			this.getSprite("beard_top").resetBrush();
			this.getSprite("status_rage").resetBrush();
			this.getSprite("tattoo_head").resetBrush();
			this.getSprite("helmet").Visible = false;
			this.getSprite("helmet_damage").Visible = false;
			this.getSprite("body_blood").Visible = false;
			this.getSprite("dirt").Visible = false;
		}
	}

	function assignRandomEquipment()
	{
		local r;

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
		{
			local weapons = [			
				"weapons/fighting_axe",
				"weapons/fighting_axe",
				"weapons/winged_mace",
				"weapons/winged_mace",				
				"weapons/noble_sword",
				"weapons/noble_sword",
				"weapons/flail",
				"weapons/warhammer",
				"weapons/military_cleaver",
				"weapons/military_cleaver",			
			];

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));			
		}

		local aList = [
			[
				2,
				"zombieswordmaster_armor_ichi"
			],
			[
				1,
				"zombieswordmaster_armor_ni"
			]
		];
		local armor = this.Const.World.Common.pickArmor(aList);

		if (this.Math.rand(1, 100) <= 66)
		{
			armor.setArmor(armor.getArmorMax() * 0.8 - 1);
		}

		this.m.Items.equip(armor);

		local helmet = [
			[
				1,
				"zombieswordmaster_helmet"
			]
		];
		local h = this.Const.World.Common.pickHelmet(helmet);
		
		if (this.Math.rand(1, 100) <= 66)
		{
			h.setArmor(h.getArmorMax() *0.8 - 1);
		}
			
		this.m.Items.equip(h);
		
		//if (::Is_PTR_Exist)
		//{
		//	this.m.Skills.addTreeOfEquippedWeapon(7);	
		//}
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
			"weapons/named/named_cleaver",
			"weapons/named/named_flail",
			"weapons/named/named_warhammer",
			"weapons/named/named_sword",
			"weapons/named/named_mace"			
		];

		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		
		if (::Is_PTR_Exist)
		{
			//this.m.Skills.addTreeOfEquippedWeapon();	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_menacing"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bully"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_strength_in_numbers"));	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_primal_fear"));	
		}
		
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);	
		return true;
	}

});

