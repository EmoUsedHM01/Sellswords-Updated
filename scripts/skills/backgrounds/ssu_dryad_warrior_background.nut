this.ssu_dryad_warrior_background <- ::inherit("scripts/skills/backgrounds/ssu_base_dryad_background", {
	m = {
		PerkGroupMultipliers = []
	},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.ssu_dryad_warrior";
		this.m.Icon = "ui/backgrounds/dryad_warrior_background.png";
		this.m.Name = "Dryad Warrior";
		this.m.HiringCost = 0;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			"trait.weasel",
			"trait.teamplayer",
			"trait.fear_undead",
			"trait.fear_beasts",
			"trait.fear_greenskins",
			"trait.fear_nobles",
			"trait.ailing",
			"trait.swift",
			"trait.clubfooted",
			"trait.irrational",
			"trait.hesitant",
			"trait.loyal",
			"trait.tiny",
			"trait.fragile",
			"trait.clumsy",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.dastard",
			"trait.insecure",
			"trait.asthmatic",
			"trait.light",
			"trait.frail",
			"trait.seductive"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Initiative,
			this.Const.Attributes.RangedSkill
		];
		this.m.Names = this.Const.Strings.DryadNames;
		this.m.Faces = ::Const.Dryad.Head;
		this.m.Bodies = ::Const.Dryad.Body;
		this.m.Hairs = null;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Level = this.Math.rand(2, 5);
		this.m.BackgroundType = ::Const.BackgroundType.Combat | ::Const.BackgroundType.Crusader | ::Const.BackgroundType.Ranger;
		this.m.AlignmentMin = ::Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = ::Const.LegendMod.Alignment.Good;
		this.m.Modifiers.Stash = ::Const.LegendMod.ResourceModifiers.Stash[2];
		this.m.Modifiers.Training = ::Const.LegendMod.ResourceModifiers.Training[3];
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
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.GreatSwordTree,
				this.Const.Perks.PolearmTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.FlailTree,
				this.Const.Perks.HammerTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree,
				this.Const.Perks.MediumArmorTree
			],
			Traits = [
				this.Const.Perks.TrainedTree,
				this.Const.Perks.ViciousTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.MartyrTree,
				this.Const.Perks.FitTree
			],
			Enemy = [],
			Class = [],
			Magic = []
		};

		if (::Is_PTR_Exist)
		{
			this.m.PerkGroupMultipliers <- [
				[0.25, ::Const.Perks.AgileTree],
				[0.25, ::Const.Perks.FastTree],
				[0.1, ::Const.Perks.DeviousTree],
				[0.1, ::Const.Perks.OrganisedTree],
				[0.5, ::Const.Perks.TalentedTree],
				[0.5, ::Const.Perks.CalmTree],
				[2, ::Const.Perks.TacticianClassTree],
				[2, ::Const.Perks.MediumArmorTree],
				[0.66, ::Const.Perks.ShieldTree],
				[0.1, ::Const.Perks.LightArmorTree],
				[0, ::Const.Perks.BowTree],
				[0, ::Const.Perks.CrossbowTree],
				[0.5, ::Const.Perks.DaggerTree],
				[0, ::Const.Perks.SlingTree],
				[0.16, ::Const.Perks.SpearTree],
				[0.25, ::Const.Perks.StaffTree],
				[0.25, ::Const.Perks.ThrowingTree]
			];

			this.m.PerkTreeDynamic = {
				Profession = [
					::MSU.Class.WeightedContainer([
						[20, ::Const.Perks.RaiderProfessionTree],
						[10, ::Const.Perks.SoldierProfessionTree],
						[70, ::Const.Perks.NoTree]
					])
				],
				Defense = [
					::Const.Perks.HeavyArmorTree
				],
				Styles = [
					::Const.Perks.OneHandedTree,
					::Const.Perks.TwoHandedTree
				],
				Enemy = [
					::Const.Perks.SwordmastersTree
				]

			};
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/dryad/dryad_flail"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"dryad_armour_warrior"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"dryad_helmet_warrior"
			]
		]));
	}

	function onAdded()
	{
		this.character_background.onAdded();
		this.setupUpdateInjuryLayer();
		this.m.Container.add(this.new("scripts/skills/perks/perk_battle_forged"))
		this.m.Container.add(this.new("scripts/skills/racial/dryad_racial"))
	}

	function buildPerkTree()
	{
		this.character_background.buildPerkTree();
		this.addPerk(::Const.Perks.PerkDefs.BattleForged, 0, false)
	}

	function onChangeAttributes()
	{
		local att = {
			Hitpoints = [
				25,
				35
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
				10,
				15
			],
			RangedSkill = [
				-10,
				-5
			],
			MeleeDefense = [
				9,
				12
			],
			RangedDefense = [
				-15,
				-20
			],
			Initiative = [
				-60,
				-70
			]
		};
		return att;
	}
});