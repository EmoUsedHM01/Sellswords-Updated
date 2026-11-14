this.ssu_necro_ghost <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {
		Variant = 0
	},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.ssu_necro_ghost";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_necro_ghost.Name;
		this.m.Icon = "ui/backgrounds/ssu_background_ghost.png";
		this.m.BackgroundDescription = ::Mod_Sellswords.Strings.ssu_necro_ghost.BackgroundDescription;
		this.m.GoodEnding = ::Mod_Sellswords.Strings.ssu_necro_ghost.GoodEnding;
		this.m.BadEnding = ::Mod_Sellswords.Strings.ssu_necro_ghost.BadEnding;
		this.m.HiringCost = 2500;
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
			"trait.legend_fear_dark",
			"trait.fearless",
			"trait.gluttonous",
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
			"trait.legend_sureshot",
			"trait.legend_double_tongued",
			"trait.legend_gift_of_people",
			"trait.legend_seductive"
		];

		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.Fatigue,
			this.Const.Attributes.Bravery,
		];

		// Unit Visuals
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = null;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.Muscular;
		
		this.m.Level = this.Math.rand(1, 2);
		this.m.Names = this.Const.Strings.GhostNames;
		this.m.Titles = this.Const.Strings.GhostTitles;
		this.m.BackgroundType = this.Const.BackgroundType.Outlaw;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
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
		return ::Mod_Sellswords.Strings.ssu_necro_ghost.Text;
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [ // 1-5 hp
				0,
				0
			],
			Bravery = [ // 75-100 bra
				45,
				60
			],
			Stamina = [ // 90-100 sta
				0,
				0
			],
			MeleeSkill = [ // 50-59 melee
				3,
				2
			],
			RangedSkill = [ // 32-43 ranged
				0,
				0
			],
			MeleeDefense = [ // 12-20 mdf
				12,
				15
			],
			RangedDefense = [ // 0-5 mdf
				0,
				0
			],
			Initiative = [ // 90-95 ini
				-10,
				-5
			]
		};
		return c;
	}
	
	function onAddEquipment()
	{
	}

	function pickRandomPerkTreeDynamic()
	{
		this.m.Variant = this.Math.rand(0, 6);

		switch (this.m.Variant)
		{
			case 1:
			this.m.PerkTreeDynamic = {
				Weapon = [
					this.Const.Perks.PolearmTree
				],
				Defense = [
					this.Const.Perks.HeavyArmorTree
				],
				Traits = [
					this.Const.Perks.SturdyTree,
					this.Const.Perks.LargeTree
				],
				Enemy = [
				],
				Class = [
					this.Const.Perks.GhostClassTree
				],
				Magic = []
			};
			break;

			case 2:
			this.m.PerkTreeDynamic = {
				Weapon = [
					this.Const.Perks.SwordTree,
					this.Const.Perks.DaggerTree,
					this.Const.Perks.ThrowingTree
				],
				Defense = [
					this.Const.Perks.LightArmorTree
				],
				Traits = [
					this.Const.Perks.FitTree,
					this.Const.Perks.ViciousTree
				],
				Enemy = [
				],
				Class = [
					this.Const.Perks.GhostClassTree
				],
				Magic = []
			};
			break;

			case 3:
			this.m.PerkTreeDynamic = {
				Weapon = [
					this.Const.Perks.DaggerTree,
					this.Const.Perks.CleaverTree,
					this.Const.Perks.ThrowingTree
				],
				Defense = [
					this.Const.Perks.MediumArmorTree
				],
				Traits = [
					this.Const.Perks.IndestructibleTree,
					this.Const.Perks.CalmTree
				],
				Enemy = [
				],
				Class = [
					this.Const.Perks.GhostClassTree
				],
				Magic = []
			};
			break;

			case 4:
			this.m.PerkTreeDynamic = {
				Weapon = [
					this.Const.Perks.SpearTree,
					this.Const.Perks.DaggerTree
				],
				Defense = [
					this.Const.Perks.MediumArmorTree
				],
				Traits = [
					this.Const.Perks.ViciousTree,
					this.Const.Perks.FastTree
				],
				Enemy = [
				],
				Class = [
					this.Const.Perks.GhostClassTree
				],
				Magic = []
			};
			break;

			case 5:
			this.m.PerkTreeDynamic = {
				Weapon = [
					this.Const.Perks.FlailTree,
					this.Const.Perks.DaggerTree
				],
				Defense = [
					this.Const.Perks.LightArmorTree
				],
				Traits = [
					this.Const.Perks.AgileTree,
					this.Const.Perks.FitTree,
					this.Const.Perks.FastTree
				],
				Enemy = [
				],
				Class = [
					this.Const.Perks.GhostClassTree
				],
				Magic = []
			};
			break;

			case 6:
			this.m.PerkTreeDynamic = {
				Weapon = [
					this.Const.Perks.ThrowingTree,
					this.Const.Perks.DaggerTree
				],
				Defense = [
					this.Const.Perks.LightArmorTree
				],
				Traits = [
					this.Const.Perks.ViciousTree,
					this.Const.Perks.InspirationalTree,
					this.Const.Perks.DeviousTree
				],
				Enemy = [
				],
				Class = [
					this.Const.Perks.GhostClassTree
				],
				Magic = []
			};
			break;
		
			default:
			this.m.PerkTreeDynamic = {
				Weapon = [
					this.Const.Perks.HammerTree,
					this.Const.Perks.HammerClassTree
				],
				Defense = [
					this.Const.Perks.HeavyArmorTree
				],
				Traits = [
					this.Const.Perks.LargeTree,
					this.Const.Perks.IndestructibleTree
				],
				Enemy = [
				],
				Class = [
					this.Const.Perks.GhostClassTree
				],
				Magic = []
			};
		}
	}

	function setNewBackgroundModifiers()
	{
		switch (this.m.Variant)
		{
		case 1: // legend_noble_2h
			this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
			this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[2];
			this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
			break;

		case 2: // assassin_background
			this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[3];
			this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
			break;

		case 3: // butcher_background
			this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[1];
			this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[1];
			this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[2];
			this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[1];
			break;

		case 4: // fisherman_background
			this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[1];
			this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
			break;

		case 5: // juggler_background
			this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[1];
			break;

		case 6: // pimp_background
			this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[2];
			this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
			this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[1];
			this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[2];
			break;
	
		default: // legend_blacksmith_background
			this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[3];
			this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[1];
			this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[2];
			this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[3];
			this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[3];
			this.m.Modifiers.Crafting = this.Const.LegendMod.ResourceModifiers.Crafting[2];
			this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[1];
			this.m.Modifiers.ToolConsumption = this.Const.LegendMod.ResourceModifiers.ToolConsumption[3];
		}
	}

	function onSerialize( _out )
	{
		this.character_background.onSerialize(_out);
		_out.writeU8(this.m.Variant);
	}

	function onDeserialize( _in )
	{
		this.character_background.onDeserialize(_in);
		this.m.Variant = _in.readU8();
		this.setNewBackgroundModifiers();
	}
});

