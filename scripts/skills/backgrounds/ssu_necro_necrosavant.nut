this.ssu_necro_necrosavant <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {
	},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.ssu_necro_vampire";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_necro_necrosavant.Name;
		this.m.Icon = "ui/backgrounds/ssu_background_vampire.png";
		this.m.BackgroundDescription = ::Mod_Sellswords.Strings.ssu_necro_necrosavant.BackgroundDescription;
		this.m.GoodEnding = ::Mod_Sellswords.Strings.ssu_necro_necrosavant.GoodEnding;
		this.m.BadEnding = ::Mod_Sellswords.Strings.ssu_necro_necrosavant.BadEnding;
		this.m.HiringCost = 1000;
		this.m.DailyCost = 20;
		this.m.Excluded = [
			"trait.brave",
			"trait.athletic",
			"trait.brute",
			"trait.eagleyes",
			"trait.huge",
			"trait.loyal",
			"trait.tough",
			"trait.disloyal",
			"trait.loyal"
		];

		this.m.Titles = ::Mod_Sellswords.Strings.ssu_necro_necrosavant.Titles;

		this.m.ExcludedTalents = [
			this.Const.Attributes.Fatigue,
			this.Const.Attributes.Bravery,
			this.Const.Attributes.RangedSkill,
		];

		// Unit Visuals
		this.m.Faces = this.Const.Faces.Vampire;
		this.m.Hairs = this.Const.Hair.Vampire;
		this.m.HairColors = this.Const.HairColors.Zombie;
		this.m.Beards = this.Const.Beards.Tidy;
		
		this.m.Level = this.Math.rand(2, 4);
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Outlaw;
		this.m.ProfessionTreeBranches = ::Legends.BackgroundProfessionTrees.SsuNecroNecrosavant.Profession;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[3];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[2];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[2];
		this.m.Modifiers.MedConsumption = this.Const.LegendMod.ResourceModifiers.MedConsumption[3];
		this.m.Modifiers.Terrain = [
			0.0, // ?
			0.0, //ocean
			0.0, //plains
			0.0, //swamp
			0.0, //hills
			0.05, //forest
			0.05, //forest
			0.05, //forest_leaves
			0.05, //autumn_forest
			0.0, //mountains
			0.0, // ?
			0.0, //farmland
			0.0, //snow
			0.05, //badlands
			0.0, //highlands
			0.0, //stepps
			0.0, //ocean
			0.05, //desert
			0.05//oasis
		];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SwordTree,
				this.Const.Perks.CleaverTree
			],
			Defense = [
				this.Const.Perks.ClothArmorTree,
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.DeviousTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.ViciousTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.VampireMagicTree
			],
			Magic = []
		};
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		
		if (this.getContainer() == null || this.getContainer().getActor() == null)
			return ret;
		
		ret.extend(this.getAttributesTooltip());
		return ret;
	}

	function onBuildDescription()
	{
		return ::Mod_Sellswords.Strings.ssu_necro_necrosavant.Text;
	}
	
	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				15,
				20
			],
			Bravery = [
				-10,
				-5
			],
			Stamina = [
				5,
				5
			],
			MeleeSkill = [
				5,
				10
			],
			RangedSkill = [
				-5,
				-5
			],
			MeleeDefense = [
				0,
				0
			],
			RangedDefense = [
				-10,
				-5
			],
			Initiative = [
				15,
				20
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
	}
	
	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();

		items.equip(this.new("scripts/items/weapons/ancient/khopesh"));
	}
	
});

