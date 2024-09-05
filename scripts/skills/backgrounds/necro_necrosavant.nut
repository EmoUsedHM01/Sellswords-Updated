this.necro_necrosavant <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {
	},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.vampire";
		this.m.Name = "Necrosavant";
		this.m.Icon = "ui/backgrounds/background_vampire.png";
		this.m.BackgroundDescription = "In the forbidden depths of ancient tombs and cursed crypts, lurks the necrosavant, a dark and sinister entity born from the forbidden arts of necromancy. Once a mortal practitioner of dark magic, the necrosavant embraced the forbidden knowledge of raising the dead, seeking to defy the natural order and wield power over life and death itself. Through dark rituals and unholy pacts, it became an undead abomination that only survives by feasting on the blood of the living.";
		this.m.GoodEnding = "After years of delving into dark magic and necromancy, %name% found redemption in a moment of clarity and remorse. Faced with the consequences of its twisted ambitions and the suffering it had caused, the necrosavant renounced its dark practices and sought to atone for its sins. Through acts of selflessness and compassion, it used its remaining powers to undo the harm it had wrought, restoring balance to the forces of life and death. In the end, the necrosavant sacrificed its own existence to ensure that no more harm would come from its dark arts, leaving behind a legacy of redemption and forgiveness.";
		this.m.BadEnding = "Consumed by their insatiable thirst for blood, %name% descended further into darkness, heedless of the destruction it left in its wake. With each soul it ate and every corpse they devoured, its twisted ambitions grew ever more depraved, leaving a trail of death and despair in its wake. As their influence spread, %name% became a feared tyrant, ruling over a kingdom of the undead with an iron fist. In the end, %name%\'s lust for power consumed it entirely, leaving behind nothing but a desolate wasteland where only darkness reigned supreme.";
		this.m.HiringCost = 1000;
		this.m.DailyCost = 20;
		this.m.Excluded = [
			"trait.brave",
			"trait.athletic",
			"trait.brute",
			"trait.eagleyes",
			"trait.huge",
			"trait.loyal",
			"trait.tough",
			"trait.disloyal",
			"trait.loyal"
		];

		this.m.Titles = [
			"the Brutal",
			"the Gruesome",
			"the Bloody",
			"the Vile",
			"The Leech",
			"the Bat"
		];

		this.m.ExcludedTalents = [
			//this.Const.Attributes.Hitpoints,
			this.Const.Attributes.Fatigue,
			this.Const.Attributes.Bravery,
			//this.Const.Attributes.Initiative,
			//this.Const.Attributes.MeleeSkill,
			this.Const.Attributes.RangedSkill,
			//this.Const.Attributes.MeleeDefense,
			//this.Const.Attributes.RangedDefense,
		];

		// Unit Visuals
		this.m.Faces = this.Const.Faces.Vampire;
		this.m.Hairs = this.Const.Hair.Vampire;
		this.m.HairColors = this.Const.HairColors.Zombie;
		this.m.Beards = this.Const.Beards.Tidy;
		
		this.m.Level = this.Math.rand(2, 4);
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Outlaw;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[3];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[2];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[2];
		this.m.Modifiers.MedConsumption = this.Const.LegendMod.ResourceModifiers.MedConsumption[3];
		this.m.Modifiers.Terrain = [
			0.0, // ?
			0.0, //ocean
			0.0, //plains
			0.0, //swamp
			0.0, //hills
			0.05, //forest
			0.05, //forest
			0.05, //forest_leaves
			0.05, //autumn_forest
			0.0, //mountains
			0.0, // ?
			0.0, //farmland
			0.0, //snow
			0.05, //badlands
			0.0, //highlands
			0.0, //stepps
			0.0, //ocean
			0.05, //desert
			0.05//oasis
		];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SwordTree,
				this.Const.Perks.CleaverTree
			],
			Defense = [
				this.Const.Perks.ClothArmorTree,
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.DeviousTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.ViciousTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.VampireMagicTree
			],
			Magic = []
		}
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
		return "{Clothed in strange black robes, %name% appears to be more of an ambassador of the dark than a man of flesh and blood. | A curious fellow, %name% carries a slumped posture, as if he is weighted by otherworldly knowledge. | %name%\'s face is hidden well inside the dark of his cowl, a crescent of yellow teeth the only notion that a man dwells within. | Not much is known about %name%, but strange rumors of sorcery and dark arts follow him. | Wherever animals mysteriously begin to die, %name% makes an appearance. | The brooches on %name%\'s cloak seem to swirl and dance like midnight in a jug. | %name%\'s hands are rare to see, only coming out as if to portray the feelings of his face which lies hidden deep in his hood. | %name%\'s eyes could be mistaken for a cat\'s one day and for a blind man\'s the next.} {Little is known about whence he came. | From where he hails is but a mystery to most. | Some say he traveled deep into the northern foothills, returning with unspoken knowledge. | Ostensibly, the dark arts are his heritage, or so he puts on. | The man\'s past is kept from all. Maybe it\'s just uninteresting, or maybe just the opposite. | One rumor of the man says he traveled the land as a magician. | Rumors of magic surround the man, though some incredulous cynics are hardly impressed. | One rumor is that he was a conman, and another is that he\'s a sorcerer. You\'re not sure which you prefer. | With rumors of dark arts being practiced once more, the man\'s magical proclamation just might be true. | Some say he eats toads for breakfast and black cats for dinner.} {You ask %name% a lot of questions, but through some handwaves and nods, you realize you have forgotten his answers. Or did you ask the questions at all? | %name% produces a dove from his sleeve. An old trick that fancies no one - until it turns in the air, returning to him as a crow. | %name% has shown the ability to shoot smoke from his mouth. It\'s not fire, but it\'s close, and has people talking in hushed tones. | %name% floats a gold coin into the air. An amazing display that leaves the man too tired to attempt it again. | Predictions of the weather are common, but %name% is unusually accurate with his own. | %name% asks to read your palms. You decline. His presence alone is as close as you\'re willing to go. | %name% suggests that the stars are a roadmap to another world. He seems to know a lot about the heavens above. | %name% suggests that the heavens above are in fact just endless streams of beings, continuing on for eons. What a jest! | %name% points to one star in the sky and seems to suggest that is where he came from. You don\'t ask for a clarification on the matter.}";
	}
	
	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				15,
				20
			],
			Bravery = [
				-10,
				-5
			],
			Stamina = [
				5,
				5
			],
			MeleeSkill = [
				5,
				10
			],
			RangedSkill = [
				-5,
				-5
			],
			MeleeDefense = [
				0,
				0
			],
			RangedDefense = [
				-10,
				-5
			],
			Initiative = [
				15,
				20
			]
		};
		return c;
	}

	function onAdded()
	{
		if (this.m.IsNew)
			this.m.Container.add(this.new("scripts/skills/perks/perk_legend_darkflight"))
		
		this.character_background.onAdded();
	}

	function buildPerkTree()
	{
		this.character_background.buildPerkTree();
		this.addPerk(::Const.Perks.PerkDefs.LegendDarkflight, 0, false)
	}
	
	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();

		items.equip(this.new("scripts/items/weapons/ancient/khopesh"));
	}
	
});

