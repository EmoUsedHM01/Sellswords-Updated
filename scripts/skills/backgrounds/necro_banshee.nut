this.necro_banshee <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {
		Variant = 0
	},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.banshee";
		this.m.Name = "Winselmutter";
		this.m.Icon = "ui/backgrounds/background_banshee.png";
		this.m.BackgroundDescription = "Winselmutters are spectral entities, known for their mournful wails and chilling presence. With flowing hair and pale features, they are said to appear near places of impending death or to herald the passing of individuals from prominent families. Legends speak of their supernatural abilities to foresee tragedy and lament the departure of souls from the mortal realm, their haunting cries echoing through the night as omens of impending doom.";
		this.m.GoodEnding = "Having embraced the light of forgiveness, %name% found solace in letting go of its earthly attachments and embracing the peace of the afterlife. Through acts of redemption and reconciliation, it resolved the unfinished business that tethered it to the mortal realm, allowing its spirit to ascend to a higher plane of existence. As it faded into the radiant glow of transcendence, %name% left behind a legacy of healing and forgiveness, a testament to the power of love and redemption to conquer even the darkest shadows.";
		this.m.BadEnding = "Freed from the confines of its mortal coil, %name% wandered aimlessly through the ethereal plane, its essence consumed by bitterness and rage. Unable to find peace in the afterlife, it became a vengeful spirit, wreaking havoc upon the living in a futile attempt to assuage its own suffering. As its spectral form grew ever more twisted by the darkness that consumed it, %name%\'s existence became a tragic tale of unending torment, a warning to all who would dare defy the natural order of life and death.";
		this.m.HiringCost = 4000;
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
			"trait.ambitious",
			"trait.fear_nobles",
			"trait.hate_nobles",
			"trait.frail",
			"trait.steady_hands",
			"trait.talented",
			"trait.pragmatic",
			"trait.unpredictable",
			"trait.slack",
			"trait.sureshot",
			"trait.double_tongued",
			"trait.gift_of_people",
			"trait.seductive"
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

		this.m.Names = this.Const.Strings.BansheeNames;
		this.m.Titles = this.Const.Strings.BansheeTitles;
		this.m.Level = this.Math.rand(2, 3);
		this.m.BackgroundType = this.Const.BackgroundType.Female | this.Const.BackgroundType.Performing | this.Const.BackgroundType.Outlaw;
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
		this.pickRandomPerkTreeDynamic();
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
			Hitpoints = [ // 5-15 hp
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
			MeleeSkill = [ // 54-64 melee
				7,
				7
			],
			RangedSkill = [ // 35-48 ranged
				3,
				3
			],
			MeleeDefense = [ // 15-26 mdf
				15,
				21
			],
			RangedDefense = [ // 0-5 mdf
				0,
				0
			],
			Initiative = [ // 95-105 ini
				-5,
				5
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
					this.Const.Perks.GreatSwordTree
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

