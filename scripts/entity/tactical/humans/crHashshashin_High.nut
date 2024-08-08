this.crHashshashin_High <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crHashshashin_High;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crHashshashin_High.XP;
		this.m.Name = this.generateName();
		this.m.IsGeneratingKillName = false;			
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

	function generateName()
	{
		return this.Const.Strings.crHashshashinNames[this.Math.rand(0, this.Const.Strings.crHashshashinNames.len() - 1)] + " " + this.Const.Strings.crHashshashinTitles[this.Math.rand(0, this.Const.Strings.crHashshashinTitles.len() - 1)];
	}	
	
	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.crHashshashin_High);
		b.DamageDirectMult *= 1.25;
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
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
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
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_double_strike"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/effects/cr_clarity_effect_permanent"));		

		if (::Is_PTR_Exist)
		{
			this.m.Skills.addPerkTree(this.Const.Perks.OneHandedTree);	

			this.m.Skills.add(this.new("scripts/skills/effects/ptr_fresh_and_furious_effect"));	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vigorous_assault"));
		}

		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.removeByID("perk.underdog");			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crDiscipline"));	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nine_lives"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_escape_artist"));					
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_battleheart"));
			local dc = this.World.getTime().Days;			
			local blk = this.Math.rand(1, 100);
			if (dc > 180 && blk >= 80)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_crBlockmaster"));
			}
			else if(dc > 140 && blk >= 50)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_crBlockskilled"));
			}
			else if(dc > 100 && blk >= 20)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_crBlocknormal"));
			}
		}			

		if (this.World.getTime().Days >= 25)
		{
			b.MeleeSkill += 5;
			b.Bravery += 10;

			if (this.World.getTime().Days >= 50)
			{
				b.DamageTotalMult += 0.1;			
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
						b.DamageTotalMult += 0.05;					
						this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
						this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_alert"));

						if (::Is_PTR_Exist)
						{
							this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_unstoppable"));
						}			

						b.MeleeSkill += 5;			
						b.MeleeDefense += 5;				
						b.Initiative += 3;
						if (this.World.getTime().Days >= 150)
						{
							b.Hitpoints += 15;						
							b.DamageTotalMult += 0.05;						
							b.MeleeSkill += 2;	
							b.Initiative += 3;
							this.m.Skills.add(this.new("scripts/skills/perks/perk_last_stand"));																				
							if (this.World.getTime().Days >= 200)
							{
								b.DamageTotalMult += 0.05;							
								b.MeleeDefense += 2;	
								b.Initiative += 4;
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

	function onDeath(_killer, _skill, _tile, _fatalityType)
	{
		if (::Mod_Sellswords.EnableHostileSequences)
			::Mod_Sellswords.doHostileSequencePotionDrop(_killer, _skill, _tile, _fatalityType, this.getContainer().getActor());
		this.human.onDeath(_killer, _skill, _tile, _fatalityType);
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
				"weapons/named/named_shamshir",
				"weapons/named/named_khopesh",			
				"weapons/named/legend_named_gladius",
				"weapons/named/named_qatal_dagger"	
			];

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

			//if (::Is_PTR_Exist)
			//{
			//	this.m.Skills.addTreeOfEquippedWeapon(7);	
			//}	
			::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);		
		}
		
		local armor = this.Const.World.Common.pickArmor([	
			[1, "hashshashin_armor_high"],				
		]);	
		
		armor.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_hyena_fur_upgrade"))
		
		this.m.Items.equip(armor);		

		this.m.Items.equip(this.Const.World.Common.pickHelmet([					
			[1, "hashshashin_helmet_high"],					
		]));
		
		local dc = this.World.getTime().Days;
		
		this.m.Items.addToBag(this.new("scripts/items/tools/daze_bomb_item"));		
	}
	
});

