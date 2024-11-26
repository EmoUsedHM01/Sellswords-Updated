this.ssu_dryad_archer_background <- ::inherit("scripts/skills/backgrounds/ssu_base_dryad_background", {
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
});