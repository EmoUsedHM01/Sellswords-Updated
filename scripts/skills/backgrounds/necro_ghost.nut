this.necro_ghost <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {
		Variant = 0
	},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.ghost";
		this.m.Name = "Geist";
		this.m.Icon = "ui/backgrounds/background_ghost.png";
		this.m.BackgroundDescription = "Lingering between the realms of the living and the dead, Geists are spirits bound to the mortal realm by unfinished business or unresolved emotions. Often appearing as ethereal apparitions, they retain a connection to the world they once inhabited, haunting the places of their past or the individuals tied to their fate.";
		this.m.GoodEnding = "Guided by the gentle whispers of benevolent spirits, %name% embarked on a journey of self-discovery and enlightenment. Through acts of kindness and compassion, it learned to transcend the pain of its past and embrace the boundless possibilities of the afterlife. As it ascended to a realm of eternal peace and serenity, %name% became a beacon of hope for lost souls, offering guidance and solace to those who still wandered the mortal realm. In the annals of eternity, its presence shone as a testament to the enduring power of love and compassion to overcome the trials of existence.";
		this.m.BadEnding = "Trapped in a realm between the living and the dead, %name% lingers in eternal torment, its spectral form twisted by the weight of unresolved anguish. Haunting the halls of its former abode, it became a malevolent force, feeding off the fear it instills in the hearts of the living. As its presence grew more malevolent with each passing day, %name%\'s legacy became one of perpetual despair, a grim reminder of the dangers of lingering in the realm of the living long after one's time has passed.";
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
			//this.Const.Attributes.Initiative,
			//this.Const.Attributes.MeleeSkill,
			//this.Const.Attributes.RangedSkill,
			//this.Const.Attributes.MeleeDefense,
			//this.Const.Attributes.RangedDefense,
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
		return "{Once a lost soul wandering the misty realms between worlds, %name% now serves as a spectral sentinel, forever bound to this earthly plane by an ancient curse. | The true identity of %name% remains shrouded in the whispers of the beyond, lost amidst the echoes of forgotten tombs and forgotten lives. | This ethereal entity bears the scars of a violent demise, its spectral form forever haunted by the echoes of its untimely end. | Despite its otherworldly nature, %name% moves with an eerie grace, its ghostly form gliding silently through the shadows. | In the realm of the living, %name% is a silent watcher, its ghostly presence barely perceptible as it drifts through the mortal world. | Beneath its translucent veil, %name% harbors a boundless hunger, its spectral essence yearning for the warmth of life that it can never again possess.}{ Though death has claimed its mortal frame, %name% lingers on, an ethereal remnant of a life long past. | Trapped between realms, %name% exists in a state of perpetual unrest, forever tormented by the memories of its former existence. | In death, %name% has become a harbinger of whispers and shadows, a spectral guardian of secrets lost to the sands of time. | From the shadowy depths of forgotten crypts, %name% emerges as a specter of the night, its form bound to this world by ancient sorceries. | Lost to the annals of history, %name% drifts through the veil between worlds, a ghostly remnant of a bygone era. | In the darkness of the tomb, %name% found its eternal rest disturbed, condemned to wander the mortal realm as a restless spirit.}{ Though its corporeal form may have faded, %name% endures as a spectral wraith, its ethereal presence haunting the desolate halls of its final resting place. | In death, %name% has become an echo of the past, a ghostly apparition doomed to forever roam the earth in search of peace. | Bound by the chains of its own sorrow, %name% wanders the haunted corridors of the world, a ghostly visage forever trapped in the grip of its own torment. | Driven by a thirst for vengeance or perhaps a longing for closure, %name% roams the earth as a restless spirit, its ethereal form a testament to the fragility of mortal life. | In the stillness of the night, %name% walks among the living, a ghostly presence that lingers on the edge of perception, a whisper in the darkness. | Though it may be forgotten by the passage of time, %name% endures as a spectral guardian, its silent vigil a testament to the enduring power of the human spirit. | Once a soul lost to the depths of the underworld, %name% now wanders the mortal realm as a spectral remnant of its former self. | Forgotten by time, %name% exists as a shadowy echo of the past, its ethereal form a haunting reminder of lives long gone. | In death, %name% found neither rest nor solace, condemned to wander the earth as a restless spirit bound by the chains of its own sorrow.}{ Drifting through the veil between worlds, %name% is a silent watcher, its ghostly form a fleeting glimpse of a world beyond mortal comprehension. | Haunted by the memories of its former existence, %name% exists in a state of perpetual unrest, its ethereal presence a haunting reminder of the fragility of life. | In the darkness of the night, %name% walks among the living, a ghostly apparition that lingers on the edge of perception, a whisper in the wind. | Though its mortal form may have perished, %name% endures as a spectral guardian, its ethereal vigil a testament to the enduring power of the human spirit. | Bound by the chains of its own sorrow, %name% wanders the earth as a restless spirit, its ghostly presence a reminder of the depths of despair. | In death, %name% has become a harbinger of whispers and shadows, a silent watcher condemned to roam the earth for all eternity.}";
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
					this.Const.Perks.PolearmTree,
					this.Const.Perks.TwoHandedTree
				],
				Defense = [
					this.Const.Perks.HeavyArmorTree
				],
				Traits = [
					this.Const.Perks.SturdyTree,
					this.Const.Perks.LargeTree
				],
				Enemy = [
					this.Const.Perks.CivilizationTree
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
					this.Const.Perks.LightArmorTree,
				],
				Traits = [
					this.Const.Perks.FitTree,
					this.Const.Perks.ViciousTree
				],
				Enemy = [
					this.Const.Perks.CivilizationTree
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
					this.Const.Perks.CivilizationTree
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
					this.Const.Perks.CivilizationTree
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
					this.Const.Perks.CivilizationTree
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
					this.Const.Perks.CivilizationTree
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
					this.Const.Perks.CivilizationTree
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

