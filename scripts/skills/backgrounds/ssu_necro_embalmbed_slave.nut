this.ssu_necro_embalmbed_slave <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {
	},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.ssu_necro_mummy";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_necro_embalmbed_slave.Name;
		this.m.Icon = "ui/backgrounds/ssu_background_embalmbed_slave.png";
		this.m.BackgroundDescription = ::Mod_Sellswords.Strings.ssu_necro_embalmbed_slave.BackgroundDescription;
		this.m.GoodEnding = ::Mod_Sellswords.Strings.ssu_necro_embalmbed_slave.GoodEnding;
		this.m.BadEnding = ::Mod_Sellswords.Strings.ssu_necro_embalmbed_slave.BadEnding;
		this.m.HiringCost = 0;
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
			this.Const.Attributes.MeleeSkill,
			this.Const.Attributes.RangedSkill,
		];

		// Unit Visuals
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = null;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.Muscular;
		
		this.m.Names = this.Const.Strings.EmbalmedNames;
		this.m.BackgroundType = this.Const.BackgroundType.Untalented | this.Const.BackgroundType.Outlaw;
		this.m.ProfessionTreeBranches = ::Legends.BackgroundProfessionTrees.SsuNecroSlave.Profession;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
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
			0.05, //badlands
			0.0, //highlands
			0.05, //stepps
			0.0, //ocean
			0.05, //desert
			0.05 //oasis
		];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SwordTree,
				this.Const.Perks.CleaverTree,
				this.Const.Perks.SlingTree
			],
			Defense = [
				this.Const.Perks.ShieldTree,
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.OrganisedTree,
				this.Const.Perks.FitTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.MummyClassTree
			],
			Magic = []
		}
	}

	function onUpdate( _properties )
	{
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
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.ssu_necro_embalmbed_slave.Tooltip
			}
		];
		
		if (this.getContainer() == null || this.getContainer().getActor() == null)
			return ret;

		ret.extend(this.getAttributesTooltip());
		return ret;
	}

	function onBuildDescription()
	{
		return ::Mod_Sellswords.Strings.ssu_necro_embalmbed_slave.Text;
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				5
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
				5
			],
			RangedSkill = [
				0,
				10
			],
			MeleeDefense = [
				2,
				0
			],
			RangedDefense = [
				2,
				0
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
		this.character_background.onAdded();
	}

	function buildAttributes(_tag = null, _attrs = null)
	{
		return this.character_background.buildAttributes("skeleton", _attrs);
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local weapons = [
			"weapons/ancient/broken_ancient_sword",
			"weapons/ancient/ancient_spear",
			"weapons/ancient/ancient_sword",
			"weapons/legend_dilapidated_sling"
		];
		items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		if (items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
			if (this.Math.rand(1, 100) <= 66)
				items.equip(this.new("scripts/items/shields/ancient/legend_mummy_shield"));

		items.equip(this.new("scripts/items/legend_armor/cloth/legend_armor_bandages"));
		
		local item = ::Legends.Items.pickHelmet([
			[
				2,
				"ancient/legend_mummy_bandages"
			],
			[
				2,
				""
			]
		]);

		if (item != null)
			items.equip(item);
	}

});