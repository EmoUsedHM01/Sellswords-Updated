this.ssu_dryad_archer_background <- ::inherit("scripts/skills/backgrounds/character_background", {
	m = {
		PerkGroupMultipliers = []
	},
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
		this.m.Names = this.Const.Strings.DryadNames;
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

		if (::Is_PTR_Exist)
		{
			this.m.PerkGroupMultipliers <- [
				[0.66, ::Const.Perks.ShieldTree],
				[3, ::Const.Perks.MediumArmorTree]
			];

			this.m.PerkTreeDynamic = {
				Profession = [
					::Const.Perks.HunterProfessionTree
				],
				Enemy = [
					::Const.Perks.ArchersTree
				],
				Traits = [
					::Const.Perks.AgileTree
				],
				Class = [
					::Const.Perks.ScoutClassTree
				],
				Defense = [
					::Const.Perks.LightArmorTree
				],
				Weapon = [
					::Const.Perks.BowTree,
					::Const.Perks.CrossbowTree,
					::Const.Perks.SlingTree,
					::Const.Perks.ThrowingTree
				]
			};
		}
	}

	function onBuildDescription()
	{
		return "{%fullname% has roamed the ancient forests for centuries, guarding its secrets and punishing those who defile it. | %fullname% remembers the first sprouting of trees, the bloom of the first flowers, and has vowed to protect them ever since. | With a spirit attuned to the earth and wisdom ancient as the stars, %fullname% has long watched over the Heartwoods. | The forests speak through %fullname%, their whispers guiding every step and decision. | %fullname% is one with the Heartwoods, and to cross paths with them is to face the wrath of nature itself. | As a guardian of the Heartwoods, %fullname% ensures that the balance is maintained, no matter the cost. | Long ago, %fullname% took up the mantle of protector, a duty carried out with unwavering resolve. | %fullname% was born of the Heartwoods, their soul intertwined with every leaf and branch. | %fullname% has seen countless seasons come and go, always ensuring the cycle of life continues. | To disturb the forest is to disturb %fullname%, and that is a mistake few live to repeat.} {With each passing season, %name% grows stronger, learning the ways of nature\'s wrath. | Having witnessed countless trespassers fall to the forest\'s fury, %name% knows the woods like no other. | %name% has honed their skills with nature\'s gifts, their power rivaled by none. | The whispers of the trees guide %name%\'s every move, making them a formidable ally or a terrifying foe. | With a touch, %name% can command the very essence of the forest to do their bidding. | Few can stand against the might of %name% when the forest itself rises to their call. | Each step %name% takes is calculated, guided by centuries of knowledge. | %name%\'s connection to the earth grants them power and insight beyond mortal comprehension. | To face %name% is to face the very soul of the forest itself. | With every rustling leaf and creaking branch, %name% grows more attuned to the world around them.} {The forest has taught %name% to be both fierce and wise in equal measure. | %name% is no stranger to the cycle of life and death, having seen it unfold for eons. | Their resolve is as unyielding as the ancient trees they protect. | Some say %name% can communicate with the very essence of the forest, guiding it to their will. | %name% is a sentinel of nature, ever-watchful and ever-ready to strike down those who threaten the balance. | Tales of %name%\'s deeds echo through the woods, a reminder of the forest\'s fury. | %name% carries the wisdom of the ages, using it to protect and preserve the sanctity of nature. | The forest\'s creatures rally to %name%\'s side, their loyalty born of mutual respect and ancient bonds. | In battle, %name% is a force of nature, their strikes swift and unrelenting.} {For those who respect the forest, %name% offers their protection and guidance. | %name% fights not for gold, but to preserve the sanctity of nature itself. | With a calm nod, %name% agrees to lend their strength to those who share their cause. | Ready to defend the ancient woods, %name% rises to the challenge, eager to uphold the balance. | For the promise of a safer world, %name% is prepared to strike down any who threaten the Heartwoods.}";
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