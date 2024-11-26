this.ssu_dryad_shaman_background <- ::inherit("scripts/skills/backgrounds/ssu_base_dryad_background", {
	m = {
		PerkGroupMultipliers = []
	},
	function create()
	{
		this.m.ID = "background.ssu_dryad_shaman";
		this.m.Icon = "ui/backgrounds/dryad_shaman_background.png";
		this.m.Name = "Dryad Shaman";
		this.m.HiringCost = 0;
		this.m.DailyCost = 0;
		this.m.Excluded = [
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
		this.m.BackgroundType = ::Const.BackgroundType.Combat | ::Const.BackgroundType.Druid | ::Const.BackgroundType.Ranger;
		this.m.AlignmentMin = ::Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = ::Const.LegendMod.Alignment.Good;
		this.m.Modifiers.Meds = ::Const.LegendMod.ResourceModifiers.Meds[2];
		this.m.Modifiers.Injury = ::Const.LegendMod.ResourceModifiers.Injury[2];
		this.m.Modifiers.MedConsumption = ::Const.LegendMod.ResourceModifiers.MedConsumption[2];
		this.m.Modifiers.Stash = ::Const.LegendMod.ResourceModifiers.Stash[0];
		this.m.Modifiers.Gathering = ::Const.LegendMod.ResourceModifiers.Gather[1];
		this.m.Modifiers.Terrain = [
			0.0, // Plains
			0.0, // -
			0.0, // -
			0.0, // Swamps
			0.0, // Hills
			0.2, // Forests
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
				this.Const.Perks.HammerTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.StaffTree,
				this.Const.Perks.DryadShamanTree
			],
			Defense = [
				this.Const.Perks.ClothArmorTree
			],
			Traits = [
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.FitTree
			],
			Enemy = [],
			Class = [],
			Magic = []
		};

		if (::Is_PTR_Exist)
		{
			this.m.PerkGroupMultipliers <- [
				[0.25, ::Const.Perks.UnstoppableTree],
				[3, ::Const.Perks.OrganisedTree],
				[0.25, ::Const.Perks.ViciousTree],
				[2, ::Const.Perks.TalentedTree]
			];

			this.m.PerkTreeDynamic = {
				Profession = [
					::Const.Perks.HolyManProfessionTree
				],
				Class = [
					::Const.Perks.DryadShamanTree
				],
				Weapon = [
					::Const.Perks.StaffTree
				]
			};
		}
	}

	function onBuildDescription()
	{
		return "{%fullname% has roamed the ancient forests for centuries, guarding its secrets and punishing those who defile it. | %fullname% remembers the first sprouting of trees, the bloom of the first flowers, and has vowed to protect them ever since. | With a spirit attuned to the earth and wisdom ancient as the stars, %fullname% has long watched over the Heartwoods. | The forests speak through %fullname%, their whispers guiding every step and decision. | %fullname% is one with the Heartwoods, and to cross paths with them is to face the wrath of nature itself. | As a guardian of the Heartwoods, %fullname% ensures that the balance is maintained, no matter the cost. | Long ago, %fullname% took up the mantle of protector, a duty carried out with unwavering resolve. | %fullname% was born of the Heartwoods, their soul intertwined with every leaf and branch. | %fullname% has seen countless seasons come and go, always ensuring the cycle of life continues. | To disturb the forest is to disturb %fullname%, and that is a mistake few live to repeat.} {With each passing season, %name% grows stronger, learning the ways of nature\'s wrath. | Having witnessed countless trespassers fall to the forest\'s fury, %name% knows the woods like no other. | %name% has honed their skills with nature\'s gifts, their power rivaled by none. | The whispers of the trees guide %name%\'s every move, making them a formidable ally or a terrifying foe. | With a touch, %name% can command the very essence of the forest to do their bidding. | Few can stand against the might of %name% when the forest itself rises to their call. | Each step %name% takes is calculated, guided by centuries of knowledge. | %name%\'s connection to the earth grants them power and insight beyond mortal comprehension. | To face %name% is to face the very soul of the forest itself. | With every rustling leaf and creaking branch, %name% grows more attuned to the world around them.} {The forest has taught %name% to be both fierce and wise in equal measure. | %name% is no stranger to the cycle of life and death, having seen it unfold for eons. | Their resolve is as unyielding as the ancient trees they protect. | Some say %name% can communicate with the very essence of the forest, guiding it to their will. | %name% is a sentinel of nature, ever-watchful and ever-ready to strike down those who threaten the balance. | Tales of %name%\'s deeds echo through the woods, a reminder of the forest\'s fury. | %name% carries the wisdom of the ages, using it to protect and preserve the sanctity of nature. | The forest\'s creatures rally to %name%\'s side, their loyalty born of mutual respect and ancient bonds. | In battle, %name% is a force of nature, their strikes swift and unrelenting.} {For those who respect the forest, %name% offers their protection and guidance. | %name% fights not for gold, but to preserve the sanctity of nature itself. | With a calm nod, %name% agrees to lend their strength to those who share their cause. | Ready to defend the ancient woods, %name% rises to the challenge, eager to uphold the balance. | For the promise of a safer world, %name% is prepared to strike down any who threaten the Heartwoods.}";
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/dryad/dryad_staff"));
		items.equip(this.new("scripts/items/ammo/forest_heart_ammo"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"dryad_armour_shaman"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"dryad_helmet_shaman"
			]
		]));
	}

	function onAdded()
	{
		this.character_background.onAdded();
		this.setupUpdateInjuryLayer();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_roots"))
		this.m.Container.add(this.new("scripts/skills/racial/dryad_racial"))
	}

	function buildPerkTree()
	{
		this.character_background.buildPerkTree();
		this.addPerk(::Const.Perks.PerkDefs.LegendRoots, 0, false)
	}

	function onChangeAttributes()
	{
		local att = {
			Hitpoints = [
				5,
				10
			],
			Bravery = [
				10,
				15
			],
			Stamina = [
				25,
				30
			],
			MeleeSkill = [
				0,
				0
			],
			RangedSkill = [
				-5,
				-5
			],
			MeleeDefense = [
				-5,
				-5
			],
			RangedDefense = [
				-5,
				-10
			],
			Initiative = [
				-40,
				-50
			]
		};
		return att;
	}
});