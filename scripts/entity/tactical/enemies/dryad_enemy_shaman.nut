this.dryad_enemy_shaman <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.DryadShaman;
		this.m.BloodType = this.Const.BloodType.Wood;
		this.m.XP = this.Const.Tactical.Actor.DryadShaman.XP;
		this.human.create();
		this.m.Faces = ::Const.Dryad.Head;
		this.m.Bodies = ::Const.Dryad.Body;
		this.m.Hairs = null;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/dryad_shaman_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.DryadShaman);
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

		this.m.Skills.add(this.new("scripts/skills/actives/root_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/insects_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/forest_blessing"));
		this.m.Skills.add(this.new("scripts/skills/actives/natural_regrowth"));

		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_second_wind"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_lithe"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crresilient"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_the_rush_of_battle"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bulwark"));
		}

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crHonorheritage"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_man_of_steel"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_exude_confidence"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_personal_armor"));
			}
		}
	}

	function assignRandomEquipment()
	{
		this.m.Items.equip(this.new("scripts/items/weapons/dryad/dryad_staff"));
		this.m.Items.equip(this.new("scripts/items/ammo/forest_heart_ammo"));
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"dryad_armour_shaman"
			]
		]));
		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"dryad_helmet_shaman"
			]
		]));

		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);		
	}

});