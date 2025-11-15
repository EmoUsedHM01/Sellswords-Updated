this.ssu_dryad_avatar_background <- ::inherit("scripts/skills/backgrounds/ssu_base_dryad_background", {
	m = {
		PerkGroupMultipliers = []
	},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.ssu_dryad_avatar";
		this.m.Icon = "ui/backgrounds/dryad_avatar_background.png";
		this.m.Name = "Dryad Avatar";
		this.m.HiringCost = 999999;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			"trait.asthmatic",
			"trait.clumsy",
			"trait.cocky"
		];
		this.m.Names = this.Const.Strings.DryadNames;
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
			0.4, // Forests
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

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/dryad/dryad_cleaver"));
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
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_roots"));
		this.m.Container.add(this.new("scripts/skills/racial/dryad_racial"));
	}

	function buildPerkTree()
	{
		this.character_background.buildPerkTree();

		this.addPerkGroup(::Const.Perks.HammerTree.Tree);
		this.addPerkGroup(::Const.Perks.CleaverTree.Tree);
		this.addPerkGroup(::Const.Perks.StavesMagicTree.Tree);
		this.addPerkGroup(::Const.Perks.DryadShamanTree.Tree);
		this.addPerkGroup(::Const.Perks.DryadTamerTree.Tree);
		this.addPerkGroup(::Const.Perks.MediumArmorTree.Tree);
		this.addPerkGroup(::Const.Perks.HeavyArmorTree.Tree);
		this.addPerkGroup(::Const.Perks.LargeTree.Tree);
		this.addPerkGroup(::Const.Perks.CalmTree.Tree);
		this.addPerkGroup(::Const.Perks.SturdyTree.Tree);
		this.addPerkGroup(::Const.Perks.IntelligentTree.Tree);
		this.addPerk(::Const.Perks.PerkDefs.LegendGatherer, 0, false);
		this.addPerkGroup(::Const.Perks.OutlandersTree.Tree);

		if (::Is_PTR_Exist)
		{
			this.addPerkGroup(::Const.Perks.ResilientTree.Tree);
			this.addPerkGroup(::Const.Perks.OneHandedTree.Tree);
			this.addPerkGroup(::Const.Perks.TwoHandedTree.Tree);

			this.addPerk(::Const.Perks.PerkDefs.PTRRisingStar, 4, false);
			this.addPerk(::Const.Perks.PerkDefs.PTRManOfSteel, 5, false);
		}
		else
		{
			this.addPerkGroup(::Const.Perks.IndestructibleTree.Tree);
			this.addPerkGroup(::Const.Perks.MartyrTree.Tree);
		}

		this.addPerk(::Const.Perks.PerkDefs.LegendBattleheart, 3, false);
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
				5,
				10
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
});