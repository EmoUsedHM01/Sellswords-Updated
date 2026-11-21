this.ssu_necro_ancient_honour_guard <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {
	},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.ssu_necro_skeleton";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_necro_ancient_honour_guard.Name;
		this.m.Icon = "ui/backgrounds/ssu_background_ancient_honour_guard.png";
		this.m.BackgroundDescription = ::Mod_Sellswords.Strings.ssu_necro_ancient_honour_guard.BackgroundDescription;
		this.m.GoodEnding = ::Mod_Sellswords.Strings.ssu_necro_ancient_honour_guard.GoodEnding;
		this.m.BadEnding = ::Mod_Sellswords.Strings.ssu_necro_ancient_honour_guard.BadEnding;
		this.m.HiringCost = 1000;
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
			this.Const.Attributes.Fatigue,
			this.Const.Attributes.Bravery,
			this.Const.Attributes.Initiative,
			this.Const.Attributes.RangedSkill,
			this.Const.Attributes.RangedDefense
		];

		// Unit Visuals
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = null;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.Muscular;
		
		this.m.Level = this.Math.rand(2, 5);
		this.m.Names = this.Const.Strings.LegionnaireNames;
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Outlaw;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[2];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[3];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[2];
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
				this.Const.Perks.PolearmTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.FlailTree,
				this.Const.Perks.HammerTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree,
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.FastTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.TrainedTree
			],
			Enemy = [],
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
		return ::Mod_Sellswords.Strings.ssu_necro_ancient_honour_guard.Text;
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				12,
				13
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				15,
				10
			],
			MeleeSkill = [
				15,
				17
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				12,
				15
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				-14,
				-7
			]
		};
		return c;
	}
	
	function onAdded()
	{
		if (this.m.IsNew)
			this.m.Container.add(this.new("scripts/skills/perks/perk_battle_forged"));
		
		this.character_background.onAdded();
	}

	function buildPerkTree()
	{
		this.character_background.buildPerkTree();
		this.addPerk(::Const.Perks.PerkDefs.BattleForged, 0, false);
	}

	function buildAttributes(_tag = null, _attrs = null)
	{
		return this.character_background.buildAttributes("skeleton", _attrs);
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local weapons = [
			"weapons/ancient/ancient_sword",
			"weapons/ancient/crypt_cleaver",
			"weapons/ancient/rhomphaia",
			"weapons/ancient/warscythe",
			"weapons/ancient/legend_gladius"
		];
		items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		if (items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
			items.equip(this.new("scripts/items/shields/ancient/tower_shield"));

		items.equip(::Legends.Items.pickArmor([
			[
				1,
				"ancient/ancient_plated_scale_hauberk"
			],
			[
				1,
				"ancient/ancient_scale_coat"
			],
			[
				1,
				"ancient/ancient_plate_harness"
			],
			[
				1,
				"ancient/ancient_plated_mail_hauberk"
			]
		]));
		local item = ::Legends.Items.pickHelmet([
			[
				1,
				"ancient/ancient_honorguard_helmet"
			]
		]);

		if (item != null)
			items.equip(item);
	}

});

