this.ssu_dryad_enemy_shaman <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.SsuDryadShaman;
		this.m.BloodType = this.Const.BloodType.Wood;
		this.m.XP = this.Const.Tactical.Actor.SsuDryadShaman.XP;
		this.human.create();
		this.m.Faces = ::Const.Dryad.Head;
		this.m.Bodies = ::Const.Dryad.Body;
		this.m.Hairs = null;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/ssu_dryad_shaman_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.SsuDryadShaman);
		b.TargetAttractionMult = 1.0;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		b.IsAffectedByNight = false;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("ssu_bust_base_dryad");
		
		this.m.Skills.add(this.new("scripts/skills/racial/ssu_dryad_racial"));

		this.m.Skills.add(this.new("scripts/skills/actives/root_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/insects_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/ssu_dryad_forest_blessing"));
		this.m.Skills.add(this.new("scripts/skills/actives/ssu_dryad_natural_regrowth"));

		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_second_wind"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_lithe"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_resilient"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ssu_honorheritage"));
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
		this.m.Items.equip(this.new("scripts/items/weapons/dryad/ssu_dryad_staff"));
		this.m.Items.equip(this.new("scripts/items/ammo/ssu_dryad_forest_heart_ammo"));
		this.m.Items.equip(::Legends.Items.pickArmor([
			[
				1,
				"ssu_dryad_armour_shaman"
			]
		]));
		this.m.Items.equip(::Legends.Items.pickHelmet([
			[
				1,
				"ssu_dryad_helmet_shaman"
			]
		]));

		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);		
	}

});