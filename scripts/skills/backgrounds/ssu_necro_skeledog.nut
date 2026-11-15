this.ssu_necro_skeledog <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {
	},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.ssu_necro_demon_hound";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_necro_skeledog.Name;
		this.m.Icon = "ui/backgrounds/ssu_background_skeledog.png";
		this.m.BackgroundDescription = ::Mod_Sellswords.Strings.ssu_necro_skeledog.BackgroundDescription;
		this.m.GoodEnding = ::Mod_Sellswords.Strings.ssu_necro_skeledog.GoodEnding;
		this.m.BadEnding = ::Mod_Sellswords.Strings.ssu_necro_skeledog.BadEnding;
		this.m.HiringCost = 3500;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			"trait.ailing",
			"trait.asthmatic",
			"trait.bleeder",
			"trait.bloodthirsty",
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
			"trait.legend_frail",
			"trait.steady_hands",
			"trait.talented",
			"trait.legend_pragmatic",
			"trait.legend_unpredictable",
			"trait.legend_slack",
			"trait.sureshot",
			"trait.legend_double_tongued",
			"trait.legend_gift_of_people",
			"trait.legend_seductive"
		];

		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.Bravery,
			this.Const.Attributes.RangedSkill,
		];

		// Unit Visuals
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = null;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.Muscular;
		
		this.m.Level = this.Math.rand(2, 3);
		this.m.Names = this.Const.Strings.DemonHoundNames;
		this.m.BackgroundType = this.Const.BackgroundType.Outlaw | this.Const.BackgroundType.Ranger | this.Const.BackgroundType.ExpertHunter;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Cooking = this.Const.LegendMod.ResourceModifiers.Cooking[3];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[3];
		this.m.Modifiers.Terrain = [
			0.0, // ?
			0.0, //ocean
			0.1, //plains
			0.0, //swamp
			0.0, //hills
			0.1, //forest
			0.1, //forest
			0.1, //forest_leaves
			0.1, //autumn_forest
			0.0, //mountains
			0.0, // ?
			0.1, //farmland
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
				],
				Defense = [
					this.Const.Perks.LightArmorTree,
					this.Const.Perks.HeavyArmorTree
				],
				Traits = [
					this.Const.Perks.ViciousTree,
					this.Const.Perks.FastTree,
					this.Const.Perks.MartyrTree,
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
		return ::Mod_Sellswords.Strings.ssu_necro_skeledog.Text;
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [ // 100-125 hp
				50,
				65
			],
			Bravery = [ // 75-100 bra
				0,
				0
			],
			Stamina = [ // 90-100 bra
				30,
				40
			],
			MeleeSkill = [ // 50-57 melee
				3,
				0
			],
			RangedSkill = [ // 0-0 ranged
				-32,
				-42
			],
			MeleeDefense = [ // 5-12 mdef
				5,
				7
			],
			RangedDefense = [ // 5-18 rdef
				5,
				13
			],
			Initiative = [ // 95-105 ini
				5,
				15
			]
		};
		return c;
	}
	
	function onAdded()
	{
		if (this.m.IsNew)
			this.m.Container.add(this.new("scripts/skills/racial/ssu_necro_fallen_hero_racial"));
		
		this.character_background.onAdded();
	}
	
	function onAddEquipment()
	{
	}

});