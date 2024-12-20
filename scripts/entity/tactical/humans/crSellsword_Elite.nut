this.crSellsword_Elite <- this.inherit("scripts/entity/tactical/human", {
	m = {
		IsLow = false
	},
	function create()
	{
		this.m.Type = this.Const.EntityType.crSellsword_Elite;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crSellsword_Elite.XP;
		this.m.Name = this.generateName();				
		this.human.create();
		this.m.Faces = this.Const.Faces.SmartMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
		this.setGender(1);		
	}
	
	function generateName()
	{
		return this.Const.Strings.crSellsword_EliteNames[this.Math.rand(0, this.Const.Strings.crSellsword_EliteNames.len() - 1)];
	}	

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.crSellsword_Elite);
		b.DamageTotalMult *= 1.15;
		b.IsSpecializedInSwords = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		this.setMoraleState(this.Const.MoraleState.Confident);			
		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_rebound"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_battleheart"));				
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_balance"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crresilient"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));		
		
		if (::Is_PTR_Exist)
		{
			this.m.Skills.addPerkTree(this.Const.Perks.TwoHandedTree);	
			this.m.Skills.addPerkTree(this.Const.Perks.OneHandedTree);		
			this.m.Skills.addPerkTree(this.Const.Perks.UnstoppableTree);
			this.m.Skills.addPerkTree(this.Const.Perks.SwordTree, 7);
			this.m.Skills.removeByID("perk.crTiC");	

			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_menacing"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bully"));	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_fruits_of_labor"));	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_concussive_strikes"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_small_target"));	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_head_smasher"));	
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vigorous_assault"));			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_man_of_steel"));
		}	

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crBattlerhaposdy"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_lithe"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_escape_artist"));						
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_in_the_zone"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_perfect_fit"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/traits/iron_jaw_trait"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_personal_armor"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bulwark"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bloodbath"));		
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_dismemberment"));	
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
			if (roll <= 3.0)
				::Mod_Sellswords.add_serpent(this.actor, false);
			else if (roll <= 6.0)
				::Mod_Sellswords.add_spider(this.actor, false);
			else if (roll <= 9.0)
				::Mod_Sellswords.add_direwolf(this.actor, false);
			else if (roll <= 12.0)
				::Mod_Sellswords.add_ghoul(this.actor, false);
			else if (roll <= 15.0)
				::Mod_Sellswords.add_orc(this.actor, false);
		}
	}

	function onDeath(_killer, _skill, _tile, _fatalityType)
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled() && _skill != null && !_skill.isRanged())
		{
			this.updateAchievement("ThereCanBeOnlyOne", 1, 1);
		}

		if (::Mod_Sellswords.EnableHostileSequences)
			::Mod_Sellswords.doHostileSequencePotionDrop(_killer, _skill, _tile, _fatalityType, this.actor);

		this.human.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function assignRandomEquipment()
	{	
		local v = this.Math.rand(1, 100);
	
		if (v <= 75)
		{
			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
			{
				local weapons = [
					"weapons/named/legend_named_bastardsword",
					"weapons/named/named_longsword",					
					"weapons/named/named_greatsword",
					"weapons/named/named_greatsword",
					"weapons/named/named_warbrand"	
				];

				this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));				
			}		
		}
		else if (v <= 100)
		{
			if (::Is_PTR_Exist)
			{
				this.m.Skills.removeByID("perk_ptr_menacing");	
				this.m.Skills.removeByID("perk_ptr_bully");	
				this.m.Skills.removeByID("perk_ptr_vigorous_assault");	
				this.m.Skills.removeByID("perk_ptr_dismemberment");	
				this.m.Skills.removeByID("perk_ptr_bloodbath");	
				this.m.Skills.removeByID("perk_ptr_bulwark");	
				this.m.Skills.removeByID("perk_ptr_personal_armor");
				this.m.Skills.addPerkTree(this.Const.Perks.SpearTree, 7);			
				this.m.Skills.addPerkTree(this.Const.Perks.PolearmTree, 7);	
				this.m.Skills.removeByID("perk.ptr_follow_up");	
			}

			this.m.Skills.removeByID("perk.legend_battleheart");

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
			{
				local weapons = [
					"weapons/named/legend_named_swordstaff",
				];

				this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));				
			}				
		}
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"sellsword_armor_elite"
			],
		]));

		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"sellsword_helmet_elite"
			]
		]));		
	}		

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"sellsword_armor_champion"
			],
		]));

		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"sellsword_helmet_champion"
			]
		]))
		this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 50;
		this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 50;		
		this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 50;
		this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 50;
		this.m.BaseProperties.DamageDirectMult *= 1.2;
		this.m.Skills.add(this.new("scripts/skills/effects/cr_clarity_effect_permanent"));		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nine_lives"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crBlockmaster"));
		return true;
	}

});

