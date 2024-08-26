this.dryad_enemy_grunt <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.DryadGrunt;
		this.m.BloodType = this.Const.BloodType.Wood;
		this.m.XP = this.Const.Tactical.Actor.DryadGrunt.XP;
		this.human.create();
		this.m.Faces = ::Const.Dryad.Head;
		this.m.Bodies = ::Const.Dryad.Body;
		this.m.Hairs = null;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.DryadGrunt);
		b.TargetAttractionMult = 1.0;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		b.IsAffectedByNight = false;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_dryad");
		
		this.m.Skills.add(this.new("scripts/skills/racial/dryad_racial"));

		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crresilient"));

		if (::Is_PTR_Exist)
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_the_rush_of_battle"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_man_of_steel"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_personal_armor"));
			}
		}
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		this.human.onDeath(_killer, _skill, _tile, _fatalityType);
		local corpse = _tile.Properties.get("Corpse");
		corpse.IsResurrectable = false;
	}

	function assignRandomEquipment()
	{
		this.m.Items.equip(this.new("scripts/items/weapons/dryad/dryad_spear"));
		this.m.Items.equip(this.new("scripts/items/shields/beasts/schrat_shield"));
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"dryad_armour_grunt"
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