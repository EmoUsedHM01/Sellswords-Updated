this.Solemner <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.Solemner;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Solemner.XP;
		this.human.create();
		this.m.Bodies = this.Const.Bodies.SouthernMale;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.Ethnicity = 1;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/militia_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Solemner);
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_southern");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));		
		this.m.Skills.add(this.new("scripts/skills/actives/throw_dirt_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		
		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 3);	
		if (dc >= 90)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_strength_in_numbers"));	
			}		

			if (dc >= 115)
			{
				if (::Is_PTR_Exist)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_rattle"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_soft_metal"));	
				}					

				if (dc >= 140)
				{
					b.Hitpoints += 10;
					b.MeleeSkill += 5;	

					if (::Is_PTR_Exist)
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_deep_impact"));
						this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_exude_confidence"));	
					}							
									
					if (dc >= 155)
					{
						if (::Is_PTR_Exist)
						{
							this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_head_smasher"));	
						}

						this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));	
						this.m.Skills.add(this.new("scripts/skills/perks/perk_crDiscipline"));		
						b.MeleeDefense += 3;				
						b.Bravery += 5;
						if (dc >= 170)
						{
							b.MeleeSkill += 5;		
							b.Initiative += 2;							
							this.m.Skills.add(this.new("scripts/skills/perks/perk_crAnchor"));
							this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smackdown"));								
							if (dc >= 200)
							{
								if (::Is_PTR_Exist)
								{
									this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vigilant"));	
								}
														
								b.MeleeDefense += 2;	
								b.Initiative += 3;							
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
		
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function assignRandomEquipment()
	{
		local r = this.Math.rand(1, 3);
		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 3);	
		if (this.Math.rand(1, 100) <= dc)
		{
			r += 1;
		}
		
		if (r == 1)
		{
		
			this.m.Items.equip(this.new("scripts/items/weapons/two_handed_flanged_mace"));
			if (dc <= 120)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[2, "solemner_mid_heavy_armor"],
					[3, "solemner_late_heavy_armor"]
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[2, "solemner_mid_heavy_helmet"],
					[3, "solemner_late_heavy_helmet"]
				]));
			}
			else if (dc <= 180)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[2, "solemner_mid_heavy_armor"],
					[3, "solemner_late_heavy_armor"]
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[2, "solemner_mid_heavy_helmet"],
					[3, "solemner_late_heavy_helmet"]
				]));
			}				
			else if (dc > 180)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[2, "solemner_mid_heavy_armor"],
					[3, "solemner_late_heavy_armor"]
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[2, "solemner_mid_heavy_helmet"],
					[3, "solemner_late_heavy_helmet"]
				]));
			}

			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));	
			
			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bulwark"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_man_of_steel"));			
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_formidable_approach"));
			}			
		}
		
		else if (r == 2)
		{
		
			this.m.Items.equip(this.new("scripts/items/weapons/oriental/heavy_southern_mace"));
			local shield = this.new("scripts/items/shields/oriental/metal_round_shield");
			this.m.Items.equip(shield);				
			if (dc <= 120)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "solemner_mid_medium_armor"],
					[0, "solemner_late_medium_armor"]
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "solemner_mid_medium_helmet"],
					[0, "solemner_late_medium_helmet"]
				]));
			}
			else if (dc <= 180)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[2, "solemner_mid_medium_armor"],
					[1, "solemner_late_medium_armor"]
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[2, "solemner_mid_medium_helmet"],
					[1, "solemner_late_medium_helmet"]
				]));
			}				
			else if (dc > 180)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "solemner_mid_medium_armor"],
					[3, "solemner_late_medium_armor"]
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "solemner_mid_medium_helmet"],
					[3, "solemner_late_medium_helmet"]
				]));
			}
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_lithe"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));		
			this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
			//this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));				
		}
		
		else if (r >= 3)
		{		
			local weapons;
			if (dc <= 150)
			{
				weapons= [
					"weapons/oriental/polemace",
					"weapons/oriental/polemace",
					"weapons/crpolemace",				
				];	
			}
			else if (dc <= 200)
			{
				weapons= [
					"weapons/oriental/polemace",
					"weapons/crpolemace",				
				];	
			}
			else if (dc > 200)
			{
				weapons= [
					"weapons/crpolemace",				
				];	
			}			
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));	
			if (dc <= 120)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "solemner_mid_light_armor"],
					[0, "solemner_late_light_armor"]
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "solemner_mid_light_helmet"],
					[0, "solemner_late_light_helmet"]
				]));
			}
			else if (dc <= 180)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[2, "solemner_mid_light_armor"],
					[1, "solemner_late_light_armor"]
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[2, "solemner_mid_light_helmet"],
					[1, "solemner_late_light_helmet"]
				]));
			}				
			else if (dc > 180)
			{
				this.m.Items.equip(this.Const.World.Common.pickArmor([
					[1, "solemner_mid_light_armor"],
					[3, "solemner_late_light_armor"]
				]));
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "solemner_mid_light_helmet"],
					[3, "solemner_late_light_helmet"]
				]));
			}

			this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));			
			this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_polearm"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_follow_up"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_leverage"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bolster"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_utilitarian"));
			}		
		}
		
		//if (::Is_PTR_Exist)
		//{
		//	this.m.Skills.addTreeOfEquippedWeapon(7);	
		//}
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);				
	}

});

