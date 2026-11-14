this.ssu_necro_zombie <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.ssu_necro_zombie";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_necro_zombie.Name;
		this.m.Icon = "ui/backgrounds/background_zombie.png";
		this.m.BackgroundDescription = ::Mod_Sellswords.Strings.ssu_necro_zombie.BackgroundDescription;
		this.m.GoodEnding = ::Mod_Sellswords.Strings.ssu_necro_zombie.GoodEnding;
		this.m.BadEnding = ::Mod_Sellswords.Strings.ssu_necro_zombie.BadEnding;
		this.m.HiringCost = 0;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			"trait.ailing",
			"trait.asthmatic",
			"trait.asthmatic",
			"trait.bleeder",
			"trait.brave",
			"trait.bright",
			"trait.cocky",
			"trait.craven",
			"trait.dastard",
			"trait.deathwish",
			"trait.determined",
			"trait.dexterous",
			"trait.disloyal",
			"trait.drunkard",
			"trait.dumb",
			"trait.fainthearted",
			"trait.fat",
			"trait.fear_undead",
			"trait.fear_greenskins",
			"trait.fear_beasts",
			"trait.fearless",
			"trait.eagle_eyes",
			"trait.greedy",
			"trait.hate_undead",
			"trait.hate_beasts",
			"trait.hate_greenskins",
			"trait.impatient",
			"trait.insecure",
			"trait.iron_lungs",
			"trait.iron_jaw",
			"trait.irrational",
			"trait.loyal",
			"trait.night_owl",
			"trait.night_blind",
			"trait.optimist",
			"trait.paranoid",
			"trait.pessimist",
			"trait.quick",
			"trait.spartan",
			"trait.superstitious",
			"trait.swift",
			"trait.teamplayer",
			"trait.weasel",
			"trait.legend_ambitious",
			"trait.legend_fear_nobles",
			"trait.legend_hate_nobles",
			"trait.flabby",
			"trait.steady_hands",
			"trait.talented",
			"trait.legend_pragmatic",
			"trait.legend_unpredictable",
			"trait.legend_slack",
			"trait.legend_sureshot",
			"trait.legend_double_tongued",
			"trait.legend_gift_of_people",
			"trait.legend_seductive"
		];

		this.m.ExcludedTalents = [
			this.Const.Attributes.Fatigue,
			this.Const.Attributes.Initiative,
			this.Const.Attributes.RangedSkill,
			this.Const.Attributes.RangedDefense,
		];

		// Unit Visuals
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
		
		this.m.BackgroundType = this.Const.BackgroundType.Untalented | this.Const.BackgroundType.Outlaw;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[1];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[1];
		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.0, //plains
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
				0.0 //oasis
			];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.AxeTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.FlailTree,
				this.Const.Perks.HammerTree
			],
			Defense = [
				this.Const.Perks.ShieldTree
			],
			Traits = [
				this.Const.Perks.MartyrTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.IndestructibleTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.ZombieClassTree
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
		return ::Mod_Sellswords.Strings.ssu_necro_zombie.Text;
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				25,
				45
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				5,
				8
			],
			MeleeSkill = [
				0,
				0
			],
			RangedSkill = [
				-15,
				0
			],
			MeleeDefense = [
				-5,
				2
			],
			RangedDefense = [
				-5,
				-5
			],
			Initiative = [
				-10,
				0
			]
		};
		return c;
	}

	function onAdded()
	{
		if (this.m.IsNew)
			this.m.Container.add(this.new("scripts/skills/perks/perk_colossus"));
		
		this.character_background.onAdded();
	}

	function buildPerkTree()
	{
		this.character_background.buildPerkTree();
		this.addPerk(::Const.Perks.PerkDefs.Colossus, 0, false);
	}
	
	function buildAttributes(_tag = null, _attrs = null)
	{
		return this.character_background.buildAttributes("zombie", _attrs);
	}
	
	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local weapons = [
			"weapons/wooden_stick",
			"weapons/wooden_flail",
			"weapons/shortsword",
			"weapons/hatchet",
			"weapons/boar_spear"
		];
		items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		
		if (items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
			if (this.Math.rand(1, 100) <= 66)
				items.equip(this.new("scripts/items/shields/wooden_shield_old"));

		items.equip(this.Const.World.Common.pickArmor([
			[
				4,
				"leather_tunic"
			],
			[
				4,
				"linen_tunic"
			],
			[
				3,
				"sackcloth"
			],
			[
				3,
				"padded_surcoat"
			],
			[
				2,
				"leather_wraps"
			],
			[
				2,
				"monk_robe"
			],
			[
				2,
				"apron"
			],
			[
				2,
				"butcher_apron"
			],
			[
				1,
				"cultist_leather_robe"
			]
		]));
		local item = this.Const.World.Common.pickHelmet([
			[
				67,
				""
			],
			[
				7,
				"hood"
			],
			[
				7,
				"straw_hat"
			],
			[
				7,
				"aketon_cap"
			],
			[
				7,
				"full_aketon_cap"
			],
			[
				7,
				"open_leather_cap"
			],
			[
				7,
				"full_leather_cap"
			],
			[
				4,
				"headscarf"
			],
			[
				4,
				"cultist_hood"
			],
			[
				4,
				"witchhunter_hat"
			],
			[
				1,
				"cultist_leather_hood"
			]
		]);

		if (item != null)
			items.equip(item);
	}
	
});