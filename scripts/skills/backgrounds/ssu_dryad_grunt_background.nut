this.ssu_dryad_grunt_background <- ::inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.ssu_dryad_grunt";
		this.m.Icon = "ui/backgrounds/dryad_background.png";
		this.m.Name = "Dryad";
		this.m.HiringCost = 0;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			"trait.asthmatic",
			"trait.clumsy",
			"trait.cocky"
		];
		this.m.Faces = ::Const.Dryad.Head;
		this.m.Bodies = ::Const.Dryad.Body;
		this.m.Hairs = null;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Level = 3;
		this.m.BackgroundType = ::Const.BackgroundType.Combat | ::Const.BackgroundType.Druid | ::Const.BackgroundType.Ranger;
		this.m.AlignmentMin = ::Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = ::Const.LegendMod.Alignment.Good;
		this.m.Modifiers.Stash = ::Const.LegendMod.ResourceModifiers.Stash[2];
		this.m.Modifiers.Training = ::Const.LegendMod.ResourceModifiers.Training[3];
		this.m.Modifiers.Gathering = ::Const.LegendMod.ResourceModifiers.Gather[1];
		this.m.Modifiers.Terrain = [
			0.0, // Plains
			0.0, // -
			0.0, // -
			0.1, // Swamps
			0.0, // Hills
			0.2, // Forests
			0.0, // -
			0.0, // -
			0.0, // -
			0.0, // Mountains
			0.0, // -
			0.1, // Farmlands
			0.0, // Snow
			0.0, // Badlands
			0.0, // Highlands
			0.0, // Steppes
			0.0, // -
			0.0, // Deserts
			0.0  // Oasis
		];
		this.m.CustomPerkTree = [
			[],
			[],
			[],
			[],
			[],
			[],
			[]
		];
	}

	function getTooltip()
	{
		local ret = this.character_background.getTooltip();
		return ret;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/dryad/dryad_spear"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"dryad_armour_grunt"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"dryad_helmet_grunt"
			]
		]));
	}

	function setupUpdateInjuryLayer()
	{
		local actor = this.getContainer().getActor().get();

		// Will always die, no survival chance when downed
		actor.isReallyKilled = function( _fatalityType )
		{
			return true;
		}
	}

	function onUpdate( _properties )
	{
		_properties.IsImmuneToBleeding = true;
		_properties.IsImmuneToPoison = true;
	}

	function onAdded()
	{
		this.character_background.onAdded();
		this.setupUpdateInjuryLayer();

		if (this.m.IsNew)
		{
			this.m.Container.add(this.new("scripts/skills/perks/perk_colossus"))
			this.m.Container.add(this.new("scripts/skills/racial/dryad_racial"))
		}
	}

	function buildPerkTree()
	{
		this.character_background.buildPerkTree();
		
		this.addPerkGroup(::Const.Perks.StaffTree.Tree);
		this.addPerkGroup(::Const.Perks.HammerTree.Tree);
		this.addPerkGroup(::Const.Perks.CleaverTree.Tree);
		this.addPerkGroup(::Const.Perks.DruidMagicTree.Tree);
		this.addPerkGroup(::Const.Perks.MediumArmorTree.Tree);
		this.addPerkGroup(::Const.Perks.HeavyArmorTree.Tree);
		this.addPerkGroup(::Const.Perks.LargeTree.Tree);
		this.addPerkGroup(::Const.Perks.CalmTree.Tree);
		this.addPerkGroup(::Const.Perks.SturdyTree.Tree);
		this.addPerkGroup(::Const.Perks.IntelligentTree.Tree);
		this.addPerkGroup(::Const.Perks.IndestructibleTree.Tree);
		this.addPerkGroup(::Const.Perks.MartyrTree.Tree);
		this.addPerk(::Const.Perks.PerkDefs.LegendGatherer, 2, false)
		this.addPerkGroup(::Const.Perks.CivilizationTree.Tree);
		this.addPerkGroup(::Const.Perks.OutlandersTree.Tree);

		if (::Is_PTR_Exist)
		{
			this.addPerkGroup(::Const.Perks.UnstoppableTree.Tree);
			this.addPerkGroup(::Const.Perks.ResilientTree.Tree);
			this.addPerk(::Const.Perks.PerkDefs.PTRManOfSteel, 5, false)
		}
	}

	function onChangeAttributes()
	{
		local att = {
			Hitpoints = [
				10,
				15
			],
			Bravery = [
				10,
				15
			],
			Stamina = [
				35,
				40
			],
			MeleeSkill = [
				5,
				10
			],
			RangedSkill = [
				-15,
				-20
			],
			MeleeDefense = [
				0,
				5
			],
			RangedDefense = [
				-15,
				-20
			],
			Initiative = [
				-40,
				-50
			]
		};
		return att;
	}

	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();
		local dryad = this.getContainer().hasSkill("racial.dryad");

		if ( dryad )
		{
			actor.m.Sound[::Const.Sound.ActorEvent.NoDamageReceived] = [
				"sounds/ambience/terrain/forest_branch_crack_00.wav",
				"sounds/ambience/terrain/forest_branch_crack_01.wav",
				"sounds/ambience/terrain/forest_branch_crack_02.wav",
				"sounds/ambience/terrain/forest_branch_crack_03.wav",
				"sounds/ambience/terrain/forest_branch_crack_04.wav",
				"sounds/ambience/terrain/forest_branch_crack_05.wav"
			];
			actor.m.Sound[::Const.Sound.ActorEvent.DamageReceived] = [
				"sounds/enemies/dlc2/schrat_hurt_shield_down_01.wav",
				"sounds/enemies/dlc2/schrat_hurt_shield_down_02.wav",
				"sounds/enemies/dlc2/schrat_hurt_shield_down_03.wav",
				"sounds/enemies/dlc2/schrat_hurt_shield_down_04.wav",
				"sounds/enemies/dlc2/schrat_hurt_shield_down_05.wav",
				"sounds/enemies/dlc2/schrat_hurt_shield_down_06.wav"
			];
			actor.m.Sound[::Const.Sound.ActorEvent.Death] = [
				"sounds/enemies/dlc2/schrat_death_01.wav",
				"sounds/enemies/dlc2/schrat_death_02.wav",
				"sounds/enemies/dlc2/schrat_death_03.wav",
				"sounds/enemies/dlc2/schrat_death_04.wav",
				"sounds/enemies/dlc2/schrat_death_05.wav",
				"sounds/enemies/dlc2/schrat_death_06.wav"
			];
			actor.m.Sound[::Const.Sound.ActorEvent.Fatigue] = [
				"sounds/enemies/dlc2/schrat_idle_05.wav",
				"sounds/enemies/dlc2/schrat_idle_06.wav",
				"sounds/enemies/dlc2/schrat_idle_07.wav",
				"sounds/enemies/dlc2/schrat_idle_08.wav",
				"sounds/enemies/dlc2/schrat_idle_09.wav"
			];
			actor.m.Sound[::Const.Sound.ActorEvent.Flee] = [
				"sounds/enemies/dlc2/schrat_idle_01.wav",
				"sounds/enemies/dlc2/schrat_idle_02.wav",
				"sounds/enemies/dlc2/schrat_idle_03.wav",
				"sounds/enemies/dlc2/schrat_idle_04.wav"
			];
			actor.m.Sound[::Const.Sound.ActorEvent.Other1] = [
				"sounds/enemies/dlc2/schrat_idle_01.wav",
				"sounds/enemies/dlc2/schrat_idle_02.wav",
				"sounds/enemies/dlc2/schrat_idle_03.wav",
				"sounds/enemies/dlc2/schrat_idle_04.wav",
				"sounds/enemies/dlc2/schrat_idle_05.wav",
				"sounds/enemies/dlc2/schrat_idle_06.wav",
				"sounds/enemies/dlc2/schrat_idle_07.wav",
				"sounds/enemies/dlc2/schrat_idle_08.wav",
				"sounds/enemies/dlc2/schrat_idle_09.wav"
			];
			
			actor.m.SoundPitch = ::Math.rand(95, 105) * 0.01;
			actor.m.SoundVolume[::Const.Sound.ActorEvent.Idle] = 2.0;
			actor.m.SoundVolume[::Const.Sound.ActorEvent.Fatigue] = 5.0;
			actor.m.SoundVolume[::Const.Sound.ActorEvent.Other1] = 2.5;
			
			return;
		}
	}

});