this.crSlayer <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crSlayer;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.crSlayer.XP;
		this.m.Name = this.generateName();
		this.m.IsGeneratingKillName = false;
		this.human.create();
		this.m.Faces = this.Const.Faces.SmartMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function generateName()
	{
		return this.Const.Strings.SlayerNames[this.Math.rand(0, this.Const.Strings.SlayerNames.len() - 1)];
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.crSlayer);
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
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_second_wind"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smackdown"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));
		this.m.Skills.add(this.new("scripts/skills/actives/barbarian_fury_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_adrenalin"));
		

		if (::Is_PTR_Exist)
		{
			this.m.Skills.addPerkTree(this.Const.Perks.TwoHandedTree);

			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_unstoppable"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_the_rush_of_battle"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bulwark"));
		}

		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");
		dc = this.Math.max(dc, mn * 3);
		if (dc >= 80)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_strength_in_numbers"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mastery_unarmed"));
			
			if (::Is_PTR_Exist)
				this.m.Skills.add(this.new("scripts/skills/racial/ptr_orc_racial"));

			if (dc >= 120)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));

				if (::Is_PTR_Exist)
					this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_personal_armor"));

				if (dc >= 150)
				{
					if (::Is_PTR_Exist)
						this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_the_rush_of_battle"));
					
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_muscularity"));
					if (dc >= 180)
						this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));
				}
			}
		}

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{	
			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_man_of_steel"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vigorous_assault"));
			}

			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_last_stand"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));
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
		if (::Mod_Sellswords.EnableHostileSequences)
			::Mod_Sellswords.doHostileSequencePotionDrop(_killer, _skill, _tile, _fatalityType, this.actor);
		this.human.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function assignRandomEquipment()
	{
		local r;
		local dc = this.World.getTime().Days;

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/barbarians/crbarbarian_hammer",
				"weapons/barbarians/crbarbarian_mace",
				"weapons/greenskins/orc_axe_2h",
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);	

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "crslayer_armor"]
		]));
		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[1, "crslayer_helmet"]
		]));
	}

});