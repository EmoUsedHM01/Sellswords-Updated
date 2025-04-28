this.crBarbarianChampionhigh <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crBarbarianChampionhigh;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crBarbarianChampionhigh.XP;
		this.m.Name = this.generateName();
		this.m.IsGeneratingKillName = false;			
		this.human.create();
		this.m.Faces = this.Const.Faces.WildMale;
		this.m.Hairs = this.Const.Hair.WildMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.WildExtended;
		this.m.SoundPitch = 0.95;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/barbarian_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function generateName()
	{
		return this.Const.Strings.crBarbarianChampionNames[this.Math.rand(0, this.Const.Strings.crBarbarianChampionNames.len() - 1)] + " " + this.Const.Strings.crBarbarianChampionTitles[this.Math.rand(0, this.Const.Strings.crBarbarianChampionTitles.len() - 1)];
	}
	
	function onInit()
	{
		this.human.onInit();
		local tattoos = [
			3,
			4,
			5,
			6
		];

		if (this.Math.rand(1, 100) <= 66)
		{
			local tattoo_body = this.actor.getSprite("tattoo_body");
			local body = this.actor.getSprite("body");
			tattoo_body.setBrush("tattoo_0" + tattoos[this.Math.rand(0, tattoos.len() - 1)] + "_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			local tattoo_head = this.actor.getSprite("tattoo_head");
			tattoo_head.setBrush("tattoo_0" + tattoos[this.Math.rand(0, tattoos.len() - 1)] + "_head");
			tattoo_head.Visible = true;
		}

		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.crBarbarianChampionhigh);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.Skills.update();
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_wildmen_01");
		this.m.Skills.add(this.new("scripts/skills/actives/barbarian_fury_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_adrenalin"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_balance"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_lithe"));			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_strength_in_numbers"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vigorous_assault"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_menacing"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_unstoppable"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bloody_harvest"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_formidable_approach"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_sweeping_strikes"));
		}

	 	if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_alert"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mastery_unarmed"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_second_wind"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_terrifying_visage"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bulwark"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_personal_armor"));
				this.m.Skills.add(this.new("scripts/skills/effects/ptr_fresh_and_furious_effect"));
			}	
		}
				
		if (this.World.getTime().Days >= 25)
		{
			b.MeleeSkill += 5;
			b.Bravery += 10;

			if (this.World.getTime().Days >= 50)
			{
				b.DamageTotalMult += 0.1;			
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_perfect_fit"));			
				b.MeleeDefense += 5;				

				if (this.World.getTime().Days >= 80)
				{
					b.DamageTotalMult += 0.05;					
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_muscularity"));									
					b.MeleeSkill += 5;			
					b.MeleeDefense += 5;			
					b.Bravery += 10;
					if (this.World.getTime().Days >= 120)
					{					
						if (::Is_PTR_Exist)
						{
							this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_tempo"));
							this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_sanguinary"));												
							this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_dismemberment"));		
						}

						this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_last_stand"));						
						if (this.World.getTime().Days >= 150)
						{
							b.DamageTotalMult += 0.05;						
							b.MeleeSkill += 2;	
							b.Initiative += 2;	
							this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_in_the_zone"));						
							this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));							
							if (this.World.getTime().Days >= 200)
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
				::Mod_Sellswords.add_orc(this.actor, true);
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
				"weapons/named/named_twincleavers",
				"weapons/named/named_twinaxes",
				
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			
			//if (::Is_PTR_Exist)
			//{
			//	this.m.Skills.addTreeOfEquippedWeapon(7);	
			//}

			::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);
		}

		if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 50)
		{
			local weapons = [
				"weapons/throwing_axe",
				"weapons/javelin"
			];

			if (this.Const.DLC.Unhold)
			{
				weapons.push("weapons/throwing_spear");
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		local armor = this.Const.World.Common.pickArmor([
				[1, "cr_barb_chosen_ichi"],
				[1, "cr_barb_chosen_ni"]				
		]);	
		
		armor.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_direwolf_pelt_upgrade"));
		
		this.m.Items.equip(armor);

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "cr_barb_chosen_ichi"],
				[1, "cr_barb_chosen_ni"]
			]));

		}
	}

});

