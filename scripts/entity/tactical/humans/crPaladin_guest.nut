this.crPaladin_guest <- this.inherit("scripts/entity/tactical/player", {
	m = {},
	function isReallyKilled( _fatalityType )
	{
		return true;
	}	
	function create()
	{		
		this.m.Type = this.Const.EntityType.crPaladin_guest;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crInfantry.XP;
		this.m.IsGuest = true;
		this.player.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/player_agent");
		this.m.AIAgent.setActor(this);		
	}

	function onInit()
	{
		this.player.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.crInfantry);
		b.TargetAttractionMult = 1.0;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.Talents.resize(this.Const.Attributes.COUNT, 0);
		this.m.Attributes.resize(this.Const.Attributes.COUNT, [
			0
		]);
		this.m.Name = this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)];
		local Titles = [
			"the Pious",
			"the Scholar",
			"the Preacher",
			"the Devoted",
			"the Quiet",
			"the Calm",
			"of the Light",
			"the Wise",			
			"the Faithful",
			"the Paladin",
			"the Lightbringer",		
		];
		this.m.Title = Titles[this.Math.rand(0, Titles.len() - 1)];		
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));													
		this.m.Skills.add(this.new("scripts/skills/perks/perk_return_favor"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_clarity"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fortified_mind"));			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mind_over_body"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_true_believer"));		
		this.m.Skills.add(this.new("scripts/skills/actives/legend_holyflame_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/legend_prayer_of_life_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/legend_prayer_of_faith_skill"));	
		this.m.Skills.add(this.new("scripts/skills/effects/cr_clarity_effect_permanent"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_sprint"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_man_of_steel"));	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_the_rush_of_battle"));	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_exude_confidence"));	

			if (this.Math.rand(1,100) <= 50)
			{
				if (this.Math.rand(1,100) > 50)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_str_line_breaker"));
				}
				else
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_str_cover_ally"));

				}
			}	
		}	

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

	function assignRandomEquipment()
	{
		local r;
		local banner = 3;
		local dc = this.World.getTime().Days;			

		banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		
		this.m.Surcoat = banner;

		this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
				
		r = this.Math.max(0, 66 - 0.5 * dc);
		if (this.Math.rand(1, 100) <= r)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
		}
		else
		{
			this.m.Items.equip(this.new("scripts/items/weapons/winged_mace"));
		}
		
		//if (::Is_PTR_Exist)
		//{
		//	this.m.Skills.addTreeOfEquippedWeapon(7);	
		//}	
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);

		local shield = this.new("scripts/items/shields/faction_heater_shield");
		shield.setFaction(banner);
		this.m.Items.equip(shield);
			
		if (dc <= 60)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[2, "crfootman_armor_early"],           // 160
				[1, "crfootman_armor_mid_plate"],       //185
				[1, "crfootman_armor_mid_patched"],     // 185				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				                              				
				[1, "crfootman_helmet_mid"],               //~150  	
				[1, "crfootman_helmet_mid_reinforced"],               //~175 					
			]));
		}	
		else if (dc <= 90)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crfootman_armor_mid_chain"],     // 185
				[1, "crfootman_armor_mid_plate"],       //185
				[1, "crfootman_armor_mid_patched"],     // 185				
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				                              				  	
				[1, "crfootman_helmet_mid_reinforced"],               //~175 
				[1, "crfootman_helmet_late_kettle"],              //~200 					
			]));
		}
		else if (dc <= 120)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crfootman_armor_mid_chain"],     // 185
				[1, "crfootman_armor_mid_plate"],       //185
				[1, "crfootman_armor_mid_patched"],     // 185
				[2, "crfootman_armor_late_ichi"],      // 195
				[2, "crfootman_armor_late_ni"],      // 200					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				                              				 	
				[1, "crfootman_helmet_mid_reinforced"],               //~175 
				[1, "crfootman_helmet_late"],               //~175  	
				[1, "crfootman_helmet_late_heavy"],               //~200					
			]));
		}
		else if (dc > 120)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crfootman_armor_late_ichi"],      // 195
				[1, "crfootman_armor_late_ni"],      // 200					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				                              				
				[1, "crfootman_helmet_late_heavy"],               //~200					
			]));
		}
	}

});

