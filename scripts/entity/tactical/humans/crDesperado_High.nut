this.crDesperado_High <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crDesperado_High;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crDesperado_High.XP;
		this.m.Name = this.generateName();
		this.m.IsGeneratingKillName = false;		
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.Military;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
	}
	
	function generateName()
	{
		return this.Const.Strings.crDesperadoNames[this.Math.rand(0, this.Const.Strings.crDesperadoNames.len() - 1)] + " " + this.Const.Strings.crDesperadoTitles[this.Math.rand(0, this.Const.Strings.crDesperadoTitles.len() - 1)];
	}	

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.crDesperado_High);
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");

		if (this.Math.rand(1, 100) <= 33)
		{
			local r = this.Math.rand(1, 4);

			if (r == 1)
			{
				local sprite = this.getSprite("permanent_injury_4");
				sprite.setBrush("permanent_injury_04");
				sprite.Visible = true;
			}
			else if (r == 2)
			{
				local sprite = this.getSprite("permanent_injury_2");
				sprite.setBrush("permanent_injury_02");
				sprite.Visible = true;
			}
			else if (r == 3)
			{
				local sprite = this.getSprite("permanent_injury_1");
				sprite.setBrush("permanent_injury_01");
				sprite.Visible = true;
			}
			else if (r == 4)
			{
				local sprite = this.getSprite("permanent_injury_scarred");
				sprite.setBrush("permanent_injury_scarred");
				sprite.Visible = true;
			}
		}
						
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));					
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smackdown"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));

		if (::Is_PTR_Exist)
		{
			//this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vigorous_assault"));
			//this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_fruits_of_labor"));	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_formidable_approach"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_man_of_steel"));	
		}

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{				
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));			
			this.m.Skills.add(this.new("scripts/skills/traits/iron_jaw_trait"));	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crIronsideweak"));			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crBruiser"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crRavager"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_personal_armor"));	
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_primal_fear"));
				local dismantle = this.new("scripts/skills/perks/perk_ptr_dismantle");
				dismantle.m.IsForceEnabled = true;
				this.m.Skills.add(dismantle);	
			}
		}
		
		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 3);	
		
		if (dc >= 25)
		{
			b.MeleeSkill += 5;
			b.Bravery += 10;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_battleheart"));

			if (dc >= 50)
			{
				if (::Is_PTR_Exist)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_wears_it_well"));
				}		
				
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_true_believer"));				
				b.MeleeDefense += 5;
				b.DamageTotalMult += 0.1;			

				if (dc >= 80)
				{
					b.DamageTotalMult += 0.05;					
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_muscularity"));				
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_second_wind"));			
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_perfect_fit"));						
					b.MeleeSkill += 5;			
					b.MeleeDefense += 5;			
					b.Bravery += 10;
					if (dc >= 150)
					{
						b.DamageTotalMult += 0.05;					
						b.MeleeSkill += 2;	
						b.Initiative += 2;

						if (::Is_PTR_Exist)
						{
							this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_fruits_of_labor"));	
						}
						
						this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_last_stand"));						
						if (dc >= 200)
						{
							b.DamageTotalMult += 0.05;						
							b.MeleeDefense += 2;	
							b.Initiative += 3;
							b.Bravery += 5;							
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
				::Mod_Sellswords.add_direwolf(this.actor, true);
		}
	}

	function onDeath(_killer, _skill, _tile, _fatalityType)
	{
		if (::Mod_Sellswords.EnableHostileSequences)
			::Mod_Sellswords.doHostileSequencePotionDrop(_killer, _skill, _tile, _fatalityType, this.actor);
		this.human.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/named/legend_named_infantry_axe",
				"weapons/named/named_two_handed_flail",
				"weapons/named/legend_named_military_goedendag",
				"weapons/named/cr_named_goedendag",				
				"weapons/named/named_two_handed_mace",
				"weapons/named/named_two_handed_hammer"				
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			
			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_menacing"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bully"));				
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bulwark"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));
			}

			this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));					
			this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));			
		}
		
		local armor = this.Const.World.Common.pickArmor([
				[1, "crknight_armor"],
				[1, "crhedgeknight_armor"]				
		]);	
		
		armor.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_additional_padding_upgrade"));
		
		this.m.Items.equip(armor);		

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[
					2,
					"crknight_helmet"
				],
				[
					3,
					"crhedgeknight_helmet"
				]				
			]));
		}
	}

});

