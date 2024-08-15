this.dryad_enemy_tamer <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.DryadTamer;
		this.m.BloodType = this.Const.BloodType.Wood;
		this.m.XP = this.Const.Tactical.Actor.DryadTamer.XP;
		this.human.create();
		this.m.Faces = ::Const.Dryad.Head;
		this.m.Bodies = ::Const.Dryad.Body;
		this.m.Hairs = null;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/barbarian_beastmaster_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.DryadTamer);
		b.TargetAttractionMult = 1.0;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_dryad");
		
		this.m.Skills.add(this.new("scripts/skills/racial/dryad_racial"));

		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_lithe"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crresilient"));

		if (::Is_PTR_Exist)
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_the_rush_of_battle"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));

			if (::Is_PTR_Exist)
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_personal_armor"));
		}
	}

	function assignRandomEquipment()
	{
		this.m.Items.equip(this.new("scripts/items/weapons/dryad/dryad_cleaver"));
		this.m.Items.equip(this.new("scripts/items/ammo/forest_heart_ammo"));
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"dryad_armour_tamer"
			]
		]));
		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"dryad_helmet_tamer"
			]
		]));

		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);		
	}

});