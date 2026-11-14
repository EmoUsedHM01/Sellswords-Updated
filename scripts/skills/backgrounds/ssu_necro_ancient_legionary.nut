this.ssu_necro_ancient_legionary <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {
	},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.ssu_necro_skeleton";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_necro_ancient_legionary.Name;
		this.m.Icon = "ui/backgrounds/ssu_background_ancient_legionary.png";
		this.m.BackgroundDescription = ::Mod_Sellswords.Strings.ssu_necro_ancient_legionary.BackgroundDescription;
		this.m.GoodEnding = ::Mod_Sellswords.Strings.ssu_necro_ancient_legionary.GoodEnding;
		this.m.BadEnding = ::Mod_Sellswords.Strings.ssu_necro_ancient_legionary.BadEnding;
		this.m.HiringCost = 500;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			"trait.ailing",
			"trait.asthmatic",
			"trait.bleeder",
			"trait.cocky",
			"trait.craven",
			"trait.dastard",
			"trait.deathwish",
			"trait.disloyal",
			"trait.drunkard",
			"trait.fat",
			"trait.fear_undead",
			"trait.fear_greenskins",
			"trait.fear_beasts",
			"trait.fearless",
			"trait.gluttonous",
			"trait.greedy",
			"trait.hate_undead",
			"trait.hate_beasts",
			"trait.hate_greenskins",
			"trait.iron_lungs",
			"trait.loyal",
			"trait.legend_fear_nobles",
			"trait.legend_hate_nobles",
			"trait.legend_seductive"
		];

		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.Fatigue,
			this.Const.Attributes.Bravery,
			this.Const.Attributes.RangedSkill,
			//this.Const.Attributes.RangedDefense
		];

		// Unit Visuals
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = null;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.Muscular;
		
		this.m.Level = this.Math.rand(1, 3);
		this.m.Names = this.Const.Strings.LegionnaireNames;
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Outlaw;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[2];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[1];
		this.m.Modifiers.Terrain = [
			0.0, // ?
			0.0, //ocean
			0.05, //plains
			0.0, //swamp
			0.0, //hills
			0.0, //forest
			0.0, //forest
			0.0, //forest_leaves
			0.0, //autumn_forest
			0.0, //mountains
			0.0, // ?
			0.0, //farmland
			0.0, //snow
			0.0, //badlands
			0.0, //highlands
			0.0, //stepps
			0.0, //ocean
			0.0, //desert
			0.05 //oasis
		];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.ShieldTree,
				this.Const.Perks.SpearTree,
				this.Const.Perks.SwordTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.FastTree,
				this.Const.Perks.TrainedTree
			],
			Enemy = [
			],
			Class = [
				this.Const.Perks.SkeletonClassTree
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
		return ::Mod_Sellswords.Strings.ssu_necro_ancient_legionary.Text;
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				5,
				5
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				6,
				12
			],
			MeleeSkill = [
				13,
				10
			],
			RangedSkill = [
				12,
				10
			],
			MeleeDefense = [
				5,
				8
			],
			RangedDefense = [
				5,
				8
			],
			Initiative = [
				0,
				0
			]
		};
		return c;
	}
	
	function onAdded()
	{
		if (this.m.IsNew)
			this.m.Container.add(this.new("scripts/skills/perks/perk_reach_advantage"));
		
		this.character_background.onAdded();
	}

	function buildPerkTree()
	{
		this.character_background.buildPerkTree();
		this.addPerk(::Const.Perks.PerkDefs.ReachAdvantage, 0, false)
	}

	function buildAttributes(_tag = null, _attrs = null)
	{
		return this.character_background.buildAttributes("skeleton", _attrs);
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r = this.Math.rand(1, 2);

		if (r == 1)
			items.equip(this.new("scripts/items/weapons/ancient/broken_bladed_pike"));
		else if (r == 2)
			items.equip(this.new("scripts/items/weapons/ancient/bladed_pike"));

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"ancient/ancient_scale_harness"
			],
			[
				1,
				"ancient/ancient_mail"
			],
			[
				1,
				"ancient/ancient_double_layer_mail"
			]
		]));
		local item = this.Const.World.Common.pickHelmet([
			[
				66,
				"ancient/ancient_legionary_helmet"
			]
		]);

		if (item != null)
			items.equip(item);
	}

	function addUniqueClassPerks()
	{
		if (this.m.ClassPerks != null) this.insertPerkGroup(this.m.ClassPerks);
	}

});

