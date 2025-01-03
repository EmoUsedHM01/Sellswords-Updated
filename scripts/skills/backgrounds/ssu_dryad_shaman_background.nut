this.ssu_dryad_shaman_background <- ::inherit("scripts/skills/backgrounds/ssu_base_dryad_background", {
	m = {
		PerkGroupMultipliers = []
	},
	function create()
	{
		this.character_background.create();
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