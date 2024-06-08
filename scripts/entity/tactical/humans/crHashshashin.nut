this.crHashshashin <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crHashshashin;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crHashshashin.XP;
		this.human.create();
		this.m.Bodies = this.Const.Bodies.SouthernMale;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.Ethnicity = 1;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/assassin_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.crHashshashin);
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_nomads");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/actives/throw_dirt_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_perfect_fit"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_second_wind"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_double_strike"));	
		
		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vigorous_assault"));
		}

		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_escape_artist"));	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mastery_nets"));			
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crDiscipline"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_offhand_training"));
			}
		}			

		if (this.World.getTime().Days >= 25)
		{
			b.MeleeSkill += 5;
			b.Bravery += 10;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));

			if (this.World.getTime().Days >= 50)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_adrenalin"));	

				if (::Is_PTR_Exist)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));	
				}
				
				b.MeleeDefense += 10;
				b.Hitpoints += 10;				

				if (this.World.getTime().Days >= 75)
				{
					b.Hitpoints += 15;
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_freedom_of_movement"));					
					if (this.World.getTime().Days >= 100)
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
						this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_alert"));						
						b.MeleeSkill += 5;			
						b.MeleeDefense += 5;				
						b.Bravery += 10;
						if (this.World.getTime().Days >= 150)
						{
							b.MeleeSkill += 2;	
							b.Initiative += 2;

							if (::Is_PTR_Exist)
							{
								this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));
							}
							
							if (this.World.getTime().Days >= 200)
							{
								b.MeleeDefense += 2;	
								b.Initiative += 3;
								b.Bravery += 10;							
							}						
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
		
		if (::Mod_Sellswords.EnableHostileSequences)
		{
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 15.0)
				::Mod_Sellswords.add_serpent(this.actor, true);
		}
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/oriental/qatal_dagger",
				"weapons/shamshir",
				"weapons/shamshir",
				"weapons/legend_katar",
				"weapons/ancient/khopesh"
			];

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			
			//if (::Is_PTR_Exist)
			//{
			//	this.m.Skills.addTreeOfEquippedWeapon(7);	
			//}	
			::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);			
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([	
			[1, "hashshashin_armor_low_reinforced"], 
			[8, "hashshashin_armor_medium"],	
			[1, "hashshashin_armor_high"],				
		]));
		this.m.Items.equip(this.Const.World.Common.pickHelmet([						
			[1, "hashshashin_helmet_low_reinforced"], 
			[8, "hashshashin_helmet_medium"],	
			[1, "hashshashin_helmet_high"],					
		]));
		
		local dc = this.World.getTime().Days;
		if (this.Math.rand(1, 100) <= dc)
		{
			this.m.Items.addToBag(this.new("scripts/items/tools/daze_bomb_item"));	
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
			"weapons/named/named_shamshir",
			"weapons/named/named_shamshir",			
			"weapons/named/named_khopesh",			
			"weapons/named/legend_named_gladius",
			"weapons/named/named_qatal_dagger",
			"weapons/named/named_qatal_dagger",			
			"weapons/named/named_katar"			
		];

		if (this.Math.rand(1, 100) <= 75)
		{
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[
					1,
					"named/black_leather_armor"
				]
			]));
		}

		if (::Is_PTR_Exist)
		{
			this.m.Skills.removeByID("perk.underdog");
			//this.m.Skills.addTreeOfEquippedWeapon(7);	
		}

		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_battleheart"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));		
		this.m.BaseProperties.DamageDirectMult *= 1.25;
		return true;
	}

});

