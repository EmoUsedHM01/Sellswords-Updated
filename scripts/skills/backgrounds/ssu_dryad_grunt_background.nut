this.ssu_dryad_grunt_background <- ::inherit("scripts/skills/backgrounds/ssu_base_dryad_background", {
	m = {
		PerkGroupMultipliers = []
	},
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
		this.m.Names = this.Const.Strings.DryadNames;
		this.m.Faces = ::Const.Dryad.Head;
		this.m.Bodies = ::Const.Dryad.Body;
		this.m.Hairs = null;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Level = 1;
		this.m.BackgroundType = ::Const.BackgroundType.Combat | ::Const.BackgroundType.Ranger;
		this.m.AlignmentMin = ::Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = ::Const.LegendMod.Alignment.Good;
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[1];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[1];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[1];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[1];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[1];
		this.m.Modifiers.Crafting = this.Const.LegendMod.ResourceModifiers.Crafting[1];
		this.m.Modifiers.MedConsumption = this.Const.LegendMod.ResourceModifiers.MedConsumption[1];
		this.m.Modifiers.Fletching = this.Const.LegendMod.ResourceModifiers.Fletching[1];
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[1];
		this.m.Modifiers.Terrain = [
			0.1, // Plains
			0.0, // -
			0.0, // -
			0.1, // Swamps
			0.1, // Hills
			0.2, // Forests
			0.0, // -
			0.0, // -
			0.0, // -
			0.0, // Mountains
			0.0, // -
			0.1, // Farmlands
			0.0, // Snow
			0.0, // Badlands
			0.1, // Highlands
			0.1, // Steppes
			0.0, // -
			0.0, // Deserts
			0.0  // Oasis
		];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.DaggerTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.ClothArmorTree,
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.OrganisedTree,
				this.Const.Perks.CalmTree,
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.FastTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.ChefProfessionTree
			],
			Magic = []
		};

		if (::Is_PTR_Exist)
		{
			this.m.PerkGroupMultipliers <- [
				[3, ::Const.Perks.CalmTree],
				[0.2, ::Const.Perks.OrganisedTree],
				[0.25, ::Const.Perks.DeviousTree],
				[0.5, ::Const.Perks.ShieldTree],
				[2, ::Const.Perks.HeavyArmorTree],
				[0.5, ::Const.Perks.SpearTree]
			];

			this.m.PerkTreeDynamic = {
				Profession = [
					::MSU.Class.WeightedContainer([
						[30, ::Const.Perks.SoldierProfessionTree],
						[70, ::Const.Perks.NoTree]
					])
				],
				Traits = [
					::Const.Perks.TrainedTree
				],
				Class = [
					::MSU.Class.WeightedContainer([
						[75, ::Const.Perks.VeteranClassTree],
						[25, ::Const.Perks.TacticianClassTree]
					])
				],
				Weapon = [
					::Const.Perks.PolearmTree,
					::Const.Perks.SwordTree
				]
			};
		}
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

	function onAdded()
	{
		this.character_background.onAdded();
		this.setupUpdateInjuryLayer();
		this.m.Container.add(this.new("scripts/skills/perks/perk_colossus"));
		this.m.Container.add(this.new("scripts/skills/racial/dryad_racial"));
	}

	function buildPerkTree()
	{
		this.character_background.buildPerkTree();
		this.addPerk(::Const.Perks.PerkDefs.Colossus, 0, false)
	}

	function onChangeAttributes()
	{
		local att = {
			Hitpoints = [
				10,
				15
			],
			Bravery = [
				0,
				5
			],
			Stamina = [
				35,
				40
			],
			MeleeSkill = [
				0,
				5
			],
			RangedSkill = [
				-10,
				-15
			],
			MeleeDefense = [
				0,
				5
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