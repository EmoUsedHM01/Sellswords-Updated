this.ssu_dryad_enemy_boss <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.SsuDryadBoss;
		this.m.BloodType = this.Const.BloodType.Wood;
		this.m.MoraleState = this.Const.MoraleState.Ignore;
		this.m.XP = this.Const.Tactical.Actor.SsuDryadBoss.XP;
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
		b.setValues(this.Const.Tactical.Actor.SsuDryadBoss);
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
		this.getSprite("socket").setBrush("ssu_bust_base_dryad");
		this.getSprite("miniboss").setBrush("bust_miniboss");
		local injury = this.addSprite("injury");
		injury.Visible = false;

		this.m.Skills.add(this.new("scripts/skills/racial/ssu_dryad_racial"));
		this.m.Skills.add(this.new("scripts/skills/traits/ssu_dryad_thorns_trait"));
		this.m.Skills.add(this.new("scripts/skills/effects/ssu_dryad_guardian_effect"));

		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_battleheart"));
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
		this.m.Items.equip(::Legends.Items.pickArmor([
			[
				1,
				"ssu_dryad_armour_warrior"
			]
		]));
		this.m.Items.equip(::Legends.Items.pickHelmet([
			[
				1,
				"ssu_dryad_helmet_grunt"
			]
		]));

		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);		
	}

});