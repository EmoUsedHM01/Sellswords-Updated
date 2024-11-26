this.ssu_dryad_tamer_background <- ::inherit("scripts/skills/backgrounds/ssu_base_dryad_background", {
	m = {
		PerkGroupMultipliers = []
	},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.ssu_dryad_tamer";
		this.m.Icon = "ui/backgrounds/dryad_tamer_background.png";
		this.m.Name = "Dryad Tamer";
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
		this.m.BackgroundType = ::Const.BackgroundType.Combat | ::Const.BackgroundType.Ranger;
		this.m.AlignmentMin = ::Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = ::Const.LegendMod.Alignment.Good;
		this.m.Modifiers.Hunting = ::Const.LegendMod.ResourceModifiers.Hunting[3];
		this.m.Modifiers.Scout = ::Const.LegendMod.ResourceModifiers.Scout[1];
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
			0.1, // Mountains
			0.0, // -
			0.0, // Farmlands
			0.0, // Snow
			0.1, // Badlands
			0.0, // Highlands
			0.0, // Steppes
			0.0, // -
			0.0, // Deserts
			0.0  // Oasis
		];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.CleaverTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.PolearmTree,
				this.Const.Perks.DryadTamerTree
			],
			Defense = [
				this.Const.Perks.MediumArmorTree
			],
			Traits = [
				this.Const.Perks.ViciousTree,
				this.Const.Perks.TrainedTree,
				this.Const.Perks.IndestructibleTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.HoundmasterClassTree
			],
			Magic = []
		};

		if (::Is_PTR_Exist)
		{
			this.m.SpecialPerkMultipliers = [
				[5, ::Const.Perks.PerkDefs.LegendBigGameHunter]
			];

			this.m.PerkGroupMultipliers <- [
				[3, ::Const.Perks.ViciousTree],
				[0.33, ::Const.Perks.ShieldTree],
				[0.5, ::Const.Perks.FlailTree],
				[0.5, ::Const.Perks.HammerTree],
				[0.5, ::Const.Perks.MaceTree],
				[0, ::Const.Perks.ApothecaryProfessionTree],
				[0, ::Const.Perks.MinstrelProfessionTree]
			];

			this.m.PerkTreeDynamic = {
				Profession = [
					::MSU.Class.WeightedContainer([
						[90, ::Const.Perks.NoTree],
						[10, ::Const.Perks.RandomTree]
					])
				],
				Enemy = [
					::Const.Perks.CivilizationTree
				],
				Class = [
					::Const.Perks.DryadTamerTree
				],
				Weapon = [
					::Const.Perks.CleaverTree
				]
			};
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/dryad/dryad_cleaver"));
		items.equip(this.new("scripts/items/ammo/forest_heart_ammo"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"dryad_armour_tamer"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"dryad_helmet_tamer"
			]
		]));
	}

	function onAdded()
	{
		this.character_background.onAdded();
		this.setupUpdateInjuryLayer();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_doghandling"))
		this.m.Container.add(this.new("scripts/skills/racial/dryad_racial"))
	}

	function buildPerkTree()
	{
		this.character_background.buildPerkTree();
		this.addPerk(::Const.Perks.PerkDefs.LegendDogHandling, 0, false)
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
				5
			],
			RangedSkill = [
				-5,
				0
			],
			MeleeDefense = [
				0,
				5
			],
			RangedDefense = [
				-10,
				-15
			],
			Initiative = [
				-30,
				-40
			]
		};
		return att;
	}
});