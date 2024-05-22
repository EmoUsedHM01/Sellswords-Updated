this.crbladedancer_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.crbladedancer";
		this.m.Name = "Blade Dancer";
		this.m.Icon = "ui/backgrounds/background_30.png";
		this.m.BackgroundDescription = "Bladedancers are the most dangerous nomads of prodigious skills.";
		this.m.GoodEnding = "The finest swordsman you\'d ever seen, %name% the old swordmaster was a natural addition to the %companyname%. But a man can\'t fight forever. Despite the company\'s growing success, it was becoming readily obvious that the swordmaster just could not physically do it anymore. He retired to a nice plot of land and is enjoying some time to himself. Or so you thought. You went out to go see the man and found him secretly training a nobleman\'s daughter. You promised to keep it a secret.";
		this.m.BadEnding = "A shame that %name% the swordmaster had to spend his twilight years in a declining mercenary company. He retired, stating he just could not physically do it anymore. You think he was just letting the %companyname% down easy, because a week later he slew ten would-be brigands on the side of a road without breaking a sweat. Last you heard, he was training ungrateful princes in the art of swordfighting.";
		this.m.HiringCost = 500;
		this.m.DailyCost = 35;
		this.m.Excluded = [
			"trait.huge",
			"trait.weasel",
			"trait.fear_undead",
			"trait.fear_beasts",
			"trait.fear_greenskins",
			"trait.fear_nobles",
			"trait.paranoid",
			"trait.impatient",
			"trait.clubfooted",
			"trait.irrational",
			"trait.athletic",
			"trait.gluttonous",
			"trait.dumb",
			"trait.bright",
			"trait.clumsy",
			"trait.tiny",
			"trait.insecure",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.dastard",
			"trait.hesitant",
			"trait.fragile",
			"trait.iron_lungs",
			"trait.tough",
			"trait.strong",
			"trait.bloodthirsty",
			"trait.double_tongued",
			"trait.slack",
			"trait.seductive"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.RangedSkill
		];
		this.m.Titles = [
			"the Legend",
			"the Old Guard",
			"the Master"
		];
		this.m.Ethnicity = this.Math.rand(1, 2);

		if (this.m.Ethnicity == 1)
		{
			this.m.Bodies = this.Const.Bodies.SouthernMuscular;
			this.m.Faces = this.Const.Faces.SouthernMale;
			this.m.Hairs = this.Const.Hair.SouthernMale;
			this.m.HairColors = this.Const.HairColors.Southern;
		}
		else
		{
			this.m.Bodies = this.Const.Bodies.AfricanMale;
			this.m.Faces = this.Const.Faces.AfricanMale;
			this.m.Hairs = this.Const.Hair.SouthernMale;
			this.m.HairColors = this.Const.HairColors.African;
		}

		this.m.Beards = this.Const.Beards.Southern;
		this.m.BeardChance = 90;
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		this.m.Level = this.Math.rand(2, 4);
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Outlaw | this.Const.BackgroundType.Ranger;
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[2];
		this.m.Modifiers.Terrain = [
			0.0,
			0.0,
			0.1,
			0.0,
			0.0,
			0.0,
			0.0,
			0.0,
			0.0,
			0.0,
			0.0,
			0.0,
			0.0,
			0.0,
			0.0,
			0.1,
			0.0,
			0.1,
			0.1
		];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SwordTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.BowTree,
				this.Const.Perks.SpearTree,
				this.Const.Perks.SlingTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.ViciousTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.AgileTree,
				this.Const.Perks.DeviousTree
			],
			Enemy = [
				this.Const.Perks.SouthernersTree,
				this.Const.Perks.DirewolfTree
			],
			Class = [],
			Magic = []
		};
	}

	function onBuildDescription()
	{
		return "{%name% fights like a fish practices swimming. | %name% isn\'t just a man\'s handle, it\'s a myth. A name used in place of words like war, combat, and death. | To say, \'You move like %name%\' is, perhaps, the greatest honor a man can bestow upon a fellow warrior. | %name% is considered to be one of the most dangerous swordsmen to have ever walked the earth.} {Much of his life is founded in myth: stories like how he dismantled a realm by challenging a king and all his guardsmen to a duel - and besting them with one hand. | Supposedly, he fought twenty men in his own garden, slowly picking and pruning his tomatoes with the same blade he was using to kill. | Some say he was left to sea for three-hundred days and there he learned - balancing on a piece of flotsam - how to move, how to fight, and how to survive. | A story goes that his family was murdered and he knew not by whom. Wanting to be ready if he came across those responsible, he taught himself to be good enough with a blade to kill anyone. | Raised by a one-armed father, he first learned how to fight with limitations. By the time he started using both hands he could already kill anybody with just one.} {Unfortunately, time and age have withered %name% into a shell of his former self. | During the orc invasions, %name% managed to kill a dozen greenskins singlehandedly. Sadly, an impossible feat does not come without a price: his sword-hand lost three fingers and his lead foot\'s achilles was severed. | Sadly, a horde of drunks fell upon his home, each hoping to become infamous by killing the famous swordsman. He slew them all, but not before taking irreversible injuries. | Legend has it that he quarreled with a foul beast of monstrous proportions. He waves the notion away with a fingerless hand and a scarred wink. | While teaching royalty how to fight, a coup that swept the entire realm had him running for his life. | Hired to teach noble heirs fighting skills, it wasn\'t long until he was embroiled in a web of intrigue and backstabbing, and had to leave as long as he still could.} {Now the old swordsman just looks to spend the rest of his fighting knowledge on the field. | While he\'s lost his edge, the man is still plenty dangerous and some say he\'s looking to find a student before he dies. | A master in the martial arts he may be, every movement he makes is echoed by the cracking of old bones. | Depressed and without purpose, %name% now finds meaning in simply blending in with the very men he used to teach. | The man makes it impossible to get through his defense, countering everything offered, but he no longer has the jump in his step to attack back. Admirable, but sad. | Given a sword, the old guard spins and twirls it in an impressive demonstration. When he plants it in the ground, he leans on the pommel to catch his breath. Not so impressive. | The man has been robbed of his athleticism, but his knowledge has turned swordfighting into mathematics.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-7,
				-7
			],
			Bravery = [
				7,
				5
			],
			Stamina = [
				-10,
				-10
			],
			MeleeSkill = [
				24,
				16
			],
			RangedSkill = [
				-5,
				-5
			],
			MeleeDefense = [
				8,
				12
			],
			RangedDefense = [
				5,
				5
			],
			Initiative = [
				-5,
				-5
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();

		if (this.Math.rand(0, 3) == 3)
		{
			local actor = this.getContainer().getActor();
			actor.setTitle(this.Const.Strings.SwordmasterTitles[this.Math.rand(0, this.Const.Strings.SwordmasterTitles.len() - 1)]);
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		if (this.Const.DLC.Unhold)
		{
			r = this.Math.rand(0, 2);

			if (r == 0)
			{
				items.equip(this.new("scripts/items/weapons/noble_sword"));
			}
			else if (r == 1)
			{
				items.equip(this.new("scripts/items/weapons/arming_sword"));
			}
			else if (r == 2)
			{
				items.equip(this.new("scripts/items/weapons/fencing_sword"));
			}
		}
		else
		{
			r = this.Math.rand(0, 1);

			if (r == 0)
			{
				items.equip(this.new("scripts/items/weapons/noble_sword"));
			}
			else if (r == 1)
			{
				items.equip(this.new("scripts/items/weapons/arming_sword"));
			}
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"padded_leather"
			],
			[
				1,
				"leather_tunic"
			],
			[
				1,
				"linen_tunic"
			],
			[
				1,
				"padded_surcoat"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				67,
				""
			],
			[
				33,
				"greatsword_hat"
			]
		]));
	}

});

