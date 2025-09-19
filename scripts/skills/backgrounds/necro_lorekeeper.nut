this.necro_lorekeeper <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.lorekeeper";
		this.m.Name = "Lorekeeper";
		this.m.Icon = "ui/backgrounds/background_lorekeeper.png";
		this.m.BackgroundDescription = "Once a respected librarian in a grand archive of knowledge, the Lorekeeper\'s existence was forever changed by a dark and ancient curse. In life, they were known for their insatiable thirst for knowledge and their unwavering dedication to preserving the accumulated wisdom of ages past. However, their obsession with forbidden tomes and arcane secrets led them down a path of no return.";
		this.m.GoodEnding = "Driven by their insatiable thirst for forbidden knowledge, %name% delved deeper into the darkest recesses of their buried library, relentlessly seeking to uncover the secrets of ultimate power. They became consumed by their obsession, heedless of the slippery slope that they were heading down. In their reckless pursuit, the Lorekeeper unwittingly stumbled upon a forbidden ritual hidden within the depths of the library\'s archives. Blinded by ambition, %name% attempted to harness the dark power, believing it would grant them the mastery they so desperately sought over undeath.";
		this.m.BadEnding = "In a climactic battle, %name% fought valiantly against those it swore to destroy, but they were ultimately overwhelmed by the sheer power of the opposing force. In their final moments, they made a desperate sacrifice, consuming themselves and the malevolent force within, hoping to at least destroy those allied against them. As the dust settled and the echoes of battle faded, %name% was nowhere to be seen, their body turned to dust. The price of their hubris. Though their name may fade into obscurity, the eventual end served as a warning to future generations of the dangers that come with unchecked ambition and the pursuit of forbidden knowledge.";
		this.m.HiringCost = 0;
		this.m.DailyCost = 0;
		
		this.m.Names = this.Const.Strings.EmbalmedNames;
		this.m.Titles = [
			"the Lorekeeper"
		];
		
		// Unit Visuals
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = null;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.Muscular;
		
		this.m.BackgroundType = this.Const.BackgroundType.Untalented | this.Const.BackgroundType.Educated | this.Const.BackgroundType.Noble;
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+25%[/color] Experience Gain"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Makes an Ancient Scroll every 10 days if your stash has space"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Summon Screaming Skulls at the start of each turn. The amount summoned is equal to [color=" + ::Const.UI.Color.PositiveValue + "]25%[/color] of your level."
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The Screaming Skulls gain Hitpoints equal to the Lorekeeper\'s Resolve and deal damage on death equal to [color=" + ::Const.UI.Color.PositiveValue + "]60-80%[/color] of their current Hitpoints."
			}
		];
		
		if (this.getContainer() == null || this.getContainer().getActor() == null)
			return ret;

		ret.extend(this.getAttributesTooltip());
		return ret;
	}

	function onBuildDescription()
	{
		return "{Once a respected librarian in a grand archive of knowledge, %name%\'s existence was forever changed by a dark and ancient curse. In life, they were known for their insatiable thirst for knowledge and their unwavering dedication to preserving the accumulated wisdom of ages past. However, their obsession with forbidden tomes and arcane secrets led them down a path of no return.}";
	}

	function onAdded()
	{
		if (this.m.IsNew)
			this.m.Container.add(this.new("scripts/skills/effects/lorekeeper_skull_spawn_effect"));
		
		this.character_background.onAdded();
	}

	function buildPerkTree()
	{
		this.character_background.buildPerkTree();

		this.addPerkGroup(::Const.Perks.BasicNecroMagicTree.Tree);
		this.addPerkGroup(::Const.Perks.ValaRuneMagicTree.Tree);
		this.addPerkGroup(::Const.Perks.PhilosophyMagicTree.Tree);
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
		items.equip(this.Const.World.Common.pickArmor([
			[
				1, "ancient/ancient_lich_attire"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1, "ancient/ancient_lich_headpiece"
			]
		]));

		for (local i = 0; i < 3; ++i)
			stash.add(this.new("scripts/items/misc/legend_ancient_scroll_item"));
	}

});