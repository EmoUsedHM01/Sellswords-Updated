this.dryad_enemy_boss <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.DryadBoss;
		this.m.BloodType = this.Const.BloodType.Wood;
		this.m.MoraleState = this.Const.MoraleState.Ignore;
		this.m.XP = this.Const.Tactical.Actor.DryadBoss.XP;
		this.human.create();
		this.m.Faces = ::Const.Dryad.Head;
		this.m.Bodies = ::Const.Dryad.Body;
		this.m.Hairs = null;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/zombie_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.DryadBoss);
		b.TargetAttractionMult = 1.0;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		b.IsImmuneToRoot = true;
		b.IsImmuneToDisarm = true;
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_dryad");
		this.getSprite("miniboss").setBrush("bust_miniboss");
		local injury = this.addSprite("injury");
		injury.Visible = false;

		this.m.Skills.add(this.new("scripts/skills/racial/dryad_racial"));
		this.m.Skills.add(this.new("scripts/skills/traits/dryad_thorns_trait"));
		this.m.Skills.add(this.new("scripts/skills/effects/dryad_guardian_effect"));

		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crresilient"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_menacing"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_man_of_steel"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_survival_instinct"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_formidable_approach"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_dismemberment"));
		}

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_battleheart"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_personal_armor"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_tempo"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vigilant"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bully"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_unstoppable"));
			}
		}
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		this.human.onDeath(_killer, _skill, _tile, _fatalityType);
		if (_tile != null)
		{
			local corpse = _tile.Properties.get("Corpse");
			corpse.IsResurrectable = false;
		}
	}

	function assignRandomEquipment()
	{
		this.m.Items.equip(this.new("scripts/items/weapons/special/ssu_legendary_hammer"));
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"dryad_armour_warrior"
			]
		]));
		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"dryad_helmet_grunt"
			]
		]));

		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);		
	}

});