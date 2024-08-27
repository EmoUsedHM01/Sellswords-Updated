this.crDeathknight <- this.inherit("scripts/entity/tactical/enemies/zombie", {
	m = {},
	function create()
	{
		this.zombie.create();
		this.m.Type = this.Const.EntityType.crDeathknight;
		this.m.BloodType = this.Const.BloodType.Dark;
		this.m.MoraleState = this.Const.MoraleState.Ignore;
		this.m.XP = this.Const.Tactical.Actor.crDeathknight.XP;
		this.m.Name = this.Const.Strings.EntityName[this.m.Type];
		this.m.IsResurrectingOnFatality = true;
		this.m.ResurrectionValue = 5.0;
		this.m.ResurrectionChance = 100;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/crDeathknight";
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
		b.setValues(this.Const.Tactical.Actor.crDeathknight);
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = true;
		b.IsImmuneToBleeding = true;
		b.FatigueDealtPerHitMult = 2;
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInCleavers = true;
		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_push_the_advantage"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crresilient"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_armor_mastery_heavy"));			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));	
		

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bear_down"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_concussive_strikes"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_push_it"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_man_of_steel"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_soft_metal"));
			this.m.Skills.addPerkTree(this.Const.Perks.OneHandedTree);
			local intimidatePerk = this.new("scripts/skills/perks/perk_ptr_intimidate");
			intimidatePerk.m.IsForceEnabled = true;
			this.m.Skills.add(intimidatePerk);				
		}

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 90)
		{
			b.MeleeSkill += 5;
			b.DamageTotalMult += 0.15;
			b.DamageReceivedArmorMult = 0.75;			
		}

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Hitpoints = b.Hitpoints * 1.15;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nine_lives"));						
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_small_target"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_primal_fear"));	
			}
		}

		this.m.CurrentProperties = clone b;			
		
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 120)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));		
			b.MeleeSkill += 1;
			b.RangedSkill += 1;			
			b.Bravery += 2;
			if (this.World.getTime().Days >= 180)
			{			
				b.MeleeDefense += 1;
				b.RangedDefense += 1;				
				b.DamageTotalMult += 0.1;
				if (this.World.getTime().Days >= 260)
				{					
					b.MeleeSkill += 1;			
					b.RangedDefense += 1;			
					b.Bravery += 2;
					if (this.World.getTime().Days >= 300)
					{
						b.MeleeSkill += 1;
						b.RangedSkill += 1;							
						b.Initiative += 5;
						if (this.World.getTime().Days >= 340)
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
			this.m.BaseProperties.MeleeDefense += dca;
			this.m.BaseProperties.RangedSkill += dca;	
			this.m.BaseProperties.RangedDefense += dca;				
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
				"weapons/greenskins/orc_cleaver",				
			];

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			//if (::Is_PTR_Exist)
			//{
			//	this.m.Skills.addTreeOfEquippedWeapon(7);	
			//}
			::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);		
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			local shields = [
				"shields/worn_kite_shield"
			];
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crTotalcover"));			
		}

		local aList = [
			[
				1,
				"cr_zombieknight_armor_high"
			]
		];
		this.m.Items.equip(this.Const.World.Common.pickArmor(aList));

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null && this.Math.rand(1, 100) <= 95)
		{
			local helmet = [
				[
					1,
					"cr_death_knight_helm"
				]
			];
			this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
		}
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/named_cleaver"
		];

		local shields = clone this.Const.Items.NamedUndeadShields;

		if (this.Math.rand(1, 100) <= 85)
		{
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		else
		{
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}

		if (::Is_PTR_Exist)
		{
			//this.m.Skills.addTreeOfEquippedWeapon();	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_menacing"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bully"));	
		}
		
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);
		return true;
	}

});

