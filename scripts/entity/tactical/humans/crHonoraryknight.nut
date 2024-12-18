this.crHonoraryknight <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crHonoraryknight;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crHonoraryknight.XP;
		this.m.Name = this.generateName();
		this.m.IsGeneratingKillName = false;
		this.human.create();
		this.m.Faces = this.Const.Faces.SmartMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
		this.setGender(1);		
	}

	function generateName()
	{
		return this.Const.Strings.FemaleKnightNames[this.Math.rand(0, this.Const.Strings.FemaleKnightNames.len() - 1)];
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.crHonoraryknight);
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
		this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_armor_mastery_heavy"));			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_perfect_fit"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_the_rush_of_battle"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bulwark"));				
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vigilant"));	
		}

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_feint"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_shield_skill"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_shield_push"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_bash"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crDiscipline"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crAnchor"));
			
			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_dismemberment"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_deep_cuts"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_exude_confidence"));				
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_personal_armor"));
			}		
		}
		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 3);			
		if (dc >= 80)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_true_believer"));				
			this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_double_strike"));				

			if (dc >= 120)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_crFoB"));				
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_balance"));			
				this.m.Skills.add(this.new("scripts/skills/perks/perk_crHonorheritage"));

				if (::Is_PTR_Exist)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_man_of_steel"));		
				}			

				if (dc >= 150)
				{
					if (::Is_PTR_Exist)
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_wears_it_well"));	
					}

					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_lithe"));					
					this.m.Skills.add(this.new("scripts/skills/perks/perk_crSignaturemove"));						
					b.MeleeSkill += 2;			
					b.MeleeDefense += 2;			
					b.RangedDefense += 2;
					if (dc >= 180)
					{
						if (::Is_PTR_Exist)
						{
							this.m.Skills.add(this.new("scripts/skills/effects/ptr_fresh_and_furious_effect"));	
						}

						this.m.Skills.add(this.new("scripts/skills/perks/perk_crTotalcover"));					
						this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));									
						this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_last_stand"));				
						b.MeleeSkill += 3;	
						b.Initiative += 3;
						
						if (dc >= 210)
						{
							if (::Is_PTR_Exist)
							{
								this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));
							}
												
							this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_in_the_zone"));						
							b.MeleeDefense += 3;	
							b.Initiative += 2;
							b.RangedDefense += 3;								
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

	function assignRandomEquipment()
	{
		local r;
		local banner = 4;

		if (("State" in this.Tactical) && this.Tactical.State != null && !this.Tactical.State.isScenarioMode())
		{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		}
		else
		{
			banner = this.getFaction();
		}

		this.m.Surcoat = banner;

		this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/noble_sword",
				"weapons/noble_sword",
				"weapons/noble_sword",				
				"weapons/military_cleaver"	
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			
			//if (::Is_PTR_Exist)
			//{
			//	this.m.Skills.addTreeOfEquippedWeapon(7);	
			//}	
			::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);		
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
		{
			r = this.Math.rand(1, 2);
			local shield;

			if (r == 1)
			{
				shield = this.new("scripts/items/shields/faction_heater_shield");
			}
			else if (r == 2)
			{
				shield = this.new("scripts/items/shields/faction_kite_shield");
			}

			shield.setFaction(banner);
			this.m.Items.equip(shield);
			this.m.Skills.add(this.new("scripts/skills/perks/perk_return_favor"));		

			if (::Is_PTR_Exist)
			{	
				this.m.Skills.add(this.new("scripts/skills/perks/perk_str_line_breaker"));
			}
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"crfemaleknight_armor"
			]
		]));

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[
					1,
					"crfemaleknight_helmet",
					banner
				]
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
		local shields = clone this.Const.Items.NamedShields;

		this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_in_the_zone"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));	
		}
		return true;
	}

});

