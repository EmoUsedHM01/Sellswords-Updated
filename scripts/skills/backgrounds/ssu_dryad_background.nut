this.ssu_dryad_background <- ::inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.ssu_dryad";
		this.m.Icon = "ui/backgrounds/dryad_background.png";
		this.m.Name = "Dryad";
		this.m.HiringCost = 6000;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			"trait.asthmatic",
			"trait.clumsy",
			"trait.cocky"
		];
		this.m.Titles = [
			"the Dryad"
		];
		this.m.Faces = ::Const.Dryad.Head;
		this.m.Bodies = ::Const.Dryad.Body;
		this.m.Hairs = null;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Level = 1;
		this.m.BackgroundType = ::Const.BackgroundType.Combat | ::Const.BackgroundType.Druid | ::Const.BackgroundType.Ranger;
		this.m.AlignmentMin = ::Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = ::Const.LegendMod.Alignment.Good;
		this.m.Modifiers.Meds = ::Const.LegendMod.ResourceModifiers.Meds[2];
		this.m.Modifiers.Injury = ::Const.LegendMod.ResourceModifiers.Injury[2];
		this.m.Modifiers.MedConsumption = ::Const.LegendMod.ResourceModifiers.MedConsumption[2];
		this.m.Modifiers.Stash = ::Const.LegendMod.ResourceModifiers.Stash[0];
		this.m.Modifiers.Hunting = ::Const.LegendMod.ResourceModifiers.Hunting[2];
		this.m.Modifiers.Scout = ::Const.LegendMod.ResourceModifiers.Scout[2];
		this.m.Modifiers.Gathering = ::Const.LegendMod.ResourceModifiers.Gather[3];
		this.m.Modifiers.Terrain = [
			0.0, // Plains
			0.0, // -
			0.0, // -
			0.1, // Swamps
			0.0, // Hills
			0.5, // Forests
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

		// Base Trees, basically ones that it always spawns with
		local trees = [
			this.Const.Perks.CleaverTree,
			this.Const.Perks.StaffTree,
			this.Const.Perks.SturdyTree,
			this.Const.Perks.MediumArmorTree,
			this.Const.Perks.DruidMagicTree			
		]

		// If you have PTR, these two are added to the base trees
		if (::Is_PTR_Exist)
		{
			trees.extend([
				this.Const.Perks.OneHandedTree,
				this.Const.Perks.ApothecaryProfessionTree	
			])
		}

		::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, trees);
		
		// Armour Trees
		local cramtrees = [
			this.Const.Perks.ClothArmorTree,
			this.Const.Perks.LightArmorTree,
			this.Const.Perks.HeavyArmorTree
		];
		
		// Weapon Trees
		local crwptrees = [
			this.Const.Perks.AxeTree,
			this.Const.Perks.SwordTree,
			this.Const.Perks.FlailTree,
			this.Const.Perks.MaceTree,
			this.Const.Perks.DaggerTree,
			this.Const.Perks.HammerTree			
		];
		
		// Trait Trees
		local crtttrees = [	
			this.Const.Perks.AgileTree,
			this.Const.Perks.FastTree,			
			this.Const.Perks.ViciousTree,			
			this.Const.Perks.CalmTree,				
			this.Const.Perks.LargeTree,
			this.Const.Perks.FitTree,
			this.Const.Perks.TrainedTree		
		];
		
		// If you have PTR, these two are added to the random trait trees
		if (::Is_PTR_Exist)
		{
			crtttrees.extend([
				this.Const.Perks.UnstoppableTree,
				this.Const.Perks.ResilientTree	
			])
		}
		
		for (local i = 0; i < 1; ++i)
		{
			// Picking a single extra armour tree to add to the perk tree
			::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [cramtrees.remove(this.Math.rand(0, cramtrees.len()-1))]);			
		}		

		for (local i = 0; i < 2; ++i)
		{
			// Picking two extra weapon tree to add to the perk tree
			::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [crwptrees.remove(this.Math.rand(0, crwptrees.len()-1))]);			
		}

		for (local i = 0; i < 2; ++i)
		{
			// Picking a two extra trait tree to add to the perk tree
			::Mod_Sellswords.HookHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [crtttrees.remove(this.Math.rand(0, crtttrees.len()-1))]);			
		}

		// Adds BattleHeart to the perk map
		::Mod_Sellswords.HookHelper.addPerksToCustomPerkTree(4, this.m.CustomPerkTree, [
			this.Const.Perks.PerkDefs.LegendBattleheart
		]);

		if (::Is_PTR_Exist)
		{
			::Mod_Sellswords.HookHelper.addPerksToCustomPerkTree(5, this.m.CustomPerkTree, [
					this.Const.Perks.PerkDefs.PTRRisingStar,
				]
			);		
			::Mod_Sellswords.HookHelper.addPerksToCustomPerkTree(4, this.m.CustomPerkTree, [
					this.Const.Perks.PerkDefs.PTRManOfSteel,
				]
			);
		}
	}

	function getTooltip()
	{
		local ret = this.character_background.getTooltip();
		return ret;
	}
	
	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/barbarians/legend_antler_cleaver"));
		items.equip(this.new("scripts/items/ammo/forest_heart_ammo"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"dryad_armour"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"dryad_helmet"
			]
		]));
	}

	function setupUpdateInjuryLayer()
	{
		local actor = this.getContainer().getActor().get();

		// will always die, no survival chance
		actor.isReallyKilled = function( _fatalityType )
		{
			return true;
		}
	}

	function onUpdate( _properties )
	{
		_properties.Vision += 1;
		_properties.IsImmuneToBleeding = true;
		_properties.IsImmuneToPoison = true;
		
	}
	
	function onAdded()
	{
		this.character_background.onAdded();
		this.setupUpdateInjuryLayer();
		this.getContainer().getActor().getSkills().add(this.new("scripts/skills/racial/dryad_racial"));
	}

	function onChangeAttributes()
	{
		local attri = {
			Hitpoints = [
				10,
				15
			],
			Bravery = [
				0,
				5
			],
			Stamina = [
				25,
				30
			],
			MeleeSkill = [
				5,
				10
			],
			RangedSkill = [
				-10,
				-10
			],
			MeleeDefense = [
				5,
				10
			],
			RangedDefense = [
				-5,
				-5
			],
			Initiative = [
				-30,
				-30
			]
		};
		return attri;
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

	function onFinishingPerkTree()
	{
	}

});

