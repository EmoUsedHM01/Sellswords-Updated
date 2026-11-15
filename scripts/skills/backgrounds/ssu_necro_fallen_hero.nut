this.ssu_necro_fallen_hero <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.ssu_necro_zombie";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_necro_fallen_hero.Name;
		this.m.Icon = "ui/backgrounds/ssu_background_fallen_hero.png";
		this.m.BackgroundDescription = ::Mod_Sellswords.Strings.ssu_necro_fallen_hero.BackgroundDescription;
		this.m.GoodEnding = ::Mod_Sellswords.Strings.ssu_necro_fallen_hero.GoodEnding;
		this.m.BadEnding = ::Mod_Sellswords.Strings.ssu_necro_fallen_hero.BadEnding;
		this.m.HiringCost = 1000;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			"trait.ailing",
			"trait.asthmatic",
			"trait.bleeder",
			"trait.clubfooted",
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
			"trait.greedy",
			"trait.hate_undead",
			"trait.iron_lungs",
			"trait.loyal",
			"trait.legend_fear_nobles",
			"trait.legend_seductive"
		];

		this.m.ExcludedTalents = [
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
		
		this.m.Level = this.Math.rand(2, 5);
		this.m.Names = this.Const.Strings.FallenHero;
		this.m.Titles = this.Const.Strings.FallenHeroTitles;
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Outlaw;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[1];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[2];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[1];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[2];
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
				this.Const.Perks.PolearmTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.FlailTree,
				this.Const.Perks.HammerTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree,
				this.Const.Perks.ShieldTree
			],
			Traits = [
				this.Const.Perks.TrainedTree,
				this.Const.Perks.ViciousTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.MartyrTree,
				this.Const.Perks.FitTree
			],
			Enemy = [
				this.Const.Perks.SwordmastersTree
			],
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
		return ::Mod_Sellswords.Strings.ssu_necro_fallen_hero.Text;
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				45,
				65
			],
			Bravery = [
				9,
				4
			],
			Stamina = [
				15,
				10
			],
			MeleeSkill = [
				11,
				10
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				9,
				12
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
			this.m.Container.add(this.new("scripts/skills/perks/perk_ssu_necro_zombie_fallen_hero"));
		
		this.character_background.onAdded();
	}

	function buildPerkTree()
	{
		this.character_background.buildPerkTree();
		this.addPerk(::Const.Perks.PerkDefs.SsuNecroZombieFallenHero, 0, false)
	}
	
	function buildAttributes(_tag = null, _attrs = null)
	{
		return this.character_background.buildAttributes("zombie", _attrs);		
	}
	
	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local weapons = [
			"weapons/winged_mace",
			"weapons/greataxe",
			"weapons/longsword",
			"weapons/two_handed_flail",
			"weapons/morning_star",
			"weapons/military_cleaver",
			"weapons/fighting_axe"
		];
		items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		
		if (items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			if (this.Math.rand(1, 2) == 1)
				items.equip(this.new("scripts/items/shields/worn_heater_shield"));
			else
				items.equip(this.new("scripts/items/shields/worn_kite_shield"));
		}

		items.equip(::Legends.Items.pickArmor([
			[
				1,
				"decayed_coat_of_plates"
			],
			[
				1,
				"decayed_coat_of_scales"
			],
			[
				1,
				"decayed_reinforced_mail_hauberk"
			]
		]));
		local item = ::Legends.Items.pickHelmet([
			[
				2,
				"decayed_closed_flat_top_with_mail"
			],
			[
				1,
				"decayed_closed_flat_top_with_sack"
			],
			[
				3,
				"decayed_full_helm"
			],
			[
				3,
				"decayed_great_helm"
			]
		]);

		if (item != null)
			items.equip(item);
	}
	
});