this.ssu_dryad_archer_background <- ::inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.ssu_dryad_archer";
		this.m.Icon = "ui/backgrounds/dryad_archer_background.png";
		this.m.Name = "Dryad Archer";
		this.m.HiringCost = 0;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			"trait.night_blind",
			"trait.short_sighted",
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
		this.m.Level = 2;
		this.m.BackgroundType = ::Const.BackgroundType.Combat | ::Const.BackgroundType.Ranger | this.Const.BackgroundType.ExpertHunter;
		this.m.AlignmentMin = ::Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = ::Const.LegendMod.Alignment.Good;
		this.m.Modifiers.Ammo = ::Const.LegendMod.ResourceModifiers.Ammo[2];
		this.m.Modifiers.Hunting = ::Const.LegendMod.ResourceModifiers.Hunting[2];
		this.m.Modifiers.Scout = ::Const.LegendMod.ResourceModifiers.Scout[3];
		this.m.Modifiers.Gathering = ::Const.LegendMod.ResourceModifiers.Gather[1];
		this.m.Modifiers.Terrain = [
			0.1, // Plains
			0.0, // -
			0.0, // -
			0.0, // Swamps
			0.0, // Hills
			0.5, // Forests
			0.0, // -
			0.0, // -
			0.0, // -
			0.0, // Mountains
			0.0, // -
			0.0, // Farmlands
			0.0, // Snow
			0.0, // Badlands
			0.0, // Highlands
			0.0, // Steppes
			0.0, // -
			0.0, // Deserts
			0.0  // Oasis
		];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.BowTree,
				this.Const.Perks.CrossbowTree,
				this.Const.Perks.SwordTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.AgileTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.ViciousTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.DeviousTree
			],
			Enemy = [
				this.Const.Perks.DirewolfTree,
				this.Const.Perks.SpiderTree,
				this.Const.Perks.SchratTree,
				this.Const.Perks.ArcherTree
			],
			Class = [],
			Magic = []
		};
	}

	function getTooltip()
	{
		local ret = this.character_background.getTooltip();
		return ret;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/dryad/dryad_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"dryad_armour_archer"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"dryad_helmet_archer"
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
		this.m.Container.add(this.new("scripts/skills/perks/perk_ballistics"))
		this.m.Container.add(this.new("scripts/skills/racial/dryad_racial"))
	}

	function buildPerkTree()
	{
		this.character_background.buildPerkTree();
		this.addPerk(::Const.Perks.PerkDefs.Ballistics, 0, false)
	}

	function onChangeAttributes()
	{
		local att = {
			Hitpoints = [
				5,
				5
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
				0,
				0
			],
			RangedSkill = [
				20,
				17
			],
			MeleeDefense = [
				0,
				0
			],
			RangedDefense = [
				0,
				3
			],
			Initiative = [
				-20,
				-30
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