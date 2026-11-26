this.ssu_necro_lorekeeper <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.ssu_necro_lorekeeper";
		this.m.Name = ::Mod_Sellswords.Strings.ssu_necro_lorekeeper.Name;
		this.m.Icon = "ui/backgrounds/ssu_necro_background_lorekeeper.png";
		this.m.BackgroundDescription = ::Mod_Sellswords.Strings.ssu_necro_lorekeeper.BackgroundDescription;
		this.m.GoodEnding = ::Mod_Sellswords.Strings.ssu_necro_lorekeeper.GoodEnding;
		this.m.BadEnding = ::Mod_Sellswords.Strings.ssu_necro_lorekeeper.BadEnding;
		this.m.HiringCost = 0;
		this.m.DailyCost = 0;
		
		this.m.Names = this.Const.Strings.EmbalmedNames;
		this.m.Titles = ::Mod_Sellswords.Strings.ssu_necro_lorekeeper.Titles;
		
		// Unit Visuals
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = null;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.Muscular;
		
		this.m.BackgroundType = this.Const.BackgroundType.Untalented | this.Const.BackgroundType.Educated | this.Const.BackgroundType.Noble;
		this.m.ProfessionTreeBranches = ::Legends.BackgroundProfessionTrees.SsuNecroLorekeeper.Profession;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.Modifiers.Crafting = this.Const.LegendMod.ResourceModifiers.Crafting[2];
		this.m.Modifiers.Enchanting = 1.5;
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
			0.2, //desert
			0.1 //oasis
		];
		this.m.CustomPerkTree = [
			[],
			[
				this.Const.Perks.PerkDefs.LegendMiasma
			],
			[],
			[],
			[],
			[],
			[
				this.Const.Perks.PerkDefs.LegendChainLightning
			]
		];
	}
	
	function onNewDay()
	{
		local stash = this.World.Assets.getStash();

		if (this.World.getTime().Days % 10 == 0 && stash.getNumberOfEmptySlots() > 0)
			stash.add(this.new("scripts/items/misc/legend_ancient_scroll_item"));
	}
	
	function onMovementStep( _tile, _levelDifference )
	{
		for( local i = 0; i < this.Const.Tactical.LichParticles.len(); i = ++i )
			this.Tactical.spawnParticleEffect(false, this.Const.Tactical.LichParticles[i].Brushes, _tile, this.Const.Tactical.LichParticles[i].Delay, this.Const.Tactical.LichParticles[i].Quantity, this.Const.Tactical.LichParticles[i].LifeTimeQuantity, this.Const.Tactical.LichParticles[i].SpawnRate, this.Const.Tactical.LichParticles[i].Stages);
	}
	
	function onUpdate( _properties )
	{
		_properties.XPGainMult *= 1.25;
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
				icon = "ui/icons/xp_received.png",
				text = ::Mod_Sellswords.Strings.ssu_necro_lorekeeper.Tooltip1
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.ssu_necro_lorekeeper.Tooltip2
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.ssu_necro_lorekeeper.Tooltip3
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.ssu_necro_lorekeeper.Tooltip4
			}
		];
		
		if (this.getContainer() == null || this.getContainer().getActor() == null)
			return ret;

		ret.extend(this.getAttributesTooltip());
		return ret;
	}

	function onBuildDescription()
	{
		return ::Mod_Sellswords.Strings.ssu_necro_lorekeeper.Text;
	}

	function onAdded()
	{
		if (this.m.IsNew)
			this.m.Container.add(this.new("scripts/skills/effects/ssu_necro_lorekeeper_skull_spawn_effect"));
		
		this.character_background.onAdded();
	}

	function buildPerkTree()
	{
		this.character_background.buildPerkTree();

		this.addPerkGroup(::Const.Perks.ZombieMagicTree.Tree);
		this.addPerkGroup(::Const.Perks.ValaRuneMagicTree.Tree);
		this.addPerkGroup(::Const.Perks.StavesMagicTree.Tree);
		this.addPerkGroup(::Const.Perks.ClothArmorTree.Tree);
		this.addPerkGroup(::Const.Perks.LightArmorTree.Tree);
		this.addPerkGroup(::Const.Perks.AgileTree.Tree);
		this.addPerkGroup(::Const.Perks.CalmTree.Tree);
		this.addPerkGroup(::Const.Perks.FastTree.Tree);
		this.addPerkGroup(::Const.Perks.IntelligentTree.Tree);
		this.addPerkGroup(::Const.Perks.SkeletonClassTree.Tree);
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				35,
				40
			],
			Bravery = [
				5,
				10
			],
			Stamina = [
				0,
				0
			],
			MeleeSkill = [
				4,
				10
			],
			RangedSkill = [
				19,
				23
			],
			MeleeDefense = [
				2,
				2
			],
			RangedDefense = [
				4,
				6
			],
			Initiative = [
				0,
				5
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local stash = this.World.Assets.getStash();
		local items = this.getContainer().getActor().getItems();
		items.equip(::Legends.Items.pickArmor([
			[
				1, "ancient/ancient_lich_attire"
			]
		]));
		items.equip(::Legends.Items.pickHelmet([
			[
				1, "ancient/ancient_lich_headpiece"
			]
		]));

		for (local i = 0; i < 3; ++i)
			stash.add(this.new("scripts/items/misc/legend_ancient_scroll_item"));
	}

});