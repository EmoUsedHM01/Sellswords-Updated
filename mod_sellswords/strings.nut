::Mod_Sellswords.Strings <- {};

::Mod_Sellswords.text <- function ( _text, ... )
{
	foreach( i, value in vargv )
	{
		local key = "{" + (i + 1) + "}";
		local filler = "" + value;
		local at = _text.find(key);

		while (at != null)
		{
			_text = _text.slice(0, at) + filler + _text.slice(at + key.len());
			at = _text.find(key, at + filler.len());
		}
	}

	return _text;
}

::Mod_Sellswords.refreshStrings <- function ()
{
	foreach( def in ::Const.Perks.PerkDefObjects )
	{
		if (!("Const" in def))
			continue;

		if (def.Const.find("Ssu") == 0 && def.Const in ::Const.Strings.PerkName)
			def.Name = ::Const.Strings.PerkName[def.Const];

		if (def.Const in ::Mod_Sellswords.Strings.PerkDescriptions)
			def.Tooltip = ::Const.Strings.PerkDescription[def.Const];
	}

	foreach( key, names in ::Mod_Sellswords.Strings.Entity )
	{
		local id = ::Const.EntityType[key];
		::Const.Strings.EntityName[id] = names[0];
		::Const.Strings.EntityNamePlural[id] = names[1];
	}
}

// ---------------------------------------------------------------------------
// Enemy names, singular then plural
// ---------------------------------------------------------------------------
::Mod_Sellswords.Strings.Entity <- {
	SsuSellswordRanger = ["Sellsword Ranger", "Sellsword Rangers"],
	SsuSellsword = ["Sellsword", "Sellswords"],
	SsuSellswordElite = ["Sellsword Elite", "Sellsword Elites"],
	SsuSellswordveteran = ["Sellsword Veteran", "Sellsword Veterans"],
	SsuSquire = ["Squire", "Squires"],
	SsuSquireLow = ["Squire", "Squires"],
	SsuBarbblacksmith = ["Barbarian Blacksmith", "Barbarian Blacksmiths"],
	SsuConscript = ["Conscript", "Conscripts"],
	SsuFallenbetrayer = ["Fallen Betrayer", "Fallen Betrayers"],
	SsuBaron = ["Baron", "Barons"],
	SsuManhunter = ["Manhunter", "Manhunters"],
	SsuSlaveowner = ["Slave Owner", "Slave Owners"],
	SsuAbjectfighter = ["Slave Fighter", "Slave Fighters"],
	SsuAbjectgladiator = ["Slave Gladiator", "Slave Gladiators"],
	SsuWarden = ["Warden", "Wardens"],
	SsuDesperado = ["Desperado", "Desperados"],
	SsuHashshashin = ["Hashshashin", "Hashshashins"],
	SsuDesperadoLow = ["Desperado", "Desperados"],
	SsuHashshashinLow = ["Hashshashin", "Hashshashins"],
	SsuOrcPillager = ["Orc Pillager", "Orc Pillagers"],
	SsuBarbarianZerkerLow = ["Barbarian Rager", "Barbarian Ragers"],
	SsuBarbarianZerkerHigh = ["Barbarian Berserker", "Barbarian Berserkers"],
	SsuKnight = ["Knight", "Knights"],
	SsuHedgeKnight = ["Hedge Knight", "Hedge Knights"],
	SsuOathbringer = ["Oathbringer", "Oathbringers"],
	SsuBarbhunter = ["Barbarian Hunter", "Barbarian Hunters"],
	SsuMercenary = ["Mercenary", "Mercenaries"],
	SsuPeasantgravedigger = ["Gravedigger", "Gravediggers"],
	SsuPeasantherbalist = ["Herbalist", "Herbalists"],
	SsuPeasantblacksmith = ["Blacksmith", "Blacksmiths"],
	SsuPeasantbutcher = ["Butcher", "Butchers"],
	SsuPeasantminstrel = ["Minstrel", "Minstrels"],
	SsuPeasantjuggler = ["Juggler", "Jugglers"],
	SsuBanditleaderwolf = ["Disguised Bandit Leader", "Disguised Bandit Leaders"],
	SsuDesperadoHigh = ["Desperado", "Desperados"],
	SsuHashshashinHigh = ["Hashshashin", "Hashshashins"],
	SsuBarbarianChampionhigh = ["Barbarian Chosen", "Barbarian Chosens"],
	SsuDesperadoWeak = ["Desperado", "Desperados"],
	SsuRetiredsoldier = ["Retired Soldier", "Retired Soldiers"],
	SsuRetiredsoldierpol = ["Retired Soldier", "Retired Soldiers"],
	SsuPeasantkiller = ["Killer", "Killers"],
	SsuZombieswordmaster = ["Yaksha", "Yakshas"],
	SsuOutlander = ["Outlander", "Outlanders"],
	SsuInfantry = ["Infantry", "Infantries"],
	SsuGuardsman = ["Guardsman", "Guardsmen"],
	SsuGuardsmanPol = ["Guardsman", "Guardsmen"],
	SsuSolemner = ["Mulathamin", "Mulathamun"],
	SsuHonoraryknight = ["Honorary Knight", "Honorary Knights"],
	SsuSquireFencer = ["Squire", "Squires"],
	SsuSellswordPolearm = ["Sellsword", "Sellswords"],
	SsuSellswordTank = ["Sellsword", "Sellswords"],
	SsuSellswordveteranPolearm = ["Sellsword Veteran", "Sellsword Veterans"],
	SsuSellswordveteranTank = ["Sellsword Veteran", "Sellsword Veterans"],
	SsuSellswordveteranRanger = ["Sellsword Veteran", "Sellsword Veterans"],
	SsuSellswordSergeant = ["Sellsword Sergeant", "Sellsword Sergeants"],
	SsuSellswordLieutenant = ["Sellsword Sergeant", "Sellsword Sergeants"],
	SsuSellswordBanner = ["Sellsword Standard Bearer", "Sellsword Standard Bearers"],
	SsuSquireNormal = ["Squire", "Squires"],
	SsuImmortal = ["Barbarian Chosen", "Barbarian Chosens"],
	SsuSkeleton = ["Ancient Praetoriani", "Ancient Praetorianus"],
	SsuSkeletonPol = ["Ancient Praetoriani", "Ancient Praetorianus"],
	SsuGoblinwarrior = ["Goblin Warrior", "Goblin Warriors"],
	SsuKnightGuest = ["Knight", "Knights"],
	SsuSquireGuest = ["Squire", "Squires"],
	SsuStandardBearerGuest = ["Standard Bearer", "Standard Bearers"],
	SsuFootmanGuest = ["Footman", "Footmen"],
	SsuBillmanGuest = ["Billman", "Billmen"],
	SsuArbalesterGuest = ["Arbalester", "Arbalesters"],
	SsuZweihanderGuest = ["Greatsword", "Greatswords"],
	SsuSergeantGuest = ["Sergeant", "Sergeants"],
	SsuBanditFootman = ["Footman", "Footmen"],
	SsuBanditBillman = ["Billman", "Billmen"],
	SsuBanditArbalester = ["Arbalester", "Arbalesters"],
	SsuBanditZweihander = ["Greatsword", "Greatswords"],
	SsuBanditSergeant = ["Sergeant", "Sergeants"],
	SsuBarbarianFootman = ["Footman", "Footmen"],
	SsuBarbarianBillman = ["Billman", "Billmen"],
	SsuBarbarianArbalester = ["Arbalester", "Arbalesters"],
	SsuBarbarianZweihander = ["Greataxe", "Greataxes"],
	SsuBarbarianSergeant = ["Sergeant", "Sergeants"],
	SsuNomadFootman = ["Footman", "Footmen"],
	SsuNomadBillman = ["Billman", "Billmen"],
	SsuNomadArbalester = ["Arbalester", "Arbalesters"],
	SsuNomadZweihander = ["Grenadier", "Grenadiers"],
	SsuNomadSergeant = ["Sergeant", "Sergeants"],
	SsuZombieFootman = ["Wiederganger", "Wiedergangers"],
	SsuZombieBillman = ["Wiederganger", "Wiedergangers"],
	SsuZombieArbalester = ["Wiederganger", "Wiedergangers"],
	SsuZombieZweihander = ["Wiederganger", "Wiedergangers"],
	SsuNecromancer = ["Necromancer", "Necromancers"],
	SsuPaladinGuest = ["Paladin", "Paladins"],
	SsuOrcWarlock = ["Orc Warlock", "Orc Warlocks"],
	SsuBarbarianKing = ["Barbarian King", "Barbarian Kings"],
	SsuSlayer = ["Beast Slayer", "Beast Slayers"],
	SsuLindwurmSlayer = ["Lindwurm Slayer", "Lindwurm Slayers"],
	SsuDeathknight = ["Death Knight", "Death Knights"],
	SsuKnightcommander = ["Knight Commander", "Knight Commanders"],
	SsuOrcGrunt = ["Orc Grunt", "Orc Grunts"],
	SsuOrcVanguard = ["Orc Slaughterer", "Orc Slaughterers"],
	SsuOrcPackleader = ["Orc Packleader", "Orc Packleaders"],
	SsuAbjectgladiator02 = ["Slave Gladiator", "Slave Gladiators"],
	SsuNomadScavenger = ["Nomad Scavenger", "Nomad Scavengers"],
	SsuBaron02 = ["Baron", "Barons"],
	SsuGoblinRider01 = ["Goblin Gendarme", "Goblin Gendarmes"],
	SsuGoblinRider02 = ["Goblin Chasseur", "Goblin Chasseurs"],
	SsuGoblinRider03 = ["Goblin Caballero", "Goblin Caballeros"],
	SsuGoblinRider04 = ["Goblin Ranger", "Goblin Rangers"],
	SsuGoblinRider00 = ["Goblin Fighter", "Goblin Fighters"],
	SsuConqueror = ["Conqueror", "Conquerors"],
	SsuDryadWolf = ["Verdant Hound", "Verdant Hounds"],
	SsuDryadSnake = ["Thicket Stalker", "Thicket Stalkers"],
	SsuDryadUnhold = ["Woodland Protector", "Woodland Protector"],
	SsuDryadLindy = ["Forest Avatar", "Forest Avatars"],
	SsuDryadWarrior = ["Briarwalker", "Briarwalkers"],
	SsuDryadGrunt = ["Dryad Sentinel", "Dryad Sentinels"],
	SsuDryadArcher = ["Thornspitter", "Thornspitters"],
	SsuDryadShaman = ["Sylvan Sage", "Sylvan Sages"],
	SsuDryadTamer = ["Wildcaller", "Wildcallers"],
	SsuDryadBoss = ["Grove Guardian", "Grove Guardians"]
};

// ---------------------------------------------------------------------------
// Name lists, perk names and perk descriptions
// ---------------------------------------------------------------------------
::Const.Strings.crSellsword_EliteNames <- [
	"William III",
	"John VI",
	"Roger de Flor",
	"Götz von Berlich",
	"Sir John Chandos",
	"Francisco II",
	"János VI",
	"Thomas Montagu",
	"Michael II",
	"Philip of Swabia",
	"Geoffrey Charny",
	"Gaspar Guzmán",
	"René of Anjou",
	"Bertrand de Born",
	"Guy of Lusignan",
	"Jean de Vienne",
	"James St. George",
	"Richard FitzGil",
	"Thibaut Chamgn",
	"Alfonso Albuque",
	"Juan de Cueva",
	"Charles of Anjou",
	"Stephen of Blois",
	"Philip III",
	"Fulk IV of Anjou",
	"Tancred Sicily",
	"Raymond Poiters",
	"Baldwin Boulogne",
	"Bohemond Taranto",
	"Stephen Tournai",
	"Henry de Bohun",
	"Conan Brittany",
	"Gilbert Clare",
	"Hubert de Burgh",
	"Ralph de Gael",
	"Richard Clare",
	"Simon de Montfort",
	"Richard V",
	"William of Ypres",
	"Robert de Vere",
	"John de Warenne",
	"Abyss de Cranes",
	"Emo the Dark",
	"Breaky de Devo",
	"Son von Satan",
	"Rygar III",
	"Chiru of Hanguk",
	"Grenik de Slav",
	"Abyss von Crane",
	"Luft the Rat"
];

::Const.Strings.crBaronNames <- [
	"Lord Charles",
	"Lord Louis",
	"Lord Carloman",
	"Lord Eudes",
	"Lord Robert",
	"Lord Raoul",
	"Lord Lothaire",
	"Lord Hugues",
	"Lord Henri",
	"Lord Philippe",
	"Lord Jean",
	"Lord NapoleonIer"
];

::Const.Strings.crBlacksmithNames <- [
	"Muradin",
	"Modimus",
	"Aegrim",
	"Vanndar",
	"Thane",
	"Baelgun",
	"Grim"
];

::Const.Strings.crBlacksmithTitles <- [
	"Bronzebeard",
	"Stormheart",
	"Flamebeard",
	"Stormpike",
	"Stonehearth",
	"Hammerfall",
	"Thunderbrew "
];

::Const.Strings.crPriestNames <- [
	"Muradin",
	"Modimus",
	"Aegrim",
	"Vanndar",
	"Thane",
	"Baelgun",
	"Grim"
];

::Const.Strings.crDesperadoNames <- [
	"Foltest",
	"Radovid",
	"Henselt",
	"Keira Metz",
	"Dijkstra",
	"Vernon Roche",
	"John Natalis",
	"Dandelion",
	"Thaler",
	"John Calveit",
	"Morvran Voorhis",
	"Stefan Skellen",
	"Cahir",
	"James Hind",
	"Cartouche",
	"Hannikel",
	"Eppelein",
	"Schinderhannes",
	"Boarische Hiasl",
	"Hans Kohlhase",
	"Mathias Kneibl"
];

::Const.Strings.crDesperadoTitles <- [
	"the Knight Slayer",
	"the Wolfhunter",
	"the Waking Flame",
	"the Dragonborn",
	"the Revager",
	"the Unchained Aggressor",
	"the Knightmare",
	"the Scourge Harverster",
	"the Infernal Guardian",
	"the Indomitable Fury",
	"the Conviction",
	"the Flame Bringer",
	"of the Nightfal",
	"the Ironbane",
	"of the Four Winds",
	"the Savage Hero",
	"the Vengeance Incarnate",
	"the Leper",
	"the Outlaw"
];

::Const.Strings.crHashshashinNames <- [
	"Abul Nuqoud",
	"Malik",
	"Kadar",
	"Ibn Jubayr",
	"Haytham",
	"Suleiman",
	"Manuel",
	"Yusuf"
];

::Const.Strings.crHashshashinTitles <- [
	"Ibn-La Ahad",
	"Vidic",
	"Al-Sayf",
	"ad-Din Sinan",
	"the Lionheart",
	"Hastings",
	"Savonarola",
	"Kaczmarek",
	"Barleti",
	"Tazim"
];

::Const.Strings.crBarbarianChampionNames <- [
	"Harald",
	"Hildr",
	"Raud",
	"Steinunn",
	"Egill",
	"Steinvor",
	"Thorkell",
	"Rusla",
	"Embla",
	"Hallfrid",
	"Hrodgeir",
	"Arinbjorn",
	"Tyrkir",
	"Sorli",
	"Stakar",
	"Authulf"
];

::Const.Strings.crBarbarianChampionTitles <- [
	"Bluetooth",
	"Fairhair",
	"Lodbrok",
	"Sighvatsdottir",
	"the Tall",
	"Skallagrimsson",
	"the White",
	"the Steel-Forged",
	"the Raven Cut",
	"the Menace",
	"the Giantslayer"
];

::Const.Strings.FemaleKnightNames <- [
	"Dame Jean",
	"Dame Eula",
	"Dame Hertha",
	"Dame Vennessa",
	"Dame Amber",
	"Dame Klee",
	"Dame Lisa",
	"Dame Sucrose",
	"Dame Klee",
	"Dame Noelle",
	"Dame Margaret",
	"Dame Maria",
	"Dame Centaurea",
	"Dame Senomy",
	"Dame Willow",
	"Dame Liz"
];

::Const.Strings.LightSwordsmanNames <- [
	"Johannes Liechtenauer",
	"Sigmund Ringeck",
	"Fiore dei Liberi",
	"Kamiizumi Nobutsuna",
	"Donald McBane",
	"Joseph Bologne",
	"Gyorgy Thury",
	"William Marshal",
	"Antonio Manciolino",
	"Camillo Agrippa",
	"Giacomo di Grassi",
	"Angelo Viggiani",
	"George Silver",
	"Henry de Sainct-Didier"
];

::Const.Strings.SergeantTitles <- [
	"the Defender of the Weak",
	"the Hardiness",
	"the Relentless Assault",
	"the Vengeance Aura",
	"the Steed of Glory",
	"the Softened Blows",
	"the Luminescence",
	"the Law and Order",
	"the Vim and Vigor",
	"the Lawbringer"
];

::Const.Strings.SellswordsNames <- [
	"William III",
	"John VI",
	"Roger de Flor",
	"Götz von Berlich",
	"Sir John Chandos",
	"Francisco II",
	"János VI",
	"Thomas Montagu",
	"Michael II",
	"Philip of Swabia",
	"Geoffrey Charny",
	"Gaspar Guzmán",
	"René of Anjou",
	"Bertrand de Born",
	"Guy of Lusignan",
	"Jean de Vienne",
	"James St. George",
	"Richard FitzGil",
	"Thibaut Chamgn",
	"Alfonso Albuque",
	"Juan de Cueva",
	"Charles of Anjou",
	"Stephen of Blois",
	"Philip III",
	"Fulk IV of Anjou",
	"Tancred Sicily",
	"Raymond Poiters",
	"Baldwin Boulogne",
	"Bohemond Taranto",
	"Stephen Tournai",
	"Henry de Bohun",
	"Conan Brittany",
	"Gilbert Clare",
	"Hubert de Burgh",
	"Ralph de Gael",
	"Richard Clare",
	"Simon de Montfort",
	"Richard V",
	"William of Ypres",
	"Robert de Vere",
	"John de Warenne",
	"Abyss de Cranes",
	"Emo of Cutter",
	"Breaky de Devo",
	"Son von Satan",
	"Rygar III",
	"Chiru of Hanguk",
	"Grenik de Slav"
];

::Const.Strings.DryadNames <- [
	"Thallos",
	"Nymor",
	"Sylvan",
	"Aelius",
	"Lior",
	"Faelon",
	"Eryndor",
	"Calanthor",
	"Isoldar",
	"Lysan",
	"Marisar",
	"Oran",
	"Tethyr",
	"Avenor",
	"Briarthorn",
	"Elowyn",
	"Faelorn",
	"Glyndor",
	"Hesperon",
	"Illyrion",
	"Junir",
	"Kael",
	"Lythan",
	"Miras",
	"Naidar",
	"Ophion",
	"Phaedron",
	"Quillar",
	"Roswyn",
	"Seraphor",
	"Talon",
	"Virel",
	"Wynor",
	"Xanthor",
	"Ysolde",
	"Zephyrus",
	"Bryndor",
	"Eirlan",
	"Melanthor",
	"Ondros",
	"Selenor",
	"Elyon",
	"Asteros",
	"Liraen",
	"Niar",
	"Orian",
	"Rhiandor",
	"Selindor",
	"Thalon",
	"Virelith"
];

::Const.Strings.WarlockTitles <- [
	"Twilight Vanquisher",
	"the Hallowed",
	"the Nightfall",
	"Of the Shattered Sun",
	"the Darkbinder",
	"the Somber",
	"the Defiler",
	"the Foul",
	"the Decrepit",
	"the Shadowlord"
];

::Const.Strings.crBerserkerTitles <- [
	"Fleshrender",
	"the Stormrider",
	"the Deathbringer",
	"Of the Vengeful",
	"the Darkbinder",
	"the Sundering",
	"Worldcarver",
	"Dire Reaver",
	"the Cyclone",
	"the Bloodcursed",
	"Fierce Adamantite Ravager",
	"the Skullcrusher",
	"the Thunderstorm"
];

::Const.Strings.SlayerNames <- [
	"the Lindwurm Hunter",
	"the Wurmhunter",
	"the Lizard Hunter",
	"the Lizard Slayer",
	"Woodstalker",
	"the Lindwurm Slayer",
	"the Unhold Slayer",
	"the Tracker",
	"the Trophyhunter",
	"the Hunter",
	"the Orc Slayer",
	"the Dragon Slayer"
];

::Const.Strings.DemonHoundNames <- [
	"Shadowfang",
	"Grimclaw",
	"Nightstalker",
	"Dreadhowl",
	"Blackheart",
	"Doomjaw",
	"Bloodmoon",
	"Shadowpaw",
	"Darkfang",
	"Midnight",
	"Deathshade",
	"Shadowthorn",
	"Grimfang",
	"Voidclaw",
	"Nightshade",
	"Darkpaw",
	"Deathhowl",
	"Shadowbite",
	"Grimshadow",
	"Voidfang",
	"Soulreaper",
	"Darkmoon",
	"Ebonclaw",
	"Shadowmaw",
	"Grimwraith",
	"Dreadclaw",
	"Nightfall",
	"Darkheart",
	"Blackclaw",
	"Doomhowl",
	"Deathfang",
	"Shadowscar",
	"Nightdread",
	"Eclipse",
	"Gloomsnarl",
	"Shadowgrip",
	"Darkstorm",
	"Grimmaw",
	"Duskrage",
	"Deathgloom",
	"Darkshade",
	"Nightwrath",
	"Shadowshade",
	"Ebonfang",
	"Doomclaw",
	"Deathshadow",
	"Blackwraith",
	"Grimdark",
	"Nightclaw",
	"Shadowwraith"
];

::Const.Strings.GhostNames <- [
	"Deth",
	"Aeren",
	"Blythe",
	"Phan",
	"Aberra",
	"Undine",
	"Auris",
	"Devo",
	"Angel",
	"Ethae",
	"Kindel",
	"Shayde",
	"Myst",
	"Ethe",
	"Charis",
	"Stray",
	"Eaven",
	"Spec",
	"Flo",
	"Devi",
	"Lloial",
	"Lite",
	"Gallo",
	"Aide",
	"Remane",
	"Aener",
	"Perris",
	"Guya",
	"Spryte",
	"Celeste",
	"Ellis",
	"Ora",
	"Faith",
	"Elyse"
];

::Const.Strings.GhostTitles <- [
	"the Haunting Specter",
	"the Malevolent Phantom",
	"the Sinister Apparition",
	"the Vengeful Shade",
	"the Dreadful Wraith",
	"the Cursed Spirit",
	"the Tormented Banshee",
	"the Eerie Poltergeist",
	"the Ghastly Revenant",
	"the Shadowy Banshee",
	"the Diabolical Entity",
	"the Sinister Specter",
	"the Maleficent Apparition",
	"the Wicked Phantom",
	"the Wretched Wraith",
	"the Forsaken Spirit",
	"the Malevolent Ghost",
	"the Sinister Shade",
	"the Ephemeral Fiend",
	"the Wicked Wight"
];

::Const.Strings.BansheeNames <- [
	"Angy",
	"Damia",
	"Mindy",
	"Temprence",
	"Azure",
	"Misty",
	"Guardia",
	"Natura",
	"Kendel",
	"Damya",
	"Essence",
	"Celeste",
	"Carisma",
	"Mortia",
	"Vissi",
	"Mallory",
	"Aurabelle",
	"Karmay",
	"Vexa",
	"Dove",
	"Blesse",
	"Dwelle",
	"Exme",
	"Auriel",
	"Zoe",
	"Chasity",
	"Eterna",
	"Aure",
	"Angelica",
	"Via",
	"Erie",
	"Mortitia",
	"Shay",
	"Ondine",
	"Lucy",
	"Auralee",
	"Topia"
];

::Const.Strings.BansheeTitles <- [
	"the Wailing Banshee",
	"the Sorrowful Spirit",
	"the Keening Specter",
	"the Ephemeral Wraith",
	"the Mourning Phantom",
	"the Lamenting Ghost",
	"the Wailing Wraith",
	"the Mourning Banshee",
	"the Sorrowful Shade",
	"the Keening Banshee",
	"the Eerie Emissary",
	"the Wretched Wail",
	"the Crying Apparition",
	"the Ephemeral Echo",
	"the Wailing Whisper",
	"the Sorrowful Siren",
	"the Mourning Maiden",
	"the Keening Cry",
	"the Eerie Enigma",
	"the Wretched Wail"
];

::Const.Strings.EmbalmedNames <- [
	"Ahhotep", 
	"Ahmose", 
	"Akhethetep", 
	"Amenemhat", 
	"Amenemope", 
	"Amenhotep", 
	"Amenirdis", 
	"Amenmose", 
	"Ameny", 
	"Ankhesenpepi", 
	"Djehuty", 
	"Harsiese", 
	"Henuttawy", 
	"Hetepheres", 
	"Hori", 
	"Huy", 
	"Iset", 
	"Isetemkheb", 
	"Isetnofret", 
	"Karomama", 
	"Khaemwaset", 
	"Khamererneb", 
	"Khenemet", 
	"Khentkaus", 
	"Kheti", 
	"Khnumhotep", 
	"Maatkare", 
	"Menkheperre", 
	"Mhepeshef", 
	"Mentuhotep", 
	"Meresankh", 
	"Meritamen", 
	"Meritites", 
	"Meqy", 
	"Meryre", 
	"Minmose", 
	"Neferkare", 
	"Nefernef", 
	"Nefertari", 
	"Neferu", 
	"Nimlot", 
	"Panehesy", 
	"Pedubastis", 
	"Psusennes", 
	"Ptahhotep", 
	"Ptahmose", 
	"Qar", 
	"Ramesses", 
	"Ramose", 
	"Sekhemrek", 
	"Senusret", 
	"Setepenre", 
	"Shoshenq", 
	"Siamun", 
	"Smendes", 
	"Sobekemsaf", 
	"Sobekhotep", 
	"Tentamun", 
	"Thutmose", 
	"Tiye", 
	"Usaqmontu"
];

::Const.Strings.FallenHero <- [
	"Ser Balor",
	"Ser Thorne",
	"Ser Reynald",
	"Ser Aldric",
	"Ser Garrick",
	"Ser Cedric",
	"Ser Lucian",
	"Ser Ragnar",
	"Ser Percival",
	"Ser Desmond",
	"Ser Harald",
	"Ser Marrok",
	"Ser Darian",
	"Ser Bran",
	"Ser Erasmus",
	"Ser Leofric",
	"Ser Mortimer",
	"Ser Thaddeus",
	"Ser Bram",
	"Ser Urien",
	"Ser Caelan",
	"Ser Oswin",
	"Ser Valerian",
	"Ser Eldric",
	"Ser Corvin",
	"Ser Declan",
	"Ser Fenrir",
	"Ser Gideon",
	"Ser Hadrian",
	"Ser Ignatius",
	"Ser Jorah",
	"Ser Kalen",
	"Ser Lysander",
	"Ser Maximus",
	"Ser Nathaniel",
	"Ser Oberon",
	"Ser Percival",
	"Ser Quintus",
	"Ser Roderick",
	"Ser Seraphim",
	"Ser Tarquin",
	"Ser Uther",
	"Ser Vortigern",
	"Ser Wulfric",
	"Ser Xander",
	"Ser Yorick",
	"Ser Zephyrus",
	"Ser Alistair",
	"Ser Benedict",
	"Ser Cyrus"
];

::Const.Strings.FallenHeroTitles <- [
	"the Blighted",
	"the Forsaken",
	"the Revenant",
	"the Lichborn",
	"the Rotting",
	"the Fleshless",
	"the Gravewalker",
	"the Deathless",
	"the Soulless",
	"the Tombguard",
	"the Lamented",
	"the Wight",
	"the Corpsebearer",
	"the Rotknight",
	"the Boneblade",
	"the Wraith",
	"the Fleshrender",
	"the Necroblade",
	"the Dreadlord",
	"the Sorrowful",
	"the Desolate",
	"the Gravekeeper",
	"the Reanimated",
	"the Lichknight",
	"the Haunted",
	"the Deathbound",
	"the Cursed",
	"the Gravelord",
	"the Hollow",
	"the Decaylord",
	"the Doombringer",
	"the Forsworn",
	"the Deathbringer",
	"the Gravebound",
	"the Necroknight",
	"the Oathbreaker",
	"the Phantom",
	"the Graveguard",
	"the Relentless",
	"the Spectral",
	"the Tombwalker",
	"the Unyielding",
	"the Vanquished",
	"the Wretched",
	"the Xombified",
	"the Yawning",
	"the Zombie Lord",
	"the Abominable",
	"the Blightbringer",
	"the Cryptkeeper"
];

::Const.Strings.LegionnaireNames <- [
	"Decimus",
	"Tiberius",
	"Marius",
	"Cassius",
	"Lucius",
	"Maximus",
	"Titus",
	"Octavius",
	"Antonius",
	"Quintus",
	"Julius",
	"Claudius",
	"Marcellus",
	"Flavius",
	"Gaius",
	"Lucianus",
	"Aurelius",
	"Fabius",
	"Marcus",
	"Cassian",
	"Cornelius",
	"Decianus",
	"Drusus",
	"Rufus",
	"Hadrian",
	"Decius",
	"Octavian",
	"Tiberian",
	"Valentinus",
	"Severus",
	"Vespasian",
	"Hadrianus",
	"Aurelius",
	"Antoninus",
	"Valerianus",
	"Marcellinus",
	"Valentinian",
	"Maximianus",
	"Titanius",
	"Claudianus",
	"Cassianus",
	"Domitianus",
	"Commodianus",
	"Valerianus",
	"Galerius",
	"Julianus",
	"Flavianus",
	"Honorius",
	"Valerianus",
	"Severianus",
	"Octavianus",
	"Tertius",
	"Tribonius",
	"Varianus",
	"Severinus",
	"Faustinus",
	"Proculus",
	"Valerius",
	"Quirinus",
	"Rusticus",
	"Urbicus",
	"Vitalianus",
	"Zephyrinus",
	"Zoticus",
	"Urbanus",
	"Fulvianus",
	"Zeno",
	"Vitalis",
	"Ulysses",
	"Hadrianus",
	"Antoninianus",
	"Vigilius",
	"Vindex",
	"Maximinus",
	"Didius",
	"Aemilianus",
	"Blandus",
	"Honoratus",
	"Ignatius",
	"Justinianus",
	"Laurentius",
	"Lucillianus",
	"Mauricius",
	"Nestorius",
	"Nicomedes",
	"Orontius",
	"Priscillianus",
	"Secundus",
	"Tacitus",
	"Taurus",
	"Urbanus",
	"Valentinianus",
	"Zacharias",
	"Nicanor",
	"Ovidius",
	"Paulus",
	"Quintilianus",
	"Septimianus",
	"Terentius"
];

::Const.Strings.PerkName.SsuNecroZombieUndying <- "Undying Resilience";

::Const.Strings.PerkDescription.SsuNecroZombieUndying <- "Instills the user with an innate defiance toward mortality, enabling it to shrug off fatal blows and rise once more.\n\n[color=#4f1800][u]Passive:[/u][/color]\n• Every battle, you can reanimate yourself once so long as you haven\'t lost your head.\n• Also grants [color=%positive%]+10[/color] hitpoints.";

::Const.Strings.PerkName.SsuNecroZombieFeasting <- "Feast On Flesh";

::Const.Strings.PerkDescription.SsuNecroZombieFeasting <- "Tastes just like chicken!\n\n[color=#4f1800][u]Passive:[/u][/color]\n• The [color=%negative%]Wiederganger Bite[/color] active skill costs [color=%positive%]1[/color] less AP and restores up to [color=%positive%]50%[/color] of the damage dealt directly to hitpoints.";

::Const.Strings.PerkName.SsuNecroZombieInfectious <- "Infectious Bite";

::Const.Strings.PerkDescription.SsuNecroZombieInfectious <- "Weeks, months or even years of not brushing your teeth creates a virulent agent of decay.\n\n[color=#4f1800][u]Passive:[/u][/color]\n• The [color=%negative%]Wiederganger Bite[/color] skill can inflict a poison that worsens over time.";

::Const.Strings.PerkName.SsuNecroZombiePuppet <- "Complete Obedience";

::Const.Strings.PerkDescription.SsuNecroZombiePuppet <- "With the repeated saturation of dark magic, this undead has long-gotten used to being a puppet for others.\n\n[color=#4f1800][u]Passive:[/u][/color]\n• The bonus stats from being [color=%negative%]Possessed[/color] are increased by 50%.";

::Const.Strings.PerkName.SsuNecroZombieFallenHero <- "Fallen Hero";

::Const.Strings.PerkDescription.SsuNecroZombieFallenHero <- "Embrace your fate as another restless undead, destined to defy death itself and endure for an eternity.\n\n[color=#4f1800][u]Passive:[/u][/color]\n• Grants [color=%positive%]+3[/color] Action Points.\n• Being fatally slain can\'t stop you from being reanimated.";

::Const.Strings.PerkName.SsuNecroSkeletonReconstruction <- "Boneforge Mastery";

::Const.Strings.PerkDescription.SsuNecroSkeletonReconstruction <- "These bones have become yet another weapon in your hands.\n\n[color=#4f1800][u]Passive:[/u][/color]\n• Has a [color=%positive%]100%[/color] chance to survive if struck down or fatally slain.";

::Const.Strings.PerkName.SsuNecroSkeletonHarden <- "Reinforced Framework";

::Const.Strings.PerkDescription.SsuNecroSkeletonHarden <- "Drinking milk makes your bones strong, but bathing in the blood of your enemies makes them even stronger!\n\n[color=#4f1800][u]Passive:[/u][/color]\n• Grants [color=%positive%]+15[/color] hitpoints and reduces slashing damage by [color=%positive%]25%[/color].";

::Const.Strings.PerkName.SsuNecroMummyCursedBody <- "Cursed Body";

::Const.Strings.PerkDescription.SsuNecroMummyCursedBody <- "Imbues the bearer with a malevolent dark energy, inflicting misfortune upon those who dare to strike them in combat.\n\n[color=#4f1800][u]Passive:[/u][/color]\n• Reduces the Resolve of adjacent enemies by [color=%negative%]-10[/color].\n• Grants a [color=%positive%]25%[/color] to curse your attacker upon taking damage.";

::Const.Strings.PerkName.SsuNecroAncientKnowledge <- "Ancient Knowledge";

::Const.Strings.PerkDescription.SsuNecroAncientKnowledge <- "You have a deep understanding when it comes to ancient weaponry, allowing you use them more effectively.\n\n[color=#4f1800][u]Passive:[/u][/color]\n• Grants a bonus of [color=%positive%]6[/color]-[color=%positive%]12[/color] damage for one-hand \'Ancient\' weapons.\n• Grants a bonus of [color=%positive%]8[/color]-[color=%positive%]24[/color] damage and [color=%positive%]+10%[/color] armour penetration for two-hand \'Ancient\' weapons.\n• Named \'Ancient\' weapons have an additional [color=%positive%]+10%[/color] chance to hit the head.";

::Const.Strings.PerkName.SsuNecroMummyInsectBreath <- "Breath of the Swarm";

::Const.Strings.PerkDescription.SsuNecroMummyInsectBreath <- "Grants the user the unsettling ability to exhale a cloud of swarming insects, enveloping foes in a maelstrom of biting, stinging creatures.\n\n[color=#4f1800][u]Active:[/u][/color]\n• Unlocks the \'Insect Breath\' active skill which applies a 7 turn debuff to an adjacent target.\n• Can only be used once per battle.\n\n• Costs [color=%negative%]3[/color] AP and [color=%negative%]15[/color] Fatigue.";

::Const.Strings.PerkName.SsuNecroGhostGhastlyTouch <- "Etheral Agility";

::Const.Strings.PerkDescription.SsuNecroGhostGhastlyTouch <- "Bestows upon the user a ghostly nimbleness, allowing them to effortlessly phase through obstacles and adversaries alike.\n\n[color=#4f1800][u]Passive:[/u][/color]\n• The [color=%negative%]Ghastly Touch[/color] skill costs [color=%positive%]1[/color] less AP and has [color=%positive%]+5%[/color] hit chance.";

::Const.Strings.PerkName.SsuNecroGhostSpectralBody <- "Phantasmal Composition";

::Const.Strings.PerkDescription.SsuNecroGhostSpectralBody <- "As the user blurs between the realms of existence, they become as insubstantial as a fleeting dream, evading attacks with ease.\n\n[color=#4f1800][u]Passive:[/u][/color]\n• Make incoming melee attacks have a [color=%positive%]-10%[/color] chance to hit you.\n• Grants a complete immunity to all ranged attacks.";

::Const.Strings.PerkName.SsuNecroGhostVanish <- "Spectral Shift";

::Const.Strings.PerkDescription.SsuNecroGhostVanish <- "Grants the ability to seamlessly traverse between realms, vanishing from one location and reappearing in another with ethereal grace.\n\n[color=#4f1800][u]Passive:[/u][/color]\n• Upon taking damage, you will be automatically teleported to another empty tile.\n• Prioritises being at least 2 tiles away from any enemies.";

::Const.Strings.PerkName.SsuNecroGhostPhase <- "Phase Through";

::Const.Strings.PerkDescription.SsuNecroGhostPhase <- "Like a wisp of mist on the wind, they glide effortlessly through both obstacles and adversaries alike.\n\n[color=#4f1800][u]Active:[/u][/color]\n• Unlocks the \'Phase Through\' active skill which allows you to move up to 3 tiles away, dealing damage to any enemies you pass through.\n\n• Costs [color=%negative%]6[/color] AP and [color=%negative%]0[/color] Fatigue.";

::Const.Strings.PerkName.SsuNecroGhostSoulEater <- "Soul Eater";

::Const.Strings.PerkDescription.SsuNecroGhostSoulEater <- "Empowers the wielder, allowing them to draw upon the life force of their foes, consuming their essence with each strike.\n\n[color=#4f1800][u]Passive:[/u][/color]\n• The [color=%negative%]Ghastly Touch[/color], [color=%negative%]Phase Through[/color], and [color=%negative%]Banshee Scream[/color] skills have [color=%positive%]33%[/color] to recover a stack of Nine Lives on hit.";

::Const.Strings.PerkName.SsuNecroSummonSkeleton <- "Osseous Resurrection";

::Const.Strings.PerkDescription.SsuNecroSummonSkeleton <- "Grants the user the ability to use their blood as a medium to bind a lost soul to a pile of well maintained skeletal remains.\n\n[color=#4f1800][u]Active:[/u][/color]\n• Unlocks the \'Reanimate Skeleton\' active skill which raises an undead minion in an adjacent tile.\n• The undead raised will have their stats increased based on the current resolve of the caster and will temporarily consume a useable corpse.\n• Taking this perk adds a single corpse to your stash, as well as the ability to obtain more corpses from suitable enemies.\n• The corpse used is returned to your stash at the end of combat, unless it has been destroyed.\n• Repeated use of the skill exacts a mental toll on the user, decreasing their mental state on each cast.\n• Unlocks a recipe in the crafting tent for producing Human Bones.\n\n• Costs [color=%negative%]7[/color] AP and [color=%negative%]35[/color] Fatigue.";

::Const.Strings.PerkName.SsuNecroSummonZombie <- "Undead Rebirth";

::Const.Strings.PerkDescription.SsuNecroSummonZombie <- "Grants the user the ability to utilize their blood as a conduit, binding a departed soul to a meticulously preserved cadaver, facilitating the resurrection of the undead.\n\n[color=#4f1800][u]Active:[/u][/color]\n• Unlocks the \'Reanimate Zombie\' active skill which raises an undead minion in an adjacent tile.\n• The undead raised will have their stats increased based on the current resolve of the caster and will temporarily consume a useable corpse.\n• Taking this perk adds a single corpse to your stash, as well as the ability to obtain more corpses from suitable enemies.\n• The corpse used is returned to your stash at the end of combat, unless it has been destroyed.\n• Repeated use of the skill exacts a mental toll on the user, decreasing their mental state on each cast.\n• Unlocks a recipe in the crafting tent for producing Human Carrion.\n\n• Costs [color=%negative%]7[/color] AP and [color=%negative%]35[/color] Fatigue.";

::Const.Strings.PerkName.SsuNecroSummonZombieDog <- "Feral Reawakening";

::Const.Strings.PerkDescription.SsuNecroSummonZombieDog <- "Grants the user the ability to infuse their blood with necromantic energy, facilitating the reanimation of a deceased canine companion.\n\n[color=#4f1800][u]Active:[/u][/color]\n• Unlocks the \'Reanimate Hound\' active skill which raises an undead minion in an adjacent tile.\n• The undead raised will have their stats increased based on the current resolve of the caster and will temporarily consume a useable corpse.\n• Taking this perk adds a single corpse to your stash, as well as the ability to obtain more corpses from suitable enemies.\n• The corpse used is returned to your stash at the end of combat, unless it has been destroyed.\n• Repeated use of the skill exacts a mental toll on the user, decreasing their mental state on each cast.\n• Unlocks a recipe in the crafting tent for producing Canine Carrion.\n\n• Costs [color=%negative%]4[/color] AP and [color=%negative%]15[/color] Fatigue.";

::Const.Strings.PerkName.SsuBackswing <- "Follow-up Maneuver";

::Const.Strings.PerkDescription.SsuBackswing <- @"
Master the art of turning failure into opportunity.

[color=%passive%][u]Passive:[/u][/color]
• Once per turn, when missing an attack against an opponent, restore [color=%positive%]3[/color] AP so long as the attack cost more than [color=%negative%]2[/color] AP.

• If this effect triggers, the next attack this turn will then use [color=%negative%]85%[/color] of your Melee and Ranged Skill and only inflicts [color=%negative%]85%[/color] of normal damage.
";

::Const.Strings.PerkName.SsuHackSpm <- "Skullsplitter";

::Const.Strings.PerkDescription.SsuHackSpm <- @"
Unleash the full potential of your axe with a series of devastating enhancements, turning every swing into a deadly opportunity.

[color=%passive%][u]Passive:[/u][/color]
• [color=%skill%]Hack[/color] gains an [color=%positive%]additional[/color] attack but deals [color=%negative%]-20%[/color] damage.

• [color=%skill%]Split Man[/color] gains [color=%positive%]+100%[/color] additional damage to the body.

• [color=%skill%]Strike[/color] gains a follow up attack that deals [color=%negative%]25%[/color] of base damage. This additional attack cannot hit the head.

• [color=%skill%]Chop[/color] deals [color=%positive%]+50%[/color] more damage to Hitpoints when hitting the head.
";

::Const.Strings.PerkName.SsuFob <- "Flurry of Blows";

::Const.Strings.PerkDescription.SsuFob <- @"
[color=%negative%][u]Requires:[/u] Piercing Damage[/color]
Learn to target vitals with your piercing attacks!

[color=%passive%][u]Passive:[/u][/color]
• Every attack that deals at least [color=%positive%]10[/color] damage to Hitpoints, applies a stacking debuff that lowers the target's threshold to receive injury and their Resolve by [color=%positive%]7%[/color].

• If this attack does at least [color=%negative%]30[/color] damage, apply an addtional stack, then inflict a stackable [color=%status%]Bleed[/color] on your target. This effect deals [color=%positive%]10[/color] damage each turn, for two turns, and can stack up to [color=%positive%]5[/color] times.

• Additionally, Piercing attacks can now inflict injuries to Undead.
";

::Const.Strings.PerkName.SsuTotalcover <- "Total Cover";

::Const.Strings.PerkDescription.SsuTotalcover <- @"
[color=%negative%][u]Requires:[/u] Shield[/color]
Master the art of deflecting blows with your shield, and of holding it where it covers the ones beside you.

[color=%passive%][u]Passive:[/u][/color]
• Gain additional Block equal to [color=%positive%]100%[/color] of your shield's Block value.

• Adjacent allies gain [color=%positive%]50%[/color] of your Block.

• If multiple users with this perk are present, only the highest bonus applies.
";

::Const.Strings.PerkName.SsuGuardian <- "The Guardian";

::Const.Strings.PerkDescription.SsuGuardian <- @"
[color=%negative%][u]Requires:[/u] Shield[/color]
Protect your allies with your shield!

[color=%passive%][u]Passive:[/u][/color]
• Increase the Melee Defense, Ranged Defense, and Initiative of adjacent allies by [color=%positive%]8%[/color] of your total Melee Defense and Ranged Defense.

• If multiple users with this perk are present, only the highest bonus applies.
";

::Const.Strings.PerkName.SsuFurinkazan <- "Furinkazan";

::Const.Strings.PerkDescription.SsuFurinkazan <- @"
Master the art of movement!

[color=%passive%][u]Passive:[/u][/color]
• Reduce the Action Point cost of [color=%skill%]Rotation[/color], [color=%skill%]Footwork[/color], [color=%skill%]Evasion[/color], [color=%skill%]Climb[/color], and [color=%skill%]Audacious Charge[/color] by [color=%negative%]1[/color] and reduce Fatigue costs by [color=%negative%]50%[/color]
";

::Const.Strings.PerkName.SsuGrandslam <- "Grand Slam";

::Const.Strings.PerkDescription.SsuGrandslam <- @"
Being massive has its pros and cons.

[color=%passive%][u]Passive:[/u][/color]
• The [color=%status%]Double Grip[/color] effect now increases damage by extra [color=%positive%]25%[/color].

• Increases Armor penetration and damage by [color=%positive%]50%[/color] when Unarmed.

• The [color=%perk%]Muscularity[/color] perk has its damage effect [color=%positive%]tripled[/color].

• The free attack of [color=%skill%]Audacious Charge[/color] deals [color=%positive%]75%[/color] damage instead of [color=%positive%]50%[/color].

• Fatigue cost of all skills is increased by [color=%negative%]8%[/color] of your Hitpoints

• Melee and throwing AP costs are increased by [color=%negative%]1[/color]

• Melee Defense, Ranged Defense, and Initiative are reduced by [color=%negative%]8%[/color] of your Hitpoints.

• The maximum Hitpoint value for this perks bonuses and penalties is [color=%positive%]150[/color].

• The [color=%skill%]Riposte[/color] skill has an additional [color=%negative%]-15%[/color] hit chance.

• The [color=%perk%]Duelist[/color] perk now additionally provides [color=%positive%]+20%[/color] additional Armor penetration Two Handed weapons and [color=%positive%]+10%[/color] for One Handed weapons and Throwing Weapons.
";

::Const.Strings.PerkName.SsuArmorMasteryCloth <- "Cloth Armor Mastery";

::Const.Strings.PerkDescription.SsuArmorMasteryCloth <- @"
Without anything weighing you down, you can jump around the battlefield unimpaired.

[color=%passive%][u]Passive:[/u][/color]
• If you start your turn adjacent to an enemy, automatically dash to the closest tile available that isn't within an enemy Zone of Control.

• This dash costs [color=%positive%]4[/color] AP, with each other Cloth Armor Tree perk reducing the cost by [color=%negative%]1[/color] to a minimum of [color=%positive%]1[/color] AP.

• Does not trigger if you are rooted unless you have the [color=%skill%]Escape Artist[/color] perk.
";

::Const.Strings.PerkName.SsuArmorMasteryLight <- "Light Armor Mastery";

::Const.Strings.PerkDescription.SsuArmorMasteryLight <- @"
The ability to move swiftly can seem almost like a dance if done by a true master.

[color=%passive%][u]Passive:[/u][/color]
• Fatigue costs are reduced by up to [color=%positive%]25%[/color]. This bonus drops exponentially when wearing head and body Armor with a total penalty to Maximum Fatigue above 15.
";

::Const.Strings.PerkName.SsuArmorMasteryMedium <- "Medium Armor Mastery";

::Const.Strings.PerkDescription.SsuArmorMasteryMedium <- @"
Straps and belts, the crux of any armor. Knowing how to stay flexible while bound up is what seperates the wheat from the chaff.

[color=%passive%][u]Passive:[/u][/color]
• Grants additional Fatigue recovery and Ranged Defense equal to your current Initiative divided by your Armor's total weight, up to a maximum of [color=%positive%]+5[/color].

• This bonus only applies when your Initiative is higher than three times your Armor's total weight, and drops to zero if the total Fatigue penalty is outside the range of [color=%negative%]20[/color] to [color=%negative%]40[/color].
";

::Const.Strings.PerkName.SsuArmorMasteryHeavy <- "Heavy Armor Mastery";

::Const.Strings.PerkDescription.SsuArmorMasteryHeavy <- @"
You've learnt how to shift the substantial weight that your Armor has from a hinderance to an advantage.

[color=%passive%][u]Passive:[/u][/color]
• Removes the penalties and [color=%positive%]doubles[/color] the Hitpoint mitigation effect applied by Heavy Armor [color=%status%]Encumbrance[/color].
";

::Const.Strings.PerkName.SsuClarity <- "Stoic Focus";

::Const.Strings.PerkDescription.SsuClarity <- @"
Patience is the key to understanding the world around you.

[color=%passive%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Clarity[/color] skill which grants [color=%positive%]+2[/color] Action Points the following turn and [color=%positive%]+1[/color] action point the turn after that.

• Does not work if you are [color=%status%]Dazed[/color], [color=%status%]Drunk[/color], [color=%status%]Hungover[/color], [color=%status%]Taunted[/color], [color=%status%]Staggered[/color], [color=%status%]Horrified[/color], [color=%status%]Concussed[/color], [color=%status%]Fleeing[/color], or over [color=%negative%]50%[/color] Fatigued.

• Costs [color=%negative%]0[/color] AP and [color=%negative%]5[/color] Fatigue.
";

::Const.Strings.PerkName.SsuSignaturemove <- "Signature Move";

::Const.Strings.PerkDescription.SsuSignaturemove <- @"
[color=%negative%][u]Requires:[/u] Melee Damage[/color]
Learn to take advantage of your weapon's momentum!

[color=%passive%][u]Passive:[/u][/color]
• The first connecting attack each turn has its Fatigue cost reduced based on the AP cost of the attack:
2 AP : [color=%negative%]40%[/color] Fatigue Reduction
3 AP : [color=%negative%]30%[/color] Fatigue Reduction
4+ AP : [color=%negative%]20%[/color] Fatigue Reduction

• Your subsequent attacks gain additional damage based on AP cost:
2 AP : [color=%positive%]+30%[/color] Damage
3 AP : [color=%positive%]+22.5%[/color] Damage
4+ AP : [color=%positive%]+15%[/color] Damage

• If your first attack connects and doesn't cost any AP, then the follow-up attack will gain an additional [color=%positive%]+10%[/color] hitchance instead.
";

::Const.Strings.PerkName.SsuBravery <- "Once More Into the Breach";

::Const.Strings.PerkDescription.SsuBravery <- @"
Summon unwavering courage in the face of adversity, enhancing your combat prowess as your morale wavers or breaks.

[color=%passive%][u]Passive:[/u][/color]
• When Morale state is [color=%status%]Wavering[/color] increase Resolve, Ranged Skill, Melee Skill, Melee Defense, and Ranged Defense by [color=%positive%]22%[/color].

• When Morale state is [color=%status%]Breaking[/color] increase Resolve, Ranged Skill, Melee Skill, Melee Defense, and Ranged Defense by [color=%positive%]38%[/color].

• When Morale state is [color=%status%]Fleeing[/color] increase Resolve, Ranged Skill, Melee Skill, Melee Defense, and Ranged Defense by [color=%positive%]57%[/color].
";

::Const.Strings.PerkName.SsuInitiative <- "In Delay, There Lies No Plenty";

::Const.Strings.PerkDescription.SsuInitiative <- @"
Harness the power of quick reflexes.

[color=%passive%][u]Passive:[/u][/color]
• [color=%positive%]Double[/color] your Initiative value when determining turn order.

• Also grants immunity to [color=%status%]Staggered[/color].
";

::Const.Strings.PerkName.SsuHitpoints <- "Too Stubborn to Die";

::Const.Strings.PerkDescription.SsuHitpoints <- @"
Embrace your indomitable spirit.

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]0.75%[/color] damage reduction for every [color=%negative%]1%[/color] of missing Hitpoints.
";

::Const.Strings.PerkName.SsuStamina <- "Cycled Breathing";

::Const.Strings.PerkDescription.SsuStamina <- @"
Master your breath to transform fatigue into adrenaline.

[color=%passive%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Unceasing Mysteries[/color] skill which allows you to gain a stacking increase to Action Points every round.

• Each time you use this skill increase Action Points gained by [color=%positive%]+1[/color] up to a maximum of [color=%positive%]9[/color] and increase Fatigue cost by [color=%negative%]5[/color].

• Also unlocks the [color=%skill%]Recover[/color] skill.

• Costs [color=%negative%]0[/color] AP and [color=%negative%]10[/color] Fatigue.
";

::Const.Strings.PerkName.SsuMeleeskill <- "Unpredictible Attacker";

::Const.Strings.PerkDescription.SsuMeleeskill <- @"
Confound your foes with deceptive strikes.

[color=%passive%][u]Passive:[/u][/color]
• When attacking a target, you follow-up with a quick attack that deals [color=%positive%]20%[/color] total damage of the initial attack.
";

::Const.Strings.PerkName.SsuRangedskill <- "The Ace of Aces";

::Const.Strings.PerkDescription.SsuRangedskill <- @"
Boom, headshot.

[color=%passive%][u]Passive:[/u][/color]
• When using ranged weapons, gain a bonus [color=%positive%]+5%[/color] chance to hit the head.

• Additionally, for every ranged enemy that you kill, gain a permanent [color=%positive%]+1%[/color] to that chance.
";

::Const.Strings.PerkName.SsuRangeddefense <- "Evasive Maneuvers";

::Const.Strings.PerkDescription.SsuRangeddefense <- @"
Increased reaction speed helps you avoid being inflicted by negative effects.

[color=%passive%][u]Passive:[/u][/color]
• Most Negative effects will have a seperate roll against your Ranged Defense before applying to you.

• These Negative effect include: [color=%status%]Charm[/color], [color=%status%]Hexed[/color], [color=%status%]Bleeding[/color], [color=%status%]Dazed[/color], [color=%status%]Disarmed[/color], [color=%status%]Distracted[/color], [color=%status%]Poisons[/color], [color=%status%]Horrified[/color], [color=%status%]Insect Swarm[/color], [color=%status%]Baffled[/color], [color=%status%]Staggered[/color], [color=%status%]Stunned[/color], [color=%status%]Withered[/color], and [color=%status%]Netted[/color].
";

::Const.Strings.PerkName.SsuRetrofithooks <- "Retrofitted Hooks";

::Const.Strings.PerkDescription.SsuRetrofithooks <- @"
Pull your enemy closer!

[color=%passive%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Hook[/color] skill when you are wielding a reach weapon, which allows you to pull your target one tile towards you.

• If your weapon already has this skill, then it will cost [color=%negative%]20%[/color] less Fatigue and gain an additional [color=%positive%]+10%[/color] chance to hit.
";

::Const.Strings.PerkName.SsuIrresistibleimpulse <- "Irresistible Impulse";

::Const.Strings.PerkDescription.SsuIrresistibleimpulse <- @"
Embrace the adrenaline, and feel it course through your veins!

[color=%passive%][u]Passive:[/u][/color]
• Each time you use the [color=%skill%]Adrenaline[/color] skill, gain [color=%positive%]+6[/color] Fatigue recovery, [color=%positive%]+5[/color] Melee Skill, [color=%positive%]+5%[/color] damage, and make enemies [color=%positive%]25%[/color] more likely to target you until the end of your next turn.
";

::Const.Strings.PerkName.SsuAudaciouscharge <- "Audacious Charge";

::Const.Strings.PerkDescription.SsuAudaciouscharge <- @"
Charge forward with all your might!

[color=%passive%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Audacious Charge[/color] skill which allows you to Charge towards a tile up to two tiles away, [color=%status%]Stagger[/color] a random enemy adjacent to that tile, then perform a free attack against them dealing [color=%positive%]50%[/color] of your main-hand weapon damage, or [color=%positive%]75%[/color] with the [color=%perk%]Grand Slam[/color] perk.

• If the target was already [color=%status%]Staggered[/color] or [color=%status%]Dazed[/color], inflict [color=%status%]Stun[/color].

• Cannot be used when engaged in melee, or used to pass through enemy zones of control.

• Picking this perk will also add [color=%perk%]Furinkazan[/color] to your perk tree, which can reduce the cost of [color=%skill%]Audacious Charge[/color].

• Costs [color=%negative%]4[/color] AP and [color=%negative%]25[/color] Fatigue. 
";

::Const.Strings.PerkName.SsuBattlerhaposdy <- "Battle Rhapsody";

::Const.Strings.PerkDescription.SsuBattlerhaposdy <- @"
Harmonize your movements and attacks to create a deadly performance that leaves your enemies in awe and disarray.

[color=%passive%][u]Passive:[/u][/color]
• Every successful attack provides a stacking effect which increases Melee Skill, Ranged Skill and Initiative by [color=%positive%]+2[/color].

• Your Action Points are increased by a total of [color=%positive%]+1[/color] at 3 stacks, [color=%positive%]+2[/color] at 6 stacks and [color=%positive%]+3[/color] at 10 stacks.

• Attacks performed against enemies which aren't adjacent only grant a stack after two successful hits.

• You lose half of the stacks if you miss an attack or if you get hit.

• Cannot have more than 10 stacks.
";

::Const.Strings.PerkName.SsuPerseverance <- "Perseverance";

::Const.Strings.PerkDescription.SsuPerseverance <- @"
Learn to persevere in the face of adversity.

[color=%passive%][u]Passive:[/u][/color]
• Damage to health is reduced by up to [color=%negative%]60%[/color] based on how much base damage is dealt to you.

• If an attack triggers over [color=%negative%]20%[/color] damage reduction, half of the damage that was ignored will be converted to a [color=%status%]Bleed[/color] that will last for two turns.

• Damage reduction calculation: For every [color=%positive%]5[/color] points of damage exceeding 25, gain one iteration that increments damage reduction by [color=%positive%]+0.5%[/color], capping at [color=%positive%]3.0%[/color]. Final damage reduction is equal to the sum percentage of all increments.
";

::Const.Strings.PerkName.SsuTic <- "Thriving in Chaos";

::Const.Strings.PerkDescription.SsuTic <- @"
Learn to master the chaos of battle.

[color=%passive%][u]Passive:[/u][/color]
• Always set morale state to [color=%status%]Wavering[/color] at start of each turn.

• Gain [color=%positive%]+5[/color] Melee Skill for each negative status effect you have, such as [color=%status%]Dazed[/color], [color=%status%]Staggered[/color], [color=%status%]Poisoned[/color], [color=%status%]Debilitated[/color] and [color=%status%]Bleeding[/color].

• Gain [color=%positive%]+5[/color] Melee Defense for every Injury you have, including permament ones.

• Gain [color=%positive%]+5[/color] Resolve for every [color=%negative%]33%[/color] of missing Hitpoints.

• Gain [color=%positive%]+5[/color] Initiative for every [color=%negative%]33%[/color] of accumulated Fatigue.

• If all the above conditions are met at least once, gain an additional [color=%positive%]+15%[/color] total damage and damage reduction.
";

::Const.Strings.PerkName.SsuNavigator <- "Navigator";

::Const.Strings.PerkDescription.SsuNavigator <- @"
Share your expertise in navigation with your allies.

[color=%passive%][u]Passive:[/u][/color]
• Grant [color=%perk%]Pathfinder[/color] to all allies adjacent to you at both the start and the end of your turn as long as you are not engaged in melee.
";

::Const.Strings.PerkName.SsuIronsideweak <- "Iron-hide";

::Const.Strings.PerkDescription.SsuIronsideweak <- @"
Thrive in the worst of conditions.

[color=%passive%][u]Passive:[/u][/color]
• All damage received is reduced by [color=%negative%]-3.3%[/color] for each adjacent opponent, up to a maximum of [color=%negative%]-20%[/color] damage reduction.
";

::Const.Strings.PerkName.SsuBruiser <- "Bruiser";

::Const.Strings.PerkDescription.SsuBruiser <- @"
Learn to beat down your opponents.

[color=%passive%][u]Passive:[/u][/color]
• Gain scaling buffs to Fatigue and Armor damage based on the damage from your Mainhand weapon. Every [color=%positive%]2[/color] points of maximum damage grants and additional [color=%positive%]+1%[/color] Armor damage and [color=%positive%]+6%[/color] Fatigue damage.
";

::Const.Strings.PerkName.SsuTrumpcard <- "Trump Card";

::Const.Strings.PerkDescription.SsuTrumpcard <- @"
This character is quick to understand the fighting style of their opponents, getting better at fighting them as the combat draws on.

[color=%passive%][u]Passive:[/u][/color]
• Your first melee attack against each enemy, hit or miss, applies a stack of [color=%status%]Distracted[/color] to them.

• [color=%status%]Distracted[/color] enemies have their Melee Skill and Ranged Skill reduced by [color=%negative%]5%[/color], [color=%negative%]15%[/color], [color=%negative%]30%[/color] or [color=%negative%]50%[/color] with one, two, three or four stacks, and lose a stack at the start of each of their turns.
";

::Const.Strings.PerkName.SsuHonorheritage <- "Honoured Heritage";

::Const.Strings.PerkDescription.SsuHonorheritage <- @"
Your optimism has its benefits.

[color=%passive%][u]Passive:[/u][/color]
• Gain a [color=%positive%]35%[/color] chance to increase your morale by one stage at the end of each turn.
";

::Const.Strings.PerkName.SsuBlocknormal <- "Block Training";

::Const.Strings.PerkDescription.SsuBlocknormal <- @"
You have learned to block blows with your weapon.

[color=%passive%][u]Passive:[/u][/color]
• Whenever you are attacked by an adjacent opponent, they roll the attack a second time against your Melee Skill.

• On a success, you receive only [color=%negative%]40%[/color] of the attack's damage. Otherwise gain between [color=%positive%]0-20%[/color] damage reduction based on the result.
";

::Const.Strings.PerkName.SsuBlockskilled <- "Skilled Blocker";

::Const.Strings.PerkDescription.SsuBlockskilled <- @"
You have become skilled in blocking blows with your weapon.

[color=%passive%][u]Passive:[/u][/color]
• Whenever you are attacked by an adjacent opponent, they roll the attack a second time against your Melee Skill.

• On a success, you receive only [color=%negative%]35%[/color] of the attack's damage. Otherwise gain between [color=%positive%]0-30%[/color] damage reduction based on the result.
";

::Const.Strings.PerkName.SsuBlockmaster <- "Master Blocker";

::Const.Strings.PerkDescription.SsuBlockmaster <- @"
You have mastered blocking blows with your weapon.

[color=%passive%][u]Passive:[/u][/color]
• Whenever you are attacked by an adjacent opponent, they roll the attack a second time against your Melee Skill.

• On a success, you receive only [color=%negative%]30%[/color] of the attack's damage. Otherwise gain between [color=%positive%]0-40%[/color] damage reduction based on the result.
";

::Const.Strings.PerkName.SsuDiscipline <- "Discipline";

::Const.Strings.PerkDescription.SsuDiscipline <- @"
This character's senses are heightened when faced with mortal danger.

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]+10[/color] Melee Defence and [color=%positive%]5[/color] Ranged Defense each time you get hit by an attack.

• This bonus lasts until the start of your turn or until an attack misses against you.
";

::Const.Strings.PerkName.SsuRavager <- "Ravager";

::Const.Strings.PerkDescription.SsuRavager <- @"
Take advantage of the fear in their eyes.

[color=%passive%][u]Passive:[/u][/color]
• Gain a stacking buff to Melee and Ranged Skill when attacking an enemy with a lower morale state than yours, and gain an additional bonus based on their total Fatigue percentage.

• Gain [color=%positive%]+5[/color] melee skill and half that as ranged skill for each difference in morale tier, and an additional [color=%positive%]1[/color] for each 20% of their accumulated Fatigue.
";

::Const.Strings.PerkName.SsuRapidmarch <- "Rapid March";

::Const.Strings.PerkDescription.SsuRapidmarch <- @"
Teach your allies to move more efficiently.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Rapid March[/color] skill which targets an adjacent ally and reduces the AP cost for movement by [color=%negative%]1[/color] for each tile, but [color=%positive%]doubles[/color] the Fatigue cost.

• Costs [color=%negative%]3[/color] AP and [color=%negative%]10[/color] Fatigue.
";

::Const.Strings.PerkName.SsuReachadvantage <- "Reach Advantage";

::Const.Strings.PerkDescription.SsuReachadvantage <- @"
[color=%negative%][u]Requires:[/u] Two-Handed Melee Weapon[/color]
Learn to use the superior reach of large weapons to keep the enemy from getting close enough to land a good hit.

[color=%passive%][u]Passive:[/u][/color]
• Mark the enemies adjacent to you at the start of the turn, and gain [color=%positive%]+100%[/color] of your melee skill as melee defense against them until waiting or ending your turn.

• When attacked by a marked opponent, reduce incoming damage by [color=%negative%]80%[/color].

• You also prevent them from approaching your Zone of Control with a [color=%perk%]Spearwall[/color]-like attack which deals [color=%negative%]20%[/color] total damage.
";

::Const.Strings.PerkName.SsuAssistance <- "Assistance";

::Const.Strings.PerkDescription.SsuAssistance <- @"
[color=%negative%][u]Requires:[/u] Two-Handed Melee Weapon[/color]
Where one blow lands, yours is quick to follow.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Assistance[/color] skill which, until the start of your next turn, makes you perform a free attack against any enemy within your attack range that gets hit by an ally's melee attack.

• These attacks deal [color=%negative%]50%[/color] less damage.

• Can not be used, and does not trigger, while engaged in melee.

• Costs [color=%negative%]4[/color] AP and [color=%negative%]30[/color] Fatigue.
";

::Const.Strings.PerkName.SsuParthianshot <- "Parthian Shot";

::Const.Strings.PerkDescription.SsuParthianshot <- @"
[color=%negative%][u]Requires:[/u] Ranged Weapon[/color]
Master the ancient tactic of the Parthian Shot, allowing you to make a precise ranged attack while retreating, catching your enemies off guard and striking fear into their ranks.

[color=%passive%][u]Passive:[/u][/color]
• Damage penetration and Damage to Hitpoints are increased by [color=%positive%]+2%[/color] of your remaining Action Points.

• The first tile moved each turn costs no Action Points and refunds its Fatigue cost, regardless of terrain, height or other movement penalties.
";

::Const.Strings.PerkName.SsuDryadSummonWolf <- "Call Verdant Hound";

::Const.Strings.PerkDescription.SsuDryadSummonWolf <- @"
[color=%negative%][u]Requires:[/u] Heart of the Forest[/color]
Call upon your loyal Greenwood companions!

[color=%passive%][u]Active:[/u][/color]
• Unlocks an active skill which summons a 'Verdant Hound', a nimble creature which can flank and harrass the enemy with its superior agility.

• Each use consumes a single charge of the 'Heart of the Forest'.

• Costs [color=%negative%]4[/color] AP and [color=%negative%]20[/color] Fatigue.
";

::Const.Strings.PerkName.SsuDryadSummonSnake <- "Conjure Thicket Stalker";

::Const.Strings.PerkDescription.SsuDryadSummonSnake <- @"
[color=%negative%][u]Requires:[/u] Heart of the Forest[/color]
Conjurer one among the deadliest of Greenwood predators!

[color=%passive%][u]Active:[/u][/color]
• Unlocks an active skill which summons a 'Thicket Stalker', a deadly assassin which can bind and harass even the hardiest of opponents.

• Each use consumes a single charge of the 'Heart of the Forest'.

• Costs [color=%negative%]5[/color] AP and [color=%negative%]30[/color] Fatigue.
";

::Const.Strings.PerkName.SsuDryadSummonUnhold <- "Beckon Woodland Protector";

::Const.Strings.PerkDescription.SsuDryadSummonUnhold <- @"
[color=%negative%][u]Requires:[/u] Heart of the Forest[/color]
Beckon forth the stalwart defenders of the Greenwoods!

[color=%passive%][u]Active:[/u][/color]
• Unlocks an active skill which summons a 'Woodland Protector', an ironbark bulwark which can break even the most resilient of shieldwalls.

• Each use consumes three charges of the 'Heart of the Forest'.

• Costs [color=%negative%]7[/color] AP and [color=%negative%]40[/color] Fatigue.
";

::Const.Strings.PerkName.SsuDryadSummonLindwurm <- "Summon Forest Avatar";

::Const.Strings.PerkDescription.SsuDryadSummonLindwurm <- @"
[color=%negative%][u]Requires:[/u] Heart of the Forest[/color]
Summons the living culmination of all the anger the Greenwoods can bring to bear!

[color=%passive%][u]Active:[/u][/color]
• Unlocks an active skill which summons a 'Forest Avatar', the most powerful denizen of the Greenwoods, one which will surely bring to your foes all the fury that your wrath entails.

• Each use consumes all five charges of the 'Heart of the Forest'.

• Costs [color=%negative%]9[/color] AP and [color=%negative%]50[/color] Fatigue.
";

::Const.Strings.PerkName.SsuDryadForestBlessing <- "Blessing of the Forest";

::Const.Strings.PerkDescription.SsuDryadForestBlessing <- @"
[color=%negative%][u]Requires:[/u] Heart of the Forest[/color]
Awaken the Greenwoods beastial nature and let your foes fertilize your home!

[color=%passive%][u]Active:[/u][/color]
• Unlocks an active skill to buff a single ally granting them increased damage and combat ability.

• Each use consumes a single charge of the 'Heart of the Forest'.

• Costs [color=%negative%]7[/color] AP and [color=%negative%]30[/color] Fatigue.
";

::Const.Strings.PerkName.SsuDryadNaturalRegrowth <- "Natural Regrowth";

::Const.Strings.PerkDescription.SsuDryadNaturalRegrowth <- @"
[color=%negative%][u]Requires:[/u] Heart of the Forest[/color]
Bring to your allies the gentle touch of the forest!

[color=%passive%][u]Active:[/u][/color]
• Unlocks an active skill to heal a single ally and cure them of any temporary injuries.

• Each use consumes a single charge of the 'Heart of the Forest'.

• Costs [color=%negative%]2[/color] AP and [color=%negative%]15[/color] Fatigue.
";

::Const.Strings.PerkDescription.LegendAthlete = @"
A training a day keeps the exhaustion away.

[color=%passive%][u]Passive:[/u][/color]
• Reduce the Fatigue cost of all your skills and movement by a percentage equal to [color=%negative%]20%[/color] of your maximum usable Fatigue after gear weight is accounted for.

• Picking the perk will also add [color=%perk%]Furinkazan[/color] to your perk map.
";

::Const.Strings.PerkDescription.LegendSmackdown = @"
Use your size and strength to bully your way into a prime position.

[color=%passive%][u]Passive:[/u][/color] 
• Effectiveness vs Armor is increased by [color=%positive%]+20%[/color]. The bonus is increased to [color=%positive%]+30%[/color] for Two-Handed Weapons.

[color=%passive%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Wind Up[/color] skill which prepares your next attack to [color=%status%]Knock Back[/color] and [color=%status%]Baffle[/color] your target on hit.
• [color=%status%]Baffled[/color] enemies suffer [color=%negative%]-15%[/color] Damage, Fatigue, and Initiative.

• Additionally, on hit, reduce targets AP by [color=%negative%]2[/color] for two turns.

• Costs [color=%negative%]2[/color] AP and [color=%negative%]15[/color] Fatigue.

• AP cost is reduced to [color=%negative%]1[/color] if wielding a Two-Handed Melee weapon. Works only with melee weapons, unarmed attacks and one handed slings. With one handed slings it will grant the [color=%skill%]Prepare Bullet[/color] effect.
";

::Const.Strings.PerkDescription.LegendLastStand = @"
'This is the hill that you will NOT die on!'

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]+1[/color] additional Melee and Ranged Defense for every [color=%negative%]2%[/color] of missing Hitpoints below [color=%negative%]66%[/color]

• Gain [color=%positive%]+1[/color] additional Action Points for every [color=%negative%]20%[/color] of missing Hitpoints.

• When below [color=%negative%]44%[/color] Hitpoints this character becomes immune to the effects of subsequent injuries, and morale is no longer affected by health loss.
";

::Const.Strings.PerkDescription.HoldOut = @"
Keep it together!

[color=%passive%][u]Passive:[/u][/color]
• Grants [color=%positive%]+8[/color] Hitpoints.

• Any negative status effect with a finite duration (e.g., [color=%status%]Bleeding[/color], [color=%status%]Charmed[/color]) has its duration reduced to one turn.

• Status effects that have their effects grow weaker over several turns (e.g., Goblin [color=%status%]Poison[/color]) are at their weakest state from the start.

• Grants a [color=%negative%]25%[/color] reduction to the effect of all negative status effects.

• Raises the chance to survive being struck down and not killed from [color=%negative%]33%[/color] to [color=%positive%]66%[/color].

• Allows the use of a second Sequence without negative effects.
";

::Const.Strings.PerkDescription.Indomitable = @"
'Mountains cannot be moved, nor taken down!'

[color=%passive%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Indomitable[/color] skill which grants a [color=%negative%]50%[/color] damage reduction, as well as immunity to being [color=%status%]Stunned[/color], [color=%status%]Knocked Back[/color], [color=%status%]Grabbed[/color], or [color=%status%]Swallowed[/color] for one turn.

• Base Resolve is [color=%positive%]doubled[/color] until the effect ends.
• Costs [color=%negative%]5[/color] AP and [color=%negative%]25[/color] Fatigue.
";

::Const.Strings.PerkDescription.LegendTwirl = @"
Practice in physical movement with a partner has given the ability to take the lead and move someone's body in a twirling movement.

[color=%passive%][u]Passive:[/u][/color]
 • The [color=%skill%]Rotation[/color] skill can now target enemies as well as allies. If you don't have [color=%perk%]Rotation[/color], taking this perk will grant you it for as long as you have this perk.

• Picking the perk will also add [color=%perk%]Furinkazan[/color] to your perk map, which reduces the cost of [color=%skill%]Rotation[/color].

• Costs [color=%negative%]3[/color] AP and [color=%negative%]25[/color] Fatigue.
";

::Const.Strings.PerkDescription.QuickHands = @"
Looking for this?

[color=%passive%][u]Passive:[/u][/color]
• Swapping an item in battle becomes a free action with no Action Point cost, once every turn.

• Does not work when swapping a Shield.
";

::Const.Strings.PerkDescription.LegendMuscularity = @"
[color=%negative%][u]Requires:[/u] Melee or Throwing Weapon Attack[/color]
Put your full weight into every blow!

[color=%passive%][u]Passive:[/u][/color]
• Gain additional Minimum and Maximum Damage based on your current Hitpoints. 

• The bonus is [color=%positive%]1.5%[/color] of your current Hitpoints per AP for attacks with a base Action Point cost of 5 or less, and [color=%positive%]2%[/color] per AP for attacks with a base Action Point cost of 6 or more.

• The factor is reduced to [color=%negative%]60%[/color] for weapons that have a range of more than one tile and [color=%negative%]80%[/color] for Daggers and Goblin Swords.

• The bonus damage cannot be higher than [color=%positive%]40[/color] for attacks with a base Action cost of 5 or less and [color=%positive%]60[/color] for attacks with base AP cost of 6 or more.
";

::Const.Strings.PerkDescription.Overwhelm = @"
Learn to take advantage of your initiative and prevent the enemy from attacking effectively by overwhelming them with your attacks!

[color=%passive%][u]Active/Passive:[/u][/color]
• With every attack, hit or miss, against an opponent that acts after you in the current round, inflict [color=%status%]Overwhelmed[/color] which lowers both Melee and Ranged Skill by [color=%negative%]-5%[/color] for one turn.

• The effect stacks with each attack, up to a maximum of 7 times, and can be applied to multiple targets at once with a single attack.

• Additionally, unlocks the [color=%skill%]Quick Feint[/color] skill which allows you to apply [color=%status%]Overwhelmed[/color] to 4 adjacent targets, and can be used every other turn.

• Costs [color=%negative%]1[/color] AP and [color=%negative%]5[/color] Fatigue.
";

::Const.Strings.PerkDescription.LegendBattleheart = @"
Wade into the thick of battle, dodging blades from behind and above, aware of all around you at the heart of the battle.

[color=%passive%][u]Passive:[/u][/color]
• Being surrounded no longer affects this character's Defenses at all.

• Upgraded version of [color=%perk%]Ironside[/color], immune to [color=%perk%]Backstabber[/color].
";

::Const.Strings.PerkDescription.Underdog = @"
I'm used to it.

[color=%passive%][u]Passive:[/u][/color]
• The defense malus due to being surrounded by opponents is reduced by [color=%negative%]5[/color].
";

::Const.Strings.PerkDescription.SunderingStrikes = @"
Learn how to strike best at your targets' Armor to destroy it as fast as possible.

[color=%passive%][u]Passive:[/u][/color]
• Effectiveness against Armor is increased by [color=%positive%]20%[/color] of your weapon's Armor effectiveness.

• The bonus is increased to [color=%positive%]30%[/color] for Two-Handed Weapons.

• When unarmed, effectiveness against Armor is increased by [color=%positive%]20%[/color].
";

::Const.Strings.PerkDescription.LegendShieldsUp = @"
Drilling your troops in a shieldwall prepares their reaction time to avoid early deaths on the battlefield.

[color=%passive%][u]Passive:[/u][/color]
• Taking this perk ensures every mercenary with a shield will use [color=%skill%]Shieldwall[/color] or [color=%skill%]Fortify[/color] before the start of each battle.
";

::Const.Strings.PerkDescription.LegendSlaughterer = @"
A gruesome display, enemies are more likely to lose morale when they witness their allies get split in two.

[color=%passive%][u]Passive:[/u][/color]
• Melee kills are always fatalities.

• Fatalities have a [color=%negative%]-15[/color] penalty to enemy Resolve checks.

• Having the 'Bloodthirsty' trait allows you to trigger an additional positive morale check when killing an enemy.
";

::Const.Strings.PerkDescription.LegendCheerOn = @"
[color=%negative%][u]Requires:[/u] Instrument or Banner[/color]
Use your way with song to cheer on an ally!

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Cheer On[/color] skill which grants [color=%positive%]+2[/color] Action Points to an ally within [color=%positive%]2[/color] tiles.

• Costs [color=%negative%]3[/color] AP and [color=%negative%]10[/color] Fatigue.
";

::Const.Strings.PerkDescription.LegendInTheZone = @"
Use your Armor's blend of protection and mobility to punish your foes mistakes!

[color=%passive%][u]Passive:[/u][/color]
• Gain a stacking buff that boosts your Melee Skill and Melee Damage by [color=%positive%]0.5%[/color] up to a maximum of [color=%positive%]10%[/color].

• Gain [color=%positive%]0.5%[/color] when you dodge a Melee attack and lose [color=%positive%]1%[/color] when you get hit by any attack.

• When engaged in Melee, the Melee Damage bonus is doubled, up to a maximum of [color=%positive%]20%[/color], and the Melee Skill bonus is converted into Melee Defense instead.

• If your Initiative is higher than twice your combined body and head Armor's penalty to Maximum Fatigue, you start the battle with stacks equal to your Armor's weight above 15.
";

::Const.Strings.PerkDescription.LegendRebound = @"
Surpass your limits!

[color=%passive%][u]Passive:[/u][/color]
• Fatigue regeneration is increased by [color=%positive%]+5[/color] while over 75% fatigued.
";

::Const.Strings.PerkDescription.FastAdaption = @"
Adapt to your opponent's moves!

[color=%passive%][u]Passive:[/u][/color]
• Gain an additional stacking [color=%positive%]+20%[/color] chance to hit with each attack that misses an opponent.

• Upon landing a hit, the character will also recover 1 Action Point for every stack up to a maximum of 3 and the bonus will be reset. The refund cannot exceed the maximum Action Points.
";

::Const.Strings.PerkDescription.Fearsome = @"
Make them scatter and flee!

[color=%passive%][u]Passive:[/u][/color]
• Any attack that inflicts at least [color=%positive%]1[/color] point of damage to hitpoints triggers a morale check for the opponent with a penalty equal to [color=%negative%]20%[/color] of your current Resolve.

• A kill [color=%positive%]triples[/color] this effect for your next attack, but if you miss the effect will be wasted.

•[color=%negative%] Does not trigger multiple times from the same attacker on the same target from a single attack[/color].
";

::Const.Strings.PerkDescription.Adrenaline = @"
Seize the initiative!

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Adrenaline[/color] skill which puts you first in the turn order for the next round, allowing you another turn before your enemies.

• Additionally adds [color=%perk%]Irresistible Impulse[/color] to your perk map, which grants additional benefits when using [color=%skill%]Adrenaline[/color].

• Costs [color=%negative%]1[/color] AP and [color=%negative%]20[/color] Fatigue.
";

::Const.Strings.PerkDescription.ReachAdvantage = @"
Learn to use the superior reach of large weapons to keep the enemy from getting close enough to land a good hit.

[color=%passive%][u]Passive:[/u][/color]
• Each hit with a Two-Handed melee weapon adds a stack of [color=%perk%]Reach Advantage[/color] which increases your Melee Defense by [color=%positive%]+5[/color], up to a maximum of [color=%positive%]5[/color] stacks.

• A single attack hitting multiple targets can add several stacks at once.

• Lose half of your stacks, at least [color=%negative%]1[/color], at the start of your turn.

• If you put away your weapon, you lose all stacks.

• Additionally, while wielding a staff, the defense malus due to being surrounded by opponents is reduced by [color=%positive%]3[/color]. If you have [color=%perk%]Ironside[/color] or [color=%perk%]Battleheart[/color], this perk will instead increase defenses by [color=%positive%]5[/color].
";

::Const.Strings.PerkDescription.Footwork = @"
Work those feet!

[color=%passive%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Footwork[/color] skill which allows you to leave a Zone of Control without triggering free attacks by using skillful footwork.

• The Fatigue Cost of the skill increases by [color=%positive%]1[/color] for every 1 point of total penalty to maximum Fatigue from head and body Armor above 15, up to a maximum Fatigue Cost of [color=%negative%]20[/color].

• Picking the perk will also add [color=%perk%]Furinkazan[/color] to your perk map, which reduces the cost of [color=%skill%]Footwork[/color].

• Costs [color=%negative%]3[/color] AP and [color=%negative%]10[/color] Fatigue.
";

::Const.Strings.PerkDescription.Rotation = @"
Just like dancing with your nan when you were young.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Rotation[/color] skill which allows two characters to switch places while ignoring Zone of Control, as long as neither character is [color=%status%]Stunned[/color], [color=%status%]Rooted[/color] or otherwise disabled.

• Picking this perk will also add [color=%perk%]Furinkazan[/color] to your perk map, which reduces the cost of [color=%skill%]Rotation[/color]

• Costs [color=%negative%]3[/color] AP and [color=%negative%]25[/color] Fatigue.
";

::Const.Strings.PerkDescription.LegendEvasion = @"
'Excuse me'

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Evasion[/color] skill which enables this character to move swiftly and safely through any Zone of Control for the next whole turn without incurring any free attacks. The first attack against you will be an automatic miss.

• Can only be used if your total armor weight is [color=%negative%]30[/color] or less.

• Picking this perk will also add [color=%perk%]Furinkazan[/color] to your perk map, which reduces the cost of [color=%skill%]Evasion[/color]

• Costs [color=%negative%]4[/color] AP and [color=%negative%]30[/color] Fatigue.
";

::Const.Strings.PerkDescription.LegendBalance = @"
Gain increased defense by balancing your Armor's weight and mobility.

[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]+10[/color] Ranged Defense when wearing head and body Armor with a total weight of 15 or less.

• Convert [color=%negative%]1[/color] Ranged Defense to Melee Defense for every 2 points that you exceed this value, but reduce the conversion by [color=%negative%]1[/color] for every 10 points that your Current Initiative is below twice your total Armor weight.

• Gain a third of the converted Melee Defense bonus back as Ranged Defense.

• The penalty to Initiative from your accumulated Fatigue is also reduced by [color=%positive%]30%[/color].
";

::Const.Strings.PerkDescription.LegendLithe = @"
Specialize in Medium Armour! Not as nimble as some but more lithe than others!

[color=%passive%][u]Passive:[/u][/color]
• Damage to Hitpoints and Armor are reduced by [color=%positive%]25%[/color] when the total penalty to Maximum Fatigue from head and body Armor is between [color=%negative%]25[/color] and [color=%negative%]35[/color].

• Outside this range, the bonus drops exponentially.
";

::Const.Strings.PerkDescription.SpecThrowing = @"
Master throwing weapons to wound or kill the enemy before they even get close.

[color=%passive%][u]Passive:[/u][/color]
• Skills build up [color=%negative%]25%[/color] less Fatigue.

• Gain [color=%positive%]20%[/color] of your Ranged Skill as additional Armor penetration and [color=%positive%]25%[/color] of your Melee Skill as additional Armor effectiveness when attacking at a distance of three tiles or less.

• Throwing Spear now ignores the damage reduction from [color=%perk%]Shield Expert[/color].
";

::Const.Strings.PerkDescription.Bullseye = @"
Nailed it!

[color=%passive%][u]Passive:[/u][/color]
• The penalty to hitchance when shooting at a target you have no clear line of fire to is reduced from [color=%negative%]75%[/color] to [color=%negative%]25%[/color] for any ranged weapons and [color=%skill%]Aimed Shot[/color] will not have a penalty at all.

• This Character's Vision is increased by [color=%positive%]+1[/color].

• Unlocks the [color=%skill%]Mark Target[/color] skill.

• Costs [color=%negative%]2[/color] AP and [color=%negative%]15[/color] Fatigue.
";

::Const.Strings.PerkDescription.LegendNetCasting = @"
Always keep a net handy!

[color=%passive%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Throw Portable Net[/color] skill which allows you to throw a makeshift net once per battle.

• Increases the range of all nets by [color=%positive%]2[/color] tiles and the range of bombs and flasks by [color=%positive%]1[/color] tile.

• Chance based on your Ranged Skill and Ranged Defense to trap additional adjacent targets when using [color=%skill%]Throw Net[/color]. The chance decreases with each target you ensnare.

• Costs [color=%negative%]4[/color] AP and [color=%negative%]25[/color] Fatigue.
";

::Const.Strings.PerkDescription.LegendMasteryNets = @"
You've learned advanced net throwing techniques.

[color=%passive%][u]Passive:[/u][/color]
• Reduce the Fatigue cost of [color=%skill%]Throw Net[/color] by [color=%negative%]25%[/color] and the AP cost by [color=%negative%]1[/color].

• [color=%skill%]Throw Net[/color] is more likely to hit.

• Grants [color=%positive%]+10[/color] Melee Defense while holding a net.

• Can now double grip with a net in your offhand and unlocks Hand to Hand abilities that might be locked from holding a net in offhand.
";

::Const.Strings.PerkDescription.LegendEscapeArtist = @"
Others see it as magic, but your deft hands know better.

[color=%passive%][u]Passive:[/u][/color]
• Grants a chance to dodge nets with Ranged Defense.

• At the start of your turn, perform a free [color=%skill%]Break Free[/color] action.

• Grants a baseline [color=%positive%]95%[/color] chance to break yourself free from [color=%status%]Rooting[/color] effects, such as Nets and Webs.

• Reduces the Action Point cost of breaking yourself and your allies free by [color=%negative%]1[/color] and the Fatigue cost by [color=%negative%]70%[/color].
";

::Const.Strings.PerkDescription.LegendDogHandling = @"
You have mastered the art of training dogs. In the heat of battle your hounds will respond and react to your commands.

[color=%passive%][u]Passive:[/u][/color]
• Grants each dog you unleash the [color=%perk%]Overwhelm[/color] perk.

• Increases the Melee Defense of unleashed dogs by [color=%positive%]5[/color].

• Unleashed dogs and wolves pick their fights more carefully, preferring targets they are more likely to hit, and become wary of charging into enemies using Spearwall.
";

::Const.Strings.PerkDescription.LegendDogWhisperer = @"
You have a way with dogs, the bond you form with them imbues each dog with more confidence and strength, knowing that you are there gives them strength.

[color=%passive%][u]Passive:[/u][/color]
• Grants each dog you unleash the [color=%perk%]Colossus[/color], [color=%perk%]Fortified Mind[/color], [color=%perk%]Underdog[/color], and [color=%perk%]Clarity[/color] perks.
";

::Const.Strings.PerkDescription.LegendThrowSand = @"
It's hard to fight with sand in your eyes.

[color=%passive%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Throw Dirt[/color] skill, which lets you throw dirt in the eyes of an enemy to [color=%status%]Distract[/color] them.

• [color=%status%]Distracted[/color] enemies have [color=%negative%]-35%[/color] Initiative and Block and deal [color=%negative%]-35%[/color] Damage.

• Costs [color=%negative%]3[/color] AP and [color=%negative%]5[/color] Fatigue.
";

::Const.Strings.PerkDescription.LegendDebilitate = @"
Ankles, hands, elbows and knees, you've learned how to fight dirty to secure victory.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Debilitate[/color] skill which primes your next attack to [color=%status%]Cripple[/color] a target for three turns, reducing their ability to inflict damage by [color=%negative%]-25%[/color] and increasing the damage they take by [color=%positive%]+15%[/color].

• Costs [color=%negative%]4[/color] AP and [color=%negative%]20[/color] Fatigue.
";

::Const.Strings.PerkDescription.Duelist = @"
Become one with your weapon and go for the weak spots!

[color=%passive%][u]Passive:[/u][/color]
• When holding a Buckler or Mummy Shield in your offhand, an extra [color=%positive%]+25%[/color] of damage ignores armor on Melee attacks.

• With the [color=%perk%]Grandslam[/color] perk, a further [color=%positive%]+20%[/color] of damage ignores armor with Two-Handed weapons, [color=%positive%]+10%[/color] with One-Handed weapons and [color=%positive%]+50%[/color] when Unarmed, also without a Buckler.

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Flourish[/color] skill, which increases the Fatigue cost of your attacks by [color=%negative%]75%[/color] and their AP cost by [color=%negative%]1[/color], but while you are faster than your target gives each attack a chance to ignore armor completely based on the Initiative difference.
";

::Const.Strings.PerkDescription.LegendConservation = @"
Conduct profane rituals meant to stave off the passage of time, further preserving the means of your craft.

[color=%passive%][u]Passive:[/u][/color]
• Reduces the daily medicine cost of maintaining Human Corpses, Bones, and other Carrion by [color=%negative%]50%[/color].
";

::Const.Strings.PerkDescription.LegendChainLightning = @"
Unleash an arcing barrage of lightning!

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=%skill%]Chain Lightning[/color] skill which inflicts damage to up to 3 enemies, dealing [color=%damage%]15-40[/color] damage which ignores armor.

• Requires a staff.

• Costs [color=%negative%]7[/color] AP and [color=%negative%]30[/color] Fatigue.

• If you have the [color=%perk%]Staff Mastery[/color] perk, reduce the AP cost by [color=%negative%]2[/color] and the Fatigue cost by [color=%negative%]25%[/color].
";

::Const.Strings.PerkDescription.LegendHoldTheLine = @"
'DON'T LET THEM BREAK THROUGH!'

[color=%active%][u]Active:[/u][/color]
• Unlocks the [color=#400080]Hold the Line[/color] skill which allows you to direct your troops to stand their ground, granting [color=%positive%]+10[/color] Melee and Ranged Defense and reducing the damage they take by [color=%positive%]10%[/color] to all allies within four tiles for one turn.

• Costs [color=%negative%]5[/color] AP and [color=%negative%]20[/color] Fatigue.
";

// perks whose description SSU sets, read by refreshStrings
::Mod_Sellswords.Strings.PerkDescriptions <- {
	SsuNecroZombieUndying = true,
	SsuNecroZombieFeasting = true,
	SsuNecroZombieInfectious = true,
	SsuNecroZombiePuppet = true,
	SsuNecroZombieFallenHero = true,
	SsuNecroSkeletonReconstruction = true,
	SsuNecroSkeletonHarden = true,
	SsuNecroMummyCursedBody = true,
	SsuNecroAncientKnowledge = true,
	SsuNecroMummyInsectBreath = true,
	SsuNecroGhostGhastlyTouch = true,
	SsuNecroGhostSpectralBody = true,
	SsuNecroGhostVanish = true,
	SsuNecroGhostPhase = true,
	SsuNecroGhostSoulEater = true,
	SsuNecroSummonSkeleton = true,
	SsuNecroSummonZombie = true,
	SsuNecroSummonZombieDog = true,
	SsuBackswing = true,
	SsuHackSpm = true,
	SsuFob = true,
	SsuTotalcover = true,
	SsuGuardian = true,
	SsuFurinkazan = true,
	SsuGrandslam = true,
	SsuArmorMasteryCloth = true,
	SsuArmorMasteryLight = true,
	SsuArmorMasteryMedium = true,
	SsuArmorMasteryHeavy = true,
	SsuClarity = true,
	SsuSignaturemove = true,
	SsuBravery = true,
	SsuInitiative = true,
	SsuHitpoints = true,
	SsuStamina = true,
	SsuMeleeskill = true,
	SsuRangedskill = true,
	SsuRangeddefense = true,
	SsuRetrofithooks = true,
	SsuIrresistibleimpulse = true,
	SsuAudaciouscharge = true,
	SsuBattlerhaposdy = true,
	SsuPerseverance = true,
	SsuTic = true,
	SsuNavigator = true,
	SsuIronsideweak = true,
	SsuBruiser = true,
	SsuTrumpcard = true,
	SsuHonorheritage = true,
	SsuBlocknormal = true,
	SsuBlockskilled = true,
	SsuBlockmaster = true,
	SsuDiscipline = true,
	SsuRavager = true,
	SsuRapidmarch = true,
	SsuReachadvantage = true,
	SsuAssistance = true,
	SsuParthianshot = true,
	SsuDryadSummonWolf = true,
	SsuDryadSummonSnake = true,
	SsuDryadSummonUnhold = true,
	SsuDryadSummonLindwurm = true,
	SsuDryadForestBlessing = true,
	SsuDryadNaturalRegrowth = true,
	LegendAthlete = true,
	LegendSmackdown = true,
	LegendLastStand = true,
	Indomitable = true,
	LegendTwirl = true,
	QuickHands = true,
	LegendMuscularity = true,
	Overwhelm = true,
	LegendBattleheart = true,
	Underdog = true,
	SunderingStrikes = true,
	LegendShieldsUp = true,
	LegendSlaughterer = true,
	LegendCheerOn = true,
	LegendInTheZone = true,
	LegendRebound = true,
	FastAdaption = true,
	Fearsome = true,
	Fearsome = true,
	Adrenaline = true,
	ReachAdvantage = true,
	Footwork = true,
	Rotation = true,
	LegendEvasion = true,
	HoldOut = true,
	LegendBalance = true,
	LegendLithe = true,
	SpecThrowing = true,
	Bullseye = true,
	LegendNetCasting = true,
	LegendMasteryNets = true,
	LegendEscapeArtist = true,
	LegendDogHandling = true,
	LegendDogWhisperer = true,
	LegendThrowSand = true,
	LegendDebilitate = true,
	Duelist = true,
	LegendConservation = true,
	LegendChainLightning = true,
	LegendHoldTheLine = true,
	HoldOut = true
};

// ---------------------------------------------------------------------------
// Texts of each script and hook, one table per file
// ---------------------------------------------------------------------------
// mod_sellswords\hooks\config\z_perks_tree_class.nut
::Mod_Sellswords.Strings.z_perks_tree_class <- {
	Name = "Veteran"
};

// mod_sellswords\hooks\config\z_perks_tree_magic.nut
::Mod_Sellswords.Strings.z_perks_tree_magic <- {
	Name1 = "Dryad Shaman",
	Name2 = "Dryad Tamer"
};

// mod_sellswords\hooks\contracts\contracts\barbarian_king_contract.nut
::Mod_Sellswords.Strings.barbarian_king_contract <- {
	Description = "A mighty warhost of barbarian tribes, united by a self-proclaimed barbarian king."
};

// mod_sellswords\hooks\contracts\contracts\break_greenskin_siege_contract.nut
::Mod_Sellswords.Strings.break_greenskin_siege_contract <- {
	Description1 = "Professional soldiers in service to local lords.",
	Description2 = "A horde of greenskins and their siege engines.",
	Description3 = "A horde of greenskins marching to war."
};

// mod_sellswords\hooks\contracts\contracts\confront_warlord_contract.nut
::Mod_Sellswords.Strings.confront_warlord_contract <- {
	Description = "A horde of greenskins led by a fearsome orc warlord."
};

// mod_sellswords\hooks\contracts\contracts\conquer_holy_site_contract.nut
::Mod_Sellswords.Strings.conquer_holy_site_contract <- {
	Description1 = "Professional soldiers in service to local lords.",
	Description2 = "Conscripted soldiers loyal to their city state."
};

// mod_sellswords\hooks\contracts\contracts\conquer_holy_site_southern_contract.nut
::Mod_Sellswords.Strings.conquer_holy_site_southern_contract <- {
	Description1 = "Conscripted soldiers loyal to their city state.",
	Description2 = "Professional soldiers in service to local lords."
};

// mod_sellswords\hooks\contracts\contracts\decisive_battle_contract.nut
::Mod_Sellswords.Strings.decisive_battle_contract <- {
	Description1 = "Professional soldiers in service to local lords.",
	Description2 = "A caravan with armed escorts transporting provisions, supplies and equipment between settlements."
};

// mod_sellswords\hooks\contracts\contracts\defend_holy_site_contract.nut
::Mod_Sellswords.Strings.defend_holy_site_contract <- {
	Description1 = "Conscripted soldiers loyal to their city state.",
	Tooltip1 = "You gain {1}",
	Tooltip2 = "You gain [color={1}]+{2}[/color] Tools and Supplies.",
	Description2 = "Professional soldiers in service to local lords."
};

// mod_sellswords\hooks\contracts\contracts\defend_holy_site_southern_contract.nut
::Mod_Sellswords.Strings.defend_holy_site_southern_contract <- {
	Description = "Professional soldiers in service to local lords."
};

// mod_sellswords\hooks\contracts\contracts\deliver_item_contract.nut
::Mod_Sellswords.Strings.deliver_item_contract <- {
	Tooltip = "You gain [color={1}]{2}[/color] Crowns and [color={3}]{4}[/color] Experience"
};

// mod_sellswords\hooks\contracts\contracts\free_greenskin_prisoners_contract.nut
::Mod_Sellswords.Strings.free_greenskin_prisoners_contract <- {
	Description = "A horde of greenskins marching to war."
};

// mod_sellswords\hooks\contracts\contracts\hold_chokepoint_contract.nut
::Mod_Sellswords.Strings.hold_chokepoint_contract <- {
	Description1 = "Professional soldiers in service to local lords.",
	Description2 = "Conscripted soldiers loyal to their city state."
};

// mod_sellswords\hooks\contracts\contracts\last_stand_contract.nut
::Mod_Sellswords.Strings.last_stand_contract <- {
	Description = "A legion of walking dead, back to claim from the living what was once theirs."
};

// mod_sellswords\hooks\contracts\contracts\legend_barbarian_prisoner_contract.nut
::Mod_Sellswords.Strings.legend_barbarian_prisoner_contract <- {
	Description = "These savages would like to have their buddy back."
};

// mod_sellswords\hooks\contracts\contracts\legend_deliver_money_contract.nut
::Mod_Sellswords.Strings.legend_deliver_money_contract <- {
	Tooltip = "You gain [color={1}]{2}[/color] Crowns and [color={3}]{4}[/color] Experience"
};

// mod_sellswords\hooks\contracts\contracts\privateering_contract.nut
::Mod_Sellswords.Strings.privateering_contract <- {
	Description = "Professional soldiers in service to local lords."
};

// mod_sellswords\hooks\contracts\contracts\return_item_contract.nut
::Mod_Sellswords.Strings.return_item_contract <- {
	Description = "A group of thieves and bandits."
};

// mod_sellswords\hooks\contracts\contracts\siege_fortification_contract.nut
::Mod_Sellswords.Strings.siege_fortification_contract <- {
	Description1 = "Professional soldiers in service to local lords.",
	Description2 = "A caravan with armed escorts transporting provisions, supplies and equipment between settlements."
};

// mod_sellswords\hooks\contracts\contracts\tutorial_contract.nut
::Mod_Sellswords.Strings.tutorial_contract <- {
	Description = "A mighty warhost of barbarian tribes, united by a self-proclaimed barbarian king."
};

// mod_sellswords\hooks\entity\tactical\legend_skeleton.nut
::Mod_Sellswords.Strings.legend_skeleton <- {
	Name = "Raised Skeleton"
};

// mod_sellswords\hooks\entity\tactical\legend_zombie.nut
::Mod_Sellswords.Strings.legend_zombie <- {
	Name = "Raised Wiederganger"
};

// mod_sellswords\hooks\entity\tactical\tactical_entity_manager.nut
::Mod_Sellswords.Strings.tactical_entity_manager <- {
	Log = "{1} has risen from the dead"
};

// mod_sellswords\hooks\entity\world\entity_manager.nut
::Mod_Sellswords.Strings.entity_manager <- {
	Description = "A free mercenary company travelling the lands and lending their swords to the highest bidder."
};

// mod_sellswords\hooks\entity\world\locations\legendary\black_monolith_location.nut
::Mod_Sellswords.Strings.black_monolith_location <- {
	Name = "Black Monolith"
};

// mod_sellswords\hooks\events\events\dlc2\witchhut_destroyed_event.nut
::Mod_Sellswords.Strings.witchhut_destroyed_event <- {
	Tooltip = "You gain {1}{2}"
};

// mod_sellswords\hooks\events\events\dlc4\location\tundra_elk_destroyed_event.nut
::Mod_Sellswords.Strings.tundra_elk_destroyed_event <- {
	Tooltip4 = "You gain [color=#456ca0]Winter\'s Touch[/color]"
};

// mod_sellswords\hooks\events\events\dlc8\lindwurm_slayer_event.nut
::Mod_Sellswords.Strings.lindwurm_slayer_event <- {
	RawDescription = "{%name% is a supposedly famous monster hunter with a particular talent for slaying lindwurms. He says he is the son of Dirk the Dragonslayer, the monster hunter who ostensibly slew the last living dragon.}"
};

// mod_sellswords\hooks\events\events\dlc8\oathbreaker_event.nut
::Mod_Sellswords.Strings.oathbreaker_event <- {
	Tooltip1 = "You gain {1}{2}",
	Tooltip2 = "You lose [color={1}]9,000[/color] Crowns",
	Title = "the Oathbreaker",
	RawDescription = "Like many men, %name% was found in squalor. Ale on his lips, grime in his ears, piss and shit at least somewhere on his person. But he was an Oathtaker at heart, and by the providence of Young Anselm it was certainly no ordinary circumstance which brought him back into the faith. Of course, he\'ll still yet pair beer with belief, but now and again one must allow a man his vices, particularly if said man shares an interest in slaying Oathbringers."
};

// mod_sellswords\hooks\events\events\dlc8\oathtakers_all_oaths_complete_event.nut
::Mod_Sellswords.Strings.oathtakers_all_oaths_complete_event <- {
	Tooltip = "{1} gains [color={2}]+2[/color] for ALL attributes"
};

// mod_sellswords\hooks\events\events\legends\legend_mummy_enter_event.nut
::Mod_Sellswords.Strings.legend_mummy_enter_event <- {
	Title = "After the battle...",
	Tooltip = "You gain {1}"
};

// mod_sellswords\hooks\events\events\special\ambition_fulfilled_event.nut
::Mod_Sellswords.Strings.ambition_fulfilled_event <- {
	Tooltip1 = "The company gained renown",
	Tooltip2 = "You went above and beyond in fulfilling the Oath",
	Title = "{1} Fulfilled"
};

// mod_sellswords\hooks\factions\actions\patrol_roads_action.nut
::Mod_Sellswords.Strings.patrol_roads_action <- {
	Description1 = "Soldiers typically well-versed in the use of arms and served as a fully armoured heavy cavalryman.",
	Description2 = "Professional soldiers in service to local lords."
};

// mod_sellswords\hooks\factions\actions\send_bandit_ambushers_action.nut
::Mod_Sellswords.Strings.send_bandit_ambushers_action <- {
	Description = "A rough and tough band of brigands preying on the weak."
};

// mod_sellswords\hooks\factions\actions\send_barbarian_ambushers_action.nut
::Mod_Sellswords.Strings.send_barbarian_ambushers_action <- {
	Description = "A warband of barbarian tribals."
};

// mod_sellswords\hooks\factions\actions\send_barbarian_roamers_action.nut
::Mod_Sellswords.Strings.send_barbarian_roamers_action <- {
	Description = "A band of barbarians out to hunt game."
};

// mod_sellswords\hooks\factions\actions\send_beast_roamers_action.nut
::Mod_Sellswords.Strings.send_beast_roamers_action <- {
	Description = "A group of Dryads, a blend between tree and man, patrolling the woods to protect their ancient groves."
};

// mod_sellswords\hooks\factions\actions\send_caravan_action.nut
::Mod_Sellswords.Strings.send_caravan_action <- {
	Description = "A trading caravan from {1} that is transporting all manner of goods between settlements."
};

// mod_sellswords\hooks\factions\actions\send_citystate_army_action.nut
::Mod_Sellswords.Strings.send_citystate_army_action <- {
	Description = "Conscripted soldiers loyal to their city state."
};

// mod_sellswords\hooks\factions\actions\send_greenskin_army_action.nut
::Mod_Sellswords.Strings.send_greenskin_army_action <- {
	Description = "A horde of greenskins marching to war."
};

// mod_sellswords\hooks\factions\actions\send_military_army_action.nut
::Mod_Sellswords.Strings.send_military_army_action <- {
	Description = "Professional soldiers in service to local lords."
};

// mod_sellswords\hooks\factions\actions\send_nomad_ambushers_action.nut
::Mod_Sellswords.Strings.send_nomad_ambushers_action <- {
	Description = "A band of desert raiders preying on anyone trying to cross the seas of sand."
};

// mod_sellswords\hooks\factions\actions\send_nomad_roamers_action.nut
::Mod_Sellswords.Strings.send_nomad_roamers_action <- {
	Description = "A band of nomads scouting the area."
};

// mod_sellswords\hooks\factions\actions\send_supplies_action.nut
::Mod_Sellswords.Strings.send_supplies_action <- {
	Description = "A caravan with armed escorts transporting provisions, supplies and equipment between settlements."
};

// mod_sellswords\hooks\factions\actions\send_undead_ambushers_action.nut
::Mod_Sellswords.Strings.send_undead_ambushers_action <- {
	Description = "A legion of walking dead, back to claim from the living what was once theirs."
};

// mod_sellswords\hooks\factions\actions\send_undead_army_action.nut
::Mod_Sellswords.Strings.send_undead_army_action <- {
	Description = "A legion of walking dead, back to claim from the living what was once theirs."
};

// mod_sellswords\hooks\factions\actions\send_undead_roamers_action.nut
::Mod_Sellswords.Strings.send_undead_roamers_action <- {
	Description = "Something seems wrong."
};

// mod_sellswords\hooks\items\accessory\legend_heartwood_sap_flask_item.nut
::Mod_Sellswords.Strings.legend_heartwood_sap_flask_item <- {
	Tooltip = "This character will gather all his physical strength and willpower to become indomitable for three turns"
};

// mod_sellswords\hooks\items\accessory\legend_hexen_ichor_potion_item.nut
::Mod_Sellswords.Strings.legend_hexen_ichor_potion_item <- {
	Description = "A disgusting Hexen brew, will grants user perfect focus, halving the action point costs of all skills for three turns."
};

// mod_sellswords\hooks\items\accessory\legend_skin_ghoul_blood_flask_item.nut
::Mod_Sellswords.Strings.legend_skin_ghoul_blood_flask_item <- {
	Tooltip = "Restores up to [color=%positive%]75%[/color] of missing health and heal wounds"
};

// mod_sellswords\hooks\items\accessory\legend_stollwurm_blood_flask_item.nut
::Mod_Sellswords.Strings.legend_stollwurm_blood_flask_item <- {
	Tooltip = "damaging adjacent attackers whenever they deal hitpoint damage or receive hitpoint damage."
};

// mod_sellswords\hooks\items\accessory\sergeant_badge_item.nut
::Mod_Sellswords.Strings.sergeant_badge_item <- {
	Tooltip1 = "[color=%positive%]+1[/color] Resolve per ally wearing a militia armband or sergeant\'s sash.",
	Tooltip2 = "Current bonus: [color=%positive%]{1}[/color]"
};

// mod_sellswords\hooks\items\ammo\legend_armor_piercing_arrows.nut
::Mod_Sellswords.Strings.legend_armor_piercing_arrows <- {
	Description = "A quiver of arrows with thin piercing tips, designed for punching through thick armour.\nIs automatically refilled after each battle if you have enough ammunition.\nGrants [color=%positive%]+25%[/color] Armour Piercing but [color=%negative%]-5%[/color] Damage"
};

// mod_sellswords\hooks\items\ammo\legend_armor_piercing_bolts.nut
::Mod_Sellswords.Strings.legend_armor_piercing_bolts <- {
	Description = "A quiver of bolts with thin piercing tips, designed for punching through thick armour.\nIs automatically refilled after each battle if you have enough ammunition.\nGrants [color=%positive%]+25%[/color] Armour Piercing but [color=%negative%]-5%[/color] Damage"
};

// mod_sellswords\hooks\items\ammo\legend_broad_head_arrows.nut
::Mod_Sellswords.Strings.legend_broad_head_arrows <- {
	Description = "A quiver of arrows with broad tips, designed for tearing through flesh, but is easily stopped by armour.\nIs automatically refilled after each battle if you have enough ammunition.\nGrants [color=%positive%]+30%[/color] Damage to Hitpoints but [color=%negative%]-10%[/color] Armour Piercing and Armour Damage"
};

// mod_sellswords\hooks\items\ammo\legend_broad_head_bolts.nut
::Mod_Sellswords.Strings.legend_broad_head_bolts <- {
	Description = "A quiver of bolts with broad tips, designed for tearing through flesh, but is easily stopped by armour.\nIs automatically refilled after each battle if you have enough ammunition.\nGrants [color=%positive%]+30%[/color] Damage to Hitpoints but [color=%negative%]-10%[/color] Armour Piercing and Armour Damage"
};

// mod_sellswords\hooks\items\ammo\legend_large_armor_piercing_arrows.nut
::Mod_Sellswords.Strings.legend_large_armor_piercing_arrows <- {
	Description = "A large quiver of arrows thin piercing tips, designed for punching through thick armour.\nIs automatically refilled after each battle if you have enough ammunition.\nGrants [color=%positive%]+25%[/color] Armour Piercing but [color=%negative%]-5%[/color] Damage"
};

// mod_sellswords\hooks\items\ammo\legend_large_armor_piercing_bolts.nut
::Mod_Sellswords.Strings.legend_large_armor_piercing_bolts <- {
	Description = "A large quiver of bolts with thin piercing tips, designed for punching through thick armour.\nIs automatically refilled after each battle if you have enough ammunition.\nGrants [color=%positive%]+25%[/color] Armour Piercing but [color=%negative%]-5%[/color] Damage"
};

// mod_sellswords\hooks\items\ammo\legend_large_broad_head_arrows.nut
::Mod_Sellswords.Strings.legend_large_broad_head_arrows <- {
	Description = "A large quiver of arrows with broad tips, designed for tearing through flesh, but is easily stopped by armour.\nIs automatically refilled after each battle if you have enough ammunition.\nGrants [color=%positive%]+30%[/color] Damage to Hitpoints but [color=%negative%]-10%[/color] Armour Piercing and Armour Damage"
};

// mod_sellswords\hooks\items\ammo\legend_large_broad_head_bolts.nut
::Mod_Sellswords.Strings.legend_large_broad_head_bolts <- {
	Description = "A large quiver of bolts with broad tips, designed for tearing through flesh, but is easily stopped by armour.\nIs automatically refilled after each battle if you have enough ammunition.\nGrants [color=%positive%]+30%[/color] Damage to Hitpoints but [color=%negative%]-10%[/color] Armour Piercing and Armour Damage"
};

// mod_sellswords\hooks\items\tools\player_banner.nut
::Mod_Sellswords.Strings.player_banner <- {
	Tooltip = "Allies at a range of 4 tiles or less receive [color=%positive%]10-15%[/color] of the Resolve of the character holding this standard as a bonus, varies from their resolve up to a maximum of the standard bearer\'s Resolve."
};

// mod_sellswords\hooks\items\trade\legend_cooking_spices_trade_item.nut
::Mod_Sellswords.Strings.legend_cooking_spices_trade_item <- {
	Tooltip1 = "Can be used in recipes 4 times",
	Tooltip2 = "Uses remaining: {1}/4"
};

// mod_sellswords\hooks\items\weapons\barbarians\skull_hammer.nut
::Mod_Sellswords.Strings.skull_hammer <- {
	Name = "Two-Handed Rusty Hammer",
	Description = "A crude metal hammer used with two hands to crush both armor and its wearer alike."
};

// mod_sellswords\hooks\items\weapons\greenskins\legend_man_mangler.nut
::Mod_Sellswords.Strings.legend_man_mangler <- {
	Name = "Great Bunt"
};

// mod_sellswords\hooks\items\weapons\greenskins\legend_meat_hacker.nut
::Mod_Sellswords.Strings.legend_meat_hacker <- {
	Description = "A long shard of sharpened rock firmly wedged into a massive bone. Not well suited for human hands."
};

// mod_sellswords\hooks\items\weapons\legendary\lightbringer_sword.nut
::Mod_Sellswords.Strings.lightbringer_sword <- {
	Tooltip = "Inflicts an additional [color=%damage%]15%[/color] damage that ignores armor to up to three targets"
};

// mod_sellswords\hooks\items\weapons\named\legend_named_longsword.nut
::Mod_Sellswords.Strings.legend_named_longsword <- {
	Name = "Bunt"
};

// mod_sellswords\hooks\scenarios\world\anatomists_scenario.nut
::Mod_Sellswords.Strings.anatomists_scenario <- {
	Description = "[p=c][img]gfx/ui/events/event_181.png[/img][/p][p]Fueled by an unquenchable thirst for knowledge, the Anatomists have spent years dissecting the exotic and the alien. With social mores dogging their research, however, they\'ve decided to form a mercenary company to acquire new source of fresh specimens.\n\n[color=#bcad8c]Advanced Researchers:[/color] Start with three elite Anatomists and high funds. Doubles the Anatomist drop chance for potions.\n[color=#bcad8c]Fresh Specimens:[/color] Characters come with the \'Resilient\' perk, which allows you to withstand mutations from up to two sequences.[/p]",
	RawDescription1 = "{Captain? Is it alright if I call you captain? Ah, of course it is. What? No, we were not calling you by another name. Yers is a smooth costard, good sir, and we would not be of such derring-do to refer to you as a sellsword who is as ordinary as any of our coetaneous clodpolls, or state that we were in some sense importuning commerce by conducting business with a man of your particular skills. No sir, we would not. We are not children of perdition, sir.}",
	RawDescription2 = "{Despite others\' hesitancies, I\'ve no qualms calling you a javel, sir. You are, after all, a javel. A scapegrace. Some sellsword or another, yes? I think only a man who trucks cowardice would avoid calling you what you are. That someone disrespects your intelligence, thinking you yourself know not yourself. Even I see that in you accepting who you are, you are quite a good specimen. I mean, sellsword.}",
	RawDescription3 = "{Though our quotidian dialogues are no doubt drollery, beneath the banausic surface I must admit I feel a touch of serotinous savagery lurking within you, coming to the fore as if my words be fire. Even our most desultory talks has me on edge, the way you stare at me with such hateful eyes. Well, know this, bounty hunter, I am no casuist, I speak in earnest. You are too fine a specimen-I mean captain to be lofting some sapskull\'s brickbats at. Understand?}"
};

// mod_sellswords\hooks\scenarios\world\beast_hunters_scenario.nut
::Mod_Sellswords.Strings.beast_hunters_scenario <- {
	Description = "[p=c][img]gfx/ui/events/event_122.png[/img][/p][p]You and your kind make your living by hunting down the many beasts that beset villages on the fringes of civilization. It is dangerous work, but it pays well enough and there is always a bigger beast to slay and more crowns to earn.\n\n[color=#bcad8c]Beast Slayers:[/color] Start with three Beast Slayers and decent equipment, as well as some beast trophies. Beast Slayers gain a unique trait when fighting beasts. Chance to find others that support your cause.\n[color=#bcad8c]Expert Skulkers:[/color] See tracks from further away. Recruits gain Escape Artist.\n[color=#bcad8c]Expert Skinners:[/color] Each beast you slay has a 50% chance to drop an additional trophy.\n[color=#bcad8c]Prejudice:[/color] Most people do not trust your kind, get 10% worse prices.[/p]"
};

// mod_sellswords\hooks\scenarios\world\cultists_scenario.nut
::Mod_Sellswords.Strings.cultists_scenario <- {
	Description = "[p=c][img]gfx/ui/events/event_140.png[/img][/p][p]Davkul awaits. You lead a small flock devoted to the elder god, and it is time to spread the word. Find more followers, acquire riches, and please Davkul with sacrifices.\n\n[color=#bcad8c]Cultists:[/color] Start with a group of five cultists. Encounter fanatical special cultists in towns.\n[color=#bcad8c]Sacrifices:[/color] Davkul will occasionally demand sacrifices from you, but also bestow boons upon those loyal to him. Davkul will not sacrifice his chosen elite. Cultists cost 25% less to buy and maintain.\n[color=#c90000]Let the Blood Flow:[/color] All cultists gain bonus melee skill and the [color=#008060]True Believer[/color] perk.[/p]",
	RawDescription1 = "When %name% joined, the cultist warmly called you captain, saying \"tis a proper manner to pursue the path into the Black from whence we came\".",
	RawDescription2 = "%name% found you upon the road, stating with certainty you were a mercenary captain. You wore but ordinary cloth at that moment, but %name% said that by Davkul\'s darkness you had an aura of wanted Black about you.",
	RawDescription3 = "A quiet figure, %name% has shadows beneath the fingerprints, running like the brine beneath a pallid shore. When you exchanged a handshake, it was as though you could hear the hissing of your sanity.",
	RawDescription4 = "%name% banded with you outside a tavern. The first time you saw the cultist, there were scars running up %name%\'s arms and across veins that could not be survived. But each morning it appears as though the scars move, slowly creeping in one direction: toward the forehead."
};

// mod_sellswords\hooks\scenarios\world\gladiators_scenario.nut
::Mod_Sellswords.Strings.gladiators_scenario <- {
	Description = "[p=c][img]gfx/ui/events/event_155.png[/img][/p][p]You\'ve fought in the arenas of the south for years. First for your freedom, then for crowns, and finally to become immortal. What else does fate have in stock for you?\n\n[color=#bcad8c]Gladiators:[/color] Start with three experienced gladiators with good equipment.\n[color=#bcad8c]Legends of the Arena:[/color] Every gladiator, including any you hire, has one of seven unique traits and demands 50% higher wages.\n[color=#bcad8c]Dirty Fighters:[/color] New recruits gain the Throw Sand skill.\n[color=#bcad8c]Glorious Few:[/color] You can never have more than 16 fighters in your roster, and if fewer than two gladiators remain, your campaign ends. Your last two gladiators can\'t be dismissed and will never desert you.[/p]"
};

// mod_sellswords\hooks\scenarios\world\legends_noble_scenario.nut
::Mod_Sellswords.Strings.legends_noble_scenario <- {
	RawDescription1 = "Though a lowly foot soldier %name% has one of the most upbeat outlooks on life you\'ve ever encountered. Unfortunately that extends to an over evaluation of self worth, expecting more pay than most.",
	RawDescription2 = "%name% is a hulking figure, both upward and outward. Not much of a talker, but a big eater.",
	RawDescription3 = "%name%\'s parents both served your family, it runs in the blood. While %name% is dependable in a fight and would never dream of leaving you, it also reduces their %name%\'s ambition and drive",
	RawDescription4 = "%name% has been a servant in your family for 5 generations now, it is unclear how anyone has survived this long, but there are no indications of the old coot giving up any time soon.",
	RawDescription5 = "%name% has won the house archery contest several years running, but never shuts up about it. The constant stream of narration makes the great aim easy to dodge."
};

// mod_sellswords\hooks\scenarios\world\legends_rangers_scenario.nut
::Mod_Sellswords.Strings.legends_rangers_scenario <- {
	Description = "[p=c][img]gfx/ui/events/event_115.png[/img][/p][p]Originally hailing from far afield, the rangers are sworn to protect their ancestral woodlands. Increasing intrusions have led the rangers to these lands. \n\n[color=#bcad8c]Outdoorsmen:[/color] Not everyone is cut out for the Rangers, some love nature and are eager to join, others will need more coin to convince. New recruits gain Pathfinder.\n[color=#bcad8c]Expert Scouts:[/color] You move faster on the campaign map and can always get a scouting report for any enemies near you.\n[color=#bcad8c]Guardians:[/color] If your ranger and druid die, its game over.[/p]"
};

// mod_sellswords\hooks\scenarios\world\legends_troupe_scenario.nut
::Mod_Sellswords.Strings.legends_troupe_scenario <- {
	Description = "[p=c][img]gfx/ui/events/event_26.png[/img][/p]The life of an artist is not an easy one, misunderstood and under appreciated. Perhaps performers will have more luck together, find and audience, travel the world, or at least stop having things thrown at you. \n\n[color=#bcad8c]Acrobatics:[/color] Anyone you hire gains the Leap ability \n[color=#bcad8c]Exposure:[/color] You will encounter more performers, and they will be cheaper to hire.\n[color=#bcad8c]Busking:[/color] You gain 10 crowns each day for each member of the troupe. Tavern rumors and drinks are cheaper."
};

// mod_sellswords\hooks\scenarios\world\manhunters_scenario.nut
::Mod_Sellswords.Strings.manhunters_scenario <- {
	Description = "[p=c][img]gfx/ui/events/event_172.png[/img][/p][p]Constant conflict between city states and nomads makes for good business. The bulk of your outfit are captives, forced to fight to earn their freedom, and their ranks grow after each battle.\n\n[color=#bcad8c]Army of Captives:[/color] Start with two manhunters and four indebted. Take up to 16 men into battle at once. Having equal or fewer indebted than non-indebted will make your men dissatisfied.\n[color=#bcad8c]Overseers:[/color] All non-indebted can whip indebted in combat to reset their morale and buff their stats.\n[color=#bcad8c]Captives:[/color] Indebted earn 10% more experience, are capped at level 8, and will die if struck down. However, they are 50% cheaper to buy in towns.[/p]",
	Tooltip1 = "[color=%negative%]-25%[/color] Experience Gain",
	Tooltip2 = "[color=%positive%]+5%[/color] Experience Gain",
	Tooltip3 = "[color=%negative%]-10%[/color] Experience Gain",
	Tooltip4 = "[color=%positive%]+10%[/color] Experience Gain",
	Tooltip5 = "Limited to character level 10",
	Tooltip6 = "Is permanently dead if struck down and will not survive with a permanent injury"
};

// mod_sellswords\hooks\scenarios\world\trader_scenario.nut
::Mod_Sellswords.Strings.trader_scenario <- {
	Description = "[p=c][img]gfx/ui/events/event_41.png[/img][/p]You are running a small trading caravan and have most of your crowns invested into trading goods. But the roads have become dangerous - brigands and greenskins lay in ambush, and there are rumors of even worse things out there.\n\n [color=#bcad8c]Trader:[/color] Get better prices for buying and selling.\n[color=#bcad8c]Not a Warrior:[/color] Start with no renown, and gain renown at half the normal rate. Every non-combat recruit gains the Pacifist perk. \n[color=#bcad8c]Bribery:[/color] Pay off human enemies instead of fighting them. Combat backgrounds cost more to hire, peddlers and donkeys cost less.",
	RawDescription = "You found %name% being thrown out of a pub and at first glance thought that was little more than a drunken miscreant. But you watched as off three would-be muggers were soon on the ground. They still managed to take off with a coin purse in the end, sure, but they could not truly defeat %name%. Impressed, you took the newly-impoverished fighter on as a caravan hand."
};

// mod_sellswords\hooks\skills\actives\aimed_shot.nut
::Mod_Sellswords.Strings.aimed_shot <- {
	Name1 = "Phantom Strike",
	Name2 = "Aimed Shot"
};

// mod_sellswords\hooks\skills\actives\bandage_ally_skill.nut
::Mod_Sellswords.Strings.bandage_ally_skill <- {
	Description = "Save yourself or another character from bleeding to death by applying pressure and provisional bandaging to any such wound. Heals 5 hitpoints instantly and 5 hitpoints next turn if user has Bandage Mastery. Neither the character using this skill nor the patient may be engaged in melee, unless the character using this skill has Bandage Mastery."
};

// mod_sellswords\hooks\skills\actives\bash.nut
::Mod_Sellswords.Strings.bash <- {
	Tooltip = "For each negative effect your target has, deal [color=%positive%]33%[/color] more damage"
};

// mod_sellswords\hooks\skills\actives\charm_skill.nut
::Mod_Sellswords.Strings.charm_skill <- {
	Log1 = "{1} can not be charmed",
	Log2 = "{1} resists being charmed thanks to his resolve",
	Log3 = "{1} resists being charmed thanks to his unnatural physiology",
	Log4 = "{1} is charmed"
};

// mod_sellswords\hooks\skills\actives\chop.nut
::Mod_Sellswords.Strings.chop <- {
	Tooltip1 = "Always hits the body.",
	Tooltip2 = "Inflicts additional [color=%positive%]{1}%[/color] damage on a hit to the head"
};

// mod_sellswords\hooks\skills\actives\ghastly_touch.nut
::Mod_Sellswords.Strings.ghastly_touch <- {
	Description = "A touch of something that doesn\'t belong to the living world. Quickly drain away any piece of life or sanity your victim has.",
	Tooltip = "Completely ignores armor"
};

// mod_sellswords\hooks\skills\actives\hand_to_hand.nut
::Mod_Sellswords.Strings.hand_to_hand <- {
	Tooltip1 = "Inflicts [color=%damage%]{1}[/color] extra fatigue on hit",
	Tooltip2 = "Has a [color=%positive%]10%[/color] additional chance to hit"
};

// mod_sellswords\hooks\skills\actives\hex_skill.nut
::Mod_Sellswords.Strings.hex_skill <- {
	Log1 = "{1} resists being hexed thanks to his unnatural physiology",
	Log2 = "{1} hexes {2}"
};

// mod_sellswords\hooks\skills\actives\hook.nut
::Mod_Sellswords.Strings.hook <- {
	Tooltip1 = "Has a range of [color=%positive%]2[/color] tiles",
	Tooltip2 = "Has a [color=%positive%]100%[/color] chance to stagger on a hit",
	Tooltip3 = "Has [color=%positive%]{1}%[/color] chance to hit"
};

// mod_sellswords\hooks\skills\actives\horrific_scream.nut
::Mod_Sellswords.Strings.horrific_scream <- {
	Description = "Let out a piercing, unworldly sound that is sure to distress anyone unfortunate enough to hear it.",
	Tooltip = "Has a range of [color=%positive%]{1}[/color] tiles"
};

// mod_sellswords\hooks\skills\actives\ignite_firelance_skill.nut
::Mod_Sellswords.Strings.ignite_firelance_skill <- {
	Tooltip = "Has [color=%positive%]+30%[/color] chance to hit"
};

// mod_sellswords\hooks\skills\actives\indomitable.nut
::Mod_Sellswords.Strings.indomitable <- {
	Tooltip1 = "Only receive [color=%positive%]{1}%[/color] of any damage",
	Tooltip2 = "Base Resolve will be increased by [color=%positive%]{1}%[/color]",
	Tooltip3 = "Become immune to being stunned",
	Tooltip4 = "Become immune to being knocked back or grabbed"
};

// mod_sellswords\hooks\skills\actives\knock_out.nut
::Mod_Sellswords.Strings.knock_out <- {
	Tooltip = "For each negative effect your target has, deal [color=%positive%]33%[/color] more damage",
	Log = "{1} has stunned {2} for one turn"
};

// mod_sellswords\hooks\skills\actives\knock_over_skill.nut
::Mod_Sellswords.Strings.knock_over_skill <- {
	Log = "{1} has stunned {2} for one turn"
};

// mod_sellswords\hooks\skills\actives\legend_chain_lightning_skill.nut
::Mod_Sellswords.Strings.legend_chain_lightning_skill <- {
	Description = "Unleash a powerful bolt of lightning that arcs between multiple enemies, dealing damage to each one in its path. Requires a Mystic Staff.",
	Tooltip = "Inflicts [color=%damage%]15[/color] - [color=%damage%]30[/color] Armor ignoring damage and chains between up to three additional adjacent targets on hit"
};

// mod_sellswords\hooks\skills\actives\legend_cheer_on_skill.nut
::Mod_Sellswords.Strings.legend_cheer_on_skill <- {
	Tooltip = "You have [color=%positive%]{1}[/color] medicine."
};

// mod_sellswords\hooks\skills\actives\legend_choke_skill.nut
::Mod_Sellswords.Strings.legend_choke_skill <- {
	Tooltip1 = "Damage halved due to holding something in your off hand",
	Tooltip2 = "This skill is not useable due to holding something in your main hand"
};

// mod_sellswords\hooks\skills\actives\legend_coordinated_volleys_skill.nut
::Mod_Sellswords.Strings.legend_coordinated_volleys_skill <- {
	Tooltip1 = "[color=%positive%]10[/color] ranged attack to all allies within [color=%positive%]4[/color] tiles for one turn",
	Tooltip2 = "The penalty to blocked ranged attack hitchance is reduced by [color=%positive%]20%[/color]"
};

// mod_sellswords\hooks\skills\actives\legend_demon_hound_bite_skill.nut
::Mod_Sellswords.Strings.legend_demon_hound_bite_skill <- {
	Description = "Tear an enemy assunder with your cursed teeth. A bite can drain the stamina of your victim for 3 turns."
};

// mod_sellswords\hooks\skills\actives\legend_gruesome_feast_skill.nut
::Mod_Sellswords.Strings.legend_gruesome_feast_skill <- {
	Description = "Feast on a corpse to regain health and cure injuries. Will daze and disgust any non-mutated ally within four tiles.",
	Log = "{1} feasts on a corpse"
};

// mod_sellswords\hooks\skills\actives\legend_halberd_smite_skill.nut
::Mod_Sellswords.Strings.legend_halberd_smite_skill <- {
	Tooltip = "Has [color=%negative%]-15%[/color] chance to hit targets directly adjacent because the weapon is too unwieldy"
};

// mod_sellswords\hooks\skills\actives\legend_miasma_skill.nut
::Mod_Sellswords.Strings.legend_miasma_skill <- {
	Description = "Release a dense cloud of noxious gas that only effects living beings",
	Tooltip1 = "Has a range of [color=%positive%]{1}[/color] tiles",
	Tooltip2 = "Deals 5-10 damage directly to hitpoints to any living units that end their turn in the miasma",
	Tooltip3 = "Lasts for four turns. While the damage can't stack, you reset the duration if you overlap the tiles with subsequent casts"
};

// mod_sellswords\hooks\skills\actives\legend_piercing_bolt_skill.nut
::Mod_Sellswords.Strings.legend_piercing_bolt_skill <- {
	Name = "Piercing Shot",
	Description = "A shot with so much force that it passes straight through one enemy to the enemy behind them."
};

// mod_sellswords\hooks\skills\actives\legend_safeguard_skill.nut
::Mod_Sellswords.Strings.legend_safeguard_skill <- {
	Tooltip = "Applies Safeguard to someone, increasing their defenses by [color=%positive%]+15[/color]"
};

// mod_sellswords\hooks\skills\actives\legend_sling_heavy_stone_skill.nut
::Mod_Sellswords.Strings.legend_sling_heavy_stone_skill <- {
	Tooltip1 = "Has a [color=%negative%]100%[/color] chance to stun and daze target on a hit to the head if not immunue and always staggers the target",
	Tooltip2 = "Has a [color=%negative%]100%[/color] chance to daze a target on a hit to the head and always staggers the target",
	Tooltip3 = "[color=%negative%]Can not be used because this character is engaged in melee[/color]",
	Log = "{1} struck a hit that leaves {2} dazed"
};

// mod_sellswords\hooks\skills\actives\miasma_skill.nut
::Mod_Sellswords.Strings.miasma_skill <- {
	Description = "Release a dense cloud of noxious gas that only effects living beings",
	Tooltip1 = "Has a range of [color=%positive%]{1}[/color] tiles",
	Tooltip2 = "Deals 5-10 damage directly to hitpoints to any living units that end their turn in the miasma",
	Tooltip3 = "Lasts for four turns. While the damage can't stack, you reset the duration if you overlap the tiles with subsequent casts"
};

// mod_sellswords\hooks\skills\actives\puncture.nut
::Mod_Sellswords.Strings.puncture <- {
	Tooltip1 = "Hit chance determined by your target's fatigue, remaining body armor and negative status like stunned, netted, grappled, etc. [color=%negative%]-50%[/color] hitchance if they are fresh and [color=%negative%]-0%[/color] if they are exhausted. Also has [color=%negative%]-1%[/color] chance to hit for every 5 points of Body Armor durability the target has above 125, up to a maximum of [color=%negative%]-35%[/color]. While negative status can provide you a total of [color=%positive%]+175%[/color] bonus.",
	Tooltip2 = "Completely ignores armor"
};

// mod_sellswords\hooks\skills\actives\raise_undead.nut
::Mod_Sellswords.Strings.raise_undead <- {
	Description = "Raise a corpse back to life as an undead, faithfully follows your bidding.",
	Tooltip1 = "Has a range of [color=%positive%]{1}[/color] tiles.",
	Tooltip2 = "Raises a suitable corpse as a Wiederganger, lasts until the end of combat."
};

// mod_sellswords\hooks\skills\actives\release_falcon_skill.nut
::Mod_Sellswords.Strings.release_falcon_skill <- {
	Description = "Release your falcon to gain vision of the surrounding 12 tiles for the duration of the current round. Can be used every other turn.",
	Tooltip = "You have [color=%positive%]{1}[/color] medicine."
};

// mod_sellswords\hooks\skills\actives\slash_lightning.nut
::Mod_Sellswords.Strings.slash_lightning <- {
	Tooltip1 = "Inflicts an additional [color=%damage%]15%[/color] damage that ignores armor to up to three targets",
	Tooltip2 = "Has [color=%positive%]+{1}%[/color] chance to hit"
};

// mod_sellswords\hooks\skills\actives\strike_skill.nut
::Mod_Sellswords.Strings.strike_skill <- {
	Tooltip1 = "Has a range of [color=%positive%]2[/color] tiles",
	Tooltip2 = "Has [color=%negative%]-15%[/color] chance to hit targets directly adjacent",
	Tooltip3 = "Do a free extra attack with [color=%positive%]25%[/color] damage(not regarded as critical strikes) on a hit",
	Tooltip4 = "Has [color=%positive%]+5%[/color] chance to hit",
	Tooltip5 = "Has [color=%negative%]-15%[/color] chance to hit targets directly adjacent because the weapon is too unwieldy"
};

// mod_sellswords\hooks\skills\actives\throw_dirt_skill.nut
::Mod_Sellswords.Strings.throw_dirt_skill <- {
	Description = "Throws dirt or sand to distract the enemy. Reduces Initiative, damage output and Block of the target by 35% for one turn. Wild Nomad used sand-attack!",
	Tooltip = "Leaves the target [color=%status%]Distracted[/color] for one turn, which reduces their Damage, Initiative and Block by [color=%negative%]35%[/color]",
	Log = "{1} throws dirt in {2}\'s face to distract them"
};

// mod_sellswords\hooks\skills\actives\zombie_bite.nut
::Mod_Sellswords.Strings.zombie_bite <- {
	Description = "A vicious bite. Will revive humanoid enemies as allied Wiedergangers if dealt as a killing blow.",
	Tooltip1 = "Has an additional [color=%positive%]15%[/color] chance to hit the head",
	Tooltip2 = "Can poison on hit"
};

// mod_sellswords\hooks\skills\backgrounds\anatomist_background.nut
::Mod_Sellswords.Strings.anatomist_background <- {
	BackgroundDescription = "Part scientist, part surgeon. Anatomists are unaccustomed to battle, but are blessed with steady hands.",
	Tooltip = "After a battle, has a chance to concoct a Sequence for each suitable enemy slain, the chance increases with each Anatomist in the company"
};

// mod_sellswords\hooks\skills\backgrounds\brawler_background.nut
::Mod_Sellswords.Strings.brawler_background <- {
	Tooltip = "[color=%positive%]+15%[/color] Damage when unarmed"
};

// mod_sellswords\hooks\skills\backgrounds\legend_beggar_commander_op_background.nut
::Mod_Sellswords.Strings.legend_beggar_commander_op_background <- {
	Log = "The framed beggar learned [color=%negative%]{1}[/color] from {2}"
};

// mod_sellswords\hooks\skills\backgrounds\legend_berserker_background.nut
::Mod_Sellswords.Strings.legend_berserker_background <- {
	Tooltip = "[color=%positive%]+15%[/color] Damage when unarmed"
};

// mod_sellswords\hooks\skills\backgrounds\legend_druid_background.nut
::Mod_Sellswords.Strings.legend_druid_background <- {
	Tooltip = "[color=%positive%]+15%[/color] Damage when unarmed"
};

// mod_sellswords\hooks\skills\backgrounds\legend_husk_background.nut
::Mod_Sellswords.Strings.legend_husk_background <- {
	Tooltip = "Davkul sees this one as spent goods without any value and will never ask you to sacrifice them."
};

// mod_sellswords\hooks\skills\effects\alp_potion_effect.nut
::Mod_Sellswords.Strings.alp_potion_effect <- {
	Tooltip1 = "Not affected by nighttime penalties\n[color=%positive%]+1[/color] Vision.",
	Tooltip2 = "Further mutations may cause this character\'s genes to spiral out of control, crippling them"
};

// mod_sellswords\hooks\skills\effects\ancient_priest_potion_effect.nut
::Mod_Sellswords.Strings.ancient_priest_potion_effect <- {
	Tooltip1 = "Morale cannot be reduced below Steady\n[color=%positive%]+10[/color] Resolve.",
	Tooltip2 = "Further mutations may cause this character\'s genes to spiral out of control, crippling them"
};

// mod_sellswords\hooks\skills\effects\bleeding_effect.nut
::Mod_Sellswords.Strings.bleeding_effect <- {
	Log = "{1} had his bleeding wound quickly close thanks to his unnatural physiology",
	Name = "Bleeding from grazes",
	Text1 = "This character is bleeding profusely from a recently received wound and will lose [color=%negative%]{1}[/color] hitpoints each turn for [color=%negative%]{2}[/color] more turn(s).",
	Text2 = "This character is bleeding slowly from multiple recent deep grazes [color=%negative%]{1}[/color] hitpoints each turn for [color=%negative%]{2}[/color] more turn(s)."
};

// mod_sellswords\hooks\skills\effects\dazed_effect.nut
::Mod_Sellswords.Strings.dazed_effect <- {
	Log = "{1} shook off being dazed thanks to his unnatural physiology"
};

// mod_sellswords\hooks\skills\effects\debilitating_attack_effect.nut
::Mod_Sellswords.Strings.debilitating_attack_effect <- {
	Description = "This character has a debilitating attack prepared. Hitting a target will temporarily reduce their ability to inflict damage and increase damage recieved for three turns. Effect removes itself on turn end after a succesful hit or after 3 attacks. Works on Attacks of Opportunity"
};

// mod_sellswords\hooks\skills\effects\direwolf_potion_effect.nut
::Mod_Sellswords.Strings.direwolf_potion_effect <- {
	Tooltip1 = "Attacks that miss have [color=%positive%]50%[/color] of their Fatigue cost refunded\n[color=%positive%]+10[/color] Fatigue.",
	Tooltip2 = "Further mutations may cause this character\'s genes to spiral out of control, crippling them"
};

// mod_sellswords\hooks\skills\effects\disarmed_effect.nut
::Mod_Sellswords.Strings.disarmed_effect <- {
	Log = "{1} quickly recovers from being disarmed thanks to his unnatural physiology"
};

// mod_sellswords\hooks\skills\effects\distracted_effect.nut
::Mod_Sellswords.Strings.distracted_effect <- {
	Log = "{1} regained his focus thanks to his unnatural physiology"
};

// mod_sellswords\hooks\skills\effects\fallen_hero_potion_effect.nut
::Mod_Sellswords.Strings.fallen_hero_potion_effect <- {
	Tooltip1 = "This character accumulates no Fatigue from enemy attacks, whether they hit or miss\n[color=%positive%]+10[/color] Hitpoints.",
	Tooltip2 = "Further mutations may cause this character\'s genes to spiral out of control, crippling them"
};

// mod_sellswords\hooks\skills\effects\geist_potion_effect.nut
::Mod_Sellswords.Strings.geist_potion_effect <- {
	Tooltip1 = "An additional [color=%positive%]10%[/color] of damage ignores armor when using melee weapons.",
	Tooltip2 = "Further mutations may cause this character\'s genes to spiral out of control, crippling them"
};

// mod_sellswords\hooks\skills\effects\goblin_grunt_potion_effect.nut
::Mod_Sellswords.Strings.goblin_grunt_potion_effect <- {
	Tooltip1 = "The Action Point costs of the Rotation and Footwork skills are reduced by [color=%positive%]1[/color]. Does not stack with other reductions.",
	Tooltip2 = "The Fatigue costs of the Rotation and Footwork skills are reduced by [color=%positive%]50%[/color]. Does not stack with other reductions.\n[color=%positive%]+10[/color] Initiative.",
	Tooltip3 = "Further mutations may cause this character\'s genes to spiral out of control, crippling them"
};

// mod_sellswords\hooks\skills\effects\goblin_overseer_potion_effect.nut
::Mod_Sellswords.Strings.goblin_overseer_potion_effect <- {
	Tooltip1 = "An additional [color=%positive%]5%[/color] of damage ignores armor when using bows or crossbows.\n[color=%positive%]+10[/color] Ranged Skill.\n[color=%positive%]+10[/color] Ranged Defense.",
	Tooltip2 = "Further mutations may cause this character\'s genes to spiral out of control, crippling them"
};

// mod_sellswords\hooks\skills\effects\honor_guard_potion_effect.nut
::Mod_Sellswords.Strings.honor_guard_potion_effect <- {
	Tooltip1 = "This character takes between [color=%positive%]25%[/color] and [color=%positive%]50%[/color] less damage from piercing attacks, such as those from bows or spears.\n[color=%positive%]+10[/color] Hitpoints.",
	Tooltip2 = "Further mutations may cause this character\'s genes to spiral out of control, crippling them"
};

// mod_sellswords\hooks\skills\effects\horrified_effect.nut
::Mod_Sellswords.Strings.horrified_effect <- {
	Log = "{1} resists being frozen with fear thanks to his unnatural physiology"
};

// mod_sellswords\hooks\skills\effects\hyena_potion_effect.nut
::Mod_Sellswords.Strings.hyena_potion_effect <- {
	Tooltip1 = "Damage received from the Bleeding status effect is reduced by [color=%negative%]50%[/color].\n[color=%positive%]+10[/color] Hitpoints.",
	Tooltip2 = "Further mutations may cause this character\'s genes to spiral out of control, crippling them"
};

// mod_sellswords\hooks\skills\effects\indomitable_effect.nut
::Mod_Sellswords.Strings.indomitable_effect <- {
	Tooltip1 = "Only receive [color=%positive%]{1}%[/color] of any damage",
	Tooltip2 = "Base Resolve will be increased by [color=%positive%]{1}%[/color]",
	Tooltip3 = "Become immune to being stunned",
	Tooltip4 = "Become immune to being knocked back or grabbed"
};

// mod_sellswords\hooks\skills\effects\insect_swarm_effect.nut
::Mod_Sellswords.Strings.insect_swarm_effect <- {
	Log = "{1} repels insects with his unnatural physiology"
};

// mod_sellswords\hooks\skills\effects\legend_beer_buzz_effect .nut
::Mod_Sellswords.Strings.legend_beer_buzz_effect  <- {
	Text = "After guzzling beer, this character has [color=%positive%]+9%[/color] damage, damage reduction and  [color=%positive%]+18%[/color] Resolve. At the expense of [color=%negative%]-6%[/color] initiative and hitchance for [color=%negative%]{1}[/color] turn(s).",
	Tooltip1 = "[color=%positive%]+9%[/color] Damage",
	Tooltip2 = "[color=%positive%]+9%[/color] Damage Reduction",
	Tooltip3 = "[color=%positive%]+18%[/color] Resolve",
	Tooltip4 = "[color=%negative%]-6%[/color] Melee Skill",
	Tooltip5 = "[color=%negative%]-6%[/color] Ranged Skill",
	Tooltip6 = "[color=%negative%]-6%[/color] Initiative"
};

// mod_sellswords\hooks\skills\effects\legend_coordinating_volleys_effect.nut
::Mod_Sellswords.Strings.legend_coordinating_volleys_effect <- {
	Tooltip = "The penalty from ranged cover is reduced by [color=%positive%]20%[/color]"
};

// mod_sellswords\hooks\skills\effects\legend_grappled_effect.nut
::Mod_Sellswords.Strings.legend_grappled_effect <- {
	Tooltip1 = "[color=%negative%]-15[/color] Fatigue recovered per turn",
	Tooltip2 = "[color=%negative%]-40%[/color] Maximum Fatigue"
};

// mod_sellswords\hooks\skills\effects\legend_mead_warmth_effect.nut
::Mod_Sellswords.Strings.legend_mead_warmth_effect <- {
	Text = "After consuming mead, this character has [color=%positive%]+12%[/color] damage, damage reduction and  [color=%positive%]+24%[/color] Resolve. At the expense of [color=%negative%]-9%[/color] initiative and hitchance for [color=%negative%]{1}[/color] turn(s).",
	Tooltip1 = "[color=%positive%]+12%[/color] Damage",
	Tooltip2 = "[color=%positive%]+12%[/color] Damage Reduction",
	Tooltip3 = "[color=%positive%]+24%[/color] Resolve",
	Tooltip4 = "[color=%negative%]-8%[/color] Melee Skill",
	Tooltip5 = "[color=%negative%]-8%[/color] Ranged Skill",
	Tooltip6 = "[color=%negative%]-8%[/color] Initiative"
};

// mod_sellswords\hooks\skills\effects\legend_return_favor_effect.nut
::Mod_Sellswords.Strings.legend_return_favor_effect <- {
	Log1 = "{1} has stunned {2} for one turn",
	Log2 = "{1} has dazed {2} for one turn",
	Log3 = "{1} has staggered {2} for one turn"
};

// mod_sellswords\hooks\skills\effects\legend_safeguarding_effect.nut
::Mod_Sellswords.Strings.legend_safeguarding_effect <- {
	Description = "This character\'s guard is down while safeguarding"
};

// mod_sellswords\hooks\skills\effects\legend_skin_ghoul_blood_effect.nut
::Mod_Sellswords.Strings.legend_skin_ghoul_blood_effect <- {
	Tooltip1 = "[color=%positive%]+ {1}[/color] this turn",
	Tooltip2 = "cure all fresh injuries",
	Log = "{1} heals for {2} points"
};

// mod_sellswords\hooks\skills\effects\legend_wine_tipsy_effect.nut
::Mod_Sellswords.Strings.legend_wine_tipsy_effect <- {
	Text = "After imbibing wine, this character has [color=%positive%]+15%[/color] damage, damage reduction and  [color=%positive%]+30%[/color] Resolve. At the expense of [color=%negative%]-10%[/color] initiative and hitchance for [color=%negative%]{1}[/color] turn(s).",
	Tooltip1 = "[color=%positive%]+15%[/color] Damage",
	Tooltip2 = "[color=%positive%]+15%[/color] Damage Reduction",
	Tooltip3 = "[color=%positive%]+30%[/color] Resolve",
	Tooltip4 = "[color=%negative%]-10%[/color] Melee Skill",
	Tooltip5 = "[color=%negative%]-10%[/color] Ranged Skill",
	Tooltip6 = "[color=%negative%]-10%[/color] Initiative"
};

// mod_sellswords\hooks\skills\effects\legend_zombie_poison_effect.nut
::Mod_Sellswords.Strings.legend_zombie_poison_effect <- {
	Tooltip1 = "[color=%negative%]-{1}[/color] Action Points",
	Tooltip2 = "[color=%negative%]-{1}[/color] Vision",
	Tooltip3 = "[color=%negative%]-{1}[/color] Initiative"
};

// mod_sellswords\hooks\skills\effects\lindwurm_potion_effect.nut
::Mod_Sellswords.Strings.lindwurm_potion_effect <- {
	Tooltip1 = "This character\'s blood burns with acid, damaging adjacent attackers whenever they deal hitpoint damage.",
	Tooltip3 = "This character has the blood of Dragons coursing through them.\n[color=%positive%]+15[/color] Hitpoints.\n[color=%positive%]+15%[/color] additional damage with attacks.",
	Tooltip4 = "Further mutations may cause this character\'s genes to spiral out of control, crippling them"
};

// mod_sellswords\hooks\skills\effects\nachzehrer_potion_effect.nut
::Mod_Sellswords.Strings.nachzehrer_potion_effect <- {
	Text = "This character\'s body has mutated to regrow skin and muscle tissue much more quickly than normal and they gain the speed of nachzehrer. Deep injuries heal much faster than normal as a result. They also seem to have developed a hunger for fresh meat, but that\'s probably unrelated.",
	Tooltip2 = "Reduces the time it takes to heal from any injury by one day, down to a mininum of one day.\n[color=%positive%]+10[/color] Initiative.",
	Tooltip3 = "Further mutations may cause this character\'s genes to spiral out of control, crippling them"
};

// mod_sellswords\hooks\skills\effects\necrosavant_potion_effect.nut
::Mod_Sellswords.Strings.necrosavant_potion_effect <- {
	Tooltip2 = "Heal [color=%positive%]15%[/color] of hitpoint damage inflicted on adjacent enemies that have blood\n[color=%positive%]+10[/color] Hitpoints.\n[color=%positive%]+5[/color] Melee Skill.",
	Tooltip3 = "Further mutations may cause this character\'s genes to spiral out of control, crippling them",
	Log = "{1} heals for {2} points"
};

// mod_sellswords\hooks\skills\effects\net_effect.nut
::Mod_Sellswords.Strings.net_effect <- {
	Tooltip1 = "[color=%negative%]Unable to move[/color]",
	Tooltip2 = "[color=%negative%]-{1}%[/color] Melee Defense",
	Tooltip3 = "[color=%negative%]-{1}%[/color] Ranged Defense",
	Tooltip4 = "[color=%negative%]-{1}%[/color] Initiative",
	Tooltip5 = "[color=%negative%]-50%[/color] Block"
};

// mod_sellswords\hooks\skills\effects\orc_berserker_potion_effect.nut
::Mod_Sellswords.Strings.orc_berserker_potion_effect <- {
	Name = "Hyperactive Glands",
	Tooltip1 = "This character gains two stacks of Rage each time they take hitpoint damage, and loses one stack at the end of each turn.",
	Tooltip2 = "Further mutations may cause this character\'s genes to spiral out of control, crippling them"
};

// mod_sellswords\hooks\skills\effects\orc_warlord_potion_effect.nut
::Mod_Sellswords.Strings.orc_warlord_potion_effect <- {
	Name = "Improved Limbic System",
	Tooltip1 = "Using orc weapons no longer imposes additional fatigue costs\n[color=%positive%]+10[/color] Fatigue.",
	Tooltip2 = "Further mutations may cause this character\'s genes to spiral out of control, crippling them"
};

// mod_sellswords\hooks\skills\effects\orc_warrior_potion_effect.nut
::Mod_Sellswords.Strings.orc_warrior_potion_effect <- {
	Tooltip2 = "[color=%positive%]33%[/color] chance to resist the Dazed, Staggered, Stunned, Distracted, and Withered status effects\n[color=%positive%]+10[/color] Hitpoints.",
	Tooltip3 = "Further mutations may cause this character\'s genes to spiral out of control, crippling them"
};

// mod_sellswords\hooks\skills\effects\orc_young_potion_effect.nut
::Mod_Sellswords.Strings.orc_young_potion_effect <- {
	Name = "Shock Absorbant Wrists",
	Text = "This character\'s wrists have mutated in such a way that the they dampen the initial shock of opposing forces. In more practical terms, this lets them hit harder. They can also make some pretty outlandish shadow puppets.",
	Tooltip2 = "Attacks do [color=%positive%]+10%[/color] additional damage",
	Tooltip3 = "Further mutations may cause this character\'s genes to spiral out of control, crippling them"
};

// mod_sellswords\hooks\skills\effects\overwhelmed_effect.nut
::Mod_Sellswords.Strings.overwhelmed_effect <- {
	Tooltip1 = "[color=%negative%]-{1}%[/color] Melee Skill",
	Tooltip2 = "[color=%negative%]-{1}%[/color] Ranged Skill",
	Hover = "[color=%negative%]-{1}%[/color] "
};

// mod_sellswords\hooks\skills\effects\schrat_potion_effect.nut
::Mod_Sellswords.Strings.schrat_potion_effect <- {
	Name = "Schrat Symbiosis",
	Text = "With the proper concoction, and implanting the heart of schrat into the body, the test subject can form a symbiosis with the heart, gaining the abilities and properties of a Schrat.",
	Tooltip1 = "Greatly reduces any form of piercing damage, but you take 100% more burning damage.",
	Tooltip3 = "Immune to being knocked back or grabbed.",
	Tooltip4 = "Further mutations may cause this character\'s genes to spiral out of control, crippling them"
};

// mod_sellswords\hooks\skills\effects\serpent_potion_effect.nut
::Mod_Sellswords.Strings.serpent_potion_effect <- {
	Name = "Venom Glands",
	Text = "This character has developed venom glands that allow them to produce poison strong enough to kill any man. Sadly they do not have the fangs of a snake or spider to deliver this venom and have to resort using piercing or cutting weapons to apply it.",
	Tooltip2 = "Piercing or cutting attacks poison the target.\n[color=%positive%]+15[/color] Initiative.\n[color=%positive%]+5[/color] Melee Skill.",
	Tooltip3 = "Further mutations may cause this character\'s genes to spiral out of control, crippling them",
	Log = "{1} is poisoned"
};

// mod_sellswords\hooks\skills\effects\skeleton_warrior_potion_effect.nut
::Mod_Sellswords.Strings.skeleton_warrior_potion_effect <- {
	Tooltip1 = "Reduces the Fatigue cost of the \'Shieldwall\' skill by [color=%positive%]{1}%[/color]\n[color=%positive%]+10[/color] Melee Defense.\n[color=%positive%]+10[/color] Fatigue.",
	Tooltip2 = "Further mutations may cause this character\'s genes to spiral out of control, crippling them"
};

// mod_sellswords\hooks\skills\effects\staggered_effect.nut
::Mod_Sellswords.Strings.staggered_effect <- {
	Log = "{1} shook off being staggered thanks to his unnatural physiology"
};

// mod_sellswords\hooks\skills\effects\stunned_effect.nut
::Mod_Sellswords.Strings.stunned_effect <- {
	Tooltip1 = "[color=%negative%]-35%[/color] Melee Defense",
	Tooltip2 = "[color=%negative%]-35%[/color] Ranged Defense",
	Log1 = "{1} resists the Stun with {2} and is Dazed instead.",
	Log2 = "{1} shakes off the stun but loses {2}",
	Log3 = "{1} shook off being stunned thanks to his unnatural physiology"
};

// mod_sellswords\hooks\skills\effects\unhold_potion_effect.nut
::Mod_Sellswords.Strings.unhold_potion_effect <- {
	Tooltip2 = "Heals [color=%positive%]5[/color] Hitpoints each turn. Cannot heal if poisoned.",
	Tooltip4 = "Further mutations may cause this character\'s genes to spiral out of control, crippling them",
	Log1 = "{1}\'s Hyperactive Cell Growth mutation regenerated {2} hitpoints"
};

// mod_sellswords\hooks\skills\effects\wiederganger_potion_effect.nut
::Mod_Sellswords.Strings.wiederganger_potion_effect <- {
	Tooltip1 = "The threshold to sustain injuries on getting hit is increased by [color=%positive%]33%[/color].\n[color=%positive%]+10[/color] Hitpoints.",
	Tooltip2 = "Further mutations may cause this character\'s genes to spiral out of control, crippling them"
};

// mod_sellswords\hooks\skills\effects\withered_effect.nut
::Mod_Sellswords.Strings.withered_effect <- {
	Log = "{1} quickly recovered from withering thanks to his unnatural physiology"
};

// mod_sellswords\hooks\skills\perks\perk_legend_balance.nut
::Mod_Sellswords.Strings.perk_legend_balance <- {
	Tooltip1 = "[color=%positive%]+{1}[/color] Melee Defense",
	Tooltip2 = "[color=%positive%]+{1}[/color] Ranged Defense",
	Tooltip3 = "[color=%negative%]-{1}[/color] Ranged Defense",
	Tooltip4 = "This character is not wearing any body armor and hence receives no bonus from this perk",
	Tooltip5 = "This character\'s Initiative is too low to gain Melee Defense from this perk",
	Tooltip6 = "The penalty to Initiative from built-up Fatigue is reduced by [color=%positive%]30%[/color]",
	Hover = "[color=%positive%]+{1}[/color] Melee Defense, {2} Ranged Defense"
};

// mod_sellswords\hooks\skills\perks\perk_legend_escape_artist.nut
::Mod_Sellswords.Strings.perk_legend_escape_artist <- {
	Log1 = "{1} breaks free (Chance: {2}, Rolled: {3})",
	Log2 = "{1} fails to break free (Chance: {2}, Rolled: {3})"
};

// mod_sellswords\hooks\skills\perks\perk_legend_in_the_zone.nut
::Mod_Sellswords.Strings.perk_legend_in_the_zone <- {
	Tooltip1 = "+[color=%positive%]{1}%[/color] Melee Skill",
	Tooltip2 = "+[color=%positive%]{1}%[/color] Melee Defense",
	Tooltip3 = "+[color=%positive%]{1}%[/color] Melee Damage",
	Tooltip4 = "Melee Damage bonus [color=%negative%]halved[/color] due to not being engaged in melee"
};

// mod_sellswords\hooks\skills\perks\perk_legend_last_stand.nut
::Mod_Sellswords.Strings.perk_legend_last_stand <- {
	Tooltip1 = "Your melee and ranged defense are increased by [color=%positive%]{1}[/color].",
	Tooltip2 = "Immune to the effects of fresh injuries, and not upset by health losses.",
	Tooltip3 = "Action Points are increased by [color=%positive%]{1}[/color]."
};

// mod_sellswords\hooks\skills\perks\perk_legend_lithe.nut
::Mod_Sellswords.Strings.perk_legend_lithe <- {
	Tooltip1 = "Damage to hitpoints from attacks is reduced by [color=%positive%]{1}%[/color]",
	Tooltip2 = "Damage to armor from attacks is reduced by [color=%positive%]{1}%[/color]",
	Tooltip3 = "[color=%negative%]This character\'s body and head armor are too heavy to gain any benefit from being lithe[/color]",
	Hover = "[color=%negative%]-{1}%[/color] armor damage taken, [color=%negative%]-{2}%[/color] hitpoint damage taken"
};

// mod_sellswords\hooks\skills\perks\perk_legend_muscularity.nut
::Mod_Sellswords.Strings.perk_legend_muscularity <- {
	Tooltip = "[color=%positive%]+{1}[/color] damage on melee attacks costing 4 AP and [color=%positive%]+{2}[/color] on those costing 6 AP (based on current Hitpoints)",
	Hover = "[color=%positive%]+{1}[/color] / [color=%positive%]+{2}[/color] damage on 4 / 6 AP attacks"
};

// mod_sellswords\hooks\skills\racial\ghost_racial.nut
::Mod_Sellswords.Strings.ghost_racial <- {
	Description = "This character doesn\'t have a corporeal form, making it extremely hard to land a hit.",
	Tooltip1 = "Is always [color=%positive%]Levitating[/color]",
	Tooltip2 = "Immune to bleeding, poison and most types of injuries.",
	Tooltip3 = "Not effected by fatigue, but needs fatigue to equip items.",
	Tooltip4 = "Not affected by morale or allies fleeing and dying.",
	Tooltip5 = "Experience is gained at 50% normal rate."
};

// mod_sellswords\hooks\skills\racial\legend_mummy_racial.nut
::Mod_Sellswords.Strings.legend_mummy_racial <- {
	Name = "Curse of the Mummy",
	Description = "Curse the attacker upon death, making them recieve 10% more damage from all sources.",
	Tooltip = "Curse the attacker on death"
};

// mod_sellswords\hooks\skills\racial\skeleton_racial.nut
::Mod_Sellswords.Strings.skeleton_racial <- {
	Name = "Resistant to Ranged Attacks",
	Description = "Ranged, Slashing and Piercing attacks are not very effective against this character."
};

// mod_sellswords\hooks\skills\racial\vampire_racial.nut
::Mod_Sellswords.Strings.vampire_racial <- {
	Name = "Bloodthirsty Curse",
	Description = "Strikes against enemy hitpoints restore your health by an amount equal to the damage dealt.",
	Tooltip1 = "Strikes against enemy hitpoints restore your health by an amount equal to the damage dealt.",
	Tooltip2 = "Immune to bleeding, poison and stuns.",
	Tooltip3 = "Not effected by fatigue, but needs fatigue to equip items.",
	Tooltip4 = "Always has [color=%negative%]0%[/color] chance to survive being struck down."
};

// mod_sellswords\hooks\skills\special\double_grip.nut
::Mod_Sellswords.Strings.double_grip <- {
	Tooltip = "+[color=%positive%]{1}%[/color] Damage"
};

// mod_sellswords\hooks\skills\traits\glorious_endurance_trait.nut
::Mod_Sellswords.Strings.glorious_endurance_trait <- {
	Description = "Forged in the arenas of the south, this character has fought many a battle, and every blow will only strengthen their indomitable will and endurance. This fabulous lifestyle demands high pay, and should fewer than two gladiators remain in your company, your campaign ends.",
	Wage = "[color=%negative%]+50%[/color] Daily Wage"
};

// mod_sellswords\hooks\skills\traits\glorious_quickness_trait.nut
::Mod_Sellswords.Strings.glorious_quickness_trait <- {
	Description = "Forged in the arenas of the south, this character has fought many a battle, and is an expert in dispatching multiple opponents in a row. This fabulous lifestyle demands high pay, and should fewer than two gladiators remain in your company, your campaign ends.",
	Wage = "[color=%negative%]+50%[/color] Daily Wage"
};

// mod_sellswords\hooks\skills\traits\glorious_resolve_trait.nut
::Mod_Sellswords.Strings.glorious_resolve_trait <- {
	Description = "Forged in the arenas of the south, this character has fought man and beast alike, and it takes a lot to break their resolve. This fabulous lifestyle demands high pay, and should fewer than two gladiators remain in your company, your campaign ends.",
	Wage = "[color=%negative%]+50%[/color] Daily Wage"
};

// mod_sellswords\hooks\skills\traits\huge_trait.nut
::Mod_Sellswords.Strings.huge_trait <- {
	Tooltip1 = "Weapons with extra Fatigue build-up on skills have no penalty for this character",
	Tooltip2 = "Weapons with extra Fatigue build-up on skills have this penalty reduced by [color=%positive%]-3[/color]"
};

// mod_sellswords\hooks\skills\traits\oath_of_fortification_trait.nut
::Mod_Sellswords.Strings.oath_of_fortification_trait <- {
	Tooltip = "The \'Shield Wall\' shield skill has grants an additional [color=%positive%]+10[/color] Melee Defense and [color=%positive%]+10[/color] Ranged Defense."
};

// mod_sellswords\hooks\skills\traits\oath_of_honor_trait.nut
::Mod_Sellswords.Strings.oath_of_honor_trait <- {
	Tooltip = "Starts combat at Confident morale if permitted by mood. When you are at Confident morale, gain [color=%positive%]+20%[/color] resolve."
};

// mod_sellswords\hooks\skills\traits\oath_of_sacrifice_trait.nut
::Mod_Sellswords.Strings.oath_of_sacrifice_trait <- {
	Tooltip = "Is not paid any wage. And the threshold to sustain injuries on getting hit is increased by [color=%positive%]20%[/color]"
};

// mod_sellswords\hooks\skills\traits\oath_of_valor_trait.nut
::Mod_Sellswords.Strings.oath_of_valor_trait <- {
	Tooltip = "Will not flee in battle. while all attributes debuff cause by low morale will be [color=%positive%]halved[/color]"
};

// mod_sellswords\hooks\skills\traits\oath_of_wrath_trait.nut
::Mod_Sellswords.Strings.oath_of_wrath_trait <- {
	Tooltip = "[color=%negative%]-5[/color] Ranged Defense"
};

// mod_sellswords\hooks\skills\traits\old_trait.nut
::Mod_Sellswords.Strings.old_trait <- {
	Tooltip = "[color=%negative%]-15%[/color] Melee Damage"
};

// mod_sellswords\hooks\ui\screens\tooltip\tooltip_events.nut
::Mod_Sellswords.Strings.tooltip_events <- {
	Tooltip1 = "Experience",
	Tooltip2 = "Characters gain experience as they or their allies slay enemies in battles. If a character has accumulated sufficient experience, they\'ll level up and be able to increase attributes and pick a perk that grants a unique bonus.\n\nBeyond the 11th character level, main characters gain a perk every two levels, and supporting characters gain a perk every five levels.",
	Tooltip3 = "Level",
	Tooltip4 = "The character\'s level measures experience in battle. Characters rise in levels as they gain experience and are able to increase their attributes and gain perks that make them better at the mercenary profession.\n\nBeyond the 11th character level, main characters gain a perk every two levels, and supporting characters gain a perk every five levels.",
	Tooltip5 = "This character is currently in the fighting line. Click to toggle character into reserves status. (Hotkey \'S\', \'A\' and \'D\' to cycle bros)",
	Tooltip6 = "This character is currently in reserves. Click to toggle character into the fighting line. While in reserves, character will eat and drink more supplies, and only participate in combat if company is under attack. (Hotkey \'S\', \'A\' and \'D\' to cycle bros)",
	Tooltip7 = "Reserves/Fighting Status"
};

// scripts\ai\tactical\behaviors\ssu_necro_ai_spawn_ghost_fragment.nut
::Mod_Sellswords.Strings.ssu_necro_ai_spawn_ghost_fragment <- {
	Name = "{1}\'s Fragment"
};

// scripts\contracts\contracts\ssu_destroy_rebellions_contract.nut
::Mod_Sellswords.Strings.ssu_destroy_rebellions_contract <- {
	Name = "Destroy Rebellions",
	Description = "A group of outlaws, trying to overthrow the noble house.",
	Title1 = "Negotiations",
	Text1 = "[img]gfx/ui/events/event_63.png[/img]{%employer%\'s sitting in his chair with pursed lips. He\'s twirling a dagger, the tip gouging a divot into his desk, and the air is more tense than usual. You\'re blocked from getting anywhere near him and his underlings by large iron bars that have descended from the ceiling. They converse among themselves, nodding occasionally, before handing a servant a scroll. You watch as the servant rushes to you. He hands it over and then recites its contents from memory.%SPEECH_ON%A large group of rebels is assembling to take over %townname%. A savage so strong and vicious that he threatens to lead a bandit horde. After which, I suspect the leader of them will want to expand on his realm. Considerable crowns are available for the man or men who can crush this band of upstarts.%SPEECH_OFF%}",
	Text2 = "{What is %townname% prepared to pay for their safety? | This should be worth a good amount of crowns to you, right?}",
	Text3 = "Negotiation",
	Text4 = "{I\'m afraid you\'re on your own. | We have more important matters to settle. | I wish you luck, but we\'ll not be part of this.}",
	Title2 = "Near %townname%",
	Text5 = "[img]gfx/ui/events/event_36.png[/img]The rebellions are in sight! Prepare for battle and protect the town!",
	Text6 = "To arms!",
	Text7 = "[img]gfx/ui/events/event_22.png[/img]{The fighting is over and the men idle in a welcome respite. %employer% will be waiting for you back in town. | With the battle over, you survey the corpses littering the field. It is a gruesome sight, yet for some reason, it fills you with joy. The ghastly hills of dead only remind you of the bastards you\'ve yet to rid this horrid world of. People like %employer% should come and see it, but he won\'t, so you\'ll have to go and see him instead. | Flesh and bone are scattered across the field, hardly discernible from one owner to the next. Black buzzards cycle overhead, halos of chevron shadows rippling over the dead, the birds waiting for the mourners to clear out. %randombrother% comes to your side and asks if they should start the return trip to %employer%. You leave the sight of the battlefield behind and nod. | A peaceful sort of ruin is made of the dead. Like it was their natural state, stiffened and at a permanent loss, and their whole life was but a fleeting fit of an accident finally come to an end. %randombrother% comes up and asks if you\'re alright. You\'re not sure, to be honest, and simply answer that it is time to go see %employer%. | Misshapen men and crooked corpses litter the ground, for battle gives the dead no sovereignty over how one comes to a final rest. The bodiless heads look at most peace, for in battle no man or beast has time to truly hack a neck away, it only comes by the quickest and sharpest of blade swings. A part of you hopes to go with such instant finality, but another part hopes you get the chance to take your killer down with you.\n\n %randombrother% comes to your side and asks for orders. You turn away from the field and tell the %companyname% to get ready to return to %employer%.}",
	Text8 = "We head back to the townhall!",
	Text9 = "[img]gfx/ui/events/event_30.png[/img]Smoke fills the air, smoke and the caustic smell of burning wood, burning livelihoods. %townname%\'s folk put all their hopes into hiring the %companyname%, a fatal mistake.",
	Text10 = "That didn\'t go as planned...",
	Title3 = "At %townname%",
	Text11 = "[img]gfx/ui/events/event_78.png[/img]{A troop of noble soldiers arrives. Their leading knight tips his helmet.%SPEECH_ON%When they told me to come out this way to aide a sellsword, I said they can go shit that command out their arse. But you know what convinced me? Knowing it was the %companyname%. You\'ve reputation, and I\'ve men to spare for this fight.%SPEECH_OFF%Judging by their equipment, they\'d be best used as a screening force to perhaps draw away elements of the oncoming enemy force. That, or perhaps it\'d be best to just fold them into the company, bolstering your ranks where you\'re already strongest.\n[color={1}][u]Warning:[/u] [/color]Make sure the sum of your fighting roster and allies is less than 27, or the game will crash.}",
	Text12 = "A typical standing army will easily handle it.",
	Text13 = "Ranged fire support will provide overwhelming combat power.",
	Text14 = "Those strongest soldiers will help us break through their frontline.",
	Text15 = "Bodyguards are enough.",
	Title4 = "On your return...",
	Text16 = "[img]gfx/ui/events/event_04.png[/img]{You return to %employer% looking rightfully smug.%SPEECH_ON%Work\'s done.%SPEECH_OFF%He nods, tipping a goblet of wine but not necessarily offering it.%SPEECH_ON%Yes. The town is eternally grateful for your help. They are also... monetarily grateful.%SPEECH_OFF%The man gestures toward the corner of the room. You see a satchel of crowns there.%SPEECH_ON%%reward% crowns, just as we agreed. Thanks again, sellsword.%SPEECH_OFF% | %employer% welcomes your return with a glass of wine.%SPEECH_ON%Drink up, sellsword, you\'ve earned it.%SPEECH_OFF%It tastes... particular. Haughty, if that could be a flavor. Your employer swings around his desk, taking a gleefully happy seat.%SPEECH_ON%You managed to protect the town just as you promised! I am most impressed.%SPEECH_OFF%He nods, tipping his goblet toward a wooden chest.%SPEECH_ON%MOST impressed.%SPEECH_OFF%You open the chest to find a bevy of golden crowns. | %employer% welcomes you into his room.%SPEECH_ON%I watched from my window, you know? Saw it all. Well, most of it. The good parts, I suppose.%SPEECH_OFF%You raise an eyebrow.%SPEECH_ON%Oh, don\'t give me that look. I don\'t feel bad for enjoying what I saw. We\'re alive, right? Us, the good guys.%SPEECH_OFF%The other eyebrow goes up.%SPEECH_ON%Well... anyway, your payment, as promised.%SPEECH_OFF%The man hands over a chest of %reward% crowns. | When you return to %employer%, you find his room almost packed up, everything ready to move and go. You raise a bit of humorous concern.%SPEECH_ON%Getting ready to go somewhere?%SPEECH_OFF%The man\'s settled into his chair.%SPEECH_ON%I had my doubts, sellsword. Can you blame me? For what it\'s worth, you shouldn\'t doubt my ability to pay.%SPEECH_OFF%He gestures across his desk. On the corner is a satchel, lumpy and bulbous with coins.%SPEECH_ON%%reward% crowns, as promised.%SPEECH_OFF% | %employer% rises from his chair when you enter. He bows, somewhat incredulously, but also earnestly. He tips his head toward the window where the din of happy peasants murmurs.%SPEECH_ON%You hear that? You\'ve earned that, mercenary. The people here love you now.%SPEECH_OFF%You nod, but the love of the common man is not what brought you here.%SPEECH_ON%What else have I earned?%SPEECH_OFF%%employer% smiles.%SPEECH_ON%A man on point. I bet that\'s what gives you your... edge. Of course, you\'ve also earned this.%SPEECH_OFF%He heaves a wooden chest onto his desk and unlatches it. The shine of gold crowns warms your heart. | %employer%\'s staring out his window when you enter. He\'s almost in a dream state, head bent low to his hand. You interrupt his thoughts.%SPEECH_ON%Thinking of me?%SPEECH_OFF%The man chuckles and playfully clutches his chest.%SPEECH_ON%You are truly the man of my dreams, mercenary.%SPEECH_OFF%He crosses the room and takes a chest from the bookshelf. He unlatches it as he sets it on the table. A glorious pile of gold crowns stares you in the face. %employer% grins.%SPEECH_ON%Now who is dreaming?%SPEECH_OFF% | %employer%\'s at his desk when you enter.%SPEECH_ON%I saw a good deal of it. The killing, the dying.%SPEECH_OFF%You take a seat.%SPEECH_ON%Hope you enjoyed the show. Viewing ain\'t free, though.%SPEECH_OFF%The man nods, taking a satchel and handing it over.%SPEECH_ON%I\'d pay for an encore, but I\'m not sure %townname% wants that.%SPEECH_OFF%}",
	Text17 = "{The %companyname% will make good use of this. | Payment for a hard day\'s work.}",
	Tooltip = "You gain [color={1}]{2}[/color] Crowns",
	Text18 = "[img]gfx/ui/events/event_30.png[/img]{%employer% welcomes your return with a point out his window.%SPEECH_ON%You see that? There, in the distance.%SPEECH_OFF%You join his side. He asks.%SPEECH_ON%What is it that you see?%SPEECH_OFF%There\'s smoke on the horizon. You let him know that\'s what you see.%SPEECH_ON%Right, smoke. I didn\'t hire you to let the brigands make smoke, understand? Of course... most of the town is still upright...%SPEECH_OFF%He heaves a satchel into your chest.%SPEECH_ON%Good work, sellsword. Just... not good enough.%SPEECH_OFF% | You return to %employer%, who looks a mix of happy and sad, somewhere between drunk and sober. This is not the look you want to see.%SPEECH_ON%You did well, sellsword. Word has it you laid those brigands utterly flat. Word also has it that they burned parts of our outskirts.%SPEECH_OFF%You nod. No point in lying about what can\'t be hidden.%SPEECH_ON%You\'ll be getting paid, but you have to understand that it takes money to rebuild those areas. Obviously, the crowns for that will be coming out of your pay...%SPEECH_OFF% | %employer%\'s slouched in his seat when you return.%SPEECH_ON%Most in %townname% are happy, but a few are not. Can you guess which ones aren\'t?%SPEECH_OFF%The brigands did manage to destroy a few parts of the outskirts, but this was a rhetorical question.%SPEECH_ON%I need funds to help rebuild the territories those marauders managed to get their hands on. I\'m sure you understand, then, why you\'ll be receiving less pay...%SPEECH_OFF%You shrug. It is what it is. | %employer%\'s at his bookshelf. He takes a book, spinning around and opening it all in one move. He lays it across his table.%SPEECH_ON%There\'s numbers there. I\'m sure you can\'t read them, but here\'s what they say: the brigands managed to destroy parts of this town, and now I need crowns to help rebuild. Unfortunately, I don\'t have that many crowns on hand to do this. I\'m sure you understand this predicament.%SPEECH_OFF%You nod and state the obvious.%SPEECH_ON%It\'s coming out of my pay.%SPEECH_OFF%The man nods and slides an open hand across his desk, drawing your attention to a satchel. There\'s no point in arguing about pay. You take the sack and make your leave.}",
	Text19 = "{That\'s just half of what we agreed to! | It is what it is...}",
	Text20 = "[img]gfx/ui/events/event_30.png[/img]{When you enter %employer%\'s room, he tells you to close the door behind you. Just as the latch clicks, he slams you with a stream of obscenities that you couldn\'t hope to keep track of. Calming down, his voice - and language - return to some level of normalcy.%SPEECH_ON%Every bit of our outskirts was destroyed. What exactly did you think I was paying you for? Get out of here.%SPEECH_OFF% | %employer% is slamming back goblets of wine when you enter. There\'s the din of angry peasants squalling outside his window.%SPEECH_ON%Hear that? They\'ll have my head if I pay you, sellsword. You had one job, one job! Protect this town. And you couldn\'t do it. So now you can do one thing for free: get the hell out of my sight.%SPEECH_OFF% | %employer% clasps his hands over his desk.%SPEECH_ON%What exactly are you expecting to get here? I\'m surprised you returned at all. Half the town is on fire and the other half is already ash. I didn\'t hire you to produce smoke and desolation, sellsword. Get the hell out of here.%SPEECH_OFF% | When you return to %employer%, he\'s holding a mug of ale. His hand is shaking. His face is red.%SPEECH_ON%It\'s taking everything in me to not throw this in your face right now.%SPEECH_OFF%Just in case, he finishes the drink in one big gulp and slams it on his desk.%SPEECH_ON%This town expected you to protect them. Instead, the brigands swarmed the outskirts like they were taking a goddamn leisure trip! I\'m not in the business of giving marauders a good time, sellsword. Get the farkin\' hell out of here!%SPEECH_OFF%}",
	Text21 = "{We should have asked for more payment in advance... | Damnit!}"
};

// scripts\contracts\contracts\ssu_explore_treasures_contract.nut
::Mod_Sellswords.Strings.ssu_explore_treasures_contract <- {
	Name = "Recover Lost Treasures",
	Title1 = "Negotiations",
	Text1 = "[img]gfx/ui/events/event_92.png[/img]%employer% welcomes you and walks you toward the town\'s square. There\'s a group of peasants milling about, but when they see you coming, they shape up and start talking as though they\'d been expecting you all day. They mostly talk in descriptors:\nTall as any man!\nArmour like you\'d never seen before!\nSpears as sharp as a peddler\'s tongue!\n\nYou hold your hand up and ask what it is they are talking about.\n%employer% laughs.%SPEECH_ON%The men here say they saw something out in a spot by the name of %location%. Naturally, they weren\'t out there for no reason. They were looking for something called %item%, a relic dear to the town that was stolen by savages, and through it we pray for food and shelter.%SPEECH_OFF%One of the peasants speaks up.%SPEECH_ON%And we was lookin\' fer it at his behest!%SPEECH_OFF%%employer% nods.%SPEECH_ON%Of course. And where they failed, perhaps you can succeed? Retrieve this relic for me and you\'ll be paid quite well for your services. Hmmmm, let\'s see. From the reports of the townsfolk, they saw a statue bearing %prizename% while they were scouting. I assume that will provide motivation enough for your assistance?%SPEECH_OFF%}",
	Text2 = "{Maybe it is. | What is %townname% prepared to pay for their idol back? | Let\'s talk money.}",
	Text3 = "Negotiation",
	Text4 = "{Not interested. | We have more important matters to settle. | I wish you luck, but we\'ll not be part of this.}",
	Title2 = "As you approach...",
	Text5 = "[img]gfx/ui/events/event_113.png[/img]{You\'ve found the barbarian village and a series of cairns that lead toward it. The stones are stacked in the shapes of men, and at the top of each cairn rests a freshly hewn human head. %randombrother% nods.%SPEECH_ON%I wonder if they believe doing that gets them closer to their gods.%SPEECH_OFF%You suspect you have another way to get them closer to their gods: by killing them all. It\'s time to plan a way of attack. | You find the barbarian village and just to its outskirts lies a round stone in the snow. It\'s so large the entire company could lay foot-to-head and still not stretch across its middle. Runes have been carved into its outer rim, long divots that are caked with dried blood. In the center of the slab is a small square rise with a curve to hold the neck. %randombrother% spits.%SPEECH_ON%Looks like a sacrificial square, er, circle.%SPEECH_OFF%Looking around, you wonder aloud where they put the bodies. The sellsword shrugs.%SPEECH_ON%Dunno. Probably ate \'em.%SPEECH_OFF%It wouldn\'t surprise you if they did. You stare at the village and ponder attacking or waiting. | The barbarian village lies just a little ways away. It\'s a nomadic scene, tents surrounded by ad hoc smithy sites and tarped wagons for granaries. You get the feeling that they are not long for any particular part of the world. %randombrother% laughs.%SPEECH_ON%Look at that one. He\'s shittin\'. What a fucker.%SPEECH_OFF%Indeed, one of the savages is squatting while talking to his fellow villagers. It is almost a metaphor in and of itself for catching the entire encampment with their pants down. | The village of savages is surprisingly not the hellscape you expected. Aside from the flayed corpse hanging upside down from a wooden holy totem, it looks like any other place with ordinary folks. Aside from the heavy set clothes and every individual carrying an axe or sword of some kind. All quite normal. There\'s a guy chopping a corpse\'s legs off and feeding them to pigs, but you\'ll see that just about anywhere. %randombrother% nods.%SPEECH_ON%Well, we\'re ready to attack. Just give the word, captain.%SPEECH_OFF% | You find the barbarian village squatting in the snowy wastes. It couldn\'t have been there long: it\'s mostly tents and the tops of them don\'t carry much snow. They must set up for a time then get back on the road, either to keep hunts fresh or to avoid the retribution of those they raid. What a shame they\'ve failed to do the latter. You ready the company for action. | You find the village of savages. Though, from first glance, they look an ordinary sort. Men, women, children. There\'s a blacksmith, a tanner, a one-eyed guy making arrows, and a huge executioner disemboweling corpses and washing the offal scum on a donkey. That one. That one reminds you of why you\'re here. | You find the barbarian village. The savages are in the midst of some religious ritual. An elderly man with a tortoise shell necklace has his fist up the decapitated and shaved head. He\'s letting the blood run down his forearm where children take horsehair brushes and sweep up the \'paint\' and go to run it against a wooden holy totem that stands a good ten feet high. The primitives watch and chant in a tongue totally foreign to you. %randombrother% whispers as though out of respect for the ritual moreso than fear of them hearing.%SPEECH_ON%Well. I say we go on down there and make an introduction, yeah?%SPEECH_OFF% | You find the barbarians moseying about their village. It\'s mostly tents and impromptu snow houses. Elderly women sit in a circle weaving baskets and younger women are making arrows while throwing glances at the burly men walking around. The men themselves pretend they don\'t care, but you know a peacock in action when you see it. There are also children hurrying to and fro this task or that. And just outside the village stand a series of wooden stakes impaling naked corpses from anus to mouth, and their chest cavities have been spread apart like butterfly wings and the insides draped down like loosened embroidering.%SPEECH_ON%Horrid.%SPEECH_OFF%%randombrother% says. You nod. It is, but that\'s why you\'re here.}",
	Text6 = "Prepare to attack.",
	Title3 = "After the battle...",
	Text7 = "[img]gfx/ui/events/event_133.png[/img]{With the help of local bounty hunters, all damned enemies have been slain to the last. With the %item% in hand, you figure you might as well grab the %prizename%. %randombrother% goes and does it, carefully freeing the statue of the piece. Once the metal wriggles free, the man pauses, readied to get clobbered if the statue were to jump to life. Instead, nothing happens. He nervously laughs.%SPEECH_ON%E-easy-peasy!%SPEECH_OFF%As relief spreads over the men, you tell them to get ready to return to %employer%.}",
	Text8 = "Farewell, king.",
	Tooltip1 = "You gain {1}",
	Title4 = "Near %townname%...",
	Text9 = "[img]gfx/ui/events/event_04.png[/img]{%employer% welcomes your entrance with applause.%SPEECH_ON%My scouts tracked your company to the north and to its, dare I say, inevitable success! Splendid work murdering those savages. Surely this will make them think twice about venturing down here again!%SPEECH_OFF%The man pays you what you\'re owed. | You enter %employer%\'s room and find him slackened into his chair. He\'s watching a naked woman saunter from one side of the room to the other. Shaking his head, he talks to you while not taking his eyes from the show.%SPEECH_ON%My scouts have already told me of your doings. Said you put it to the barbarians like they\'d done their wrongs against you personally. I like that. I like the lack of restraint. Wish more of my own men had it.%SPEECH_OFF%A servant, previously unseen, quickly marches across the room. He\'s got a red candle atop his head and a chest of crowns in his hands. You take your pay and leave the room as quick as you can. | You find %employer% and a group of armored men standing around a table. A barbarian\'s corpse is on it. The flesh is greyed, but the body\'s musculature and grit has not yet been decayed. They ask if you truly fought men of this sort. You cut to the chase and ask for your pay. %employer% claps and shows you off to the group.%SPEECH_ON%Gentlemen, this is the sort of man I want in my ranks! Unfearful and always focused.%SPEECH_OFF%One of the nobles spits and says something you don\'t hear. You ask him to speak up if he\'s something to say, but %employer% rushes forward, chest of crowns in hand, and sends you on your way. | Finding %employer% proves a little difficult, a hunt that ends in a seemingly abandoned barn. You see him standing before a dead barbarian, the corpse hanging from the rafters by his legs like a fisherman\'s haul. The body has been burned, mutilated, and all else. %employer% crouches and washes his hands in a bucket.%SPEECH_ON%I\'ve to say, sellsword, you killing a whole number of these savages is most impressive. This one here lasted a good long while. Took to the pain like he was gonna pay it forward to me tenfold. But he never did. Did you?%SPEECH_OFF%The man gently slaps the barbarian\'s face and the chains clink as the body gently twists. %employer% nods.%SPEECH_ON%A servant outside will have your pay. A job well done, sellsword.%SPEECH_OFF% | You find %employer% and a group of men overseeing the defense of %townname%, no doubt preparing themselves for whatever attack may come next. Judging by the appearance of the men, their ambitions of survival will meet a reality far more cruel than they are ready for. But you keep that to yourself. %employer% thanks you for a job well done and pays you what is owed. | A few denizens of %townname% see your return with horrified confusion, mistaking you for the savages that they\'d come to know. Windows are shuttered, doors slammed closed, children hurried away, and a few braver souls step out with pitchforks. %employer% hurries out of his abode and sets them straight, explaining you are the heroes of the tale, that you went north and annihilated the savages, burned their village, and scattered them to the wastes. Windows swing wide and doors creak open and the children return to their play. Just when you think order has returned, an old woman snarls.%SPEECH_ON%A sellsword is just a savage by another name!%SPEECH_OFF%Sighing, you tell %employer% to pay what is owed. | %employer% is studying a few scrolls. He\'s also penning notes into them and crossing others out. Looking up, he explains that he\'s putting you into the records as a \'hero who went to the wastes\' and \'slaughtered the savages in a fashion most proper and southernly.\' He asks you to remind him what your name is. You ask him to pay you what you\'re owed. | %employer% is in the company of a group of sobbing women. He\'s consoling them and when you enter he stands and points you out to them.%SPEECH_ON%Behold! The man who has slain those who murdered your husbands!%SPEECH_OFF%The women wail and clamber to you, one after the other, and you know what to do besides nod sternly and stoically. %employer% is the last of the crowd to find you, a chest of crowns in his arm and a wry smile on his lips. You take your pay and the man returns to the women.%SPEECH_ON%There there, fine ladies, the world will see a new dawn. Please, come with me. Does anyone want wine?%SPEECH_OFF% | %employer% welcomes you with open arms. You decline a hug and ask for your pay. He returns to his desk.%SPEECH_ON%I wasn\'t trying to hug you, sellsword.%SPEECH_OFF%He taps the chest rather despondently.%SPEECH_ON%But you did a good job slaughtering those savages. I\'ve a number of scouts who reported it as a \'splendid time\' you had out there. You\'ve earned this.%SPEECH_OFF%He pushes the chest across the desk and you take it at arm\'s length, meeting a slight bit of resistance as he holds onto it. You hurriedly leave the room without looking at him again. | You have a hard time finding %employer%, eventually finding him halfway down a well shaft plugging a hole with a stone slab. He shouts up to you.%SPEECH_ON%Ah, the sellsword. Hoist me up, men!%SPEECH_OFF%A pulley system draws up the plank upon which he sits. He swings his legs off and rests them on the rim of the wellhead.%SPEECH_ON%Our mason was killed by a donkey so I thought I\'d lend a hand myself. Nothing like a little dirty work to get a good man up in the morn\'.%SPEECH_OFF%He slaps your chest with his glove, it leaves a powdered outline. He nods and fetches a servant to go get your pay.%SPEECH_ON%A job well done, sellsword. Very, very well done. Heh.%SPEECH_OFF%You don\'t humor him. | %employer% is found giving a speech to a crowd of peasants. He describes an unnamed force of southerners that headed north and annihilated the savage scum. At no point are you or the %companyname% named. When he\'s done, the mob of peons cheer and clap and flowers are thrown and a general state of festivity takes over. %employer% seeks you out and shakes your hand while pushing a chest of crowns toward you.%SPEECH_ON%I wish I could call you the hero to these fine folk, but mercenaries are not seen in the best of light.%SPEECH_OFF%You wrap your hands around the payment and lean forward.%SPEECH_ON%All I want is the pay. Have fun out there, %employer%.%SPEECH_OFF% | You find %employer% attending a funeral ceremony. They\'re burning a pyre weighed with three corpses and what may possibly be a fourth, smaller one. Possibly a whole family. %employer% says a few kind words and then sets the woodwork ablaze. A servant surprises you with a chest of crowns.%SPEECH_ON%%employer% does not wish to be bothered. Here is your pay, sellsword. Please count if you do not trust it is all there.%SPEECH_OFF%}",
	Text10 = "Crowns well deserved.",
	Tooltip2 = "You gain [color={1}]{2}[/color] Crowns"
};

// scripts\contracts\contracts\ssu_purge_infection_contract.nut
::Mod_Sellswords.Strings.ssu_purge_infection_contract <- {
	Name = "Purge Infection",
	Title1 = "Negotiations",
	Text1 = "[img]gfx/ui/events/event_31.png[/img]{%employer% throws back his silken sleeves and cracks his knuckles.%SPEECH_ON%Just weeks ago, an extremely vile threat arose in the form of a plague. To our horror, my cabinet discovered that the plague was not merely an illness but a way of turning innocent townsfolk into undead creatures. The fallen have been resurrected en masse by a local clique of Necromancers.%SPEECH_OFF%You nod, as a sellsword is often hired to deal with difficult things. The man continues.%SPEECH_ON%Some of my men were sent to the town of %settlementname% for an investigation. The grain there had been tampered with, and without an influx of new food and a quarantine, the people of %settlementname% will all soon become infected. %noblehousename% is sorry for this, but we must do anything we can to prevent further harm to our House.\n\n What I need you to do is burn them all, especially those despicable necromancers, the puppeteers behind this insidious plot, along with any infected who continue to spread this plague. To end the assault by these monsters, I will also send along two experienced Paladins with you. These are strong men, experienced against the \'undead\', but unfortunately, two men won\'t be enough here. There\'ll be a large satchel of crowns waiting for you right here if you go there and help them. What do you say, hm?%SPEECH_OFF%}",
	Text2 = "{Let\'s talk money. | How many crowns are we talking about? | What will the pay be? | For the right price, anything can be done.}",
	Text3 = "Negotiation",
	Text4 = "{That\'s not our line of work. | That\'s not for the %companyname%.| We don\'t deal with the Undead.}",
	Title2 = "As you approach...",
	Text5 = "[img]gfx/ui/events/event_02.png[/img]{Approaching %settlementname%, %randombrother% suddenly calls out from the front.%SPEECH_ON%Sir, hurry!%SPEECH_OFF%You rush over to him and look ahead. The town is absolutely surrounded by a pale sea of bobbing, moaning undead! The %companyname% will have to cut through them to get inside. \nA man jogs toward the %companyname%. He\'s holding one of his arms and a crown of blood runs down his head. He yells out.%SPEECH_ON%Go, go away! There\'s nothing for you here but horrors!%SPEECH_OFF%%randombrother% throws the stranger to the ground and draws a weapon to keep him there. You stay the mercenary\'s hand as you look ahead; %settlementname% is already surrounded by a large number of the undead. The %companyname% needs to act fast! \nRounding a pathway, you\'re brought to a sudden stop. Near you, a few of the cold, pale undead linger, oddly outcast from the horde. %randombrother% remarks that there are a couple of warm-blooded figures clad in black among these outliers; it seems you\'ve found your target. \nWith the horde of undead already pushing in from outside %settlementname%\'s walls, and the heads of the militia peeking over the defenses, you leave them to defend the town while you make your way over to the Necromancers. \nDrawing out your sword, you command the %companyname% to battle!}",
	Text6 = "Prepare to attack.",
	Title3 = "After the battle...",
	Text7 = "[img]gfx/ui/events/event_46.png[/img]{You stare over the battlefield. It is littered with the dead, the dying, the undying, and the dying undead. Men, of the living, breathing sort, march through the muck, finishing off anything that remotely resembles a walking corpse. With the fight over and the town saved, %employer% should now be expecting you. | The battle is over and the town is saved. Time to return to %employer% for a hell of a payday. | %settlementname% resembles a flooded graveyard more than any town you know. Corpses, new and old, are washed out across the earth, blood and moldy filth pooled about each. The stench reminds you of a dead dog you found alongside a creek, bones dripping with decomposition, the body being fed upon by crawfish and maggots.\n\nThe relentless attacks have finally ceased; %settlementname% seems safe for now. %employer% should be expecting you and you\'ve no reason to stay in this horrid place any longer. | Well, the town is saved. The peasants step about the battlefield with long sticks, poking the earth like pelicans prodding over a pool of the most dangerous waters. %randombrother% comes over, cleaning the sludge off his blade, and asks if it is time to return to %employer%. You nod. The sooner you can get back for your pay, the better. | The battle is over. Among the dead are peasants and militiamen, each attended by survivors who\'ve come to cloak the bodies with sobbing silhouettes. As for the dead undead, well, nobody cares. Those bodies lay as though they came with no purpose and yet departed with thorough destruction of whatever they touched. The sight of their corpses, and the chaotic nothingness they represent, is infuriating. Not wanting to be around a second longer, you inform the men to get ready to return to %employer%. | You and the %companyname% stand victorious. The town and its people will survive, for now, and you can return to %employer% for your pay. | The lieutenant of the guard thanks you for saving the town. You mention that the only reason you\'re here is because someone paid you. He shrugs.%SPEECH_ON%I thank the rains I\'ve no command over; I\'ll thank you mercenary whether you like it or not.%SPEECH_OFF% | The battle is over and, thankfully, won. Undead bodies spill over the earth in such disarray that they hardly look any different than they did shambling and shuffling just hours ago. But the more recently expired share no such cosmic despondence. Wailing women and confused children attend to them. You look away from the scene, ordering the %companyname% to prepare its return to %employer%. | A dead man is at your feet and beside him is an undead corpse. It\'s the strangest of sights, for they are equally put out of this world, but there\'s life yet in the man. The breath of a recent memory. You saw him swinging to the very end. A noble way for a fighter to go. This corpse, though? What of it? You\'ll remember it tearing a man\'s throat out with its bare teeth. Maybe the corpse had a time beyond that moment, when it had a family, a time when it was but a kind man doing good in this world. But a throat-ripping monstrosity is all it is now. All it will be remembered as.\n\nThe relentless attacks on %settlementname% have finally ceased, and so you hurry to collect the company and prepare a return to %employer% in %townname%. A good payday is better than another moment of looking at this shite. | What is a dead man? What if a dead man was killed twice over? And what of a dead man killed thrice over? Unfortunate. Misfortunate. And a joke.\n\n You walk the battlefield collecting the men of the %companyname%. The town of %settlementname% is saved for now, and so it\'s time for you to get back to %employer% in %townname% for a well-earned payday. | %randombrother% wipes his forehead with a cloth, leaving behind a disgusting smear of pale liquid.%SPEECH_ON%Shite, what is that? Is that brain? Sir, would you please?%SPEECH_OFF%You help the man clean himself off. He stands back, arms wide. He\'s still absolutely covered in blood, guts, and things which may forever be left unknown.%SPEECH_ON%How do I look?%SPEECH_OFF%His grin winks out of the murk like a rind of the moon through a pale sky. You refuse to answer and just tell him to go get the men. With %settlementname% saved for now, %employer% will be expecting the company back in %townname%, and the company should be expecting a well-earned payday. | %randombrother% comes to your side, together the two of you overlooking the battlefield. Already you can see the families of the dead coming out to find their lost ones. Their wailing is sharp, humanly pitched, a disturbingly welcome respite from the growling, moaning despondence of the undead. The mercenary claps you on the shoulder.%SPEECH_ON%I\'ll go and collect the men so we can get on back to %townname% and collect our pay.%SPEECH_OFF% | You watch as women shuffle about the battlefield, holding their dresses up like wetted fowl steering clear of a pond\'s murk. Of course, once they find what they\'re looking for, they drop all regard for cleanliness and drop into the filth, wailing and howling, covering themselves in the very horrors which had dispatched their fathers and husbands with infuriating indifference.\n\n %randombrother% joins your side.%SPEECH_ON%Sir, the attacks have ceased and the men are ready to return to %townname%. Just give the word.%SPEECH_OFF% | The lieutenant of the guard comes to your side and shakes your hand. Drying blood cracks and crumbles as you shake. He puts his fists to his hips and nods at the scene.%SPEECH_ON%You did well, sellsword, and we could not have done it without you. I\'d like to offer you more as thanks, but this town needs all the resources it has to rebuild. I do hope that %employer% pays you all that you are worth.%SPEECH_OFF%You hope so, too.}",
	Text8 = "We\'re done here.",
	Title4 = "On your return...",
	Text9 = "[img]gfx/ui/events/event_56.png[/img]{You enter %townname% and find %employer% looking over a balcony. He calls to you just as a guard slams a satchel of crowns into your arms .%SPEECH_ON%Sellsword! So glad to have you back! My little birds have already told me much of your doings. I hope you spend those crowns well!%SPEECH_OFF%Before you can say anything, the man spins and leaves. The guard who handed you the crowns is already gone as well. Peasants walk around you like a signpost pointing to places they\'ll never go. | You find %employer% slapping and kicking a child around, eventually punting him into the dirt with a swift boot to the chest. Seeing you, the nobleman wipes the sweat from his brow and explains himself.%SPEECH_ON%This doesn\'t concern you.%SPEECH_OFF%The kid is tilting on hands and knees, one hand to his belly, the other drawing blood from his leaking nose. Gradually, he gets to his feet, wavering there, blinkered eyes blinking crimson. A servant comes by and starts dabbing water over him, but the nobleman grabs the cloth and tosses it aside .%SPEECH_ON%You think he\'ll learn that way. If you want to help someone, help this sellsword. He is owed %reward_completion% crowns. Snap snap.%SPEECH_OFF%The servant nods and quickly leaves. You stay awhile, watching the beating continue. The kid doesn\'t cry or call out for there is a learned expectation in this punishment. A few minutes pass when the servant suddenly reappears, satchel in hand. He hands it to you and whispers an earnest suggestion that you make your leave. | %employer% is stooped over his table, arms tented long and stiff, his head drooped low as he stares at a dead crow.%SPEECH_ON%Found this raven in my bed this morning. Just lying there. Dead. Do you \'ve any idea what that means?%SPEECH_OFF%You suggest that it was, perhaps, a joke. The nobleman scoffs.%SPEECH_ON%Nay. I think this has to do with you, sellsword. You did well in saving that town, but perhaps it was not meant to be saved. Maybe that is what this bird represents. Maybe the dead shall come for me next as I have left Death itself unpaid.%SPEECH_OFF%You use this statement to slowly segue into the issue of your own pay. Despite his wild ravings, the nobleman does momentarily get his wits together to pay you your %reward_completion% crowns. | %employer% is listening to a group of scribes, somehow arranged in order of age and seniority. The youth of the group stay quiet, the only noise out of them is the scribbling of their quill pens. The elders argue amongst themselves, using volume just as much as reason and rationality. This seems a common sight nowadays, no doubt the dead climbing out of their graves being of some concern to men of philosophical takes. Regardless, you belch loudly to introduce yourself, shattering their conversation with disgusting aplomb. %employer% laughs and waves you in.%SPEECH_ON%Ah, sellsword! The man who gets things done, come to talk with the men who simply yap?%SPEECH_OFF%You shake your head and tell him you\'re only there for the pay. The nobleman nods.%SPEECH_ON%Of course. You did well in saving that town. I\'ve heard much of your heroics. %reward_completion% crowns await you there in the corner.%SPEECH_OFF%You walk across the room, your boots filling the suddenly hollow room with quiet claps of leather on stone. The scribes twist to watch you, murmuring amongst themselves. You pick a satchel up, hearing the chink of crowns shift around with a most welcomed weight. You quietly leave, though the second the door closes behind you the scribes erupt with arguing once again. | %employer% is found with a few women beside him. They\'re telling him of their lost fathers, husbands, and brothers. He nods, attentively, though occasionally sparing a moment to glance at the bosom of the youngest girl.%SPEECH_ON%Yes, yes of course. Absolutely horrible. Horrible! Hold on one moment. Sellsword!%SPEECH_OFF%He waves you in. The women part as you make your entrance. The youngest gal looks you up and down, quickly wiping tears from her eyes and does a little bit of youthful primping. The nobleman sees this and glances between you and her .%SPEECH_ON%Ahem, yes, uh, your crowns are in the corner. You must go. Now. I\'ve things to attend to.%SPEECH_OFF%He stands and points toward your %reward_completion% crowns, and in one swift motion takes the lady by the hand.%SPEECH_ON%Now, young backstress, you said your husband is dead and you\'ve no one left in this life? Absolutely no one at all?%SPEECH_OFF% | Dogs chew up something in the path. Whatever it was, it once had life, bones and organs which have long since grown pale and rotten, though the mongrel\'s rabid eating would suggest it might as well be a slab of steak. %employer% greets you, attentive guards at his side.%SPEECH_ON%My birds tell me the town was saved. You\'ve done well, mercenary, better than I had thought you would. Your pay, as agreed upon.%SPEECH_OFF%He hands you a satchel of %reward_completion% crowns. The dogs pause, turning their heads toward you with flesh swinging from their teeth, narrow black eyes staring with an emptiness that reflects their hunger. The guards lower their spears and the dogs, somehow interpreting this correctly, slowly turn back to their dinner. | %employer% is found sitting low in his chair. He despondently waves you into the room.%SPEECH_ON%I\'ve horrid news. My seer says I\'ve brought a curse upon my land and my people. That\'s why the dead rise again.%SPEECH_OFF%You shrug and kindly state that the seer is full of shite. The nobleman shrugs.%SPEECH_ON%I sure hope so. What was it we agreed upon, %reward_completion% crowns?%SPEECH_OFF%You\'re tempted to say you agreed to more, but dare not cross a man who is so superstitious. When you answer, he smiles warmly at your accurate response.%SPEECH_ON%Good call, sellsword. You passed that test. I may be going mad, but I\'m not one to trifle with. %SPEECH_OFF%You ask if your honesty will be rewarded. The man raises an eyebrow.%SPEECH_ON%Your head is on your shoulders, is it not?%SPEECH_OFF%Point taken. | %employer% is found on his balcony. You join him, though guards stand very nearby, eyeing you carefully. The man waves his arm to the town which lies beneath him.%SPEECH_ON%I know you did not save this town directly but, in a way, I think you did. Stopping the undead anywhere is as good as stopping them here. Would you agree?%SPEECH_OFF%The man punctuates the question with a satchel of %reward_completion% crowns. You take the pay and nod. He nods back.%SPEECH_ON%Glad you agree for we may yet need your services again.%SPEECH_OFF% | You step into %employer%\'s darkened room. There are rugs over the windows and most of the candles are not lit. All the light flickers beside a scribe standing with a candelabra, his fire-red face grinning behind the candles like a little devil holding a trident. He glances at you and quietly sets the candles down. As he steps back, it is as though he were falling into a black pool, his disembodied face slowly dipping into the darkness. He\'s still there, breathing slightly, rustling his cloak, but you\'ve nought a part of him to see. %employer% waves you in.%SPEECH_ON%Sellsword! By the old gods, you did well in saving that town!%SPEECH_OFF%You step forward, glancing at the darkness which shifts around, some of it shadow, some of it man. %employer% hands you a satchel. A scattering of candlelit coins shimmers across its open top.%SPEECH_ON%%reward_completion% crowns, as agreed upon. Now, please, depart. I have more to study, and even more to learn.%SPEECH_OFF%You take your pay and slowly leave. As the door closes, you see the scribe reemerge like a gaunt spectre, bony hands reaching for the light once more. | %employer% is found in his study. Guards stand at all the corners and a scribe quietly goes around the shelves, pulling scrolls and putting them back with equal earnestness and disappointment. You\'re quickly waved in and just as quickly paid by the nobleman.%SPEECH_ON%Good job, sellsword. You\'re already a hero in some parts of these lands. Hell, maybe you\'ll end up in one of these scrolls, forever remembered.%SPEECH_OFF%You hear the scribe scoff. %employer% waves toward the door.%SPEECH_ON%Please? I\'ve immense things to study, and so little time to do it.%SPEECH_OFF% | You enter %employer%\'s room to find the man deep in his chair. Peasants argue on either side of him, pointing and accusing.%SPEECH_ON%This man is a murderer!%SPEECH_OFF%The defendant scoffs.%SPEECH_ON%Murderer? What happened was an accident! I thought he was one of them undead fellers!%SPEECH_OFF%The other man scoffs this time.%SPEECH_ON%Undead? He was merely drunk!%SPEECH_OFF%Tempers rise.%SPEECH_ON%Well, I heard growling! Or grunting.%SPEECH_OFF%Your employer despondently waves you in.%SPEECH_ON%Sellsword, good job on saving that town. Your pay.%SPEECH_OFF%He pushes a satchel of %reward_completion% crowns across the table. The peasants pause, staring at the coins wink out of its open top. You take the satchel, pretending that it weighs far too much for you.%SPEECH_ON%Oof, so heavy it is! You sirs have a good day.%SPEECH_OFF% | %employer% welcomes you into his room.%SPEECH_ON%My little birds tell me of the town being saved. You did well, mercenary, well enough in a world that\'s become so dark. Your pay of %reward_completion% crowns, as agreed upon.%SPEECH_OFF% | %employer% is standing outside, staring toward a graveyard that has gathered quite a few residents since your last visit. He hands you a satchel of %reward_completion% crowns.%SPEECH_ON%You did well, mercenary. Word of your doings has spread across the land. One success won\'t save us all, but it puts us on the right path. If we are to win this damned war with the dead, we need as much spirit and hope we can muster.%SPEECH_OFF%Taking your pay, you add that sellswords need as many crowns as possible. You know, to keep their \'spirits\' high. The nobleman grins.%SPEECH_ON%I\'m being sanctimonious, not philanthropic. Get on out of here.%SPEECH_OFF% | %employer%\'s guards take you into his room. He\'s got a few scrolls unwound all around him. Broken quill pens litter his table as though someone had splattered a bird there.%SPEECH_ON%Sellsword! Tis good to see the man of the hour, the day, the week! You did well in saving that town.%SPEECH_OFF%He throws you a satchel of %reward_completion% crowns.%SPEECH_ON%One victory to keep a town alive, one victory to keep the hopes of the people alive. I should pay you more. I mean, I won\'t, but I should.%SPEECH_OFF%You glumly take your pay, nodding back and responding.%SPEECH_ON%Well, it\'s the thought that counts.%SPEECH_OFF%The nobleman snaps his fingers.%SPEECH_ON%Exactly!%SPEECH_OFF% | You find %employer% slunk deep in his chair with an even deeper frown. His clothes wink with shiny opulence and the candelabras look worth more than the servants holding them. The gaudy grouch despondently waves you in. He speaks slowly and sarcastically.%SPEECH_ON%One victory for man. One more victory to carry us to the next day. Mmm, thank you sellsword.%SPEECH_OFF%You slowly step forward, the servants glancing at you with fearful eyes. You take your pay and step back. %employer% waves you away now.%SPEECH_ON%Begone. I hope to see you again, lest you are of ill-shape and of dead body, then it would be a shame. Then again, that\'s how we\'re all going to end up, isn\'t it?%SPEECH_OFF%You say nothing and make your leave. It appears the war against the unending undead has worn on the nobleman.}",
	Text10 = "{Honest pay for honest work. | Crowns is crowns.}",
	Tooltip = "You gain [color={1}]{2}[/color] Crowns",
	Text11 = "[img]gfx/ui/events/event_56.png[/img]{The undead were too many and you had to retreat. Unfortunately, a whole town doesn\'t have such liberties and so %settlementname% was completely overrun. You didn\'t stick around to see what became of its citizens, though it doesn\'t take a genius to guess. | The %companyname% has been defeated in the field by the hordes of undead. In the wake of your failure, %settlementname% is quickly overrun. A mass of peasants run from the town and those too slow are added to the sea of shambling corpses. | You failed to hold back the undead! The corpses slowly shuffle beyond the walls of %settlementname% and eat and kill all that they come across. As you flee the field, you see the lieutenant of the militia shuffling alongside the horde of corpses.}",
	Text12 = "They won\'t be welcoming us in %settlementname%..."
};

// scripts\encounters\events\ssu_anatomist_recruit_encounter.nut
::Mod_Sellswords.Strings.ssu_anatomist_recruit_encounter <- {
	Title = "Anatomist",
	Text1 = "[img]gfx/ui/events/event_184.png[/img]{Your company arrives at %settlement% after a long and grueling journey. Seeking respite for mind and feet, you and your men head towards the local tavern, hoping for a warm meal and perhaps some news or a new contract. As the night wears on and the ale flows freely, your attention is drawn to a peculiar figure seated alone in the corner, surrounded by books and scrolls.\n\nThe %person_anatomist% is meticulously scribbling notes, occasionally pausing to take a sip from %their_anatomist% mug. %Their_anatomist% attire, though travel-worn, hints at a scholarly background. The strange collection of vials and anatomical diagrams laid out before %them_anatomist% further piques your curiosity. You approach %them_anatomist%, and %they_anatomist% looks up, eyes gleaming with a mixture of enthusiasm and exhaustion.%SPEECH_ON%Ah, a sellsword company, I presume? A fortunate encounter, indeed! You see, I am %anatomist%, an Anatomist, a seeker of knowledge in the realm of flesh and bone. My research requires specimens—fresh ones—and your line of work, well, it seems to provide ample opportunity for that, does it not?%SPEECH_OFF%}",
	Text2 = "We could do that, but what\'s in it for us?",
	Text3 = "We\'ve no time for your experiments.",
	RawDescription = "{You encountered %name% in a tavern. %They%\'s a former physician whose obsession with the secrets of life and death has driven %them% to study the fallen in search of new-found knowledge. As an outcast, %they% sought to join your company, offering %their% unusual expertise to both enhance your men and discover the vulnerabilities of your enemies through macabre research.}",
	Text4 = "[img]gfx/ui/events/event_184.png[/img]{The anatomist’s eyes light up, and %they_anatomist% leans in closer, %their_anatomist% voice lowering conspiratorially. %SPEECH_ON%Ah, I see you\'re a man of pragmatism. Good, good! Allow me to elaborate. My work is not just about study and research; it\'s about application. With my knowledge, I can help your men recover faster from wounds that would otherwise fester and cripple them. My concoctions, derived from the very essence of life and death, can bolster your fighters\' resilience in ways you\'ve never imagined.%SPEECH_OFF%%They_anatomist% glances around the tavern, ensuring no one is eavesdropping, before continuing. %SPEECH_ON%And there\'s more. You see, the things I discover on the battlefield—diseases, poisons, and even the strange humors that animate the dead—they can be harnessed, turned into tools of war. With my help, your company could gain the edge it needs to turn the tide of any battle.%SPEECH_OFF%%They_anatomist% leans back, a sly smile forming on %their_anatomist% lips. %SPEECH_ON%Of course, there is a price. I will require the bodies of your fallen foes, untouched and fresh. In exchange, I offer not just my services as a healer, but access to knowledge that few others possess. Knowledge that could make your company legendary.%SPEECH_OFF%}",
	Text5 = "Fark it, come on then.",
	Text6 = "We\'re not keen on dragging a scholar into battle.",
	Text7 = "[img]gfx/ui/events/event_184.png[/img]{The anatomist grins widely and nods.%SPEECH_ON%Excellent! You won\'t regret this decision, Captain. Together, we shall unlock secrets that will make your enemies tremble!%SPEECH_OFF%}",
	Text8 = "I\'m sure we will...",
	Text9 = "[img]gfx/ui/events/event_184.png[/img]{The anatomist sighs, %their_anatomist% shoulders slumping slightly.%SPEECH_ON%A shame, truly. But I understand. Some paths are not meant for everyone.%SPEECH_OFF%%They_anatomist% returns to %their_anatomist% notes and you head back over to the company, hoping to get at least another couple drinks in before you retire for the night.}",
	Text10 = "What a proper farkin\' weirdo..."
};

// scripts\entity\tactical\enemies\ssu_deathknight.nut
::Mod_Sellswords.Strings.ssu_deathknight <- {
	Name = "Headless {1}"
};

// scripts\entity\tactical\enemies\ssu_dryad_lindy.nut
::Mod_Sellswords.Strings.ssu_dryad_lindy <- {
	Name1 = "Forest Avatar",
	Name2 = "{1}\'s tail"
};

// scripts\entity\tactical\enemies\ssu_dryad_lindy_tail.nut
::Mod_Sellswords.Strings.ssu_dryad_lindy_tail <- {
	Name = "Avatar tail",
	Log1 = "{1}\'s natural armor is hit for [b]{2}[/b] damage",
	Log2 = "{1}\'s {2} is hit for [b]{3}[/b] damage and suffers {4}!",
	Log3 = "{1}\'s {2} is hit for [b]{3}[/b] damage"
};

// scripts\entity\tactical\enemies\ssu_dryad_snake.nut
::Mod_Sellswords.Strings.ssu_dryad_snake <- {
	Name = "Thicket Stalker"
};

// scripts\entity\tactical\enemies\ssu_dryad_unhold.nut
::Mod_Sellswords.Strings.ssu_dryad_unhold <- {
	Name = "Woodland Protector"
};

// scripts\entity\tactical\enemies\ssu_dryad_wolf.nut
::Mod_Sellswords.Strings.ssu_dryad_wolf <- {
	Name = "Verdant Hound"
};

// scripts\entity\tactical\enemies\ssu_fallenbetrayer.nut
::Mod_Sellswords.Strings.ssu_fallenbetrayer <- {
	Name = "Headless {1}"
};

// scripts\entity\tactical\enemies\ssu_necro_ghost_praetorian_boss.nut
::Mod_Sellswords.Strings.ssu_necro_ghost_praetorian_boss <- {
	Name = "Kriegsgeist",
	Log = "{1} remains unharmed!"
};

// scripts\entity\tactical\enemies\ssu_necro_ghost_praetorian_boss_fragment.nut
::Mod_Sellswords.Strings.ssu_necro_ghost_praetorian_boss_fragment <- {
	Log = "A Horrific Scream echoes in {1}\'s head"
};

// scripts\entity\tactical\enemies\ssu_zombieswordmaster.nut
::Mod_Sellswords.Strings.ssu_zombieswordmaster <- {
	Name = "Headless {1}"
};

// scripts\entity\tactical\humans\ssu_paladin_guest.nut
::Mod_Sellswords.Strings.ssu_paladin_guest <- {
	Titles = [ "the Pious", "the Scholar", "the Preacher", "the Devoted", "the Quiet", "the Calm", "of the Light", "the Wise", "the Faithful", "the Paladin", "the Lightbringer", ]
};

// scripts\entity\tactical\humans\ssu_sergeant_guest.nut
::Mod_Sellswords.Strings.ssu_sergeant_guest <- {
	Title = "the Sergeant"
};

// scripts\entity\tactical\ssu_necro_undead_player.nut
::Mod_Sellswords.Strings.ssu_necro_undead_player <- {
	Log1 = "{1} has killed {2}",
	Log2 = "{1} has died",
	Log3 = "{1} has struck down {2}",
	Log4 = "{1} has fallen and can\'t get up"
};

// scripts\entity\tactical\ssu_necro_zombie_dog.nut
::Mod_Sellswords.Strings.ssu_necro_zombie_dog <- {
	Name = "Raised Hound"
};

// scripts\entity\world\locations\ssu_bandit_camp_location.nut
::Mod_Sellswords.Strings.ssu_bandit_camp_location <- {
	Text = "A reinforced encampment built on a ruin castle, where usually a large group of outlaws are assembled by a notorious bandit warlord."
};

// scripts\entity\world\locations\ssu_bandit_ruins_location.nut
::Mod_Sellswords.Strings.ssu_bandit_ruins_location <- {
	Text = "A once proud fortress now lying in ruins, a once bullied peasant now compelled vicious desperado."
};

// scripts\entity\world\locations\ssu_dryad_tree_location.nut
::Mod_Sellswords.Strings.ssu_dryad_tree_location <- {
	Text = "An immensely tall ash tree. You can see things climbing between the giant branches as you gaze from afar.",
	Name = "Yggdrasil"
};

// scripts\entity\world\locations\ssu_necro_kriegsgeist_location.nut
::Mod_Sellswords.Strings.ssu_necro_kriegsgeist_location <- {
	Text = "A broken down stronghold, one which wraps you in a bone-deep chill when you gaze upon it.",
	Name = "Kriegsgeist: Castle of Ghastly Screams"
};

// scripts\entity\world\locations\ssu_orc_fortress_location.nut
::Mod_Sellswords.Strings.ssu_orc_fortress_location <- {
	Text = "A mighty fortress made from massive iron wood logs and covered in tribal paintings of war. The bloodthirsty shouts of orcs echoing behind the walls can be heard from afar.",
	Name = "Fortress of the Warlord"
};

// scripts\entity\world\locations\ssu_ss_camp_location.nut
::Mod_Sellswords.Strings.ssu_ss_camp_location <- {
	Text = "A magnificent tower blending into the surroundings without lacking coordination.",
	Name = "{1}’s Tower"
};

// scripts\events\events\dlc6\location\ssu_necro_sunken_library_event.nut
::Mod_Sellswords.Strings.ssu_necro_sunken_library_event <- {
	Title = "As you approach...",
	Text1 = "[img]gfx/ui/events/event_173.png[/img]{After spending what felt like an eternity exploring the farthest corners of the world in search of hidden knowledge and ancient secrets, you finally return to the sunken library buried deep within the desert sands.\n\nAs you approach the weathered ruins of the ancient building, memories of the time away flood your mind, a tapestry of experiences woven from the threads of countless insights and discoveries. Yet, despite the wealth of knowledge you\'ve amassed during your travels, a sense of anticipation grips your skeletal form as you draw closer to your long-abandoned home.\n\nWith each step, the shifting sands whisper tales of the secrets that lie buried beneath the desert\'s surface, guiding you back to the heart of this hidden sanctuary.\n\nStanding before the weathered walls of the library, a sense of homecoming washes over you, your untiring form pulsing with renewed vigor at the prospect of delving once more into the depths of this cherished repository of knowledge. But that\'s a trap, and the knowledge you\'ve gained while away has proven that. Although, you suppose that since you\'re here already you could stock up on some more supplies.}",
	Text2 = "More scrolls couldn\'t hurt.",
	Text3 = "Scrolls",
	Text4 = "Some leftover arms for the guards maybe.",
	Text5 = "Gear",
	Text6 = "Could always use another servant.",
	Text7 = "Recruit",
	Text8 = "[img]gfx/ui/events/event_161.png[/img]{Before departing from the ancient structure once more, you make your way through the dimly lit corridors of the sunken library, your skeletal form moving effortlessly through the sand and dusty air. Keen eyes scan the shelves lined with crumbling tomes and weathered scrolls, each one a treasure trove of forgotten knowledge waiting to be uncovered.\n\nWith a practiced hand, you pluck several scrolls from their resting places, their ancient parchment crackling softly beneath your touch. Each scroll is a fragment of history, a piece of the puzzle that you\'ve dedicated your existence to unraveling. As they get added to your collection, a sense of satisfaction wash over you, knowing that these scrolls will soon reveal their secrets.\n\nArms laden with extra reading material, you turn to leave the sunken library behind once more, mind already racing with thoughts of the information that awaits beyond these weathered walls. But as you take those final steps towards the exit, you cast one last glance over your shoulder, a silent promise to return again one day and continue the quest for knowledge in the place you call home.}",
	Text9 = "{These will go nicely with the rest.}",
	Tooltip = "You gain {1}{2}",
	Text10 = "[img]gfx/ui/events/event_161.png[/img]{Before venturing forth from the ancient structure, you make a detour to the armory tucked away in the depths of the sunken library. Though your pursuits lie in the realm of knowledge and magic, you are no stranger to the perils of the world beyond, and intimately know the importance of being prepared for whatever challenges may arise.\n\nMoving with a sense of purpose, you survey the racks of weapons and suits of armor that line the walls of the armory, their surfaces gleaming faintly in the dim light. Your gaze lingers on a finely crafted sword, its blade etched with ancient words of power, and a suit of armour adorned with intricate designs that speak of battles long since past.\n\nCalling over one of your retinue, you select the runed sword and a sturdy suit of armour that will provide your guards with both protection and mobility for the journey ahead. With weapons and armour secured, your make way to the exit of the armoury, footsteps echoing softly against the stone floors. Stepping out into the dusty corridors of the ancient library once more, you are filled with a renewed sense of purpose, ready to embark on the next chapter of your pursuit for knowledge.}",
	Text11 = "{They better appreciate this...}",
	Text12 = "[img]gfx/ui/events/event_161.png[/img]{Before setting out from the sunken library, you make your way to the chambers where your loyal servants await your command. Among them, you seek out one whose skills will prove invaluable on your journey into the unknown, a steadfast companion to accompany your quest for knowledge.\n\nYou survey the ranks of loyal servants with a thoughtful gaze, each one reliable and ready to face the dangers of the realm above. Among them, you find a servant whose unwavering loyalty and dedication set them apart from the rest, a guardian whose presence will bring you comfort on the long road ahead.\n\nWith a gesture of acknowledgment, you beckon %dude% to your side, their eyes alight with anticipation at the prospect of serving you once more. As they fall into step, you make your way to the exit of the chambers, footsteps echoing softly against the stone floors. Stepping out into the dusty corridors of the ancient library once more, you feel ready to face whatever challenges may come our way as another one of your servants joins your ever-growing retinue.}",
	Text13 = "{Now get to work!}"
};

// scripts\events\events\special\ssu_check_difficulty_event.nut
::Mod_Sellswords.Strings.ssu_check_difficulty_event <- {
	Title = "Difficulty Customization",
	Text1 = "[img]gfx/ui/events/event_64.png[/img]This is a periodical event, which procs every 50 days, the aim of which is to help you adjust the difficulty of the game on the fly.\n\nThis event does not change your selected difficulty and instead adjusts your party strength (combat rating) resulting in enemy parties being easier or harder depending on the multiplier.\n\nThe difficulty adjustment is determined by the most recent choice.",
	Text2 = "I\'m ready to pick my difficulty.",
	Text3 = "[img]gfx/ui/events/event_64.png[/img]Again, just to reiterate, this event does not change your selected COMBAT difficulty that you picked at the start of the game, it only adjusts your party strength. The difficulty adjustment is determined by the most recent choice.\n\nThe mod is balanced around the Normal rating of 85%, for best results I\'d recommend you keep it on that. That being said, the option to change it on the fly is here for that specific reason. If you're finding the game too easy or too hard, feel free to adjust the enemy scaling.[/p]",
	Text4 = "Beginner (55%)",
	Text5 = "Easy (70%)",
	Text6 = "Normal (85%, default)",
	Text7 = "Hard (100%)",
	Text8 = "Extreme (115%)",
	Text9 = "[img]gfx/ui/events/event_24.png[/img]Beginner difficulty set.\n\nWe forge our path through steel and sweat, earning honor with every battle.",
	Text10 = "Let's continue our journey.",
	Tooltip1 = "{1} gains [color={2}]+{3}[/color] Max Fatigue",
	Tooltip2 = "{1} gains [color={2}]+{3}[/color] Initiative",
	Tooltip3 = "{1} gains [color={2}]+{3}[/color] Hitpoints",
	Tooltip4 = "{1} gains [color={2}]+{3}[/color] Resolve",
	Text11 = "[img]gfx/ui/events/event_24.png[/img]Easy difficulty set.\n\nWhen the world turns against us, we stand firm, united by our resolve and our blades.",
	Text12 = "[img]gfx/ui/events/event_24.png[/img]Normal difficulty set.\n\nIn every contract, we find purpose; in every victory, we find glory.",
	Text13 = "[img]gfx/ui/events/event_24.png[/img]Hard difficulty set.\n\nOur strength is not just in our swords, but in the bonds we share as comrades.",
	Text14 = "[img]gfx/ui/events/event_24.png[/img]Extreme difficulty set.\n\nWe live by the sword, but our legacy is written in the legends we leave behind."
};

// scripts\events\events\ssu_companion_event.nut
::Mod_Sellswords.Strings.ssu_companion_event <- {
	Title = "Like minds and simple hearts",
	Text1 = "[img]gfx/ui/events/event_127.png[/img]{A figure comes into sight, sitting on a low rock and carefully sharpening their weapon and patching any holes in their armour. Strangely enough, they speak first.%SPEECH_ON%I\'m %recruit%, and there\'s talk across the land of you runnin\' around looking to prove \'urself%SPEECH_OFF%Your hand steadily crawls towards your weapon but the stranger takes note of this.%SPEECH_ON%No — not like that. In fact, im interesting in joining. The arenas in the south only have so many things to kill and the north can be...somewhat empty at times.%SPEECH_OFF%}",
	Text2 = "You might as well join us.",
	Text3 = "No, thanks, we\'re good.",
	Name = "{1}\'s Bag"
};

// scripts\events\events\ssu_dryad_event.nut
::Mod_Sellswords.Strings.ssu_dryad_event <- {
	Title = "The Awakening",
	Text1 = "[img]gfx/ui/events/event_128.png[/img]For countless generations, the Heartwoods have stood as a haven of untamed nature, protected by the Dryads who dwell within its ancient groves. But the peace of the forest is under siege. Human settlements spread like wildfire, their axes and torches cutting deeper into the heart of the woodland with each passing day. Sacred trees are felled to fuel their forges, and once-pristine streams are polluted by their heedless ways.\n\nThe Dryads have long held their wrath in check, hoping that humans would come to respect the natural order. But patience has given way to fury. The forest stirs, and its guardians rise with it. Warriors from a time long past—each Dryad prepares to defend their ancestral home from the encroaching invaders.\n\nThis is no longer a time for silent protection. The balance of the land has been shattered, and the Dryads will no longer allow the desecration of their sacred home. The invaders will be driven back, their settlements reduced to ruins, and the forest will be restored to its former glory. With the ancient power of nature at their command, the Dryads will fight to reclaim what is rightfully theirs.",
	Text2 = "Time to get to work!"
};

// scripts\events\events\ssu_dryad_tree_enter_event.nut
::Mod_Sellswords.Strings.ssu_dryad_tree_enter_event <- {
	Title1 = "As you approach...",
	Text1 = "[img]gfx/ui/events/legend_heartwood.png[/img]{The company gather at the edge of the ancient forest, the dim glow of torches casting eerie shadows among the trees. The air is thick with tension, each sellsword\'s face set with a grim determination.%SPEECH_ON%We\'ve lost too many to them%SPEECH_OFF% %randombrother% mutters, tightening the grip on their weapon.%SPEECH_ON%These farkers won\'t stop until every village is overrun by their cursed roots.%SPEECH_OFF%You nod in agreement. The World Tree is their heart, their source of power. If we burn it, we end this war for good. The forests will never be safe as long as it stands.\n\nA whisper of wind rustled the leaves, almost as if the forest itself was listening.\n\n%randombrother% approaches you.%SPEECH_ON%Cap\'n? Are you sure about this?%SPEECH_OFF%}",
	Text2 = "Burn it all down!",
	Text3 = "Enter",
	Text4 = "Let\'s come back once we\'re stronger.",
	Text5 = "[img]gfx/ui/events/legend_heartwood_ritual.png[/img]{You push deeper into the heart of the forest, the glow of your torches barely piercing the thick fog. The ancient trees tower ominously, twisted branches forming an almost impenetrable barrier above.\n\nAs you approach the World Tree, a sense of unease settls over the group, the silence of the forest growing heavier with each step.%SPEECH_ON%Stay sharp%SPEECH_OFF%You whisper, voice tense.%SPEECH_ON%They know we\'re here.%SPEECH_OFF%As if by command, the forest starts to comes alive. From every direction, the Dryads emerge. Silent, ethereal figures stepping out from the trees as if they were one with the wood itself.\n\n%companyname% find themselves surrounded, the eerie eyes of your enemies glowing with an ancient fury. The smell of the air, thick with the scent of sap and earth. The rustling of leaves. The flickering of torches against the tree. You start to tighten your grip around your weapon as the first wave of Dryads lumber forward.}",
	Text6 = "Fight for your lives! Fight like you\'ve never fought before!",
	Text7 = "[img]gfx/ui/events/legend_heartwood_dead.png[/img]{The forest was eerily quiet after the battle. The company, bloodied and weary, stand among the fallen dryads, their breath heavy in the stillness. The remains of the World Tree looming over them, its ancient bark now scarred, broken by the clash.\n\nFrom the shadows of the trees, a lone dryad emerged, moving slowly, almost hesitantly. Their form delicate, eyes wide with confusion and sorrow. They seem lost, as if the violence had shattered something within them. %randombro%, still gripping their sword, steps forward cautiously. %SPEECH_ON%What do you want?%SPEECH_OFF% they demand, though their voice lacks the earlier bravado.\n\nThe dryad didn't respond immediately. Instead they look around at the destruction, their gaze lingering on the bodies of their fallen kin. Finally, they met the sellsword's eyes, expression one of deep sadness.%SPEECH_ON%Why?%SPEECH_OFF%They quietly mutter, their gravelly voice barely audible.%SPEECH_ON%Why have you done this?%SPEECH_OFF%The sellswords exchanged uneasy glances, their earlier resolve wavering in the face of their grief. The dryad takes another step forward, posture unthreatening but filled with a profound sense of loss.%SPEECH_ON%We were only trying to protect our home. Our lives. And now? Now there is nothing left to protect.%SPEECH_OFF%Their words hang in the air, heavy with the weight of the devastation that had been wrought. The sellswords of %companyname%, victorious but hollow, only stand in silence, their triumph now tinged with the bitter taste of regret.}",
	Text8 = "You can continue your fight alongside us.",
	Text9 = "Recruit",
	Text10 = "You can burn with the rest of them!",
	Text11 = "Deny",
	Title2 = "After the battle...",
	Text12 = "Perhaps one day...",
	Text13 = "[img]gfx/ui/events/legend_heartwood_dead.png[/img]The sellswords, recognizing something in the Dryad\'s sorrowful plea, sheath their weapons. You step forward and extended a hand.%SPEECH_ON%You fought bravely,%SPEECH_OFF% You say, voice softer now.%SPEECH_ON%If you truly have nothing left here, come with us. The world outside this forest is harsh, but if your mission is to rid the world of man then there\'s no-one better to work with.%SPEECH_OFF%The Dryad looks up, their eyes searching your face. They see no malice, no bloodlust, only a weary soul trying to survive, much like them.\n\nAfter a moment\'s hesitation, they placed their hand in yours, the touch cool and delicate, like the leaves that once surrounded them.",
	Text14 = "Welcome to the company.",
	Title3 = "the Lost",
	RawDescription = "%name% was once a guardian of the sacred world tree Yggdrasil, deeply connected to the natural world and tasked with protecting the forest from invaders.\nThey lived in harmony with the other Dryads, using their abilities to heal the land and maintain the delicate balance of nature. However, after witnessing the destruction of their home and the loss of their kin, they found themselves at a crossroads.\nTorn between their duty to the forest and a growing curiosity about the human world, they eventually chose to join the company, hoping to understand your ways and perhaps find a new purpose beyond the confines of the forest.",
	Title4 = "It\'s time to leave.",
	Text15 = "[img]gfx/ui/events/legend_heartwood_dead.png[/img]You don\'t think the Dryad should be left to roam the land, but you do set it free nonetheless.\n\nNo sooner than you shout the command does the company leap into action, resulting in the Dryad\'s swift demise. Better to leave nothing left, lest they somehow return down the road.",
	Text16 = "It\'s time to leave."
};

// scripts\events\events\ssu_gladiators_end_event.nut
::Mod_Sellswords.Strings.ssu_gladiators_end_event <- {
	Text1 = "[img]gfx/ui/events/event_155.png[/img]{Captain. A word, and then I am gone.\n\nDo you know what a gladiator is without another gladiator? A man in a silly helmet. There is nobody left to tell me that I, %gladiator%, am the lesser fighter. Nobody to lie about how many he killed while I was busy killing more. Nobody to drink my wine and swear on the Gilder that a sellsword did it. I fought for the crowd my whole life, and it turns out the only crowd I ever cared for was the men bleeding into the sand next to me.\n\nYour sellswords are fine killers, but they fight for crowns. I never learned how to do that, and I am too pretty to start now. So I am going back south. The arena will have me, and when it finally takes me, at least it will be loud.\n\nKeep my share. Without its gladiators the %companyname% has no name worth shouting anyway, and by morning the rest of them will have worked that out too.}",
	Text2 = "It was glorious while it lasted.",
	Title = "The Last Gladiator"
};

// scripts\events\events\ssu_necro_kriegsgeist_castle_enter_event.nut
::Mod_Sellswords.Strings.ssu_necro_kriegsgeist_castle_enter_event <- {
	Title1 = "As you approach...",
	Text1 = "[img]gfx/ui/events/event_99.png[/img]{Standing before you, the stronghold of a forgotten past. From rumors, there is great treasures inside this ruins of a castle, untouched by treasure hunters as none of them return alive or are still sane of mind.\n\nYou used to think such tales were nonsense but now you\'ve finally reached here, the chilling air, the dreadful feeling in your gut, the thought of being watched by something. It\'s as true as the rumors said, making you grow ever more anxious, a sentiment you\'re sure most of the company shares.\n\n%randombrother% approaches you.%SPEECH_ON%Cap\'n? Why again must we enter this damned place? Surely nothing good can come from us tresspassing.%SPEECH_OFF%}",
	Text2 = "Be that as it may, we\'re going in. Get ready for anything.",
	Text3 = "Aye, let\'s not disturb what rests here just yet.",
	Text4 = "[img]gfx/ui/events/event_57.png[/img]{You enter the keep, keeping your wits about you as the company carefully advances through these hallowed grounds. You glance around as you approach a giant castle in the centre of the keep.%SPEECH_ON%Hey %randombrother%, open the doors.%SPEECH_OFF% You hear them muttering something about a \'being a farkin\' chicken\', but you sure-as-shit aren\'t about to open them yourself.\n\nAs they push open the massive, time-worn doors of the keep, the groan of rusted hinges echoes through the cold, dark surroundings. The company enters, air thick with what is certainly the passage of centuries and you swear you can hear the faint whispers of long-dead souls as you navigate the men through the ancient halls.\n\nUpon entering what you can only imagine was once a beautiful courtyard, you spot a figure ahead. Its giant spectral form draped in an ancient armor, and as it turns in welcome, their glowing eyes lock onto yours. In its hands, the prize of the keep, the entire reason you\'re here, a glowing halberd forged from a forgotten age wielded with a deadly intent.%SPEECH_ON%Trespassers, you shouldn\'t have come here. Now you\'ll pay for such foolishness with your lives!%SPEECH_OFF%}",
	Text5 = "Time to earn those crowns! Men, get into positions!",
	Text6 = "[img]gfx/ui/events/event_99.png[/img]{As the dust settles and the echoes of battle fade, the once formidable specter lies vanquished, its cursed armor shattered and the ancient halberd now in your hands. The air grows still, as if the very walls of the keep recognize your triumph.\n\nThough many of the company bear wounds, there is a palpable sense of relief. The treasure of Kriegsgeist Castle is now yours, but at what cost? Only time will tell if the true prize was worth the bloodshed.}",
	Text7 = "We survived, and are stronger for it.",
	Title2 = "After the battle...",
	Tooltip = "You gain [color=#456ca0]Specter\'s Requiem[/color]",
	Text8 = "[img]gfx/ui/events/event_99.png[/img]The cold grip of defeat tightens as the last of your company falls, their bodies claimed by the haunted grounds of Kriegsgeist Castle. The spectral warrior looms over your broken form, its hollow laughter echoing through the desolate halls. The ancient halberd gleams in the gloom, untouched and unclaimed. Perhaps one day, another will be bold enough to challenge this cursed place—but today, it belongs to the dead.",
	Text9 = "Perhaps one day..."
};

// scripts\events\events\ssu_necro_lorekeeper_intro_event.nut
::Mod_Sellswords.Strings.ssu_necro_lorekeeper_intro_event <- {
	Text1 = "[img]gfx/ui/events/event_173.png[/img]{For centuries, the presence of the Lorekeeper had haunted the desolate halls of their sunken library. First, bound by its lust for knowledge, and then to guard their treasured tomes. Yet, as the shadows lengthened and the whispers of the dead grew louder, a malevolent force stirred within the heart of the buried repository. \n\nDriven by an insatiable hunger for knowledge and fueled by the dark energies that pulsed within their undead form, the Lorekeeper\'s once dormant spirit awakened with a newfound purpose. No longer content to linger in their sandy tomb, they fixed their spectral gaze upon the wealth of knowledge awaiting beyond their previous confines. \n\nEmerging from the sunken remains of the library, the Lorekeeper gathered their loyal servants to its side. Initially assigned to carrying the most important of its literary treasures, they also signalled the start of an army of undead, soon to march upon the world of the living. \n\nWith each step they took, the ground darkened beneath their feet, and the air grew thick with the stench of decay. As the sun set on the horizon and darkness descended upon the land, the stage was set for a campaign that would determine the fate of both the living and the dead. \n\nThe Lorekeeper\'s reign of terror had begun, and the world soon understand the power that once lay dormant under the sandy dunes of the south.}",
	Text2 = "Time to \'aquire\' some new reading material...",
	Title = "A Wealth of Knowledge Awaits"
};

// scripts\events\events\ssu_necro_recruit_undead_event.nut
::Mod_Sellswords.Strings.ssu_necro_recruit_undead_event <- {
	Title = "Well What Do We Have Here",
	Text1 = "[img]gfx/ui/events/event_29.png[/img]As you walk along the road, {you can\'t help but notice a shifting figure moving out of the corner of your eye. | a small shape darting in and out of your vision. | a lumbering mass traipsing through the field.} On closer inspection it seems a member of the undead has lost their way - just as a sheep jumps the paddock and wanderers aimlessly before being stolen or killed.\n\n It is hard to say where this one came from, perhaps a {nearby battlefield | mass grave | far off place | raided farmstead | shallow ditch | shallow grave}. Either way, they would make a good addition to %companyname% to bolster your horde.",
	Text2 = "I shall call you... %joiner%!",
	Text3 = "Leave it to wander."
};

// scripts\events\events\ssu_orc_fortress_destroyed_event.nut
::Mod_Sellswords.Strings.ssu_orc_fortress_destroyed_event <- {
	Title = "After the battle...",
	Text1 = "[img]gfx/ui/events/event_32.png[/img]{The warlord is right where he should be: dead on the ground. It looks surprisingly at peace given the amount of terror and chaos it put on this earth. You and %randombrother% look at the orc warlord\'s corpse. Flies are already busying themselves on its tongue, farking one another and spreading their plague. The mercenary looks at you and laughs.%SPEECH_ON%Is that the end you see for yourself, a bunch of insects doing the business on your goddam face?%SPEECH_OFF%You shrug and answer.%SPEECH_ON%It\'s a long ways away from dying while wrapped in a blanket and surrounded by family, that\'s for sure.%SPEECH_OFF%You slap the sellsword on the chest.%SPEECH_ON%C\'mon, enough of that talk. Let\'s get back to the nearest town and have a nice drink.%SPEECH_OFF%}",
	Text2 = "Still, we prevailed."
};

// scripts\events\events\ssu_sellswords_intro_event.nut
::Mod_Sellswords.Strings.ssu_sellswords_intro_event <- {
	Text1 = "[img]gfx/ui/events/event_80.png[/img] The crisp morning breeze fills your lungs as dawn breaks on the horizon, marking the beginning of a new chapter in your life.\n\nAfter years of fighting in the blood-soaked fields for scant rewards, you\'ve finally amassed enough crowns to forge your own mercenary company. With you stand %bro1%, %bro2%, and %bro3%, battle-hardened companions who you\'ve shared many a battlefield with, and with them you\'ll share many more. Now, as their commander, you lead the %companyname%.\n\nAs you journey across these lands, your first task is to bolster your ranks. In the towns and villages, you\'ll find many eager recruits, though most are untested in the ways of war. Whether driven by desperation or the allure of quick riches, many will not survive their first battle. Yet, do not let this dishearten you. This is the life of a mercenary, and in every village, there are always new souls ready to embrace the dangers and opportunities of this brutal profession.\n\nThese are perilous times. Bandits and marauders lie in wait along the roads, wild beasts haunt the shadowy forests, and orcish hordes stir restlessly on the fringes of civilization. Whispers of dark magic circulate, telling of the dead rising from their graves. But where there is danger, there is also opportunity. Whether you take on contracts in the towns and cities or venture out on your own to plunder and explore, there is no shortage of ways to earn a fortune.\n\nYour men await your command, ready to live and die under the banner of the %companyname%.",
	Text2 = "Onwards!",
	Title = "The {1}"
};

// scripts\events\events\ssu_volunteer_event.nut
::Mod_Sellswords.Strings.ssu_volunteer_event <- {
	Title = "After the battle...",
	Text1 = "[img]gfx/ui/events/event_53.png[/img]{The surviving man scrambles away from you. He\'s muttering something. You can\'t hear it, but the language is clear nonetheless: he knows who you are, and what you are. | The battle over, you find one survivor in the field. He\'s a little scraped up but could be of use. | %SPEECH_ON%Slaving shit, do your worst.%SPEECH_OFF%Despite being the last man standing, the northerner\'s still got some fight in him. He may do well in the %companyname%. | You find the last man standing, hurt but alive. He\'s a northerner and would look good in chains. Perhaps fetch a solid price in the south, or serve as fodder on the frontlines? | The northern troop has been cut down to its last, a pale man who seems to not dwell long in defeat.%SPEECH_ON%Southern shits, your \'Gilder\' can suck my balls. C\'mon, give me a weapon, I\'ll show you how a northerner dies!%SPEECH_OFF%You can\'t help but like his gusto. Instead of serving worms in the grave, perhaps he could serve the company as one of the indebted?}",
	Text2 = "Take him as an indebted to the Gilder so that he may earn his salvation.",
	Text3 = "We have no use for him.",
	RawDescription = "Formerly a soldier loyal to noble lords, his company was slaughtered by your men and %name% was taken as an indebted. It didn\'t take much to break his spirit and force him to fight for you."
};

// scripts\items\accessory\ssu_militia_armband_item.nut
::Mod_Sellswords.Strings.ssu_militia_armband_item <- {
	Name = "Militia Armband",
	Description = "A crimson armband signaling membership for militias incapable of requisitioning proper uniforms.",
	Tooltip1 = "[color=%positive%]+1[/color] Resolve per ally wearing a militia armband or sergeant\'s sash.",
	Tooltip2 = "Current bonus: [color=%positive%]{1}[/color]"
};

// scripts\items\ammo\ssu_dryad_forest_heart_ammo.nut
::Mod_Sellswords.Strings.ssu_dryad_forest_heart_ammo <- {
	Name = "Heart of the Forest",
	Description = "The life and soul of the forest, used for casting Dryad magic. Is automatically refilled after each battle if you have enough ammunition.",
	Tooltip1 = "Contains enough power for [color=%positive%]{1}[/color] uses",
	Tooltip2 = "[color=%negative%]Is dull and useless[/color]"
};

// scripts\items\ammo\ssu_quiver_of_bleeding_arrows.nut
::Mod_Sellswords.Strings.ssu_quiver_of_bleeding_arrows <- {
	Name = "Quiver of Serrated Arrows",
	Description = "A quiver of arrows, with arrowheads made of sharp serrated metal.\nIt will cause targets to gain a stacking bleed debuff, causing 10 damage per stack for 2 turns.\nEach ammo refilled costs thrice as much compared to conventional ammunition.\nIs automatically refilled after each battle if you have enough ammunition.",
	Tooltip1 = "Contains [color=%positive%]{1}[/color] arrows",
	Tooltip2 = "[color=%negative%]Is empty and useless[/color]"
};

// scripts\items\ammo\ssu_quiver_of_bleeding_bolts.nut
::Mod_Sellswords.Strings.ssu_quiver_of_bleeding_bolts <- {
	Name = "Quiver of Serrated Bolts",
	Description = "A quiver of bolts with arrowheads made of sharp serrated metal.\nIt will cause targets to gain a stacking bleed debuff, causing 10 damage per stack for 2 turns.\nEach ammo refilled costs thrice as much compared to conventional ammunition.\nIs automatically refilled after each battle if you have enough ammunition.",
	Tooltip1 = "Contains [color=%positive%]{1}[/color] bolts",
	Tooltip2 = "[color=%negative%]Is empty and useless[/color]"
};

// scripts\items\ammo\ssu_quiver_of_fire_arrows.nut
::Mod_Sellswords.Strings.ssu_quiver_of_fire_arrows <- {
	Name = "Quiver of Fire Arrows",
	Description = "A quiver of arrows with a oiled tip and a sparker on the rim.\nIt will inflict an additional 50% of damage as fire damage and ignite the ground the target stands on for 2 turns, does extra damage against undead and trees.\nCan cause fire related injuries.\nEach ammo refilled costs thrice as much compared to conventional ammunition.\nIs automatically refilled after each battle if you have enough ammunition.",
	Tooltip1 = "Contains [color=%positive%]{1}[/color] arrows",
	Tooltip2 = "[color=%negative%]Is empty and useless[/color]"
};

// scripts\items\ammo\ssu_quiver_of_fire_bolts.nut
::Mod_Sellswords.Strings.ssu_quiver_of_fire_bolts <- {
	Name = "Quiver of Fire Bolts",
	Description = "A quiver of bolts with a oiled tip and a sparker on the rim.\nIt will inflict an additional 50% of damage as fire damage and ignite the ground the target stands on for 2 turns, does extra damage against undead and trees.\nCan cause fire related injuries.\nEach ammo refilled costs thrice as much compared to conventional ammunition.\nIs automatically refilled after each battle if you have enough ammunition.",
	Tooltip1 = "Contains [color=%positive%]{1}[/color] bolts",
	Tooltip2 = "[color=%negative%]Is empty and useless[/color]"
};

// scripts\items\ammo\ssu_quiver_of_freezing_arrows.nut
::Mod_Sellswords.Strings.ssu_quiver_of_freezing_arrows <- {
	Name = "Quiver of Freezing Arrows",
	Description = "A quiver of arrows, the heads of which are tipped by the Ebonice of the North.\nIt will chill targets for up to two turns, reducing their action points by 3 and initiative by 30.\nEach ammo refilled costs thrice as much compared to conventional ammunition.\nIs automatically refilled after each battle if you have enough ammunition.",
	Tooltip1 = "Contains [color=%positive%]{1}[/color] arrows",
	Tooltip2 = "[color=%negative%]Is empty and useless[/color]"
};

// scripts\items\ammo\ssu_quiver_of_freezing_bolts.nut
::Mod_Sellswords.Strings.ssu_quiver_of_freezing_bolts <- {
	Name = "Quiver of Freezing bolts",
	Description = "A quiver of bolts, the heads of which are tipped by the Ebonice of the North.\nIt will chill targets for up to two turns, reducing their action points by 3 and initiative by 30.\nEach ammo refilled costs thrice as much compared to conventional ammunition.\nIs automatically refilled after each battle if you have enough ammunition.",
	Tooltip1 = "Contains [color=%positive%]{1}[/color] bolts",
	Tooltip2 = "[color=%negative%]Is empty and useless[/color]"
};

// scripts\items\ammo\ssu_quiver_of_phantom_arrows.nut
::Mod_Sellswords.Strings.ssu_quiver_of_phantom_arrows <- {
	Name = "Quiver of Phantom Arrows",
	Description = "A quiver of quietly humming ghostly arrows. You can't see these translucent arrows clearly, with them constantly flickering in and out of your vision as you gaze upon them. What you can clearly see however is the power that they contain.\nFires 2 additional phantom arrows, their damage is based on how many consecutive hits you've performed.\nEach ammo refilled costs thrice as much compared to conventional ammunition.\nIs automatically refilled after each battle if you have enough ammunition.",
	Tooltip1 = "Contains [color=%positive%]{1}[/color] arrows",
	Tooltip2 = "[color=%negative%]Is empty and useless[/color]"
};

// scripts\items\ammo\ssu_quiver_of_phantom_bolts.nut
::Mod_Sellswords.Strings.ssu_quiver_of_phantom_bolts <- {
	Name = "Quiver of Phantom Bolts",
	Description = "A quiver of quietly humming ghostly bolts. You can't see these translucent bolts clearly, with them constantly flickering in and out of your vision as you gaze upon them. What you can clearly see however is the power that they contain.\nFires 2 additional phantom bolts, their damage is based on how many consecutive hits you've performed.\nEach ammo refilled costs thrice as much compared to conventional ammunition.\nIs automatically refilled after each battle if you have enough ammunition.",
	Tooltip1 = "Contains [color=%positive%]{1}[/color] bolts",
	Tooltip2 = "[color=%negative%]Is empty and useless[/color]"
};

// scripts\items\ammo\ssu_quiver_of_poisoned_arrows.nut
::Mod_Sellswords.Strings.ssu_quiver_of_poisoned_arrows <- {
	Name = "Quiver of Poisoned Arrows",
	Description = "A quiver of arrows, taken from the corpse of a dead Goblin.\nIt contains a liquid filling the bottom of the quiver to quickly apply the Goblin\'s poison to inserted arrows, the poison lasts for 3 turns.\nEach ammo refilled costs thrice as much compared to conventional ammunition.\nIs automatically refilled after each battle if you have enough ammunition.",
	Tooltip1 = "Contains [color=%positive%]{1}[/color] arrows",
	Tooltip2 = "[color=%negative%]Is empty and useless[/color]"
};

// scripts\items\ammo\ssu_quiver_of_poisoned_bolts.nut
::Mod_Sellswords.Strings.ssu_quiver_of_poisoned_bolts <- {
	Name = "Quiver of Poisoned Bolts",
	Description = "A quiver of bolts, taken from the corpse of a dead Goblin.\nIt contains a liquid filling the bottom of the quiver to quickly apply the Goblin\'s poison to inserted bolts, the poison lasts for 3 turns.\nEach ammo refilled costs thrice as much compared to conventional ammunition.\nIs automatically refilled after each battle if you have enough ammunition.",
	Tooltip1 = "Contains [color=%positive%]{1}[/color] bolts",
	Tooltip2 = "[color=%negative%]Is empty and useless[/color]"
};

// scripts\items\armor\greenskins\ssu_orc_berserker_light_armor.nut
::Mod_Sellswords.Strings.ssu_orc_berserker_light_armor <- {
	Name = "Trophy Bones"
};

// scripts\items\armor\greenskins\ssu_orc_berserker_medium_armor.nut
::Mod_Sellswords.Strings.ssu_orc_berserker_medium_armor <- {
	Name = "Bone Armor"
};

// scripts\items\armor\greenskins\ssu_orc_grunt_heavy_armor.nut
::Mod_Sellswords.Strings.ssu_orc_grunt_heavy_armor <- {
	Name = "Metal Plated Hide Armor"
};

// scripts\items\armor\greenskins\ssu_orc_grunt_light_armor.nut
::Mod_Sellswords.Strings.ssu_orc_grunt_light_armor <- {
	Name = "Hide Armor"
};

// scripts\items\armor\greenskins\ssu_orc_grunt_medium_armor.nut
::Mod_Sellswords.Strings.ssu_orc_grunt_medium_armor <- {
	Name = "Hide Armor"
};

// scripts\items\armor\greenskins\ssu_orc_packleader_heavy_armor.nut
::Mod_Sellswords.Strings.ssu_orc_packleader_heavy_armor <- {
	Name = "Looted Plate Armor"
};

// scripts\items\armor\greenskins\ssu_orc_packleader_light_armor.nut
::Mod_Sellswords.Strings.ssu_orc_packleader_light_armor <- {
	Name = "Looted Scale Armor"
};

// scripts\items\armor\greenskins\ssu_orc_packleader_medium_armor.nut
::Mod_Sellswords.Strings.ssu_orc_packleader_medium_armor <- {
	Name = "Looted Reinforced Mail"
};

// scripts\items\armor\ssu_guerdan_armor.nut
::Mod_Sellswords.Strings.ssu_guerdan_armor <- {
	Name = "Heavy Armor"
};

// scripts\items\helmets\ssu_helmet_orc_bear_head_helm.nut
::Mod_Sellswords.Strings.ssu_helmet_orc_bear_head_helm <- {
	Name = "Helmet"
};

// scripts\items\helmets\ssu_helmet_orc_bone_helm.nut
::Mod_Sellswords.Strings.ssu_helmet_orc_bone_helm <- {
	Name = "Helmet"
};

// scripts\items\helmets\ssu_helmet_orc_faceplate_helm.nut
::Mod_Sellswords.Strings.ssu_helmet_orc_faceplate_helm <- {
	Name = "Metal Plated Helmet"
};

// scripts\items\helmets\ssu_helmet_orc_packleader_heavy_helm.nut
::Mod_Sellswords.Strings.ssu_helmet_orc_packleader_heavy_helm <- {
	Name = "Metal Plate Helmet"
};

// scripts\items\helmets\ssu_helmet_orc_packleader_medium_helm.nut
::Mod_Sellswords.Strings.ssu_helmet_orc_packleader_medium_helm <- {
	Name = "Looted Kettle Hat"
};

// scripts\items\legend_armor\armor_upgrades\ssu_dryad_pauldrons_archer.nut
::Mod_Sellswords.Strings.ssu_dryad_pauldrons_archer <- {
	Name = "Greenwood Archer's Pauldrons",
	Description = "Tough yet flexible wooden pauldrons. Whatever magic was used to craft them seems to have lingered, slowly regrowing them when damaged.",
	Tooltip = "Repairs [color=%positive%]5[/color] armour each turn",
	Log = "{1} repaired for {2} points"
};

// scripts\items\legend_armor\armor_upgrades\ssu_dryad_pauldrons_grunt.nut
::Mod_Sellswords.Strings.ssu_dryad_pauldrons_grunt <- {
	Name = "Greenwood Pauldrons",
	Description = "Tough yet flexible wooden pauldrons. Whatever magic was used to craft them seems to have lingered, slowly regrowing them when damaged.",
	Tooltip = "Repairs [color=%positive%]5[/color] armour each turn",
	Log = "{1} repaired for {2} points"
};

// scripts\items\legend_armor\armor_upgrades\ssu_dryad_pauldrons_shaman.nut
::Mod_Sellswords.Strings.ssu_dryad_pauldrons_shaman <- {
	Name = "Greenwood Shaman Pauldrons",
	Description = "Tough yet flexible wooden pauldrons. Whatever magic was used to craft them seems to have lingered, slowly regrowing them when damaged.",
	Tooltip = "Repairs [color=%positive%]5[/color] armour each turn",
	Log = "{1} repaired for {2} points"
};

// scripts\items\legend_armor\armor_upgrades\ssu_dryad_pauldrons_tamer.nut
::Mod_Sellswords.Strings.ssu_dryad_pauldrons_tamer <- {
	Name = "Greenwood Tamer's Pauldrons",
	Description = "Tough yet flexible wooden pauldrons. Whatever magic was used to craft them seems to have lingered, slowly regrowing them when damaged.",
	Tooltip = "Repairs [color=%positive%]5[/color] armour each turn",
	Log = "{1} repaired for {2} points"
};

// scripts\items\legend_armor\armor_upgrades\ssu_dryad_pauldrons_warrior.nut
::Mod_Sellswords.Strings.ssu_dryad_pauldrons_warrior <- {
	Name = "Greenwood Warrior's Pauldrons",
	Description = "Tough yet flexible wooden pauldrons. Whatever magic was used to craft them seems to have lingered, slowly regrowing them when damaged.",
	Tooltip = "Repairs [color=%positive%]5[/color] armour each turn",
	Log = "{1} repaired for {2} points"
};

// scripts\items\legend_armor\chain\ssu_armor_hauberk_sleevless_named.nut
::Mod_Sellswords.Strings.ssu_armor_hauberk_sleevless_named <- {
	Description = "Truly fit for a knight, this sleevless mail hauberk is made from the highest quality materials and boasts precious decorations and ornaments."
};

// scripts\items\legend_armor\chain\ssu_dryad_chain_archer.nut
::Mod_Sellswords.Strings.ssu_dryad_chain_archer <- {
	Name = "Greenwood Archer's Gorget",
	Description = "A thick wooden gorget. Whatever magic was used to craft it seems to have lingered, slowly regrowing the armour when damaged.",
	Tooltip = "Repairs [color=%positive%]5[/color] armour each turn",
	Log = "{1} repaired for {2} points"
};

// scripts\items\legend_armor\chain\ssu_dryad_chain_grunt.nut
::Mod_Sellswords.Strings.ssu_dryad_chain_grunt <- {
	Name = "Greenwood Gorget",
	Description = "A thick wooden gorget. Whatever magic was used to craft it seems to have lingered, slowly regrowing the armour when damaged.",
	Tooltip = "Repairs [color=%positive%]5[/color] armour each turn",
	Log = "{1} repaired for {2} points"
};

// scripts\items\legend_armor\chain\ssu_dryad_chain_shaman.nut
::Mod_Sellswords.Strings.ssu_dryad_chain_shaman <- {
	Name = "Greenwood Shaman's Gorget",
	Description = "A thick wooden gorget. Whatever magic was used to craft it seems to have lingered, slowly regrowing the armour when damaged.",
	Tooltip = "Repairs [color=%positive%]5[/color] armour each turn",
	Log = "{1} repaired for {2} points"
};

// scripts\items\legend_armor\chain\ssu_dryad_chain_tamer.nut
::Mod_Sellswords.Strings.ssu_dryad_chain_tamer <- {
	Name = "Greenwood Tamer's Gorget",
	Description = "A thick wooden gorget. Whatever magic was used to craft it seems to have lingered, slowly regrowing the armour when damaged.",
	Tooltip = "Repairs [color=%positive%]5[/color] armour each turn",
	Log = "{1} repaired for {2} points"
};

// scripts\items\legend_armor\chain\ssu_dryad_chain_warrior.nut
::Mod_Sellswords.Strings.ssu_dryad_chain_warrior <- {
	Name = "Greenwood Warrior's Gorget",
	Description = "A thick wooden gorget. Whatever magic was used to craft it seems to have lingered, slowly regrowing the armour when damaged.",
	Tooltip = "Repairs [color=%positive%]5[/color] armour each turn",
	Log = "{1} repaired for {2} points"
};

// scripts\items\legend_armor\cloak\ssu_dryad_cloak_archer.nut
::Mod_Sellswords.Strings.ssu_dryad_cloak_archer <- {
	Name = "Greenwood Archer's Cloak",
	Description = "A magnificent growth of plants which feels as tough as it is intimiating to your enemies. Whatever magic was used to craft it seems to have lingered, slowly regrowing the armour when damaged.",
	Tooltip = "Repairs [color=%positive%]5[/color] armour each turn",
	Log = "{1} repaired for {2} points"
};

// scripts\items\legend_armor\cloak\ssu_dryad_cloak_grunt.nut
::Mod_Sellswords.Strings.ssu_dryad_cloak_grunt <- {
	Name = "Greenwood Cloak",
	Description = "A magnificent growth of plants which feels as tough as it is intimiating to your enemies. Whatever magic was used to craft it seems to have lingered, slowly regrowing the armour when damaged.",
	Tooltip = "Repairs [color=%positive%]5[/color] armour each turn",
	Log = "{1} repaired for {2} points"
};

// scripts\items\legend_armor\cloak\ssu_dryad_cloak_shaman.nut
::Mod_Sellswords.Strings.ssu_dryad_cloak_shaman <- {
	Name = "Greenwood Shaman Cloak",
	Description = "A magnificent growth of plants which feels as tough as it is intimiating to your enemies. Whatever magic was used to craft it seems to have lingered, slowly regrowing the armour when damaged.",
	Tooltip = "Repairs [color=%positive%]5[/color] armour each turn",
	Log = "{1} repaired for {2} points"
};

// scripts\items\legend_armor\cloak\ssu_dryad_cloak_tamer.nut
::Mod_Sellswords.Strings.ssu_dryad_cloak_tamer <- {
	Name = "Greenwood Tamer's Cloak",
	Description = "A magnificent growth of plants which feels as tough as it is intimiating to your enemies. Whatever magic was used to craft it seems to have lingered, slowly regrowing the armour when damaged.",
	Tooltip = "Repairs [color=%positive%]5[/color] armour each turn",
	Log = "{1} repaired for {2} points"
};

// scripts\items\legend_armor\cloak\ssu_dryad_cloak_warrior.nut
::Mod_Sellswords.Strings.ssu_dryad_cloak_warrior <- {
	Name = "Greenwood Warrior Cloak",
	Description = "A magnificent growth of plants which feels as tough as it is intimiating to your enemies. Whatever magic was used to craft it seems to have lingered, slowly regrowing the armour when damaged.",
	Tooltip = "Repairs [color=%positive%]5[/color] armour each turn",
	Log = "{1} repaired for {2} points"
};

// scripts\items\legend_armor\cloak\ssu_necro_embalmbed_soldier_body.nut
::Mod_Sellswords.Strings.ssu_necro_embalmbed_soldier_body <- {
	Name = "Ancient Southern Plate",
	Description = "An ancient piece of armor, designed to protect the torso from attacks. While the protection offered isn\'t perfect, the armor is just as much of an art piece as it is a defensive tool."
};

// scripts\items\legend_armor\cloak\ssu_necro_lorekeeper_body.nut
::Mod_Sellswords.Strings.ssu_necro_lorekeeper_body <- {
	Name = "Lorekeeper\'s Shawl",
	Description = "An ancient, but well-crafted, shawl with intricate decorations. This ceremonial cloak was required to be worn at all times by the acting head librarian.",
	Tooltip1 = "Makes enemies more likely to attack you",
	Tooltip2 = "Grants immunity to being stunned"
};

// scripts\items\legend_armor\cloth\ssu_dryad_cloth.nut
::Mod_Sellswords.Strings.ssu_dryad_cloth <- {
	Name = "Dryad Gown",
	Description = "A long and soft gown, magically woven from long leaves. Whatever magic was used to craft it seems to have lingered, slowly regrowing it when damaged.",
	Tooltip = "Repairs [color=%positive%]5[/color] armour each turn",
	Log = "{1} repaired for {2} points"
};

// scripts\items\legend_armor\plate\ssu_adorned_heavy_plate.nut
::Mod_Sellswords.Strings.ssu_adorned_heavy_plate <- {
	Name = "Adorned Heavy Plate",
	Description = "A heavy chainmail hauberk worn under a thick riveted jacket and reinforced with vambraces. Adorned with trophies and lovingly maintained despite its extensive use, this is the armor of a true questing knight."
};

// scripts\items\legend_armor\plate\ssu_adorned_mail_shirt.nut
::Mod_Sellswords.Strings.ssu_adorned_mail_shirt <- {
	Name = "Adorned Harness",
	Description = "A heavy mail shirt covered by a quilted surcoat. An impressive and well-maintained piece, adorned with trophies and holy symbols."
};

// scripts\items\legend_armor\plate\ssu_adorned_warriors_plate.nut
::Mod_Sellswords.Strings.ssu_adorned_warriors_plate <- {
	Name = "Adorned Warrior\'s Plate",
	Description = "A long mail shirt covered by a riveted leather gambeson. Heavily worn from extensive use, but adorned with relics and well-maintained."
};

// scripts\items\legend_armor\plate\ssu_dryad_plate_archer.nut
::Mod_Sellswords.Strings.ssu_dryad_plate_archer <- {
	Name = "Greenwood Archer's Breastplate",
	Description = "A rigid breastplate made from incredibly tough wood. Whatever magic was used to craft it seems to have lingered, slowly regrowing the armour when damaged.",
	Tooltip = "Repairs [color=%positive%]5[/color] armour each turn",
	Log = "{1} repaired for {2} points"
};

// scripts\items\legend_armor\plate\ssu_dryad_plate_grunt.nut
::Mod_Sellswords.Strings.ssu_dryad_plate_grunt <- {
	Name = "Greenwood Breastplate",
	Description = "A rigid breastplate made from incredibly tough wood. Whatever magic was used to craft it seems to have lingered, slowly regrowing the armour when damaged.",
	Tooltip = "Repairs [color=%positive%]5[/color] armour each turn",
	Log = "{1} repaired for {2} points"
};

// scripts\items\legend_armor\plate\ssu_dryad_plate_shaman.nut
::Mod_Sellswords.Strings.ssu_dryad_plate_shaman <- {
	Name = "Greenwood Shaman's Breastplate",
	Description = "A rigid breastplate made from incredibly tough wood. Whatever magic was used to craft it seems to have lingered, slowly regrowing the armour when damaged.",
	Tooltip = "Repairs [color=%positive%]5[/color] armour each turn",
	Log = "{1} repaired for {2} points"
};

// scripts\items\legend_armor\plate\ssu_dryad_plate_tamer.nut
::Mod_Sellswords.Strings.ssu_dryad_plate_tamer <- {
	Name = "Greenwood Tamer's Breastplate",
	Description = "A rigid breastplate made from incredibly tough wood. Whatever magic was used to craft it seems to have lingered, slowly regrowing the armour when damaged.",
	Tooltip = "Repairs [color=%positive%]5[/color] armour each turn",
	Log = "{1} repaired for {2} points"
};

// scripts\items\legend_armor\plate\ssu_dryad_plate_warrior.nut
::Mod_Sellswords.Strings.ssu_dryad_plate_warrior <- {
	Name = "Greenwood Warrior's Breastplate",
	Description = "A rigid breastplate made from incredibly tough wood. Whatever magic was used to craft it seems to have lingered, slowly regrowing the armour when damaged.",
	Tooltip = "Repairs [color=%positive%]5[/color] armour each turn",
	Log = "{1} repaired for {2} points"
};

// scripts\items\legend_armor\plate\ssu_leather_lamellar_harness_heavy_rotten.nut
::Mod_Sellswords.Strings.ssu_leather_lamellar_harness_heavy_rotten <- {
	Name = "Decayed Lamellar Harness",
	Description = "This lamellar harness made of thick overlapping metal plates is worn and parts have come lose or are missing. It still offers very good protection if you don\'t mind the smell."
};

// scripts\items\legend_armor\plate\ssu_leather_lamellar_heavy_rotten.nut
::Mod_Sellswords.Strings.ssu_leather_lamellar_heavy_rotten <- {
	Name = "Decayed Heavy Lamellar Armor",
	Description = "A heavy lamellar armor that covers most parts of the body with thick that is worn and decayed."
};

// scripts\items\legend_armor\plate\ssu_named_heraldic_mail.nut
::Mod_Sellswords.Strings.ssu_named_heraldic_mail <- {
	Description = "Truly fit for a knight, this plate coat is made from the highest quality materials and boasts precious decorations and ornaments."
};

// scripts\items\legend_armor\plate\ssu_named_noble_mail_armor.nut
::Mod_Sellswords.Strings.ssu_named_noble_mail_armor <- {
	Description = "This piece of light mail armor was once the personal item of a well known fencing master. It is as light as a tunic, but protects all vital body parts."
};

// scripts\items\legend_armor\plate\ssu_named_plated_mail_hauberk.nut
::Mod_Sellswords.Strings.ssu_named_plated_mail_hauberk <- {
	Description = "A thick mail hauberk combined with sturdy metal plates. This armor will protect its wearer even in the fiercest of battles."
};

// scripts\items\legend_armor\plate\ssu_named_sellswords_armor.nut
::Mod_Sellswords.Strings.ssu_named_sellswords_armor <- {
	Description = "This piece of layered armor belonged to a famed mercenary once. Its high resilience and flexibility make it a remarkable piece of craftsmanship. And it even comes with extra pockets!"
};

// scripts\items\legend_armor\tabard\ssu_horn_tabard.nut
::Mod_Sellswords.Strings.ssu_horn_tabard <- {
	Name = "Horn Plate",
	Description = "These segments of horn plate are made from one of the hardest yet flexible materials nature has to offer. Worn over common armor, they can help to deflect incoming blows.",
	Tooltip = "Reduces any melee damage to the body by [color=%negative%]-10%[/color]"
};

// scripts\items\legend_armor\tabard\ssu_necro_embalmbed_priest_body.nut
::Mod_Sellswords.Strings.ssu_necro_embalmbed_priest_body <- {
	Name = "Ancient Priest Garb",
	Description = "An ancient dressing for the priests of a civilisation long past. The priests that would wear this were often the centrepiece of horrific ritualistic sacrifice, offering their body and soul on an grim altar to appease their ancient Gods."
};

// scripts\items\legend_helmets\helm\ssu_adorned_closed_flat_top_with_mail.nut
::Mod_Sellswords.Strings.ssu_adorned_closed_flat_top_with_mail <- {
	Name = "Adorned Closed Flat Top",
	Description = "A closed helmet with complete faceguard and mail to protect the neck. Heavily worn from extensive use, but adorned with relics and well-maintained."
};

// scripts\items\legend_helmets\helm\ssu_adorned_full_helm.nut
::Mod_Sellswords.Strings.ssu_adorned_full_helm <- {
	Name = "Dumet Full Helm",
	Description = "A closed metal helm made by heterogeneous alloy to extend its tractility with breathing holes, this is the helmet of a true questing knight."
};

// scripts\items\legend_helmets\helm\ssu_death_knight_great_helm.nut
::Mod_Sellswords.Strings.ssu_death_knight_great_helm <- {
	Name = "Death Knight's Great Helm",
	Description = "Death Knight's Great Helm."
};

// scripts\items\legend_helmets\helm\ssu_death_knight_great_helm_02.nut
::Mod_Sellswords.Strings.ssu_death_knight_great_helm_02 <- {
	Name = "Death Knight's Great Helm",
	Description = "Death Knight's Great Helm."
};

// scripts\items\legend_helmets\helm\ssu_dryad_helm_archer.nut
::Mod_Sellswords.Strings.ssu_dryad_helm_archer <- {
	Name = "Dryad Archer's Helm",
	Description = "A sturdy wooden helm, pilfered from the corpse of a Dryad. For some reason it seems to slowly stitch itself back together when damaged.",
	Tooltip = "Repairs [color=%positive%]10[/color] armour each turn",
	Log = "{1} repaired for {2} points"
};

// scripts\items\legend_helmets\helm\ssu_dryad_helm_shaman.nut
::Mod_Sellswords.Strings.ssu_dryad_helm_shaman <- {
	Name = "Dryad Shaman Helm",
	Description = "A sturdy wooden helm, pilfered from the corpse of a Dryad. For some reason it seems to slowly stitch itself back together when damaged.",
	Tooltip = "Repairs [color=%positive%]10[/color] armour each turn",
	Log = "{1} repaired for {2} points"
};

// scripts\items\legend_helmets\helm\ssu_dryad_helm_tamer.nut
::Mod_Sellswords.Strings.ssu_dryad_helm_tamer <- {
	Name = "Dryad Tamer's Helm",
	Description = "A sturdy wooden helm, pilfered from the corpse of a Dryad. For some reason it seems to slowly stitch itself back together when damaged.",
	Tooltip = "Repairs [color=%positive%]10[/color] armour each turn",
	Log = "{1} repaired for {2} points"
};

// scripts\items\legend_helmets\helm\ssu_dryad_helm_warrior.nut
::Mod_Sellswords.Strings.ssu_dryad_helm_warrior <- {
	Name = "Dryad Warrior's Helm",
	Description = "A sturdy wooden helm, pilfered from the corpse of a Dryad. For some reason it seems to slowly stitch itself back together when damaged.",
	Tooltip = "Repairs [color=%positive%]10[/color] armour each turn",
	Log = "{1} repaired for {2} points"
};

// scripts\items\legend_helmets\helm\ssu_helmet_orc_bear_head_helm.nut
::Mod_Sellswords.Strings.ssu_helmet_orc_bear_head_helm_helm <- {
	Name = "Orc Bear Helm",
	Description = "The distinctive helm made from a dead bear."
};

// scripts\items\legend_helmets\helm\ssu_helmet_orc_bone_helm.nut
::Mod_Sellswords.Strings.ssu_helmet_orc_bone_helm_helm <- {
	Name = "Orc Looted Bone Helm",
	Description = "An orc helm made from looted bones, patched and forged together."
};

// scripts\items\legend_helmets\helm\ssu_helmet_orc_faceplate_helm.nut
::Mod_Sellswords.Strings.ssu_helmet_orc_faceplate_helm_helm <- {
	Name = "Orc Nasal Mask",
	Description = "An orc helm made of a looted nasal helm."
};

// scripts\items\legend_helmets\helm\ssu_helmet_orc_packleader_heavy_helm.nut
::Mod_Sellswords.Strings.ssu_helmet_orc_packleader_heavy_helm_helm <- {
	Name = "Orc Nasal Mask",
	Description = "An orc helm made of a looted nasal helm."
};

// scripts\items\legend_helmets\helm\ssu_helmet_orc_packleader_medium_helm.nut
::Mod_Sellswords.Strings.ssu_helmet_orc_packleader_medium_helm_helm <- {
	Name = "Orc Looted Bone Helm",
	Description = "An orc helm made from looted bones, patched and forged together."
};

// scripts\items\legend_helmets\helm\ssu_knightly_fullhelm.nut
::Mod_Sellswords.Strings.ssu_knightly_fullhelm <- {
	Name = "Greenskin Killer Fullhelm",
	Description = "An embellished helm of a knight with a beautiful design that melds both aesthetics and practicality. The visage is something that strikes fear into the heart of Goblins for they are aware of what a hunter looks like.",
	Tooltip = "User deals [color=%positive%]20%[/color] more damage to Goblins"
};

// scripts\items\legend_helmets\helm\ssu_named_conic_helmet.nut
::Mod_Sellswords.Strings.ssu_named_conic_helmet <- {
	Description = "This conic helmet has often an attached faceguard attached and finely fitted scales to protect the neck."
};

// scripts\items\legend_helmets\helm\ssu_named_nordic_helmet.nut
::Mod_Sellswords.Strings.ssu_named_nordic_helmet <- {
	Description = "This nordic helmet with faceguard is extraordinarly crafted, and as protective as it is impressive looking."
};

// scripts\items\legend_helmets\helm\ssu_named_red_and_gold_band_helmet.nut
::Mod_Sellswords.Strings.ssu_named_red_and_gold_band_helmet <- {
	Description = "This southern style helmet is not only richly decorated, but also well balanced and made from extremely high quality metals."
};

// scripts\items\legend_helmets\helm\ssu_named_steppe_helmet_with_mail.nut
::Mod_Sellswords.Strings.ssu_named_steppe_helmet_with_mail <- {
	Description = "A masterfully crafted helmet in the fashion of the steppe folks. Decorated with gold applications and equipped with additional cheek guards."
};

// scripts\items\legend_helmets\helmets\ssu_femaleknight_helmet.nut
::Mod_Sellswords.Strings.ssu_femaleknight_helmet <- {
	Name = "Chain Hood",
	Description = "A sturdy chain hood of military grade"
};

// scripts\items\legend_helmets\helmets\ssu_knight_faction_helm_enclave_armet.nut
::Mod_Sellswords.Strings.ssu_knight_faction_helm_enclave_armet <- {
	Name = "Chain Hood",
	Description = "A sturdy chain hood of military grade"
};

// scripts\items\legend_helmets\helmets\ssu_knight_faction_helm_enclave_great_bascinet.nut
::Mod_Sellswords.Strings.ssu_knight_faction_helm_enclave_great_bascinet <- {
	Name = "Chain Hood",
	Description = "A sturdy chain hood of military grade"
};

// scripts\items\legend_helmets\helmets\ssu_knight_faction_helm_enclave_great_helm.nut
::Mod_Sellswords.Strings.ssu_knight_faction_helm_enclave_great_helm <- {
	Name = "Chain Hood",
	Description = "A sturdy chain hood of military grade"
};

// scripts\items\legend_helmets\helmets\ssu_knight_faction_helm_enclave_great_helm_late.nut
::Mod_Sellswords.Strings.ssu_knight_faction_helm_enclave_great_helm_late <- {
	Name = "Bevor",
	Description = "A solid metal bevor."
};

// scripts\items\legend_helmets\helmets\ssu_knight_faction_helm_enclave_venitian_bascinet.nut
::Mod_Sellswords.Strings.ssu_knight_faction_helm_enclave_venitian_bascinet <- {
	Name = "Chain Hood",
	Description = "A sturdy chain hood of military grade"
};

// scripts\items\legend_helmets\helmets\ssu_knight_faction_helm_frogmouth_faceplate.nut
::Mod_Sellswords.Strings.ssu_knight_faction_helm_frogmouth_faceplate <- {
	Name = "Bevor",
	Description = "A solid metal bevor."
};

// scripts\items\legend_helmets\helmets\ssu_knight_faction_helm_great_helm_armet.nut
::Mod_Sellswords.Strings.ssu_knight_faction_helm_great_helm_armet <- {
	Name = "Chain Hood",
	Description = "A sturdy chain hood of military grade"
};

// scripts\items\legend_helmets\helmets\ssu_knight_faction_helm_great_helm_armet_heavy.nut
::Mod_Sellswords.Strings.ssu_knight_faction_helm_great_helm_armet_heavy <- {
	Name = "Bevor",
	Description = "A solid metal bevor."
};

// scripts\items\legend_helmets\helmets\ssu_knight_faction_helm_great_helm_faceplate_01.nut
::Mod_Sellswords.Strings.ssu_knight_faction_helm_great_helm_faceplate_01 <- {
	Name = "Chain Hood",
	Description = "A sturdy chain hood of military grade"
};

// scripts\items\legend_helmets\helmets\ssu_knight_faction_helm_great_helm_faceplate_02.nut
::Mod_Sellswords.Strings.ssu_knight_faction_helm_great_helm_faceplate_02 <- {
	Name = "Chain Hood",
	Description = "A sturdy chain hood of military grade"
};

// scripts\items\legend_helmets\helmets\ssu_knight_faction_helm_great_helm_faceplate_heavy_01.nut
::Mod_Sellswords.Strings.ssu_knight_faction_helm_great_helm_faceplate_heavy_01 <- {
	Name = "Bevor",
	Description = "A solid metal bevor."
};

// scripts\items\legend_helmets\helmets\ssu_knight_faction_helm_great_helm_faceplate_heavy_02.nut
::Mod_Sellswords.Strings.ssu_knight_faction_helm_great_helm_faceplate_heavy_02 <- {
	Name = "Bevor",
	Description = "A solid metal bevor."
};

// scripts\items\legend_helmets\helmets\ssu_knight_faction_helm_great_helm_frogmouth.nut
::Mod_Sellswords.Strings.ssu_knight_faction_helm_great_helm_frogmouth <- {
	Name = "Chain Hood",
	Description = "A sturdy chain hood of military grade"
};

// scripts\items\legend_helmets\helmets\ssu_knight_faction_helm_great_helm_frogmouth_heavy.nut
::Mod_Sellswords.Strings.ssu_knight_faction_helm_great_helm_frogmouth_heavy <- {
	Name = "Bevor",
	Description = "A solid metal bevor."
};

// scripts\items\legend_helmets\helmets\ssu_knight_faction_helm_great_helm_heavy.nut
::Mod_Sellswords.Strings.ssu_knight_faction_helm_great_helm_heavy <- {
	Name = "Bevor",
	Description = "A solid metal bevor."
};

// scripts\items\legend_helmets\hood\ssu_dryad_horns.nut
::Mod_Sellswords.Strings.ssu_dryad_horns <- {
	Name = "Dryad Horns",
	Description = "Long protruding horns grown from the head of a Dryad.",
	Tooltip = "Repairs [color=%positive%]10[/color] armour each turn",
	Log = "{1} repaired for {2} points"
};

// scripts\items\legend_helmets\top\ssu_helmet_ancient_beard_mask.nut
::Mod_Sellswords.Strings.ssu_helmet_ancient_beard_mask <- {
	Name = "Ancient Bearded Mask",
	Description = "Bearded Mask of an ancient honor guard."
};

// scripts\items\legend_helmets\top\ssu_helmet_ancient_mask.nut
::Mod_Sellswords.Strings.ssu_helmet_ancient_mask <- {
	Name = "Ancient Mask",
	Description = "A masked helm of an ancient honor guard."
};

// scripts\items\legend_helmets\top\ssu_helmet_barbarian_berserker.nut
::Mod_Sellswords.Strings.ssu_helmet_barbarian_berserker <- {
	Name = "Northern Berserker Band",
	Description = "A sturdy yet decorative eye-covering worn by berserkers of the northern tribes."
};

// scripts\items\legend_helmets\top\ssu_named_mask.nut
::Mod_Sellswords.Strings.ssu_named_mask <- {
	Description = "An exquisit metal faceplate in the shape of a faceguard resembles a fearsome warrior that is about to strike his enemy."
};

// scripts\items\legend_helmets\vanity\ssu_adorned_closed_flat_top_with_mail_vanity.nut
::Mod_Sellswords.Strings.ssu_adorned_closed_flat_top_with_mail_vanity <- {
	Name = "Adorned Hood",
	Description = "Heavily worn from extensive use, but adorned with relics and well-maintained."
};

// scripts\items\legend_helmets\vanity\ssu_adorned_heavy_vanity.nut
::Mod_Sellswords.Strings.ssu_adorned_heavy_vanity <- {
	Name = "Relic Ornament",
	Description = "Adorned with relics and lovingly maintained despite its extensive use, this is the helmet of a true questing knight."
};

// scripts\items\legend_helmets\vanity\ssu_death_knight_vanity.nut
::Mod_Sellswords.Strings.ssu_death_knight_vanity <- {
	Name = "Decayed Goddess Helmet Ornament",
	Description = "Decayed ornament top of the goddess."
};

// scripts\items\legend_helmets\vanity\ssu_dryad_mask.nut
::Mod_Sellswords.Strings.ssu_dryad_mask <- {
	Name = "Dryad's Mask",
	Description = "A sturdy wooden mask, pilfered from the corpse of a living tree. For some reason it seems to slowly stitch itself back together when damaged.",
	Tooltip = "Repairs [color=%positive%]10[/color] armour each turn",
	Log = "{1} repaired for {2} points"
};

// scripts\items\legend_helmets\vanity\ssu_hyena_helm.nut
::Mod_Sellswords.Strings.ssu_hyena_helm <- {
	Name = "Hyena Helm",
	Description = "An impressive hyena head covering.",
	Tooltip = "[color=%positive%]+10[/color] Initiative"
};

// scripts\items\legend_helmets\vanity\ssu_necro_lorekeeper_head.nut
::Mod_Sellswords.Strings.ssu_necro_lorekeeper_head <- {
	Name = "Lorekeeper\'s Headpiece",
	Description = "An ancient, but well-crafted, headpiece with intricate decorations. This ceremonial headdress was required to be worn at all times by the acting head librarian.",
	Tooltip1 = "Allows the wearer to see at night and negates any penalties due to nighttime.",
	Tooltip2 = "Makes enemies more likely to attack you",
	Tooltip3 = "Doubles your Resolve if defending against fear and mind control abilities"
};

// scripts\items\legend_helmets\vanity\ssu_southern_wrap_vanity.nut
::Mod_Sellswords.Strings.ssu_southern_wrap_vanity <- {
	Name = "Southern Wrap",
	Description = "A well craft southern wrap."
};

// scripts\items\misc\anatomist\ssu_sequence_item.nut
::Mod_Sellswords.Strings.ssu_sequence_item <- {
	Use = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process.",
	Sickness = "Heavily mutates the body. Long periods of sickness are expected.",
	Warning = "WARNING: Aligning yourself to more than one sequence can cause serious health complications such as death."
};

// scripts\items\misc\anatomist\ssu_alp_sequence_item.nut
::Mod_Sellswords.Strings.ssu_alp_sequence_item <- {
	Name = "Sequence: Alp\nStrain - Sleeper",
	Description = "This draft, the result of intensive study into the so-called \'Third Eye\' of the Alp, allows whomever drinks it to see through the night as if it were day, see into the minds of others, and torment them with nightmares!\nBlurry vision and hallucinations are expected while the body acclimates.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects."
};

// scripts\items\misc\anatomist\ssu_demon_alp_sequence_item.nut
::Mod_Sellswords.Strings.ssu_demon_alp_sequence_item <- {
	Name = "Sequence: Alp\nStrain - Demon",
	Description = "This concoction, borne from research into the legendary Demon Alp, further improves the qualities given in the previous Strain.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects."
};

// scripts\items\misc\anatomist\ssu_basilisk_sequence_item.nut
::Mod_Sellswords.Strings.ssu_basilisk_sequence_item <- {
	Name = "Sequence: Basilisk\nStrain - Drone",
	Description = "Anyone who has watched a Basilisk hunt knows the bird does not waste a peck, every strike goes for the eyes. This tincture, distilled from the nerves behind a Drone\'s beak, teaches the drinker\'s arm the same habit.\nA twitch of the neck and a newfound interest in shiny helmets are to be expected.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects."
};

// scripts\items\misc\anatomist\ssu_basilisk_sentry_sequence_item.nut
::Mod_Sellswords.Strings.ssu_basilisk_sentry_sequence_item <- {
	Name = "Sequence: Basilisk\nStrain - Sentry",
	Description = "This concoction, borne from research into the Basilisk Sentry, further improves the qualities given in the previous Strain. A Sentry\'s beak goes through a helmet as easily as through bone, and now so do the drinker\'s blows.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects."
};

// scripts\items\misc\anatomist\ssu_direwolf_sequence_item.nut
::Mod_Sellswords.Strings.ssu_direwolf_sequence_item <- {
	Name = "Sequence: Direwolf\nStrain - Alpha",
	Description = "This humoural concoction, borne from research into the dreaded Direwolf, will turn even the clumsiest oaf into an elite, lithe warrior.\n Gain the ability to gracefully move with the tides of battle long after lesser men succumb to fatigue!\nMild akathisia after consuming is normal, if not expected.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects."
};

// scripts\items\misc\anatomist\ssu_white_direwolf_sequence_item.nut
::Mod_Sellswords.Strings.ssu_white_direwolf_sequence_item <- {
	Name = "Sequence: Direwolf\nStrain - White",
	Description = "This concoction, borne from research into the legendary White Direwolf, further improves the qualities given in the previous variant.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects."
};

// scripts\items\misc\anatomist\ssu_goblin_sequence_item.nut
::Mod_Sellswords.Strings.ssu_goblin_sequence_item <- {
	Name = "Sequence: Goblin\nStrain - Grubby-Fingers",
	Description = "Equal parts terrifying and annoying, the uncanny marksmanship of goblins has long been thought unattainable by ordinary, self-respecting humans. With this wondrous concoction, however, the discerning warrior can harness some of that latent skill and obtain the celerity inherent in these greenskins.\nSome noted effects include loss of height and possible kleptomanic tendencies.\n\nUnfortunately, the anatomist says that this race is too feeble to develop a higher strain variant, so consumption of this Sequence may limit future growth.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects."
};

// scripts\items\misc\anatomist\ssu_hyena_sequence_item.nut
::Mod_Sellswords.Strings.ssu_hyena_sequence_item <- {
	Name = "Sequence: Hyena\nStrain - Scavenger",
	Description = "The Hyenas of the south run their prey down for miles, biting and letting go and biting again until the blood loss does the rest. This draught lends the drinker their tireless gait and their knack for opening wounds that refuse to close.\nThe Anatomist insists the laughing fits will pass.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects."
};

// scripts\items\misc\anatomist\ssu_enraged_hyena_sequence_item.nut
::Mod_Sellswords.Strings.ssu_enraged_hyena_sequence_item <- {
	Name = "Sequence: Hyena\nStrain - Enraged",
	Description = "This concoction, borne from research into the Enraged Hyena, further improves the qualities given in the previous Strain. The drinker covers ground at a frightening pace, and the wounds they leave are deeper still.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects."
};

// scripts\items\misc\anatomist\ssu_lindwurm_sequence_item.nut
::Mod_Sellswords.Strings.ssu_lindwurm_sequence_item <- {
	Name = "Sequence: Lindwurm\nStrain - Acidity",
	Description = "Feel your blood boil! Or, more to the point, don\'t! With this tincture, the burning blood of a lindwurm will flow through your decidedly human veins, with the lucky subject none the wiser. Until they start bleeding, of course.\nFortunately, the Lindwurm is already a creature of exceptional lineage, and as a result, imbimbing this potion will perfect your puny physique!\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects."
};

// scripts\items\misc\anatomist\ssu_stollwurm_sequence_item.nut
::Mod_Sellswords.Strings.ssu_stollwurm_sequence_item <- {
	Name = "Sequence: Lindwurm\nStrain - Stoll",
	Description = "This potion further improves upon the previous strain. In addition to further improving the physique of the drinker, they mutate organs that allow them to better take blows and negative ailments.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects."
};

// scripts\items\misc\anatomist\ssu_nachzehrer_sequence_item.nut
::Mod_Sellswords.Strings.ssu_nachzehrer_sequence_item <- {
	Name = "Sequence: Ghoul\nStrain - Glutton",
	Description = "If one divorces the horror of the act from its utility, there are few phenomena more marvelous in nature than the Nachzehrer\'s ability to recover by eating the flesh of the recently deceased. No longer! Now man himself may partake in such a feast!\nThis potion also allows the drinker to gain the speed and wild frenzy of the Nachzehrer.\nDespite a few incidents in which townsfolk have run screaming from rabid, naked men devouring their family pets, the Anatomist assures you that this tincture is perfectly safe for consumption.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects."
};

// scripts\items\misc\anatomist\ssu_skin_ghoul_sequence_item.nut
::Mod_Sellswords.Strings.ssu_skin_ghoul_sequence_item <- {
	Name = "Sequence: Ghoul\nStrain - Skin-Flayer",
	Description = "From research on the legendary Skin Ghoul, this potion grants the drinker minor regeneration, as well as improving the properties of the previous potion.\nThe drinker seems to have gained an unusual sense for blood and every strike they make causes vicious bleeding.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects."
};

// scripts\items\misc\anatomist\ssu_necro_necrosavant_lord_sequence_item.nut
::Mod_Sellswords.Strings.ssu_necro_necrosavant_lord_sequence_item <- {
	Name = "Sequence: Vampyre\nStrain - Lord",
	Description = "This concoction, borne from research into the legendary necrosavant lord, further improves the qualities given in the sequence 9 potion, Vampire. \n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the sickness."
};

// scripts\items\misc\anatomist\ssu_necro_necrosavant_sequence_item.nut
::Mod_Sellswords.Strings.ssu_necro_necrosavant_sequence_item <- {
	Name = "Sequence: Vampyre\nStrain - Bloodletter",
	Description = "Whoever drinks this incredible potion, produced with the ash of a Necrosavant, will find themselves in possession of the miraculous healing powers of the undead creatures!\nIt does not grant the extended lifespan associated with the abominations, however - quite the opposite, in fact. This may be considered a feature should the imbiber get a bit too comfortable drinking blood.\nConsumers have remarked effects that feel similar to immortality and their bodies regressing in age, although from the associated cost, you\'re not entirely sure if it\'s worth it.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects."
};

// scripts\items\misc\anatomist\ssu_orc_sequence_item.nut
::Mod_Sellswords.Strings.ssu_orc_sequence_item <- {
	Name = "Sequence: Orc\nStrain - Unga-Bunga",
	Description = "Many Generals have wished that Orcs might be cowed, for if one could control the greenskins and direct their strength with the intellect of man, they would surely control an unstoppable force.\nWith this, such fantasies are within reach!\nWhen you asked the Anatomist about side-effects, they assured you that the constant drooling and excessive violent tendencies that were reported are the norm for sellswords anyway.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects."
};

// scripts\items\misc\anatomist\ssu_orc_warlord_sequence_item.nut
::Mod_Sellswords.Strings.ssu_orc_warlord_sequence_item <- {
	Name = "Sequence: Orc\nStrain - Warlord",
	Description = "Borne from the study of the renowned Orc Warlord, this potion improves upon that of the previous strain, allowing one to wield heavy orc weapons with ease as well as letting an orc\'s rage flow through one\'s veins.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects."
};

// scripts\items\misc\anatomist\ssu_schrat_sequence_item.nut
::Mod_Sellswords.Strings.ssu_schrat_sequence_item <- {
	Name = "Sequence: Schrat\nStrain - Barkskin",
	Description = "One of the more obscure creatures in these lands. Though this race has lost much of it\'s former glory, they are still derived from the legendary tree of wisdom.\nThis potion grants the drinker the properties of a Schrat as well as a glimpse into the machinations of their mind.\nCommon side-effects include seasonal depression, excessive thirst, and uncontrollable itching of the skin.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects."
};

// scripts\items\misc\anatomist\ssu_greenwood_schrat_sequence_item.nut
::Mod_Sellswords.Strings.ssu_greenwood_schrat_sequence_item <- {
	Name = "Sequence: Schrat\nStrain - Greenwood",
	Description = "From research on the legendary Greenwood Schrat, this potion improves upon the symbiotic relationship formed in the previous strain.\nNow the imbiber can grow roots and branches out of their body to attack.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects."
};

// scripts\items\misc\anatomist\ssu_serpent_sequence_item.nut
::Mod_Sellswords.Strings.ssu_serpent_sequence_item <- {
	Name = "Sequence: Snake\nStrain - Ssssss",
	Description = "A quite interesting potion, according to the anatomist who made it. Although this species currently cannot support a higher Strain, this potion confers upon the drinker the ability to produce poison from the pores of their skin, as well as various immunities to other types of poisons.\nThey also have developed the survival instinct of a snake and gain excellent pattern recognition skills.\nVarious side-effects have been documented, which include, but are not limited to; developing a forked tongue, an uncontrollable desire to sway with music, and excessive wriggling in your sleep.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects."
};

// scripts\items\misc\anatomist\ssu_unhold_sequence_item.nut
::Mod_Sellswords.Strings.ssu_unhold_sequence_item <- {
	Name = "Sequence: Unhold\nStrain - Giant",
	Description = "This potion will grant near immortality and power to whomever drinks it! That\'s right, just like the dreaded Unhold, any lucky enough to consume this will have their wounds close mere moments after opening!\nTake it!\nQuickly!\nDon\'t think, act!\nNOTE: Any sudden lumps or otherwise unknown growths are to be removed as soon as possible. Please confer with your local Anatomist for more details.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects."
};

// scripts\items\misc\anatomist\ssu_rock_unhold_sequence_item.nut
::Mod_Sellswords.Strings.ssu_rock_unhold_sequence_item <- {
	Name = "Sequence: Unhold\nStrain - Mountain",
	Description = "From research on the legendary Rock Unhold of the mountains, this potion improves upon the previous strain, granting the drinker increased regeneration and creating natural armor on their body that regenerates.\n The Anatomist tells you that at this stage, the additional growths are impossible to remove, and if you haven\'t already, a drafted will is advised.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects."
};

// scripts\items\misc\anatomist\ssu_webknecht_sequence_item.nut
::Mod_Sellswords.Strings.ssu_webknecht_sequence_item <- {
	Name = "Sequence: Spider\nStrain - Weaver",
	Description = "As any experienced beast hunter could tell you, what makes the overgrown arachnids known as Webknechts truly fearsome is their vicious poison. Imbimbing this potion grants the drinker the venom glands of a Webknecht, the ability to resist various poisons, and nightvision.\nThe Anatomist remarked that it was odd that this potion only granted minor enhancements. Was he missing something? Where was the power of this species concentrated?\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects."
};

// scripts\items\misc\anatomist\ssu_redback_sequence_item.nut
::Mod_Sellswords.Strings.ssu_redback_sequence_item <- {
	Name = "Sequence: Spider\nStrain - Redback",
	Description = "It turns out that the majority of the strength that came from this genus was contained within the legendary Redback.\nWith future research into the species, this potion improves upon the poison of the previous strain, allowing the drinker to poison their enemies with Redback poison instead of the inferior Webnecht.\nThe ability to spew forth webs from your mouth sounds fine in concept, but you wonder if the addition of insects to your diet is a worthy trade-off.\n\nYou can drink potions of the same sequence without serious consequences, but you will still have to deal with the side-effects."
};

// scripts\items\misc\ssu_ap_potion_item.nut
::Mod_Sellswords.Strings.ssu_ap_potion_item <- {
	Name = "Elixir of Potency",
	Description = "Few people have heard about this legendary potion, and fewer still would be capable enough to craft it.\nCreated from using the rarest of ingredients, it pushes the abilities of any who imbibe to their upmost limits.",
	Tooltip1 = "Gain [color=%positive%]+1[/color] Action Point.\nPermanently.",
	Tooltip2 = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
};

// scripts\items\misc\ssu_necro_skeleton_potion.nut
::Mod_Sellswords.Strings.ssu_necro_skeleton_potion <- {
	Name = "Undead Transformation Potion: Skeleton",
	Description = "This foul concoction is a glistening, viscous liquid that reeks of decay. Upon consumption, the drinker\'s flesh begins to wither and fall away, revealing a skeletal form underneath. The transformation is both painful and permanent, turning the imbiber into an undead skeleton bound to the whims of dark magic.",
	Tooltip1 = "Skeletise: Your flesh sloughs off until there\'s nothing left but bone. Transforms the user into a [color=%negative%]SKELETON[/color].",
	Tooltip2 = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
};

// scripts\items\misc\ssu_necro_zombie_potion.nut
::Mod_Sellswords.Strings.ssu_necro_zombie_potion <- {
	Name = "Undead Transformation Potion: Zombie",
	Description = "This thick, putrid elixir has an odor reminiscent of rot and death. When consumed, the drinker\'s flesh decays rapidly, their body becoming a grotesque, shambling corpse. This transformation grants the imbiber the relentless endurance and primal strength of an undead, but at the cost of a never-ending hunger for living flesh and the loss of all reason.",
	Tooltip1 = "Zombify: Your flesh rots and decays, granting unnatural vitality but a constant hunger for flesh. Transforms the user into a [color=%negative%]ZOMBIE[/color].",
	Tooltip2 = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
};

// scripts\items\spawns\ssu_necro_zombie_dog.nut
::Mod_Sellswords.Strings.ssu_necro_zombie_dog_spawns <- {
	Name = "Canine Carrion",
	Description = "A heap of canine offal; limbs, skin, and gore, all salvaged from mans best friend, the perfect medium for your grim work. Requires constant preservation as the encroaching rot threatens to stall your efforts."
};

// scripts\items\supplies\ssu_banquet_item.nut
::Mod_Sellswords.Strings.ssu_banquet_item <- {
	Name = "Excellent Banquet",
	Description = "Provisions. A meal that is well prepared and greatly enjoyed. The ideal provision to take with you on long journeys and expeditions. Can be eaten in battle to increase all of your combat attributes, based on amount of the food. Will be used as provisions if left in the company stash."
};

// scripts\items\supplies\ssu_salad_item.nut
::Mod_Sellswords.Strings.ssu_salad_item <- {
	Name = "Salad",
	Description = "Provisions. Food mixtures either arranged on a plate or tossed and served with a moist dressing, usually consisting of greens. Can be eaten in battle to provide up to 5 healing and fatigue recovery over ten turns, based on the amount remaining. Will be used as provisions if left in the company stash."
};

// scripts\items\tools\ssu_acid_flask_item_02.nut
::Mod_Sellswords.Strings.ssu_acid_flask_item_02 <- {
	Name1 = "Stollwurm's Acid Flask",
	Description1 = "A flask filled with the concentrate of a Stollwurm\'s acidic blood. It is highly corrosive to many materials and burns through armor quickly and is more robust than normal acid flasks. Can be thrown at short ranges. If the company has Alchemy Tools, this item is refilled after each battle, consuming 30 ammunition per use.",
	Tooltip1 = "Worn in Offhand",
	Tooltip2 = "Range of [color=%positive%]{1}[/color] tiles",
	Tooltip3 = "Reduces the target\'s armor by [color=%damage%]25%[/color] each turn for 3 turns",
	Tooltip4 = "Has a [color=%damage%]33%[/color] chance to hit bystanders at the same or lower height level as well",
	Tooltip5 = "Lasts for at least [color=%positive%]{1}[/color] turns",
	Tooltip6 = "Cannot be refilled after battle, because this company has no Alchemy Tools",
	Name2 = "Acid Flask",
	Name3 = "Stollwurm's Acid Flask (Used)",
	Description2 = "A spent and shattered flask. If the company has \"Alchemy Tools\", this item is refilled after each battle, consuming 30 ammunition per use."
};

// scripts\items\weapons\barbarians\ssu_barbarian_hammer.nut
::Mod_Sellswords.Strings.ssu_barbarian_hammer <- {
	Name = "Two-Handed Skull Hammer",
	Description = "A crude metal hammer used with two hands to crush both armor and its wearer alike.",
	Categories = "Hammer, Two-Handed"
};

// scripts\items\weapons\barbarians\ssu_barbarian_mace.nut
::Mod_Sellswords.Strings.ssu_barbarian_mace <- {
	Name = "Horn Decorated Mace",
	Description = "A huge club fitted with skulls and horns, showing primitive but cruel prowess. Receiving a blow from this weapon will leave anyone dazed and gasping for air, no matter their armor.",
	Categories = "Mace, Two-Handed"
};

// scripts\items\weapons\barbarians\ssu_war_axe.nut
::Mod_Sellswords.Strings.ssu_war_axe <- {
	Name = "Fiery War Axe",
	Description = "A heavy northern war axe with a blackened head. The raiders who carry these would rather have a second axe in the other hand than a shield.",
	Categories = "Axe, One-Handed"
};

// scripts\items\weapons\dryad\ssu_dryad_bow.nut
::Mod_Sellswords.Strings.ssu_dryad_bow <- {
	Name = "Dryad Bow",
	Description = "This hardwood bow, crafted by the skilled hands of the Dryads, is a masterpiece of natural artistry. The bowstring, unique to the Heartwoods, is woven from the finest threads of spider silk.",
	Tooltip = "Slowly repairs [color=%positive%]5[/color] durability each turn."
};

// scripts\items\weapons\dryad\ssu_dryad_cleaver.nut
::Mod_Sellswords.Strings.ssu_dryad_cleaver <- {
	Name = "Dryad Antler Whip",
	Description = "A very unique style of whip crafted from an antler and a heart of oak. Unwieldy and blunt, but still dangerous.",
	Tooltip = "Slowly repairs [color=%positive%]5[/color] durability each turn."
};

// scripts\items\weapons\dryad\ssu_dryad_flail.nut
::Mod_Sellswords.Strings.ssu_dryad_flail <- {
	Name = "Dryad's Thorned Flail",
	Description = "This two-handed flail crafted by Dryads is a weapon of nature\'s fury, its long wooden handle entwined with living vines and covered in razor-sharp thorns. When swung in battle, the flail not only delivers crushing blows but also tears through flesh with its barbed spikes",
	Tooltip = "Slowly repairs [color=%positive%]5[/color] durability each turn."
};

// scripts\items\weapons\dryad\ssu_dryad_spear.nut
::Mod_Sellswords.Strings.ssu_dryad_spear <- {
	Name = "Dryad Spear",
	Description = "A short yet sturdy glaive, crafted from Heartwood by the Dryads. Despite its appearance, the end of the blade holds a dangerously sharp edge.",
	Tooltip = "Slowly repairs [color=%positive%]5[/color] durability each turn."
};

// scripts\items\weapons\dryad\ssu_dryad_staff.nut
::Mod_Sellswords.Strings.ssu_dryad_staff <- {
	Name = "Dryad Staff",
	Description = "A sturdy staff crafted by Dryads from their sacred Heartwood. When exposed to blood, the mystical properties of these staves reveal themselves.",
	Tooltip = "Slowly repairs [color=%positive%]5[/color] durability each turn."
};

// scripts\items\weapons\greenskins\ssu_orc_mace.nut
::Mod_Sellswords.Strings.ssu_orc_mace <- {
	Name = "Spiked Mace",
	Description = "A wooden shaft fitted with a skull for good measure, used to deliver a combination of blunt-force and puncturing blows. Not well suited for human hands.",
	Categories = "Mace, One-Handed"
};

// scripts\items\weapons\greenskins\ssu_orc_spear.nut
::Mod_Sellswords.Strings.ssu_orc_spear <- {
	Name = "Flakes",
	Description = "A rough yet sturdy patchwork spear used by Orc Young. Not well suited for human hands.",
	Categories = "Spear, One-Handed"
};

// scripts\items\weapons\greenskins\ssu_orc_staff.nut
::Mod_Sellswords.Strings.ssu_orc_staff <- {
	Name = "Orc Bone Stave",
	Description = "A strange ritualistic bone tipped staff used by the spiritualists of the Orcs. Despite being made from mundane materials, you swear you can feel something otherworldly about it."
};

// scripts\items\weapons\greenskins\ssu_orc_sword.nut
::Mod_Sellswords.Strings.ssu_orc_sword <- {
	Name = "Unhold Gutter",
	Description = "A huge two-handed blade with a rough, jagged edge. The Orcs use this for carving through giants. Not well suited for human hands."
};

// scripts\items\weapons\named\ssu_named_bastardsword.nut
::Mod_Sellswords.Strings.ssu_named_bastardsword <- {
	Description = "This longsword is a true masterpiece, with a blade that is both flexible yet extremely durable."
};

// scripts\items\weapons\named\ssu_named_fan_axe.nut
::Mod_Sellswords.Strings.ssu_named_fan_axe <- {
	Name = "Golden Dawn",
	Description = "A long, two-handed axe that doubles as a very heavy fan"
};

// scripts\items\weapons\named\ssu_named_goedendag.nut
::Mod_Sellswords.Strings.ssu_named_goedendag <- {
	Description = "A military grade metal-reinforced hammer with a spike at the top. Can be used to thrust at the enemy, or pummel them into submission."
};

// scripts\items\weapons\named\ssu_named_katar.nut
::Mod_Sellswords.Strings.ssu_named_katar <- {
	Description = "An exquisitely crafted H-shaped horizontal blade sitting above the knuckles. Has a thickened tip that is particularily effective at piercing armor but its construction prevents it from being gripped with two hands."
};

// scripts\items\weapons\named\ssu_named_orc_axe_infantry.nut
::Mod_Sellswords.Strings.ssu_named_orc_axe_infantry <- {
	Description = "A long shard of sharpened rock firmly wedged into a massive bone. Not well suited for human hands."
};

// scripts\items\weapons\named\ssu_named_orc_hammer_2h.nut
::Mod_Sellswords.Strings.ssu_named_orc_hammer_2h <- {
	Description = "A massive crude hammer with a head fashioned from a chunk of solid iron. Too heavy to be used effectively by the average human."
};

// scripts\items\weapons\named\ssu_named_orc_mace_2h.nut
::Mod_Sellswords.Strings.ssu_named_orc_mace_2h <- {
	Description = "Almost a whole bronze statue uprooted, haphazardly reinforced with protruding iron rivets. Too heavy to be used effectively by the average human."
};

// scripts\items\weapons\named\ssu_named_orc_sword_1h.nut
::Mod_Sellswords.Strings.ssu_named_orc_sword_1h <- {
	Description = "A huge one-handed blade with a rough, jagged edge. The Orcs use this for carving through fresh meat. Not well suited for human hands."
};

// scripts\items\weapons\named\ssu_named_orc_sword_2h.nut
::Mod_Sellswords.Strings.ssu_named_orc_sword_2h <- {
	Description = "A massive, crudely sharpened shard of metal that makes up for its stunted length through sheer weight. Too heavy to be used effectively by the average human.",
	Name = "Great Bunt"
};

// scripts\items\weapons\named\ssu_named_spontoon.nut
::Mod_Sellswords.Strings.ssu_named_spontoon <- {
	Description = "Some spontoon-style axes which used the same shaped blades mounted on the side of the weapon with a shorter handle, it's a huge and heavy battle spear with amazing power."
};

// scripts\items\weapons\named\ssu_named_staff.nut
::Mod_Sellswords.Strings.ssu_named_staff <- {
	Name = "Grimwar's Staff",
	Description = "A sturdy staff with a crystal ball on its tip, it catches the light in mysterious ways."
};

// scripts\items\weapons\special\ssu_legendary_axe.nut
::Mod_Sellswords.Strings.ssu_legendary_axe <- {
	Name = "[color=#456ca0]Winter\'s Touch, the Ijirok\'s Remembrance[/color]",
	Description = "One of the seven legendary weapons,\n[color=#456ca0]Winter\'s Touch[/color] is the embodiment of death\'s cold embrace.\nCreated from the frozen lake of the Hunting Grounds, the bitterly cold ice this blade has growing from it never seems to melt.",
	Categories = "Axe, Two-Handed",
	Tooltip1 = "One of the seven [color=#456ca0]Legendary[/color] weapons.",
	Tooltip2 = "Inflicts the [color=%positive%]Chilled[/color] status effect on hit.",
	Tooltip3 = "Inflicts the [color=%positive%]Staggered[/color] status effect on hit."
};

// scripts\items\weapons\special\ssu_legendary_cleaver.nut
::Mod_Sellswords.Strings.ssu_legendary_cleaver <- {
	Name = "[color=#456ca0]Bloodfang Twinblade[/color]",
	Description = "One of the seven legendary weapons,\n[color=#456ca0]Bloodfang Twinblades[/color] gleam with a sinister light, their edges serrated like the fangs they were crafted from.\nIndividually, they are lifeless, but when united, they pulse with a thirst for blood, their true power unleashed in a symphony of blood, bone, and steel.\nThe blades can cut through the toughest armor, leaving behind wounds that never fully heal.",
	Categories = "Cleaver, One-Handed",
	Tooltip1 = "One of the seven [color=#456ca0]Legendary[/color] weapons.",
	Tooltip2 = "When [color=%negative%]Bloodied[/color], grants the user [color=%positive%]20%[/color] additional damage dealt and recieved.",
	Tooltip3 = "When attacking enemies that bleed, heals the player equal to the damage inflicted.",
	Tooltip4 = "Bleeds inflicted with this weapon are permanent.",
	Tooltip5 = "Lifeless on its own. Hold one of the two blades in each hand to unite them, which replaces their skills with [color=%positive%]Rend Flesh[/color], [color=%positive%]Mince[/color] and [color=%positive%]Swing[/color] and grants:"
};

// scripts\items\weapons\special\ssu_legendary_dagger.nut
::Mod_Sellswords.Strings.ssu_legendary_dagger <- {
	Name = "[color=#456ca0]Obsidian Dagger[/color]",
	Description = "One of the seven legendary weapons,\nthe [color=#456ca0]Obsidian Dagger[/color] was given to you by a witch after tempering it with your blood.\nReflections in its glass seem to move on their own, but this is clearly a trick of the eye.\nVery curiously, however, blood never seems to dry if it rests upon the obsidian.",
	Tooltip1 = "One of the seven [color=#456ca0]Legendary[/color] weapons.",
	Tooltip2 = "Inflicts the [color=%positive%]Withered[/color] status effect on hit.",
	Tooltip3 = "When attacking enemies that bleed, heals the player equal to the damage inflicted.",
	Tooltip4 = "Resurrects any human killed with it as a Wiederganger fighting for you."
};

// scripts\items\weapons\special\ssu_legendary_hammer.nut
::Mod_Sellswords.Strings.ssu_legendary_hammer <- {
	Name = "[color=#679d5e]Nature\'s Judgement[/color]",
	Description = "One of the seven legendary weapons,\n[color=#679d5e]Nature\'s Judgement[/color] is forged from the heartwood of the oldest living tree in the forest and imbued with the essence of nature itself.\nIts construction is entwined with living roots and mystical runes that glow with green light. The sheer force its blows can bring will shatter flesh and steel alike.",
	Categories = "Hammer, Two-Handed",
	Tooltip1 = "One of the seven [color=#456ca0]Legendary[/color] weapons.",
	Tooltip2 = "When swung, this weapon unleashes a powerful shockwave to all enemies in adjacent tiles to the target.",
	Tooltip3 = "Inflicts the [color=%positive%]Rooted[/color] status effect on hit.",
	Tooltip4 = "Slowly repairs [color=%positive%]+10[/color] durability per turn."
};

// scripts\items\weapons\special\ssu_legendary_spear.nut
::Mod_Sellswords.Strings.ssu_legendary_spear <- {
	Name = "[color=#456ca0]Specter\'s Requiem[/color]",
	Description = "One of the seven legendary weapons,\n[color=#456ca0]Specter\'s Requiem[/color] emits a low, mournful wail that echoes through the air when swung, freezing the blood of any nearby foes. Said to be wielded by a forgotten warrior cursed to eternal unrest, this weapon can phase through armor and shields, leaving only ghostly wounds that fester in the soul of those unfortunate enough to face against the wielder.",
	Categories = "Spear, Polearm, Two-Handed",
	Tooltip1 = "One of the seven [color=#456ca0]Legendary[/color] weapons.",
	Tooltip2 = "Attacks from this weapon [color=%negative%]ignore[/color] armor."
};

// scripts\items\weapons\special\ssu_legendary_sword.nut
::Mod_Sellswords.Strings.ssu_legendary_sword <- {
	Name = "[color=#456ca0]Reproach of the Old Gods[/color]",
	Description = "One of the seven legendary weapons,\n[color=#456ca0]Reproach of the Old Gods[/color] bends purples and oranges until it seemingly carries twilight itself in its fuller.\nHeld to the touch, one cannot tell if they are being burned or chilled. Magic or well-crafted, whatever the weapon is it vibrates as though it were fighting off power immense and you need only swing it to find the steel\'s true charge.",
	Categories = "Sword, Two-Handed",
	Tooltip1 = "One of the seven [color=#456ca0]Legendary[/color] weapons.",
	Tooltip2 = "Inflicts an additional [color=%positive%]15%[/color] damage that ignores armor, and chains, on up to three targets."
};

// scripts\items\weapons\ssu_advancedfirelance.nut
::Mod_Sellswords.Strings.ssu_advancedfirelance <- {
	Name1 = "Advanced Fire Lance",
	Description = "An experimental two-handed spear of southern design with multiple explosive charges that will spew fire over two tiles when ignited. This more advanced design can be used up to 3 times per battle and is automatically refilled after.",
	Name2 = "Advanced Fire Lance (Spent)"
};

// scripts\items\weapons\ssu_heavy_goedendag.nut
::Mod_Sellswords.Strings.ssu_heavy_goedendag <- {
	Name = "Lucerne Hammer",
	Description = "A military grade metal-reinforced hammer with a spike at the top. Can be used to thrust at the enemy, or pummel them into submission."
};

// scripts\items\weapons\ssu_heavy_mining_pick.nut
::Mod_Sellswords.Strings.ssu_heavy_mining_pick <- {
	Name = "Two-Handed Miners Pickaxe",
	Description = "A heavy metal mining pick, used with both hands to crush troublesome rocks. It\'s now being put to use crushing men and their soft metal armor instead.",
	Categories = "Hammer, Two-Handed"
};

// scripts\items\weapons\ssu_kriegsmesser.nut
::Mod_Sellswords.Strings.ssu_kriegsmesser <- {
	Name1 = "Kriegsmesser",
	Description = "Messer are characterized by their single-edged blades. The blade is certainly brutally efficient in cutting, but the simple design has also a subtlety that is easily overlooked.",
	Name2 = "Bunt"
};

// scripts\items\weapons\ssu_longaxe.nut
::Mod_Sellswords.Strings.ssu_longaxe <- {
	Name = "Refined Longaxe",
	Description = "A relatively thin blade on a very long shaft used for devastating cutting attacks over some distance, and to render shields unusable from behind the frontline.",
	Categories = "Axe, Two-Handed"
};

// scripts\items\weapons\ssu_necro_lorekeeper_book.nut
::Mod_Sellswords.Strings.ssu_necro_lorekeeper_book <- {
	Name = "The Black Book",
	Description = "An old and eerie looking tome with a fleshen cover. Its pages are filled with inscrutable writing and mysterious drawings that you can\'t begin to understand. The longer you look at the book, the more uneasy it makes you feel. Perhaps someone with more knowledge in ancient languages could make some sense of it.",
	Tooltip = "Contains forbidden knowledge that only those well versed in languages of the past can make use of"
};

// scripts\items\weapons\ssu_polehammer.nut
::Mod_Sellswords.Strings.ssu_polehammer <- {
	Name = "Refined Polehammer",
	Description = "A warhammer mounted on a long pole, used against armored targets over some distance and from behind the frontline.",
	Categories = "Hammer, Two-Handed"
};

// scripts\items\weapons\ssu_polemace.nut
::Mod_Sellswords.Strings.ssu_polemace <- {
	Name = "Refined Polemace",
	Description = "A long mace that can be used to deliver stunning blows over a distance.",
	Categories = "Mace, Two-Handed"
};

// scripts\items\weapons\ssu_ranged_flail.nut
::Mod_Sellswords.Strings.ssu_ranged_flail <- {
	Name = "Refined Pole Flail",
	Description = "A separate striking head attached to a pole by a chain. A rather unpredictable weapon, but useful to strike over or around shield cover."
};

// scripts\items\weapons\ssu_spontoon01.nut
::Mod_Sellswords.Strings.ssu_spontoon01 <- {
	Name = "Short Spear",
	Description = "A simple pike with a short shaft. Can be used for striking and blocking, while its suitable length is designed to concentrate the force of a punch and thrust at enemies."
};

// scripts\items\weapons\ssu_spontoon02.nut
::Mod_Sellswords.Strings.ssu_spontoon02 <- {
	Name = "Spontoon",
	Description = "A pair of blades or lugs on each side, giving the weapon the look of a military fork. Can be used for striking and blocking, while its suitable length is designed to concentrate the force of a punch and thrust at enemies."
};

// scripts\items\weapons\ssu_spontoon03.nut
::Mod_Sellswords.Strings.ssu_spontoon03 <- {
	Name = "Heavy Halberd",
	Description = "A half-pike featured a more elaborate head than the typical pike. Can be used to thrust at the enemy, or pummel them into submission."
};

// scripts\items\weapons\ssu_swordlance.nut
::Mod_Sellswords.Strings.ssu_swordlance <- {
	Name = "Refined Swordlance",
	Description = "A long pole attached to a sharp curved blade, used to deliver deep sweeping strikes over some distance.",
	Categories = "Polearm, Two-Handed"
};

// scripts\scenarios\world\ssu_dryad_scenario.nut
::Mod_Sellswords.Strings.ssu_dryad_scenario <- {
	Name = "Dryad",
	Description = "[p=c][img]gfx/ui/events/legend_heartwood.png[/img][/p][p]The Dryads of the wild woods are wary of humans, prefering the company of the fauna and flora that surrounds them. \n\n[color=#bcad8c]Woodborne:[/color] Can cast Dryad magic, summoning woodland beings and imbuing allies with power.\n[color=#bcad8c]Heart of the Forest:[/color] Start the game with a Forest Heart, use this to attune yourself to that of the Greenwoods.\n[color=#bcad8c]Solitary:[/color] The Dryad hates nearly all humans, refusing to recruit anybody except wildlings, herbalists, beast tamers and other practictioners of wild magic.\n[color=#bcad8c]Avatar:[/color] If your Dryad dies, its game over.[/p]",
	RawDescription = "%name% has only ever known the heartwoods, the world of man is strange and disgusting."
};

// scripts\scenarios\world\ssu_lone_wolf_easy_scenario.nut
::Mod_Sellswords.Strings.ssu_lone_wolf_easy_scenario <- {
	Name = "Not So Lone Wolf",
	Description = "[p=c][img]gfx/ui/events/event_35.png[/img][/p][p]You have been traveling for a long time, taking part in tourneys and sparring with young nobles. A hedge knight as tall as a tree, you never needed anybody for long. Is it true still?\n\n[color=#bcad8c]Lone Wolf:[/color] Start with a single experienced hedge knight and great equipment but low funds.\n[color=#bcad8c]Elite Few:[/color] Only hire top talents.\n[color=#bcad8c]Avatar:[/color] If your lone wolf dies, the campaign ends.\n[color=#bcad8c]of the Same Mind:[/color] Encounter other champions through events to join your cause.[/p]",
	Title = "the Lone Wolf"
};

// scripts\scenarios\world\ssu_necro_lorekeeper_scenario.nut
::Mod_Sellswords.Strings.ssu_necro_lorekeeper_scenario <- {
	Name = "The Lorekeeper",
	Description = "[p=c][img]gfx/ui/events/event_173.png[/img][/p][p] After what felt like an eternity dedicated to research, you finally feel ready to unleash the fruits of your labour upon the living!\n\n[color=#bcad8c]Ancient Loyalties:[/color] Start with the Lorekeeper and two reliable servants. If the Lorekeeper dies, the binds are broken and the journey ends.\n[color=#bcad8c]Grim Companions:[/color] Undead can be found and bound to your will, while mortals wither away from your dark magic. Cultists, Gravediggers, Graverobbers, Anatomists, and Necromancers will flock to join you but other backgrounds cost 30% more to recruit and maintain. Cannot hire pious backgrounds.\n[color=#bcad8c]Terrible reputation:[/color] Recruits cannot hate the undead, relationships are poor with all factions and degrade slowly each day. Undead are passive towards you, and will steadily return to neutral if relations turn negative.[/p]",
	Title = "the Lorekeeper"
};

// scripts\scenarios\world\ssu_sellswords_scenario.nut
::Mod_Sellswords.Strings.ssu_sellswords_scenario <- {
	Name = "Sellswords"
};

// scripts\skills\actives\ssu_banner_wave.nut
::Mod_Sellswords.Strings.ssu_banner_wave <- {
	Name = "Emblem of Valor",
	Description = "As the banner billows in the wind, it serves as a beacon of inspiration for allies, granting them temporary AP.",
	Tooltip1 = "Grants all allied units within 8 tiles [color=%positive%]1[/color] additional Action Point for their next turn.",
	Tooltip2 = "[color=%negative%]Can not be used because this character is engaged in melee[/color]"
};

// scripts\skills\actives\ssu_bone_cleaver_flurry.nut
::Mod_Sellswords.Strings.ssu_bone_cleaver_flurry <- {
	Name = "Mince",
	Description = "A continuous flurry of blows so oppressive that it will send anything that survives reeling.",
	Tooltip1 = "Will make five separate strikes for [color=%negative%]50%[/color] of the weapon\'s damage each.",
	Tooltip2 = "Has a higher than normal chance to cause fatalities.",
	Tooltip3 = "Inflicts additional stacking [color=%damage%]{1}[/color] bleeding damage per turn."
};

// scripts\skills\actives\ssu_bone_cleaver_slash.nut
::Mod_Sellswords.Strings.ssu_bone_cleaver_slash <- {
	Name = "Rend Flesh",
	Description = "A brute force cleaving attack that can inflict devastating bleeding wounds, provided no armour is absorbing the blow.",
	Tooltip = "Inflicts additional stacking [color=%damage%]{1}[/color] bleeding damage per turn."
};

// scripts\skills\actives\ssu_bone_cleaver_swing.nut
::Mod_Sellswords.Strings.ssu_bone_cleaver_swing <- {
	Name = "Swing",
	Description = "Swinging the weapons in a wide arc that hits three adjacent tiles in counter-clockwise order. Be careful around your own men unless you want to relieve your payroll!",
	Tooltip1 = "Can hit up to 3 targets",
	Tooltip2 = "Will make two separate strikes for [color=%negative%]65%[/color] of the weapon\'s damage each",
	Tooltip3 = "Inflicts additional stacking [color=%damage%]{1}[/color] bleeding damage per turn.",
	Tooltip4 = "Has [color=%negative%]-5%[/color] chance to hit",
	Tooltip5 = "Has [color=%positive%]+5%[/color] chance to hit",
	Log = "{1} is bleeding"
};

// scripts\skills\actives\ssu_charge.nut
::Mod_Sellswords.Strings.ssu_charge <- {
	Name = "Charge",
	Description = "Charge at an enemy up to 2 tiles away, attacking them in the process.",
	Log1 = "{1} charges and is repelled",
	Log2 = "{1} charges and tramples {2}",
	Log3 = "{1} charges and stuns {2}",
	Log4 = "{1} charges and staggers {2}",
	Log5 = "{1} charges"
};

// scripts\skills\actives\ssu_clarity_skill.nut
::Mod_Sellswords.Strings.ssu_clarity_skill <- {
	Name = "Clarify",
	Description = "A well honed mind can perceive more in each instant, making time appear slower in key instants of need."
};

// scripts\skills\actives\ssu_dryad_forest_blessing.nut
::Mod_Sellswords.Strings.ssu_dryad_forest_blessing <- {
	Name = "Blessings of the Forest",
	Description = "Instill a target with the power of the Forest's Heart for two turns, granting them additional damage and combat ability. Can not be used while engaged in melee.",
	Tooltip1 = "Has a range of [color=%positive%]{1}[/color], can only target damaged units.",
	Tooltip2 = "[color=%positive%]+25%[/color] Damage",
	Tooltip3 = "[color=%positive%]+15[/color] Melee Skill",
	Tooltip4 = "[color=%positive%]+15[/color] Ranged Skill",
	Tooltip5 = "[color=%positive%]+15[/color] Melee Defense",
	Tooltip6 = "[color=%positive%]+15[/color] Ranged Defense",
	Tooltip7 = "Has [color=%positive%]{1}[/color] charges left",
	Tooltip8 = "[color=%negative%]Needs a heart filled with power equipped[/color]",
	Tooltip9 = "[color=%negative%]Can not be used because this character is engaged in melee[/color]"
};

// scripts\skills\actives\ssu_dryad_natural_regrowth.nut
::Mod_Sellswords.Strings.ssu_dryad_natural_regrowth <- {
	Name = "Natural Regrowth",
	Description = "Heals a friendly unit, removing all fresh injuries and healing up to 60 health per use. Can not be used while engaged in melee.",
	Tooltip1 = "Has a range of [color=%positive%]{1}[/color], can only target damaged units.",
	Tooltip2 = "You can heal up to [color=%positive%]60[/color] hitpoints.",
	Tooltip3 = "Has [color=%positive%]{1}[/color] charges left",
	Tooltip4 = "[color=%negative%]Needs a heart filled with power equipped[/color]",
	Tooltip5 = "[color=%negative%]Can not be used because this character is engaged in melee[/color]"
};

// scripts\skills\actives\ssu_dryad_summon_lindy.nut
::Mod_Sellswords.Strings.ssu_dryad_summon_lindy <- {
	Name = "Summon Forest Avatar",
	Description = "Summons a wood-bound leviathan. Needs a free nearby tile to spawn in. Can not be used while engaged in melee.",
	Tooltip1 = "Summons a Woodland Leviathan",
	Tooltip2 = "Costs 5 Forest Heart charges",
	Tooltip3 = "Has [color=%positive%]{1}[/color] charges left",
	Tooltip4 = "[color=%negative%]Needs a heart filled with power equipped[/color]",
	Tooltip5 = "[color=%negative%]Can not be used because this character is engaged in melee[/color]"
};

// scripts\skills\actives\ssu_dryad_summon_snake.nut
::Mod_Sellswords.Strings.ssu_dryad_summon_snake <- {
	Name = "Conjure Thicket Stalker",
	Description = "Summons a wood-bound serpent. Needs a free nearby tile to spawn in. Can not be used while engaged in melee.",
	Tooltip1 = "Summons a Woodland Serpent",
	Tooltip2 = "Costs 1 Forest Heart charge",
	Tooltip3 = "Has [color=%positive%]{1}[/color] charges left",
	Tooltip4 = "[color=%negative%]Needs a heart filled with power equipped[/color]",
	Tooltip5 = "[color=%negative%]Can not be used because this character is engaged in melee[/color]"
};

// scripts\skills\actives\ssu_dryad_summon_unhold.nut
::Mod_Sellswords.Strings.ssu_dryad_summon_unhold <- {
	Name = "Beckon Woodland Protector",
	Description = "Summons a woodland protector. Needs a free nearby tile to spawn in. Can not be used while engaged in melee.",
	Tooltip1 = "Summons a Woodland Protector",
	Tooltip2 = "Costs 3 Forest Heart charges",
	Tooltip3 = "Has [color=%positive%]{1}[/color] charges left",
	Tooltip4 = "[color=%negative%]Needs a heart filled with power equipped[/color]",
	Tooltip5 = "[color=%negative%]Can not be used because this character is engaged in melee[/color]"
};

// scripts\skills\actives\ssu_dryad_summon_wolf.nut
::Mod_Sellswords.Strings.ssu_dryad_summon_wolf <- {
	Name = "Call Verdant Hound",
	Description = "Summons a wood-bound wolf. Needs a free nearby tile to spawn in. Can not be used while engaged in melee.",
	Tooltip1 = "Summons a Woodland Wolf",
	Tooltip2 = "Costs 1 Forest Heart charge",
	Tooltip3 = "Has [color=%positive%]{1}[/color] charges left",
	Tooltip4 = "[color=%negative%]Needs a heart filled with power equipped[/color]",
	Tooltip5 = "[color=%negative%]Can not be used because this character is engaged in melee[/color]"
};

// scripts\skills\actives\ssu_earth_hammer_smite_skill.nut
::Mod_Sellswords.Strings.ssu_earth_hammer_smite_skill <- {
	Name = "Nature's Wrath",
	Description = "A powerful overhead strike performed with full force to smash a target and their surroundings to bits. Anyone hit will be staggered and lose initiative.",
	Tooltip1 = "Has a [color=%positive%]100%[/color] chance to stagger on a hit.",
	Tooltip2 = "Unleashes a powerful shockwave on hit to all enemies in adjacent tiles to the target.",
	Log = "{1} has staggered {2} for one turn"
};

// scripts\skills\actives\ssu_ghost_spear_strike.nut
::Mod_Sellswords.Strings.ssu_ghost_spear_strike <- {
	Name = "Wailing Strike",
	Description = "A slow overhead strike performed with full force. Due to the nature of the weapon used, it strikes directly at the soul of the enemy.",
	Tooltip1 = "Has [color=%negative%]-15%[/color] chance to hit targets directly adjacent because the weapon is too unwieldy",
	Tooltip2 = "Has a range of [color=%positive%]2[/color] tiles"
};

// scripts\skills\actives\ssu_hook_skill.nut
::Mod_Sellswords.Strings.ssu_hook_skill <- {
	Name = "Hook",
	Description = "A target 2 tiles away is hooked and pulled close if there is space. Anyone hit will be staggered and lose initiative. A target can not be pulled up a level of height, but may take damage if it is pulled down several levels of height at once. Shieldwall, Spearwall and Riposte will be canceled for a successfully hooked-in target. A rooted target can not be hooked.",
	Tooltip1 = "Has a range of [color=%positive%]2[/color] tiles",
	Tooltip2 = "Has a [color=%positive%]100%[/color] chance to stagger on a hit",
	Tooltip3 = "Has [color=%positive%]+10%[/color] chance to hit",
	Log1 = "{1} hooks in {2}",
	Log2 = "{1} has staggered {2} for one turn"
};

// scripts\skills\actives\ssu_howl_player.nut
::Mod_Sellswords.Strings.ssu_howl_player <- {
	Name = "Howl",
	Description = "Let loose a howl, boosting the morale of all allied direwolves within 6 tiles."
};

// scripts\skills\actives\ssu_jab.nut
::Mod_Sellswords.Strings.ssu_jab <- {
	Name = "Jab",
	Description = "A full forced prong performed for maximum reach rather than force that can hit two tiles in a straight line.",
	Tooltip1 = "Can hit up to 2 targets",
	Tooltip2 = "Has [color=%positive%]+10%[/color] chance to hit"
};

// scripts\skills\actives\ssu_necro_banshee_scream.nut
::Mod_Sellswords.Strings.ssu_necro_banshee_scream <- {
	Name = "Banshee Scream",
	Description = "Unleash a piercing, otherworldly sound that is bound to scar anyone unfortunate enough to hear it.",
	Tooltip1 = "Inflicts [color=%damage%]{1}[/color] - [color=%damage%]{2}[/color] damage that ignores armor",
	Tooltip2 = "Has a range of [color=%positive%]{1}[/color] tiles",
	Tooltip3 = "Damage is reduced by target\'s [color=%negative%]Resolve[/color]",
	Tooltip4 = "Has a chance to inflict [color=%negative%]Horrified[/color] effect",
	Log1 = "{1} uses Banshee Scream",
	Log2 = "{1} is horrified"
};

// scripts\skills\actives\ssu_necro_ghost_collect_fragment_skill.nut
::Mod_Sellswords.Strings.ssu_necro_ghost_collect_fragment_skill <- {
	Log = "{1}\'s fragments return to itself"
};

// scripts\skills\actives\ssu_necro_ghost_phase_through.nut
::Mod_Sellswords.Strings.ssu_necro_ghost_phase_through <- {
	Name = "Phase Through",
	Description = "Flying in a straight line, move up to 3 tiles away, dealing damage to any enemies you pass through. Has a 50% chance to apply the \'Distracted\' effect.",
	Tooltip1 = "Has a range of [color=%positive%]{1}[/color] tiles",
	Tooltip2 = "Deal damage to any entity you have passed through",
	Tooltip3 = "Completely ignores armor"
};

// scripts\skills\actives\ssu_necro_ghost_possess.nut
::Mod_Sellswords.Strings.ssu_necro_ghost_possess <- {
	Name = "Possess",
	Description = "Take control of a living creature.",
	Log1 = "{1} vanishes",
	Log2 = "{1} has rallied"
};

// scripts\skills\actives\ssu_necro_horrific_scream.nut
::Mod_Sellswords.Strings.ssu_necro_horrific_scream <- {
	Name = "Horrific Scream",
	Description = "Unleash a haunting, ethereal wail that is sure to strike fear into the hearts of all who hear it.",
	Tooltip = "Has a range of [color=%positive%]{1}[/color] tiles",
	Log = "{1} uses Horrific Scream"
};

// scripts\skills\actives\ssu_necro_insect_breath.nut
::Mod_Sellswords.Strings.ssu_necro_insect_breath <- {
	Name = "Insects Breath",
	Description = "Exhale a swarm of malevolent insects, enveloping your foes in a torrential cloud of biting and stinging creatures.",
	Tooltip = "[color=%negative%]Can only be used once per battle[/color]"
};

// scripts\skills\actives\ssu_necro_raise_all_undead.nut
::Mod_Sellswords.Strings.ssu_necro_raise_all_undead <- {
	Name = "The Danse Macabre",
	Description = "Witness the darkest depths of necromantic power. Unleash a wave of unholy energy that reanimates all suitable corpses.",
	Tooltip1 = "Has an [color=%positive%]unlimited[/color] range.",
	Tooltip2 = "Raises all suitable corpses on the map as a Wiederganger, lasts until the end of combat.",
	Tooltip3 = "[color=%negative%]Can only be used once per battle.[/color]",
	Tooltip4 = "[color=%negative%]Has been spent[/color].",
	Tooltip5 = "There is [color=%positive%]{1}[/color] corpse available for resurrection",
	Tooltip6 = "There are [color=%positive%]{1}[/color] corpses available for resurrection",
	Tooltip7 = "[color=%negative%]There is currently no suitable corpse on the map[/color]",
	Log = "{1} has reanimated the fallen!"
};

// scripts\skills\actives\ssu_necro_summon_skeleton.nut
::Mod_Sellswords.Strings.ssu_necro_summon_skeleton <- {
	Name1 = "Reanimate Skeleton",
	Description = "Use blood magic to re-animate one of your bone piles, and send it marching into the enemy. Takes a toll on the users mental state as they try and drag a spirit from the afterlife to inhabit the remains.",
	Tooltip1 = "The strength of the reanimated corpse scales based on the current resolve of the caster.",
	Tooltip2 = "Each successive cast makes it harder for the user to drag another soul from the ethereal plane.",
	Tooltip3 = "There are {1} spawns available in your inventory",
	Tooltip4 = "Will reanimate a strengthened undead.",
	Tooltip5 = "Will reanimate a regular undead.",
	Tooltip6 = "Will reanimate a weakened undead.",
	Name2 = "Raised Skeleton",
	Log = "{1} suffered [color=%negative%]backlash[/color] from the summoning ritual"
};

// scripts\skills\actives\ssu_necro_summon_zombie.nut
::Mod_Sellswords.Strings.ssu_necro_summon_zombie <- {
	Name1 = "Reanimate Zombie",
	Description = "Use blood magic to re-animate a fashioned corpse, and send it stumbling into the enemy. Takes a toll on the users mental state as they try and drag a spirit from the afterlife to inhabit the corpse.",
	Tooltip1 = "The strength of the reanimated corpse scales based on the current resolve of the caster.",
	Tooltip2 = "Each successive cast makes it harder for the user to drag another soul from the ethereal plane.",
	Tooltip3 = "There are {1} spawns available in your inventory",
	Tooltip4 = "Will reanimate a strengthened undead.",
	Tooltip5 = "Will reanimate a regular undead.",
	Tooltip6 = "Will reanimate a weakened undead.",
	Name2 = "Raised Wiederganger",
	Log = "{1} suffered [color=%negative%]backlash[/color] from the summoning ritual"
};

// scripts\skills\actives\ssu_necro_summon_zombie_dog.nut
::Mod_Sellswords.Strings.ssu_necro_summon_zombie_dog <- {
	Name1 = "Reanimate Hound",
	Description = "Use blood magic to re-animate one of your canid corpses, and send it towards the enemy flank. Takes a toll on the users mental state as they try and drag a spirit from the afterlife to inhabit the remains.",
	Tooltip1 = "The strength of the reanimated corpse scales based on the current resolve of the caster.",
	Tooltip2 = "Each successive cast makes it harder for the user to drag another soul from the ethereal plane.",
	Tooltip3 = "There are {1} spawns available in your inventory",
	Tooltip4 = "Will reanimate an undead hound.",
	Name2 = "Raised Hound",
	Log = "{1} suffered [color=%negative%]backlash[/color] from the summoning ritual"
};

// scripts\skills\actives\ssu_overwhelm_attack.nut
::Mod_Sellswords.Strings.ssu_overwhelm_attack <- {
	Name = "Quick Feint",
	Description = "Use a subtle feint to give yourself a strategic edge in combat by keeping adversaries off guard. Can be used every other turn.",
	Tooltip1 = "Can affect up to 4 adjacent targets",
	Tooltip2 = "Inflicts the \'Overwhelmed\' debuff to all enemies hit by the attack"
};

// scripts\skills\actives\ssu_assistance_skill.nut
::Mod_Sellswords.Strings.ssu_assistance_skill <- {
	Name = "Assistance",
	Description = "Ready your weapon to strike any enemy within your attack range that gets hit by an ally. Lasts until the start of your next turn.",
	Tooltip1 = "Performs a free attack against any enemy in attack range that gets hit by an ally's melee attack",
	Tooltip2 = "These attacks deal [color=%negative%]{1}%[/color] less damage",
	WarningWeapon = "[color=%negative%]Requires a Two-Handed Melee Weapon[/color]",
	WarningEngaged = "[color=%negative%]Can not be used while engaged in melee[/color]"
};

// scripts\skills\actives\ssu_rapidmarch_skill.nut
::Mod_Sellswords.Strings.ssu_rapidmarch_skill <- {
	Name = "Rapid March",
	Tooltip = "Grant a nearby ally \'Rapid March\' effect, reduced his Action Point cost for movement by [color=%positive%]1[/color] for each tile, but the Fatigue cost is doubled."
};

// scripts\skills\actives\ssu_staff_sweep.nut
::Mod_Sellswords.Strings.ssu_staff_sweep <- {
	Name = "Sweep",
	Description = "Sweep your staff along the floor to make your enemies lose their balance!",
	Tooltip1 = "Can hit up to 3 targets",
	Tooltip2 = "Has [color=%negative%]-5%[/color] chance to hit",
	Log = "{1} struck a blow that leaves {2} dazed"
};

// scripts\skills\actives\ssu_stamina_skill.nut
::Mod_Sellswords.Strings.ssu_stamina_skill <- {
	Name = "Unceasing Mysteries",
	Description = "The Grail ripped the Thunderskin from flesh. The Heart is the Blood's Drum, and here is its secret doctrine...",
	Tooltip1 = "Gain [color=%positive%]+{1}[/color] action point",
	Tooltip2 = "Will gain [color=%positive%]1[/color] more action point and cost [color=%negative%]5[/color] more fatigue each time you use it."
};

// scripts\skills\actives\ssu_strike.nut
::Mod_Sellswords.Strings.ssu_strike <- {
	Name = "Strike",
	Description = "A sweeping strike in a wide arc that hits three adjacent tiles in counter-clockwise order over some distance. Be careful around your own men unless you want to relieve your payroll!",
	Tooltip1 = "Can hit up to 2 targets",
	Tooltip2 = "Has a range of [color=%positive%]2[/color] tiles"
};

// scripts\skills\actives\ssu_throw_acid_flask_02.nut
::Mod_Sellswords.Strings.ssu_throw_acid_flask_02 <- {
	Name = "Throw Acid Flask",
	Description = "Throw a flask of acid towards a target, where it will shatter and spray its contents. The acid will slowly corrode away any armor of those hit - friend and foe alike.",
	Tooltip1 = "Reduces the target\'s armor by [color=%damage%]25%[/color] each turn for 3 turns",
	Tooltip2 = "Has a [color=%damage%]33%[/color] chance to hit bystanders at the same or lower height level as well",
	Tooltip3 = "Lasts for at least [color=%positive%]{1}[/color] turns",
	Tooltip4 = "Has [color=%positive%]{1}[/color] use left",
	Tooltip5 = "[color=%negative%]Has been used[/color]"
};

// scripts\skills\actives\ssu_throw_net_free.nut
::Mod_Sellswords.Strings.ssu_throw_net_free <- {
	Name = "Throw Portable Net",
	Description = "Throw a net on your target in order to prevent them from moving or defending themself effectively.",
	Tooltip1 = "Has a range of [color=%positive%]{1}[/color] tiles",
	Tooltip2 = "Some targets can never be caught or ensnared",
	Tooltip3 = "Can be used once per battle"
};

// scripts\skills\actives\ssu_whip.nut
::Mod_Sellswords.Strings.ssu_whip <- {
	Name = "Whip"
};

// scripts\skills\backgrounds\ssu_dryad_archer_background.nut
::Mod_Sellswords.Strings.ssu_dryad_archer_background <- {
	Name = "Dryad Archer",
	Text = "{%fullname% has roamed the ancient forests for centuries, guarding its secrets and punishing those who defile it. | %fullname% remembers the first sprouting of trees, the bloom of the first flowers, and has vowed to protect them ever since. | With a spirit attuned to the earth and wisdom ancient as the stars, %fullname% has long watched over the Heartwoods. | The forests speak through %fullname%, their whispers guiding every step and decision. | %fullname% is one with the Heartwoods, and to cross paths with them is to face the wrath of nature itself. | As a guardian of the Heartwoods, %fullname% ensures that the balance is maintained, no matter the cost. | Long ago, %fullname% took up the mantle of protector, a duty carried out with unwavering resolve. | %fullname% was born of the Heartwoods, their soul intertwined with every leaf and branch. | %fullname% has seen countless seasons come and go, always ensuring the cycle of life continues. | To disturb the forest is to disturb %fullname%, and that is a mistake few live to repeat.} {With each passing season, %name% grows stronger, learning the ways of nature\'s wrath. | Having witnessed countless trespassers fall to the forest\'s fury, %name% knows the woods like no other. | %name% has honed their skills with nature\'s gifts, their power rivaled by none. | The whispers of the trees guide %name%\'s every move, making them a formidable ally or a terrifying foe. | With a touch, %name% can command the very essence of the forest to do their bidding. | Few can stand against the might of %name% when the forest itself rises to their call. | Each step %name% takes is calculated, guided by centuries of knowledge. | %name%\'s connection to the earth grants them power and insight beyond mortal comprehension. | To face %name% is to face the very soul of the forest itself. | With every rustling leaf and creaking branch, %name% grows more attuned to the world around them.} {The forest has taught %name% to be both fierce and wise in equal measure. | %name% is no stranger to the cycle of life and death, having seen it unfold for eons. | Their resolve is as unyielding as the ancient trees they protect. | Some say %name% can communicate with the very essence of the forest, guiding it to their will. | %name% is a sentinel of nature, ever-watchful and ever-ready to strike down those who threaten the balance. | Tales of %name%\'s deeds echo through the woods, a reminder of the forest\'s fury. | %name% carries the wisdom of the ages, using it to protect and preserve the sanctity of nature. | The forest\'s creatures rally to %name%\'s side, their loyalty born of mutual respect and ancient bonds. | In battle, %name% is a force of nature, their strikes swift and unrelenting.} {For those who respect the forest, %name% offers their protection and guidance. | %name% fights not for gold, but to preserve the sanctity of nature itself. | With a calm nod, %name% agrees to lend their strength to those who share their cause. | Ready to defend the ancient woods, %name% rises to the challenge, eager to uphold the balance. | For the promise of a safer world, %name% is prepared to strike down any who threaten the Heartwoods.}"
};

// scripts\skills\backgrounds\ssu_dryad_avatar_background.nut
::Mod_Sellswords.Strings.ssu_dryad_avatar_background <- {
	Name = "Dryad Avatar",
	Titles = [ "the Dryad" ]
};

// scripts\skills\backgrounds\ssu_dryad_grunt_background.nut
::Mod_Sellswords.Strings.ssu_dryad_grunt_background <- {
	Name = "Dryad",
	Text = "{%fullname% has roamed the ancient forests for centuries, guarding its secrets and punishing those who defile it. | %fullname% remembers the first sprouting of trees, the bloom of the first flowers, and has vowed to protect them ever since. | With a spirit attuned to the earth and wisdom ancient as the stars, %fullname% has long watched over the Heartwoods. | The forests speak through %fullname%, their whispers guiding every step and decision. | %fullname% is one with the Heartwoods, and to cross paths with them is to face the wrath of nature itself. | As a guardian of the Heartwoods, %fullname% ensures that the balance is maintained, no matter the cost. | Long ago, %fullname% took up the mantle of protector, a duty carried out with unwavering resolve. | %fullname% was born of the Heartwoods, their soul intertwined with every leaf and branch. | %fullname% has seen countless seasons come and go, always ensuring the cycle of life continues. | To disturb the forest is to disturb %fullname%, and that is a mistake few live to repeat.} {With each passing season, %name% grows stronger, learning the ways of nature\'s wrath. | Having witnessed countless trespassers fall to the forest\'s fury, %name% knows the woods like no other. | %name% has honed their skills with nature\'s gifts, their power rivaled by none. | The whispers of the trees guide %name%\'s every move, making them a formidable ally or a terrifying foe. | With a touch, %name% can command the very essence of the forest to do their bidding. | Few can stand against the might of %name% when the forest itself rises to their call. | Each step %name% takes is calculated, guided by centuries of knowledge. | %name%\'s connection to the earth grants them power and insight beyond mortal comprehension. | To face %name% is to face the very soul of the forest itself. | With every rustling leaf and creaking branch, %name% grows more attuned to the world around them.} {The forest has taught %name% to be both fierce and wise in equal measure. | %name% is no stranger to the cycle of life and death, having seen it unfold for eons. | Their resolve is as unyielding as the ancient trees they protect. | Some say %name% can communicate with the very essence of the forest, guiding it to their will. | %name% is a sentinel of nature, ever-watchful and ever-ready to strike down those who threaten the balance. | Tales of %name%\'s deeds echo through the woods, a reminder of the forest\'s fury. | %name% carries the wisdom of the ages, using it to protect and preserve the sanctity of nature. | The forest\'s creatures rally to %name%\'s side, their loyalty born of mutual respect and ancient bonds. | In battle, %name% is a force of nature, their strikes swift and unrelenting.} {For those who respect the forest, %name% offers their protection and guidance. | %name% fights not for gold, but to preserve the sanctity of nature itself. | With a calm nod, %name% agrees to lend their strength to those who share their cause. | Ready to defend the ancient woods, %name% rises to the challenge, eager to uphold the balance. | For the promise of a safer world, %name% is prepared to strike down any who threaten the Heartwoods.}"
};

// scripts\skills\backgrounds\ssu_dryad_shaman_background.nut
::Mod_Sellswords.Strings.ssu_dryad_shaman_background <- {
	Name = "Dryad Shaman",
	Text = "{%fullname% has roamed the ancient forests for centuries, guarding its secrets and punishing those who defile it. | %fullname% remembers the first sprouting of trees, the bloom of the first flowers, and has vowed to protect them ever since. | With a spirit attuned to the earth and wisdom ancient as the stars, %fullname% has long watched over the Heartwoods. | The forests speak through %fullname%, their whispers guiding every step and decision. | %fullname% is one with the Heartwoods, and to cross paths with them is to face the wrath of nature itself. | As a guardian of the Heartwoods, %fullname% ensures that the balance is maintained, no matter the cost. | Long ago, %fullname% took up the mantle of protector, a duty carried out with unwavering resolve. | %fullname% was born of the Heartwoods, their soul intertwined with every leaf and branch. | %fullname% has seen countless seasons come and go, always ensuring the cycle of life continues. | To disturb the forest is to disturb %fullname%, and that is a mistake few live to repeat.} {With each passing season, %name% grows stronger, learning the ways of nature\'s wrath. | Having witnessed countless trespassers fall to the forest\'s fury, %name% knows the woods like no other. | %name% has honed their skills with nature\'s gifts, their power rivaled by none. | The whispers of the trees guide %name%\'s every move, making them a formidable ally or a terrifying foe. | With a touch, %name% can command the very essence of the forest to do their bidding. | Few can stand against the might of %name% when the forest itself rises to their call. | Each step %name% takes is calculated, guided by centuries of knowledge. | %name%\'s connection to the earth grants them power and insight beyond mortal comprehension. | To face %name% is to face the very soul of the forest itself. | With every rustling leaf and creaking branch, %name% grows more attuned to the world around them.} {The forest has taught %name% to be both fierce and wise in equal measure. | %name% is no stranger to the cycle of life and death, having seen it unfold for eons. | Their resolve is as unyielding as the ancient trees they protect. | Some say %name% can communicate with the very essence of the forest, guiding it to their will. | %name% is a sentinel of nature, ever-watchful and ever-ready to strike down those who threaten the balance. | Tales of %name%\'s deeds echo through the woods, a reminder of the forest\'s fury. | %name% carries the wisdom of the ages, using it to protect and preserve the sanctity of nature. | The forest\'s creatures rally to %name%\'s side, their loyalty born of mutual respect and ancient bonds. | In battle, %name% is a force of nature, their strikes swift and unrelenting.} {For those who respect the forest, %name% offers their protection and guidance. | %name% fights not for gold, but to preserve the sanctity of nature itself. | With a calm nod, %name% agrees to lend their strength to those who share their cause. | Ready to defend the ancient woods, %name% rises to the challenge, eager to uphold the balance. | For the promise of a safer world, %name% is prepared to strike down any who threaten the Heartwoods.}"
};

// scripts\skills\backgrounds\ssu_dryad_tamer_background.nut
::Mod_Sellswords.Strings.ssu_dryad_tamer_background <- {
	Name = "Dryad Tamer",
	Text = "{%fullname% has roamed the ancient forests for centuries, guarding its secrets and punishing those who defile it. | %fullname% remembers the first sprouting of trees, the bloom of the first flowers, and has vowed to protect them ever since. | With a spirit attuned to the earth and wisdom ancient as the stars, %fullname% has long watched over the Heartwoods. | The forests speak through %fullname%, their whispers guiding every step and decision. | %fullname% is one with the Heartwoods, and to cross paths with them is to face the wrath of nature itself. | As a guardian of the Heartwoods, %fullname% ensures that the balance is maintained, no matter the cost. | Long ago, %fullname% took up the mantle of protector, a duty carried out with unwavering resolve. | %fullname% was born of the Heartwoods, their soul intertwined with every leaf and branch. | %fullname% has seen countless seasons come and go, always ensuring the cycle of life continues. | To disturb the forest is to disturb %fullname%, and that is a mistake few live to repeat.} {With each passing season, %name% grows stronger, learning the ways of nature\'s wrath. | Having witnessed countless trespassers fall to the forest\'s fury, %name% knows the woods like no other. | %name% has honed their skills with nature\'s gifts, their power rivaled by none. | The whispers of the trees guide %name%\'s every move, making them a formidable ally or a terrifying foe. | With a touch, %name% can command the very essence of the forest to do their bidding. | Few can stand against the might of %name% when the forest itself rises to their call. | Each step %name% takes is calculated, guided by centuries of knowledge. | %name%\'s connection to the earth grants them power and insight beyond mortal comprehension. | To face %name% is to face the very soul of the forest itself. | With every rustling leaf and creaking branch, %name% grows more attuned to the world around them.} {The forest has taught %name% to be both fierce and wise in equal measure. | %name% is no stranger to the cycle of life and death, having seen it unfold for eons. | Their resolve is as unyielding as the ancient trees they protect. | Some say %name% can communicate with the very essence of the forest, guiding it to their will. | %name% is a sentinel of nature, ever-watchful and ever-ready to strike down those who threaten the balance. | Tales of %name%\'s deeds echo through the woods, a reminder of the forest\'s fury. | %name% carries the wisdom of the ages, using it to protect and preserve the sanctity of nature. | The forest\'s creatures rally to %name%\'s side, their loyalty born of mutual respect and ancient bonds. | In battle, %name% is a force of nature, their strikes swift and unrelenting.} {For those who respect the forest, %name% offers their protection and guidance. | %name% fights not for gold, but to preserve the sanctity of nature itself. | With a calm nod, %name% agrees to lend their strength to those who share their cause. | Ready to defend the ancient woods, %name% rises to the challenge, eager to uphold the balance. | For the promise of a safer world, %name% is prepared to strike down any who threaten the Heartwoods.}"
};

// scripts\skills\backgrounds\ssu_dryad_warrior_background.nut
::Mod_Sellswords.Strings.ssu_dryad_warrior_background <- {
	Name = "Dryad Warrior",
	Text = "{%fullname% has roamed the ancient forests for centuries, guarding its secrets and punishing those who defile it. | %fullname% remembers the first sprouting of trees, the bloom of the first flowers, and has vowed to protect them ever since. | With a spirit attuned to the earth and wisdom ancient as the stars, %fullname% has long watched over the Heartwoods. | The forests speak through %fullname%, their whispers guiding every step and decision. | %fullname% is one with the Heartwoods, and to cross paths with them is to face the wrath of nature itself. | As a guardian of the Heartwoods, %fullname% ensures that the balance is maintained, no matter the cost. | Long ago, %fullname% took up the mantle of protector, a duty carried out with unwavering resolve. | %fullname% was born of the Heartwoods, their soul intertwined with every leaf and branch. | %fullname% has seen countless seasons come and go, always ensuring the cycle of life continues. | To disturb the forest is to disturb %fullname%, and that is a mistake few live to repeat.} {With each passing season, %name% grows stronger, learning the ways of nature\'s wrath. | Having witnessed countless trespassers fall to the forest\'s fury, %name% knows the woods like no other. | %name% has honed their skills with nature\'s gifts, their power rivaled by none. | The whispers of the trees guide %name%\'s every move, making them a formidable ally or a terrifying foe. | With a touch, %name% can command the very essence of the forest to do their bidding. | Few can stand against the might of %name% when the forest itself rises to their call. | Each step %name% takes is calculated, guided by centuries of knowledge. | %name%\'s connection to the earth grants them power and insight beyond mortal comprehension. | To face %name% is to face the very soul of the forest itself. | With every rustling leaf and creaking branch, %name% grows more attuned to the world around them.} {The forest has taught %name% to be both fierce and wise in equal measure. | %name% is no stranger to the cycle of life and death, having seen it unfold for eons. | Their resolve is as unyielding as the ancient trees they protect. | Some say %name% can communicate with the very essence of the forest, guiding it to their will. | %name% is a sentinel of nature, ever-watchful and ever-ready to strike down those who threaten the balance. | Tales of %name%\'s deeds echo through the woods, a reminder of the forest\'s fury. | %name% carries the wisdom of the ages, using it to protect and preserve the sanctity of nature. | The forest\'s creatures rally to %name%\'s side, their loyalty born of mutual respect and ancient bonds. | In battle, %name% is a force of nature, their strikes swift and unrelenting.} {For those who respect the forest, %name% offers their protection and guidance. | %name% fights not for gold, but to preserve the sanctity of nature itself. | With a calm nod, %name% agrees to lend their strength to those who share their cause. | Ready to defend the ancient woods, %name% rises to the challenge, eager to uphold the balance. | For the promise of a safer world, %name% is prepared to strike down any who threaten the Heartwoods.}"
};

// scripts\skills\backgrounds\ssu_necro_ancient_auxiliary.nut
::Mod_Sellswords.Strings.ssu_necro_ancient_auxiliary <- {
	Name = "Ancient Auxiliary",
	BackgroundDescription = "A reanimated ancient soldier, its bones weathered by the passage of time yet still bearing the marks of formidable skill. Clad in remnants of rusted armor and wielding a tarnished blade, this skeletal auxiliary remains a haunting reminder of battles long past.",
	GoodEnding = "As the battle\'s tumult waned, %name%, once a mere vessel for darkness, found itself infused with the essence of valor and purpose. With a resolute heart beating in its empty chest, it laid down their ancient arms, a testament to the transformative power of courage and redemption. Amidst the fading echoes of conflict, %name% stood as a sentinel of hope, its hollow gaze now alight with the gentle flicker of peace, a beacon guiding lost souls towards a brighter dawn. And so, in the annals of legend, the tale of %name% was not one of eternal damnation, but a saga of triumph over the shadows, where even the darkest of beings could find solace in the embrace of light.",
	BadEnding = "With its last breath rattling through its ancient bones, %name% collapsed amidst the battlefield's desolation. Its empty sockets stared skyward, filled not with the light of redemption, but with the eternal darkness of failure. Forgotten by history, it became yet another grim reminder of the futility of defiance against the tides of fate, lost to the annals of time as little more than a whisper in the wind.",
	Text = "{Where %name% orginally comes from is a mystery - their orginal name has been lost to time or washed away on an ancient gravestone far, far away. | Who this creature one was matters little. They serve and obey. That is all that matters. | This one is marked with cuts and nail marks, and still surprisingly fresh. | Come rain, snow or sandstorm %name% happily goes where they please. A truely free soul in a world of toil and dispair. If the world had more people like %name%, it would be a much better place. | This one is marked with stab wounds and cuts across their whole body. Many of which seem ancient in origin. | %name% is marked with wounds, many of which are fatal but have been carefully stitched shut or cauterized - suggesting that at some point, someone cared for this poor fark after death. Who the caretaker was will forever be a mystery however. | This one seems a little older than most, with barely any forms of battle damage across its carcass. Maybe this one died in a peaceful manner? Such things are rare in this world. | This one bares little evidence of a violent death, save for the noose marks around its throat. | With the rampant war and famile across the land, corpses like %name% turn up in droves these days. Mass graves remain uncovered, graveyards barely watched over. Perfect marketplaces to hone the dark arts. | The war of many names created a treaure trove of unliving recruits for necromancers. %name% is one such product of the conflict, seeminly a little more astute and reactive to orders than the average corpse - not that expectations are set very high or anything... | This one was bound and thrown into a river, however the main cause of death seems to be the dozens of arrows pocked across its body. The work of poachers, bored brigands or a vengeful feud come to an end.}{ Don\'t let the exterior fool you, when fresh game is involved %name% acts with sudden alacrity unbecoming their form. | The presence of anything living will drive this animal into a frenzy, no matter the size. | This corpse also comes with a small satchel of rusted coins, which are going to waste in their current state. You are sure it won\'t miss them anyway... | %name% lazily swings a rusted shortsword around as they plod aimlessly. | %name% is a fitting name, don\'t you think? It captures the struggle of this creature well. | While undead, these creatures are more like wild animals than brutal killers. | You poke %name% on what remains of its arm. It turns to look at you, then moves past you to chase a stray dog. You like this one. | %name% is still covered in clods of earth, sand and what else. This also gives you an idea... | The lifeless stare still takes some getting used to. The harder you look the more it feels like something is still in there. Something still human...} {You wonder how long it would take to teach this corpse to best a knight in battle. On second thoughts you aren\'t sure if you have that much time. | A victim of violence, %name% seems eager to continue the cycle of suffering. Perfect. | While clumsy, this create will make a fine addition to any collector looking to bulk out their macabre hobby. | You get the impression %name% would\'ve been an interesting person to know when they were alive. Oh well. | A victim of murder, lyncing or witchcraft, maybe %name% was just in the wrong place at the wrong time? | %name% almost seems to enjoy their new existance in unlife. | After all, who needs tiring muscles, decent pay and moments of sheer panic? Not this one. | Weathered and beaten, this one will make a fine addition to the collection. | Sometimes you feel guilty to treat these creatures as personal servants.} {Despite everything, the body is willing and the flesh is weak. But you get the impression this won\'t be a problem. | You jokingly hand the corpse a contract, and it looks at the parchment with some familiarity... | While cheap labour, you really hope you don\'t need to scrub out any armour it might end up wearing. | You push %name% and it manages to stay standing, which is more impressive than it sounds by walking corpse standards. | But with sharp teeth like that, who needs weapons? | %name% drops to their knees and attempts to eat the critters crawling in the dirt. This will be a long and fruitful relationship. | If anything, %name% will make a decent pack mule for all the things you don\'t want to carry. | The poor thing looks hungry. | On second thought, maybe %name% isn\'t memorable enough. Surely you can do better...'}"
};

// scripts\skills\backgrounds\ssu_necro_ancient_honour_guard.nut
::Mod_Sellswords.Strings.ssu_necro_ancient_honour_guard <- {
	Name = "Ancient Honour Guard",
	BackgroundDescription = "Though lacking in durability, this skeleton champion compensates with agility and precision, darting through the fray with an otherworldly grace. Its movements are fluid yet purposeful, guided by the instincts of a warrior long honed in the crucible of conflict.",
	GoodEnding = "As the final echoes of battle faded into the night, %name% stood amidst the carnage, its bones weary yet unbroken. No longer a puppet to the whims of darkness, but a guardian of the fractured realm it once sought to conquer. With a solemn reverence, it laid down its weapons, a silent oath sworn to never again sow the seeds of chaos. As dawn kissed the horizon with hues of hope, %name% took its final bow, not in defeat, but in the quiet victory of a soul reborn. And so, in the tapestry of legends, the tale of %name% shall endure not as a harbinger of fear, but as a testament to the boundless potential of redemption—a reminder that even the coldest of hearts can thaw beneath the warmth of forgiveness.",
	BadEnding = "In the dying embers of twilight, %name%, consumed by the darkness that once fueled its existence, succumbed to the allure of power. With malevolent glee, it unleashed unspeakable horrors upon the land, its skeletal visage twisted into a mockery of its former self. The realm, now ensnared in the grip of eternal night, trembled beneath the weight of its tyranny, as the once-heroic figure became a harbinger of despair, forever damned to roam the shadows as a grim specter of destruction.",
	Text = "{Where %name% orginally comes from is a mystery - their orginal name has been lost to time or washed away on an ancient gravestone far, far away. | Who this creature one was matters little. They serve and obey. That is all that matters. | This one is marked with cuts and nail marks, and still surprisingly fresh. | Come rain, snow or sandstorm %name% happily goes where they please. A truely free soul in a world of toil and dispair. If the world had more people like %name%, it would be a much better place. | This one is marked with stab wounds and cuts across their whole body. Many of which seem ancient in origin. | %name% is marked with wounds, many of which are fatal but have been carefully stitched shut or cauterized - suggesting that at some point, someone cared for this poor fark after death. Who the caretaker was will forever be a mystery however. | This one seems a little older than most, with barely any forms of battle damage across its carcass. Maybe this one died in a peaceful manner? Such things are rare in this world. | This one bares little evidence of a violent death, save for the noose marks around its throat. | With the rampant war and famile across the land, corpses like %name% turn up in droves these days. Mass graves remain uncovered, graveyards barely watched over. Perfect marketplaces to hone the dark arts. | The war of many names created a treaure trove of unliving recruits for necromancers. %name% is one such product of the conflict, seeminly a little more astute and reactive to orders than the average corpse - not that expectations are set very high or anything... | This one was bound and thrown into a river, however the main cause of death seems to be the dozens of arrows pocked across its body. The work of poachers, bored brigands or a vengeful feud come to an end.}{ Don\'t let the exterior fool you, when fresh game is involved %name% acts with sudden alacrity unbecoming their form. | The presence of anything living will drive this animal into a frenzy, no matter the size. | This corpse also comes with a small satchel of rusted coins, which are going to waste in their current state. You are sure it won\'t miss them anyway... | %name% lazily swings a rusted shortsword around as they plod aimlessly. | %name% is a fitting name, don\'t you think? It captures the struggle of this creature well. | While undead, these creatures are more like wild animals than brutal killers. | You poke %name% on what remains of its arm. It turns to look at you, then moves past you to chase a stray dog. You like this one. | %name% is still covered in clods of earth, sand and what else. This also gives you an idea... | The lifeless stare still takes some getting used to. The harder you look the more it feels like something is still in there. Something still human...} {You wonder how long it would take to teach this corpse to best a knight in battle. On second thoughts you aren\'t sure if you have that much time. | A victim of violence, %name% seems eager to continue the cycle of suffering. Perfect. | While clumsy, this create will make a fine addition to any collector looking to bulk out their macabre hobby. | You get the impression %name% would\'ve been an interesting person to know when they were alive. Oh well. | A victim of murder, lyncing or witchcraft, maybe %name% was just in the wrong place at the wrong time? | %name% almost seems to enjoy their new existance in unlife. | After all, who needs tiring muscles, decent pay and moments of sheer panic? Not this one. | Weathered and beaten, this one will make a fine addition to the collection. | Sometimes you feel guilty to treat these creatures as personal servants.} {Despite everything, the body is willing and the flesh is weak. But you get the impression this won\'t be a problem. | You jokingly hand the corpse a contract, and it looks at the parchment with some familiarity... | While cheap labour, you really hope you don\'t need to scrub out any armour it might end up wearing. | You push %name% and it manages to stay standing, which is more impressive than it sounds by walking corpse standards. | But with sharp teeth like that, who needs weapons? | %name% drops to their knees and attempts to eat the critters crawling in the dirt. This will be a long and fruitful relationship. | If anything, %name% will make a decent pack mule for all the things you don\'t want to carry. | The poor thing looks hungry. | On second thought, maybe %name% isn\'t memorable enough. Surely you can do better...'}"
};

// scripts\skills\backgrounds\ssu_necro_ancient_legionary.nut
::Mod_Sellswords.Strings.ssu_necro_ancient_legionary <- {
	Name = "Ancient Legionary",
	BackgroundDescription = "The skeleton of a long dead warrior. Though its form lacks the flesh and sinew of the living, its combat prowess is unmatched, a testament to the discipline and training of its former life.",
	GoodEnding = "In the hushed aftermath of battle, the once-ferocious %name% found itself standing amidst the remnants of chaos, its bones now adorned not with the stains of blood, but with the grace of newfound purpose. With each clatter of its skeletal frame, it echoed a melody of redemption, a symphony of resilience rising from the ashes of strife. As the sun dipped below the horizon, casting its golden hues upon the scarred landscape, %name% knelt, its bony fingers gently tracing the earth. In that moment of quiet reflection, it vowed not to be defined by its past of darkness, but to embrace a future illuminated by the guiding light of honor and compassion. And so, with each step forward, %name% embarked on a journey not of conquest, but of healing—a testament to the enduring power of redemption in a world where even the bleakest souls can find their way home.",
	BadEnding = "Time went on, unending as it is for those that are no longer bound to the mortal coil. Eventually %name% found themselves victim to a holy crusade, aimed at those uniquely afflicted with undeath. As the battle\'s fury reached its crescendo, %name% fought on with reckless abandon, heedless of the toll exacted upon its brittle form. With each strike, bone shattered and splintered, until it lay broken and defeated upon the blood-soaked earth. Its demise served as a grim testament to the folly of pride, a cautionary tale etched in the crimson stains of hubris, destined to be recounted by future generations as a warning against the arrogance of the fallen.",
	Text = "{Where %name% orginally comes from is a mystery - their orginal name has been lost to time or washed away on an ancient gravestone far, far away. | Who this creature one was matters little. They serve and obey. That is all that matters. | This one is marked with cuts and nail marks, and still surprisingly fresh. | Come rain, snow or sandstorm %name% happily goes where they please. A truely free soul in a world of toil and dispair. If the world had more people like %name%, it would be a much better place. | This one is marked with stab wounds and cuts across their whole body. Many of which seem ancient in origin. | %name% is marked with wounds, many of which are fatal but have been carefully stitched shut or cauterized - suggesting that at some point, someone cared for this poor fark after death. Who the caretaker was will forever be a mystery however. | This one seems a little older than most, with barely any forms of battle damage across its carcass. Maybe this one died in a peaceful manner? Such things are rare in this world. | This one bares little evidence of a violent death, save for the noose marks around its throat. | With the rampant war and famile across the land, corpses like %name% turn up in droves these days. Mass graves remain uncovered, graveyards barely watched over. Perfect marketplaces to hone the dark arts. | The war of many names created a treaure trove of unliving recruits for necromancers. %name% is one such product of the conflict, seeminly a little more astute and reactive to orders than the average corpse - not that expectations are set very high or anything... | This one was bound and thrown into a river, however the main cause of death seems to be the dozens of arrows pocked across its body. The work of poachers, bored brigands or a vengeful feud come to an end.}{ Don\'t let the exterior fool you, when fresh game is involved %name% acts with sudden alacrity unbecoming their form. | The presence of anything living will drive this animal into a frenzy, no matter the size. | This corpse also comes with a small satchel of rusted coins, which are going to waste in their current state. You are sure it won\'t miss them anyway... | %name% lazily swings a rusted shortsword around as they plod aimlessly. | %name% is a fitting name, don\'t you think? It captures the struggle of this creature well. | While undead, these creatures are more like wild animals than brutal killers. | You poke %name% on what remains of its arm. It turns to look at you, then moves past you to chase a stray dog. You like this one. | %name% is still covered in clods of earth, sand and what else. This also gives you an idea... | The lifeless stare still takes some getting used to. The harder you look the more it feels like something is still in there. Something still human...} {You wonder how long it would take to teach this corpse to best a knight in battle. On second thoughts you aren\'t sure if you have that much time. | A victim of violence, %name% seems eager to continue the cycle of suffering. Perfect. | While clumsy, this create will make a fine addition to any collector looking to bulk out their macabre hobby. | You get the impression %name% would\'ve been an interesting person to know when they were alive. Oh well. | A victim of murder, lyncing or witchcraft, maybe %name% was just in the wrong place at the wrong time? | %name% almost seems to enjoy their new existance in unlife. | After all, who needs tiring muscles, decent pay and moments of sheer panic? Not this one. | Weathered and beaten, this one will make a fine addition to the collection. | Sometimes you feel guilty to treat these creatures as personal servants.} {Despite everything, the body is willing and the flesh is weak. But you get the impression this won\'t be a problem. | You jokingly hand the corpse a contract, and it looks at the parchment with some familiarity... | While cheap labour, you really hope you don\'t need to scrub out any armour it might end up wearing. | You push %name% and it manages to stay standing, which is more impressive than it sounds by walking corpse standards. | But with sharp teeth like that, who needs weapons? | %name% drops to their knees and attempts to eat the critters crawling in the dirt. This will be a long and fruitful relationship. | If anything, %name% will make a decent pack mule for all the things you don\'t want to carry. | The poor thing looks hungry. | On second thought, maybe %name% isn\'t memorable enough. Surely you can do better...'}"
};

// scripts\skills\backgrounds\ssu_necro_banshee.nut
::Mod_Sellswords.Strings.ssu_necro_banshee <- {
	Name = "Winselmutter",
	BackgroundDescription = "Winselmutters are spectral entities, known for their mournful wails and chilling presence. With flowing hair and pale features, they are said to appear near places of impending death or to herald the passing of individuals from prominent families. Legends speak of their supernatural abilities to foresee tragedy and lament the departure of souls from the mortal realm, their haunting cries echoing through the night as omens of impending doom.",
	GoodEnding = "Having embraced the light of forgiveness, %name% found solace in letting go of its earthly attachments and embracing the peace of the afterlife. Through acts of redemption and reconciliation, it resolved the unfinished business that tethered it to the mortal realm, allowing its spirit to ascend to a higher plane of existence. As it faded into the radiant glow of transcendence, %name% left behind a legacy of healing and forgiveness, a testament to the power of love and redemption to conquer even the darkest shadows.",
	BadEnding = "Freed from the confines of its mortal coil, %name% wandered aimlessly through the ethereal plane, its essence consumed by bitterness and rage. Unable to find peace in the afterlife, it became a vengeful spirit, wreaking havoc upon the living in a futile attempt to assuage its own suffering. As its spectral form grew ever more twisted by the darkness that consumed it, %name%\'s existence became a tragic tale of unending torment, a warning to all who would dare defy the natural order of life and death.",
	Text = "{Once a lost soul wandering the misty realms between worlds, %name% now serves as a spectral sentinel, forever bound to this earthly plane by an ancient curse. | The true identity of %name% remains shrouded in the whispers of the beyond, lost amidst the echoes of forgotten tombs and forgotten lives. | This ethereal entity bears the scars of a violent demise, its spectral form forever haunted by the echoes of its untimely end. | Despite its otherworldly nature, %name% moves with an eerie grace, its ghostly form gliding silently through the shadows. | In the realm of the living, %name% is a silent watcher, its ghostly presence barely perceptible as it drifts through the mortal world. | Beneath its translucent veil, %name% harbors a boundless hunger, its spectral essence yearning for the warmth of life that it can never again possess.}{ Though death has claimed its mortal frame, %name% lingers on, an ethereal remnant of a life long past. | Trapped between realms, %name% exists in a state of perpetual unrest, forever tormented by the memories of its former existence. | In death, %name% has become a harbinger of whispers and shadows, a spectral guardian of secrets lost to the sands of time. | From the shadowy depths of forgotten crypts, %name% emerges as a specter of the night, its form bound to this world by ancient sorceries. | Lost to the annals of history, %name% drifts through the veil between worlds, a ghostly remnant of a bygone era. | In the darkness of the tomb, %name% found its eternal rest disturbed, condemned to wander the mortal realm as a restless spirit.}{ Though its corporeal form may have faded, %name% endures as a spectral wraith, its ethereal presence haunting the desolate halls of its final resting place. | In death, %name% has become an echo of the past, a ghostly apparition doomed to forever roam the earth in search of peace. | Bound by the chains of its own sorrow, %name% wanders the haunted corridors of the world, a ghostly visage forever trapped in the grip of its own torment. | Driven by a thirst for vengeance or perhaps a longing for closure, %name% roams the earth as a restless spirit, its ethereal form a testament to the fragility of mortal life. | In the stillness of the night, %name% walks among the living, a ghostly presence that lingers on the edge of perception, a whisper in the darkness. | Though it may be forgotten by the passage of time, %name% endures as a spectral guardian, its silent vigil a testament to the enduring power of the human spirit. | Once a soul lost to the depths of the underworld, %name% now wanders the mortal realm as a spectral remnant of its former self. | Forgotten by time, %name% exists as a shadowy echo of the past, its ethereal form a haunting reminder of lives long gone. | In death, %name% found neither rest nor solace, condemned to wander the earth as a restless spirit bound by the chains of its own sorrow.}{ Drifting through the veil between worlds, %name% is a silent watcher, its ghostly form a fleeting glimpse of a world beyond mortal comprehension. | Haunted by the memories of its former existence, %name% exists in a state of perpetual unrest, its ethereal presence a haunting reminder of the fragility of life. | In the darkness of the night, %name% walks among the living, a ghostly apparition that lingers on the edge of perception, a whisper in the wind. | Though its mortal form may have perished, %name% endures as a spectral guardian, its ethereal vigil a testament to the enduring power of the human spirit. | Bound by the chains of its own sorrow, %name% wanders the earth as a restless spirit, its ghostly presence a reminder of the depths of despair. | In death, %name% has become a harbinger of whispers and shadows, a silent watcher condemned to roam the earth for all eternity.}"
};

// scripts\skills\backgrounds\ssu_necro_embalmbed_priest.nut
::Mod_Sellswords.Strings.ssu_necro_embalmbed_priest <- {
	Name = "Embalmed Priest",
	BackgroundDescription = "Within the shadowed confines of a long-forgotten temple lay a resplendant figure, its decrepit form draped in tattered vestments and jewellery of a bygone era. The humming of dreadful magics swirl around this spectral figure, though before it can be brought to bear against you, words of power roll of your tongue. Now, your magic has bound its soul to your will, the previous consciousness fading into obscurity like the dimming embers of a forgotten flame.",
	GoodEnding = "As the desert winds whisper tales of forgotten kings and lost tombs, %name% stands sentinel amidst the sands, its form bathed in the golden glow of redemption. With each passing moment, it sheds the shackles of its cursed existence, emerging not as a harbinger of dread, but as a guardian of ancient wisdom and protector of sacred lands. In the annals of time, %name%\'s legacy endures not as a curse to be feared, but as a beacon of hope—a reminder that even in death, the spark of life and love can never truly be extinguished.",
	BadEnding = "%name% continues to wander to a world it no longer recognizes—a realm devoid of the reverence it once commanded. Cursed to wander the earth as a specter of vengeance, it unleashes its wrath upon unsuspecting travelers, sowing chaos and despair with each step. Forever bound by the chains of its own bitterness, %name%\'s legacy is one of sorrow and regret, a cautionary tale of the dangers of clinging to the past at the expense of embracing the present.",
	Tooltip = "Curses the attacker on death",
	Text = "{Where %name% orginally comes from is a mystery - their orginal name has been lost to time or washed away on an ancient gravestone far, far away. | Who this creature one was matters little. They serve and obey. That is all that matters. | This one is marked with cuts and nail marks, and still surprisingly fresh. | Come rain, snow or sandstorm %name% happily goes where they please. A truely free soul in a world of toil and dispair. If the world had more people like %name%, it would be a much better place. | This one is marked with stab wounds and cuts across their whole body. Many of which seem ancient in origin. | %name% is marked with wounds, many of which are fatal but have been carefully stitched shut or cauterized - suggesting that at some point, someone cared for this poor fark after death. Who the caretaker was will forever be a mystery however. | This one seems a little older than most, with barely any forms of battle damage across its carcass. Maybe this one died in a peaceful manner? Such things are rare in this world. | This one bares little evidence of a violent death, save for the noose marks around its throat. | With the rampant war and famile across the land, corpses like %name% turn up in droves these days. Mass graves remain uncovered, graveyards barely watched over. Perfect marketplaces to hone the dark arts. | The war of many names created a treaure trove of unliving recruits for necromancers. %name% is one such product of the conflict, seeminly a little more astute and reactive to orders than the average corpse - not that expectations are set very high or anything... | This one was bound and thrown into a river, however the main cause of death seems to be the dozens of arrows pocked across its body. The work of poachers, bored brigands or a vengeful feud come to an end.}{ Don\'t let the exterior fool you, when fresh game is involved %name% acts with sudden alacrity unbecoming their form. | The presence of anything living will drive this animal into a frenzy, no matter the size. | This corpse also comes with a small satchel of rusted coins, which are going to waste in their current state. You are sure it won\'t miss them anyway... | %name% lazily swings a rusted shortsword around as they plod aimlessly. | %name% is a fitting name, don\'t you think? It captures the struggle of this creature well. | While undead, these creatures are more like wild animals than brutal killers. | You poke %name% on what remains of its arm. It turns to look at you, then moves past you to chase a stray dog. You like this one. | %name% is still covered in clods of earth, sand and what else. This also gives you an idea... | The lifeless stare still takes some getting used to. The harder you look the more it feels like something is still in there. Something still human...} {You wonder how long it would take to teach this corpse to best a knight in battle. On second thoughts you aren\'t sure if you have that much time. | A victim of violence, %name% seems eager to continue the cycle of suffering. Perfect. | While clumsy, this create will make a fine addition to any collector looking to bulk out their macabre hobby. | You get the impression %name% would\'ve been an interesting person to know when they were alive. Oh well. | A victim of murder, lyncing or witchcraft, maybe %name% was just in the wrong place at the wrong time? | %name% almost seems to enjoy their new existance in unlife. | After all, who needs tiring muscles, decent pay and moments of sheer panic? Not this one. | Weathered and beaten, this one will make a fine addition to the collection. | Sometimes you feel guilty to treat these creatures as personal servants.} {Despite everything, the body is willing and the flesh is weak. But you get the impression this won\'t be a problem. | You jokingly hand the corpse a contract, and it looks at the parchment with some familiarity... | While cheap labour, you really hope you don\'t need to scrub out any armour it might end up wearing. | You push %name% and it manages to stay standing, which is more impressive than it sounds by walking corpse standards. | But with sharp teeth like that, who needs weapons? | %name% drops to their knees and attempts to eat the critters crawling in the dirt. This will be a long and fruitful relationship. | If anything, %name% will make a decent pack mule for all the things you don\'t want to carry. | The poor thing looks hungry. | On second thought, maybe %name% isn\'t memorable enough. Surely you can do better...'}"
};

// scripts\skills\backgrounds\ssu_necro_embalmbed_slave.nut
::Mod_Sellswords.Strings.ssu_necro_embalmbed_slave <- {
	Name = "Embalmed Slave",
	BackgroundDescription = "A preserved corpse created using long lost methodology. There are rumours about a terrible curse come their final rest, hopefully that\'s all they are.",
	GoodEnding = "Amidst the crumbling ruins of a forgotten empire, %name% awakens from its slumber, its eyes alight with the fire of ancient knowledge long suppressed. With each step forward, it carries not the weight of curses past, but the wisdom of centuries untold, a beacon guiding lost souls towards the path of enlightenment. In the tapestry of history, %name%\'s story is not one of lamentation, but of triumph—a testament to the resilience of the human spirit to rise from the ashes of oblivion and illuminate the world with the light of understanding.",
	BadEnding = "Freed from its age-old slumber, %name% continues on with a hunger that knows no bounds—a craving not for sustenance, but for the souls of the living. With each victim claimed, it grows stronger, its withered form pulsating with unholy energy. As terror grips the land, %name%\'s name becomes synonymous with fear, its reign of terror casting a shadow over the sands of time for eternity, a grim reminder of the consequences of tampering with forces beyond mortal comprehension.",
	Tooltip = "Curses the attacker on death",
	Text = "{Where %name% orginally comes from is a mystery - their orginal name has been lost to time or washed away on an ancient gravestone far, far away. | Who this creature one was matters little. They serve and obey. That is all that matters. | This one is marked with cuts and nail marks, and still surprisingly fresh. | Come rain, snow or sandstorm %name% happily goes where they please. A truely free soul in a world of toil and dispair. If the world had more people like %name%, it would be a much better place. | This one is marked with stab wounds and cuts across their whole body. Many of which seem ancient in origin. | %name% is marked with wounds, many of which are fatal but have been carefully stitched shut or cauterized - suggesting that at some point, someone cared for this poor fark after death. Who the caretaker was will forever be a mystery however. | This one seems a little older than most, with barely any forms of battle damage across its carcass. Maybe this one died in a peaceful manner? Such things are rare in this world. | This one bares little evidence of a violent death, save for the noose marks around its throat. | With the rampant war and famile across the land, corpses like %name% turn up in droves these days. Mass graves remain uncovered, graveyards barely watched over. Perfect marketplaces to hone the dark arts. | The war of many names created a treaure trove of unliving recruits for necromancers. %name% is one such product of the conflict, seeminly a little more astute and reactive to orders than the average corpse - not that expectations are set very high or anything... | This one was bound and thrown into a river, however the main cause of death seems to be the dozens of arrows pocked across its body. The work of poachers, bored brigands or a vengeful feud come to an end.}{ Don\'t let the exterior fool you, when fresh game is involved %name% acts with sudden alacrity unbecoming their form. | The presence of anything living will drive this animal into a frenzy, no matter the size. | This corpse also comes with a small satchel of rusted coins, which are going to waste in their current state. You are sure it won\'t miss them anyway... | %name% lazily swings a rusted shortsword around as they plod aimlessly. | %name% is a fitting name, don\'t you think? It captures the struggle of this creature well. | While undead, these creatures are more like wild animals than brutal killers. | You poke %name% on what remains of its arm. It turns to look at you, then moves past you to chase a stray dog. You like this one. | %name% is still covered in clods of earth, sand and what else. This also gives you an idea... | The lifeless stare still takes some getting used to. The harder you look the more it feels like something is still in there. Something still human...} {You wonder how long it would take to teach this corpse to best a knight in battle. On second thoughts you aren\'t sure if you have that much time. | A victim of violence, %name% seems eager to continue the cycle of suffering. Perfect. | While clumsy, this create will make a fine addition to any collector looking to bulk out their macabre hobby. | You get the impression %name% would\'ve been an interesting person to know when they were alive. Oh well. | A victim of murder, lyncing or witchcraft, maybe %name% was just in the wrong place at the wrong time? | %name% almost seems to enjoy their new existance in unlife. | After all, who needs tiring muscles, decent pay and moments of sheer panic? Not this one. | Weathered and beaten, this one will make a fine addition to the collection. | Sometimes you feel guilty to treat these creatures as personal servants.} {Despite everything, the body is willing and the flesh is weak. But you get the impression this won\'t be a problem. | You jokingly hand the corpse a contract, and it looks at the parchment with some familiarity... | While cheap labour, you really hope you don\'t need to scrub out any armour it might end up wearing. | You push %name% and it manages to stay standing, which is more impressive than it sounds by walking corpse standards. | But with sharp teeth like that, who needs weapons? | %name% drops to their knees and attempts to eat the critters crawling in the dirt. This will be a long and fruitful relationship. | If anything, %name% will make a decent pack mule for all the things you don\'t want to carry. | The poor thing looks hungry. | On second thought, maybe %name% isn\'t memorable enough. Surely you can do better...'}"
};

// scripts\skills\backgrounds\ssu_necro_embalmbed_soldier.nut
::Mod_Sellswords.Strings.ssu_necro_embalmbed_soldier <- {
	Name = "Embalmed Soldier",
	BackgroundDescription = "Guarding the sacred tombs of antiquity are the rank and file of the Embalmed, their skeletal forms enshrouded in the remnants of ancient armor and wielding weapons long since dulled by time. Legends weave tales of a malevolent curse that lingers upon these spectral sentinels, cursing any who dare defy their eternal vigil.",
	GoodEnding = "As the sands of time settle, %name%, once bound by curses and forgotten by the world, finds redemption in the embrace of light. With each bandage unwound, revealing not the decay of flesh, but the radiance of a soul reborn, it steps forth from the shadows of the tomb into the dawn of a new era. No longer a relic of a bygone age, but a guardian of wisdom and keeper of secrets, %name%\'s journey transcends the confines of mortality, a testament to the enduring power of the human spirit to defy the ravages of time and find eternal peace.",
	BadEnding = "Awoken from its eternal rest by your hands, %name% continued on with a thirst for vengeance burning in its ancient heart. With curses whispered upon the winds, it stalks the descendants of those who disturbed its tomb, wreaking havoc upon their lives with cruel and merciless intent. In the end, %name%\'s wrath knews no bounds, leaving naught but devastation in its wake—a grim testament to the dangers of awakening the wrath of the dead and the folly of tampering with forces beyond mortal ken.",
	Tooltip = "Curses the attacker on death",
	Text = "{Where %name% orginally comes from is a mystery - their orginal name has been lost to time or washed away on an ancient gravestone far, far away. | Who this creature one was matters little. They serve and obey. That is all that matters. | This one is marked with cuts and nail marks, and still surprisingly fresh. | Come rain, snow or sandstorm %name% happily goes where they please. A truely free soul in a world of toil and dispair. If the world had more people like %name%, it would be a much better place. | This one is marked with stab wounds and cuts across their whole body. Many of which seem ancient in origin. | %name% is marked with wounds, many of which are fatal but have been carefully stitched shut or cauterized - suggesting that at some point, someone cared for this poor fark after death. Who the caretaker was will forever be a mystery however. | This one seems a little older than most, with barely any forms of battle damage across its carcass. Maybe this one died in a peaceful manner? Such things are rare in this world. | This one bares little evidence of a violent death, save for the noose marks around its throat. | With the rampant war and famile across the land, corpses like %name% turn up in droves these days. Mass graves remain uncovered, graveyards barely watched over. Perfect marketplaces to hone the dark arts. | The war of many names created a treaure trove of unliving recruits for necromancers. %name% is one such product of the conflict, seeminly a little more astute and reactive to orders than the average corpse - not that expectations are set very high or anything... | This one was bound and thrown into a river, however the main cause of death seems to be the dozens of arrows pocked across its body. The work of poachers, bored brigands or a vengeful feud come to an end.}{ Don\'t let the exterior fool you, when fresh game is involved %name% acts with sudden alacrity unbecoming their form. | The presence of anything living will drive this animal into a frenzy, no matter the size. | This corpse also comes with a small satchel of rusted coins, which are going to waste in their current state. You are sure it won\'t miss them anyway... | %name% lazily swings a rusted shortsword around as they plod aimlessly. | %name% is a fitting name, don\'t you think? It captures the struggle of this creature well. | While undead, these creatures are more like wild animals than brutal killers. | You poke %name% on what remains of its arm. It turns to look at you, then moves past you to chase a stray dog. You like this one. | %name% is still covered in clods of earth, sand and what else. This also gives you an idea... | The lifeless stare still takes some getting used to. The harder you look the more it feels like something is still in there. Something still human...} {You wonder how long it would take to teach this corpse to best a knight in battle. On second thoughts you aren\'t sure if you have that much time. | A victim of violence, %name% seems eager to continue the cycle of suffering. Perfect. | While clumsy, this create will make a fine addition to any collector looking to bulk out their macabre hobby. | You get the impression %name% would\'ve been an interesting person to know when they were alive. Oh well. | A victim of murder, lyncing or witchcraft, maybe %name% was just in the wrong place at the wrong time? | %name% almost seems to enjoy their new existance in unlife. | After all, who needs tiring muscles, decent pay and moments of sheer panic? Not this one. | Weathered and beaten, this one will make a fine addition to the collection. | Sometimes you feel guilty to treat these creatures as personal servants.} {Despite everything, the body is willing and the flesh is weak. But you get the impression this won\'t be a problem. | You jokingly hand the corpse a contract, and it looks at the parchment with some familiarity... | While cheap labour, you really hope you don\'t need to scrub out any armour it might end up wearing. | You push %name% and it manages to stay standing, which is more impressive than it sounds by walking corpse standards. | But with sharp teeth like that, who needs weapons? | %name% drops to their knees and attempts to eat the critters crawling in the dirt. This will be a long and fruitful relationship. | If anything, %name% will make a decent pack mule for all the things you don\'t want to carry. | The poor thing looks hungry. | On second thought, maybe %name% isn\'t memorable enough. Surely you can do better...'}"
};

// scripts\skills\backgrounds\ssu_necro_fallen_hero.nut
::Mod_Sellswords.Strings.ssu_necro_fallen_hero <- {
	Name = "Fallen Hero",
	BackgroundDescription = "Once a valiant knight sworn to defend their house, Fallen Heroes are victim to a dark magic that twisted their noble spirit into something unholy. Bound by your will, it now roams the land clad in tarnished armor, a haunting echo of its former self. Though memories of its past life linger in the recesses of its decayed mind, the reanimated knight is driven by an insatiable hunger for flesh, forever torn between its lingering sense of duty and the primal urges now given.",
	GoodEnding = "Despite its cursed existence, %name% found redemption in an unexpected act of heroism. In a pivotal moment of clarity, memories of its former life as a noble knight flooded back, stirring a long-forgotten sense of duty and honor. With newfound purpose, %name% valiantly defended a village besieged by Greenskins, laying down its undead life to protect the innocent. In the aftermath, its soul found peace, released from the shackles of undeath as a reward for its selfless sacrifice.",
	BadEnding = "Consumed by the insatiable hunger that gnawed at its rotting flesh, %name% descended further into darkness, its once-glorious armor now tarnished by decay and despair. With each passing day, its mind grew more clouded, driven solely by the primal urge to feed on the living. In a twisted parody of its former chivalry, %name% became a terror on the battlefield, slaughtering indiscriminately in a futile attempt to satiate its endless hunger. Hunted by those it once swore to protect, %name% met its end in a blaze of glory, its legacy forever tainted by the darkness that consumed it.",
	Text = "{Where %name% orginally comes from is a mystery - their orginal name has been lost to time or washed away on an ancient gravestone far, far away. | Who this creature one was matters little. They serve and obey. That is all that matters. | This one is marked with cuts and nail marks, and still surprisingly fresh. | Come rain, snow or sandstorm %name% happily goes where they please. A truely free soul in a world of toil and dispair. If the world had more people like %name%, it would be a much better place. | This one is marked with stab wounds and cuts across their whole body. Many of which seem ancient in origin. | %name% is marked with wounds, many of which are fatal but have been carefully stitched shut or cauterized - suggesting that at some point, someone cared for this poor fark after death. Who the caretaker was will forever be a mystery however. | This one seems a little older than most, with barely any forms of battle damage across its carcass. Maybe this one died in a peaceful manner? Such things are rare in this world. | This one bares little evidence of a violent death, save for the noose marks around its throat. | With the rampant war and famile across the land, corpses like %name% turn up in droves these days. Mass graves remain uncovered, graveyards barely watched over. Perfect marketplaces to hone the dark arts. | The war of many names created a treaure trove of unliving recruits for necromancers. %name% is one such product of the conflict, seeminly a little more astute and reactive to orders than the average corpse - not that expectations are set very high or anything... | This one was bound and thrown into a river, however the main cause of death seems to be the dozens of arrows pocked across its body. The work of poachers, bored brigands or a vengeful feud come to an end.}{ Don\'t let the exterior fool you, when fresh game is involved %name% acts with sudden alacrity unbecoming their form. | The presence of anything living will drive this animal into a frenzy, no matter the size. | This corpse also comes with a small satchel of rusted coins, which are going to waste in their current state. You are sure it won\'t miss them anyway... | %name% lazily swings a rusted shortsword around as they plod aimlessly. | %name% is a fitting name, don\'t you think? It captures the struggle of this creature well. | While undead, these creatures are more like wild animals than brutal killers. | You poke %name% on what remains of its arm. It turns to look at you, then moves past you to chase a stray dog. You like this one. | %name% is still covered in clods of earth, sand and what else. This also gives you an idea... | The lifeless stare still takes some getting used to. The harder you look the more it feels like something is still in there. Something still human...} {You wonder how long it would take to teach this corpse to best a knight in battle. On second thoughts you aren\'t sure if you have that much time. | A victim of violence, %name% seems eager to continue the cycle of suffering. Perfect. | While clumsy, this create will make a fine addition to any collector looking to bulk out their macabre hobby. | You get the impression %name% would\'ve been an interesting person to know when they were alive. Oh well. | A victim of murder, lyncing or witchcraft, maybe %name% was just in the wrong place at the wrong time? | %name% almost seems to enjoy their new existance in unlife. | After all, who needs tiring muscles, decent pay and moments of sheer panic? Not this one. | Weathered and beaten, this one will make a fine addition to the collection. | Sometimes you feel guilty to treat these creatures as personal servants.} {Despite everything, the body is willing and the flesh is weak. But you get the impression this won\'t be a problem. | You jokingly hand the corpse a contract, and it looks at the parchment with some familiarity... | While cheap labour, you really hope you don\'t need to scrub out any armour it might end up wearing. | You push %name% and it manages to stay standing, which is more impressive than it sounds by walking corpse standards. | But with sharp teeth like that, who needs weapons? | %name% drops to their knees and attempts to eat the critters crawling in the dirt. This will be a long and fruitful relationship. | If anything, %name% will make a decent pack mule for all the things you don\'t want to carry. | The poor thing looks hungry. | On second thought, maybe %name% isn\'t memorable enough. Surely you can do better...'}"
};

// scripts\skills\backgrounds\ssu_necro_ghost.nut
::Mod_Sellswords.Strings.ssu_necro_ghost <- {
	Name = "Geist",
	BackgroundDescription = "Lingering between the realms of the living and the dead, Geists are spirits bound to the mortal realm by unfinished business or unresolved emotions. Often appearing as ethereal apparitions, they retain a connection to the world they once inhabited, haunting the places of their past or the individuals tied to their fate.",
	GoodEnding = "Guided by the gentle whispers of benevolent spirits, %name% embarked on a journey of self-discovery and enlightenment. Through acts of kindness and compassion, it learned to transcend the pain of its past and embrace the boundless possibilities of the afterlife. As it ascended to a realm of eternal peace and serenity, %name% became a beacon of hope for lost souls, offering guidance and solace to those who still wandered the mortal realm. In the annals of eternity, its presence shone as a testament to the enduring power of love and compassion to overcome the trials of existence.",
	BadEnding = "Trapped in a realm between the living and the dead, %name% lingers in eternal torment, its spectral form twisted by the weight of unresolved anguish. Haunting the halls of its former abode, it became a malevolent force, feeding off the fear it instills in the hearts of the living. As its presence grew more malevolent with each passing day, %name%\'s legacy became one of perpetual despair, a grim reminder of the dangers of lingering in the realm of the living long after one's time has passed.",
	Text = "{Once a lost soul wandering the misty realms between worlds, %name% now serves as a spectral sentinel, forever bound to this earthly plane by an ancient curse. | The true identity of %name% remains shrouded in the whispers of the beyond, lost amidst the echoes of forgotten tombs and forgotten lives. | This ethereal entity bears the scars of a violent demise, its spectral form forever haunted by the echoes of its untimely end. | Despite its otherworldly nature, %name% moves with an eerie grace, its ghostly form gliding silently through the shadows. | In the realm of the living, %name% is a silent watcher, its ghostly presence barely perceptible as it drifts through the mortal world. | Beneath its translucent veil, %name% harbors a boundless hunger, its spectral essence yearning for the warmth of life that it can never again possess.}{ Though death has claimed its mortal frame, %name% lingers on, an ethereal remnant of a life long past. | Trapped between realms, %name% exists in a state of perpetual unrest, forever tormented by the memories of its former existence. | In death, %name% has become a harbinger of whispers and shadows, a spectral guardian of secrets lost to the sands of time. | From the shadowy depths of forgotten crypts, %name% emerges as a specter of the night, its form bound to this world by ancient sorceries. | Lost to the annals of history, %name% drifts through the veil between worlds, a ghostly remnant of a bygone era. | In the darkness of the tomb, %name% found its eternal rest disturbed, condemned to wander the mortal realm as a restless spirit.}{ Though its corporeal form may have faded, %name% endures as a spectral wraith, its ethereal presence haunting the desolate halls of its final resting place. | In death, %name% has become an echo of the past, a ghostly apparition doomed to forever roam the earth in search of peace. | Bound by the chains of its own sorrow, %name% wanders the haunted corridors of the world, a ghostly visage forever trapped in the grip of its own torment. | Driven by a thirst for vengeance or perhaps a longing for closure, %name% roams the earth as a restless spirit, its ethereal form a testament to the fragility of mortal life. | In the stillness of the night, %name% walks among the living, a ghostly presence that lingers on the edge of perception, a whisper in the darkness. | Though it may be forgotten by the passage of time, %name% endures as a spectral guardian, its silent vigil a testament to the enduring power of the human spirit. | Once a soul lost to the depths of the underworld, %name% now wanders the mortal realm as a spectral remnant of its former self. | Forgotten by time, %name% exists as a shadowy echo of the past, its ethereal form a haunting reminder of lives long gone. | In death, %name% found neither rest nor solace, condemned to wander the earth as a restless spirit bound by the chains of its own sorrow.}{ Drifting through the veil between worlds, %name% is a silent watcher, its ghostly form a fleeting glimpse of a world beyond mortal comprehension. | Haunted by the memories of its former existence, %name% exists in a state of perpetual unrest, its ethereal presence a haunting reminder of the fragility of life. | In the darkness of the night, %name% walks among the living, a ghostly apparition that lingers on the edge of perception, a whisper in the wind. | Though its mortal form may have perished, %name% endures as a spectral guardian, its ethereal vigil a testament to the enduring power of the human spirit. | Bound by the chains of its own sorrow, %name% wanders the earth as a restless spirit, its ghostly presence a reminder of the depths of despair. | In death, %name% has become a harbinger of whispers and shadows, a silent watcher condemned to roam the earth for all eternity.}"
};

// scripts\skills\backgrounds\ssu_necro_lorekeeper.nut
::Mod_Sellswords.Strings.ssu_necro_lorekeeper <- {
	Name = "Lorekeeper",
	BackgroundDescription = "Once a respected librarian in a grand archive of knowledge, the Lorekeeper\'s existence was forever changed by a dark and ancient curse. In life, they were known for their insatiable thirst for knowledge and their unwavering dedication to preserving the accumulated wisdom of ages past. However, their obsession with forbidden tomes and arcane secrets led them down a path of no return.",
	GoodEnding = "Driven by their insatiable thirst for forbidden knowledge, %name% delved deeper into the darkest recesses of their buried library, relentlessly seeking to uncover the secrets of ultimate power. They became consumed by their obsession, heedless of the slippery slope that they were heading down. In their reckless pursuit, the Lorekeeper unwittingly stumbled upon a forbidden ritual hidden within the depths of the library\'s archives. Blinded by ambition, %name% attempted to harness the dark power, believing it would grant them the mastery they so desperately sought over undeath.",
	BadEnding = "In a climactic battle, %name% fought valiantly against those it swore to destroy, but they were ultimately overwhelmed by the sheer power of the opposing force. In their final moments, they made a desperate sacrifice, consuming themselves and the malevolent force within, hoping to at least destroy those allied against them. As the dust settled and the echoes of battle faded, %name% was nowhere to be seen, their body turned to dust. The price of their hubris. Though their name may fade into obscurity, the eventual end served as a warning to future generations of the dangers that come with unchecked ambition and the pursuit of forbidden knowledge.",
	Titles = [ "the Lorekeeper" ],
	Tooltip1 = "[color=%positive%]+25%[/color] Experience Gain",
	Tooltip2 = "Makes an Ancient Scroll every 10 days if your stash has space",
	Tooltip3 = "Summon Screaming Skulls at the start of each turn. The amount summoned is equal to [color=%positive%]25%[/color] of your level.",
	Tooltip4 = "The Screaming Skulls gain Hitpoints equal to the Lorekeeper\'s Resolve and deal damage on death equal to [color=%positive%]60-80%[/color] of their current Hitpoints.",
	Text = "{Once a respected librarian in a grand archive of knowledge, %name%\'s existence was forever changed by a dark and ancient curse. In life, they were known for their insatiable thirst for knowledge and their unwavering dedication to preserving the accumulated wisdom of ages past. However, their obsession with forbidden tomes and arcane secrets led them down a path of no return.}"
};

// scripts\skills\backgrounds\ssu_necro_necrosavant.nut
::Mod_Sellswords.Strings.ssu_necro_necrosavant <- {
	Name = "Necrosavant",
	BackgroundDescription = "In the forbidden depths of ancient tombs and cursed crypts, lurks the necrosavant, a dark and sinister entity born from the forbidden arts of necromancy. Once a mortal practitioner of dark magic, the necrosavant embraced the forbidden knowledge of raising the dead, seeking to defy the natural order and wield power over life and death itself. Through dark rituals and unholy pacts, it became an undead abomination that only survives by feasting on the blood of the living.",
	GoodEnding = "After years of delving into dark magic and necromancy, %name% found redemption in a moment of clarity and remorse. Faced with the consequences of its twisted ambitions and the suffering it had caused, the necrosavant renounced its dark practices and sought to atone for its sins. Through acts of selflessness and compassion, it used its remaining powers to undo the harm it had wrought, restoring balance to the forces of life and death. In the end, the necrosavant sacrificed its own existence to ensure that no more harm would come from its dark arts, leaving behind a legacy of redemption and forgiveness.",
	BadEnding = "Consumed by their insatiable thirst for blood, %name% descended further into darkness, heedless of the destruction it left in its wake. With each soul it ate and every corpse they devoured, its twisted ambitions grew ever more depraved, leaving a trail of death and despair in its wake. As their influence spread, %name% became a feared tyrant, ruling over a kingdom of the undead with an iron fist. In the end, %name%\'s lust for power consumed it entirely, leaving behind nothing but a desolate wasteland where only darkness reigned supreme.",
	Titles = [ "the Brutal", "the Gruesome", "the Bloody", "the Vile", "The Leech", "the Bat" ],
	Text = "{Clothed in strange black robes, %name% appears to be more of an ambassador of the dark than a man of flesh and blood. | A curious fellow, %name% carries a slumped posture, as if he is weighted by otherworldly knowledge. | %name%\'s face is hidden well inside the dark of his cowl, a crescent of yellow teeth the only notion that a man dwells within. | Not much is known about %name%, but strange rumors of sorcery and dark arts follow him. | Wherever animals mysteriously begin to die, %name% makes an appearance. | The brooches on %name%\'s cloak seem to swirl and dance like midnight in a jug. | %name%\'s hands are rare to see, only coming out as if to portray the feelings of his face which lies hidden deep in his hood. | %name%\'s eyes could be mistaken for a cat\'s one day and for a blind man\'s the next.} {Little is known about whence he came. | From where he hails is but a mystery to most. | Some say he traveled deep into the northern foothills, returning with unspoken knowledge. | Ostensibly, the dark arts are his heritage, or so he puts on. | The man\'s past is kept from all. Maybe it\'s just uninteresting, or maybe just the opposite. | One rumor of the man says he traveled the land as a magician. | Rumors of magic surround the man, though some incredulous cynics are hardly impressed. | One rumor is that he was a conman, and another is that he\'s a sorcerer. You\'re not sure which you prefer. | With rumors of dark arts being practiced once more, the man\'s magical proclamation just might be true. | Some say he eats toads for breakfast and black cats for dinner.} {You ask %name% a lot of questions, but through some handwaves and nods, you realize you have forgotten his answers. Or did you ask the questions at all? | %name% produces a dove from his sleeve. An old trick that fancies no one - until it turns in the air, returning to him as a crow. | %name% has shown the ability to shoot smoke from his mouth. It\'s not fire, but it\'s close, and has people talking in hushed tones. | %name% floats a gold coin into the air. An amazing display that leaves the man too tired to attempt it again. | Predictions of the weather are common, but %name% is unusually accurate with his own. | %name% asks to read your palms. You decline. His presence alone is as close as you\'re willing to go. | %name% suggests that the stars are a roadmap to another world. He seems to know a lot about the heavens above. | %name% suggests that the heavens above are in fact just endless streams of beings, continuing on for eons. What a jest! | %name% points to one star in the sky and seems to suggest that is where he came from. You don\'t ask for a clarification on the matter.}"
};

// scripts\skills\backgrounds\ssu_necro_skeledog.nut
::Mod_Sellswords.Strings.ssu_necro_skeledog <- {
	Name = "Höllenhund",
	BackgroundDescription = "In the outskirts of unfortunate villages prowls the Höllenhund. Its skeletal frame, adorned with remnants of decaying flesh and jagged bone, exudes an aura of malevolence and dread. With glowing eyes that pierce through the shadows, it traverses the nearby surroundings, ever vigilant in its hunt for lost souls and wayward spirits. It\'s definitely a good boy!",
	GoodEnding = "In the heart of a nearby battlesite, %name%, found redemption in an unexpected act of compassion. Moved by the plight of a lost soul, it offered guidance and protection, leading the wayward spirit towards the light of salvation. As %name% escorted the soul to its final rest, a profound sense of peace washed over it, dispelling the darkness and illuminating the path to redemption. Transformed by its selfless act, %name% was granted absolution, its spectral form fading into the ether as it found peace in the knowledge that it had helped a soul find its way home.",
	BadEnding = "Consumed by the darkness inside it\'s soul, %name% succumbed to the allure of those primal instincts, becoming a relentless predator of lost souls and wayward spirits. With each passing moment, its hunger for power grew insatiable, driving it to unleash chaos and destruction upon the realm. As %name%\'s reign of terror spread, fear gripped the hearts of all who dwelled in the country, their cries of anguish echoing through the shadows as they fell prey to the relentless hunter. In the end, the %name% became a malevolent force of darkness, forever condemned to roam the world as a harbinger of doom and despair.",
	Text = "{Where %name% originally comes from is a mystery - their orginal name has been lost to time or washed away on an ancient gravestone far, far away. | Who this creature one was matters little. They serve and obey. That is all that matters. | This one is marked with cuts and nail marks, and still surprisingly fresh. | Come rain, snow or sandstorm %name% happily goes where they please. A truely free soul in a world of toil and dispair. If the world had more people like %name%, it would be a much better place. | This one is marked with stab wounds and cuts across their whole body. Many of which seem ancient in origin. | %name% is marked with wounds, many of which are fatal but have been carefully stitched shut or cauterized - suggesting that at some point, someone cared for this poor fark after death. Who the caretaker was will forever be a mystery however. | This one seems a little older than most, with barely any forms of battle damage across its carcass. Maybe this one died in a peaceful manner? Such things are rare in this world. | This one bares little evidence of a violent death, save for the noose marks around its throat. | With the rampant war and famile across the land, corpses like %name% turn up in droves these days. Mass graves remain uncovered, graveyards barely watched over. Perfect marketplaces to hone the dark arts. | The war of many names created a treaure trove of unliving recruits for necromancers. %name% is one such product of the conflict, seeminly a little more astute and reactive to orders than the average corpse - not that expectations are set very high or anything... | This one was bound and thrown into a river, however the main cause of death seems to be the dozens of arrows pocked across its body. The work of poachers, bored brigands or a vengeful feud come to an end.}{ Don\'t let the exterior fool you, when fresh game is involved %name% acts with sudden alacrity unbecoming their form. | The presence of anything living will drive this animal into a frenzy, no matter the size. | This corpse also comes with a small satchel of rusted coins, which are going to waste in their current state. You are sure it won\'t miss them anyway... | %name% lazily swings a rusted shortsword around as they plod aimlessly. | %name% is a fitting name, don\'t you think? It captures the struggle of this creature well. | While undead, these creatures are more like wild animals than brutal killers. | You poke %name% on what remains of its arm. It turns to look at you, then moves past you to chase a stray dog. You like this one. | %name% is still covered in clods of earth, sand and what else. This also gives you an idea... | The lifeless stare still takes some getting used to. The harder you look the more it feels like something is still in there. Something still human...} {You wonder how long it would take to teach this corpse to best a knight in battle. On second thoughts you aren\'t sure if you have that much time. | A victim of violence, %name% seems eager to continue the cycle of suffering. Perfect. | While clumsy, this create will make a fine addition to any collector looking to bulk out their macabre hobby. | You get the impression %name% would\'ve been an interesting person to know when they were alive. Oh well. | A victim of murder, lyncing or witchcraft, maybe %name% was just in the wrong place at the wrong time? | %name% almost seems to enjoy their new existance in unlife. | After all, who needs tiring muscles, decent pay and moments of sheer panic? Not this one. | Weathered and beaten, this one will make a fine addition to the collection. | Sometimes you feel guilty to treat these creatures as personal servants.} {Despite everything, the body is willing and the flesh is weak. But you get the impression this won\'t be a problem. | You jokingly hand the corpse a contract, and it looks at the parchment with some familiarity... | While cheap labour, you really hope you don\'t need to scrub out any armour it might end up wearing. | You push %name% and it manages to stay standing, which is more impressive than it sounds by walking corpse standards. | But with sharp teeth like that, who needs weapons? | %name% drops to their knees and attempts to eat the critters crawling in the dirt. This will be a long and fruitful relationship. | If anything, %name% will make a decent pack mule for all the things you don\'t want to carry. | The poor thing looks hungry. | On second thought, maybe %name% isn\'t memorable enough. Surely you can do better...'}"
};

// scripts\skills\backgrounds\ssu_necro_zombie.nut
::Mod_Sellswords.Strings.ssu_necro_zombie <- {
	Name = "Wiederganger",
	BackgroundDescription = "A corpse in varying forms of decay. While slow on the uptake, it makes for a frightning opponent to most. You can also pick any name you like!",
	GoodEnding = "Despite its undead nature, %name% experienced a flicker of humanity amidst the decay and despair. Through a series of unlikely events, it formed a connection with a compassionate individual who saw beyond its rotting exterior. Through patience and kindness, this person helped %name% regain fragments of its former self, reminding it of the warmth of friendship and the value of empathy. In time, the zombie's violent urges waned, replaced by a sense of purpose and belonging. Together with its newfound friend, %name% embarked on a journey of redemption, seeking to make amends for the harm it caused in its mindless state.",
	BadEnding = "There is no beginning or end for %name%. Like any feral animal, they simply wander around—occasionally following hordes of like-minded dead, continually being adopted by new masters, slain, only to rise again and wander some more. %name% repeats this cycle until one day the blow will be fatal. Is this a curse or a blessing? To cheat death in such a manner, many would kill for. But %name% does not care. There is only hunger.",
	Text = "{Where %name% orginally comes from is a mystery - their orginal name has been lost to time or washed away on an ancient gravestone far, far away. | Who this creature one was matters little. They serve and obey. That is all that matters. | This one is marked with cuts and nail marks, and still surprisingly fresh. | Come rain, snow or sandstorm %name% happily goes where they please. A truely free soul in a world of toil and dispair. If the world had more people like %name%, it would be a much better place. | This one is marked with stab wounds and cuts across their whole body. Many of which seem ancient in origin. | %name% is marked with wounds, many of which are fatal but have been carefully stitched shut or cauterized - suggesting that at some point, someone cared for this poor fark after death. Who the caretaker was will forever be a mystery however. | This one seems a little older than most, with barely any forms of battle damage across its carcass. Maybe this one died in a peaceful manner? Such things are rare in this world. | This one bares little evidence of a violent death, save for the noose marks around its throat. | With the rampant war and famile across the land, corpses like %name% turn up in droves these days. Mass graves remain uncovered, graveyards barely watched over. Perfect marketplaces to hone the dark arts. | The war of many names created a treaure trove of unliving recruits for necromancers. %name% is one such product of the conflict, seeminly a little more astute and reactive to orders than the average corpse - not that expectations are set very high or anything... | This one was bound and thrown into a river, however the main cause of death seems to be the dozens of arrows pocked across its body. The work of poachers, bored brigands or a vengeful feud come to an end.}{ Don\'t let the exterior fool you, when fresh game is involved %name% acts with sudden alacrity unbecoming their form. | The presence of anything living will drive this animal into a frenzy, no matter the size. | This corpse also comes with a small satchel of rusted coins, which are going to waste in their current state. You are sure it won\'t miss them anyway... | %name% lazily swings a rusted shortsword around as they plod aimlessly. | %name% is a fitting name, don\'t you think? It captures the struggle of this creature well. | While undead, these creatures are more like wild animals than brutal killers. | You poke %name% on what remains of its arm. It turns to look at you, then moves past you to chase a stray dog. You like this one. | %name% is still covered in clods of earth, sand and what else. This also gives you an idea... | The lifeless stare still takes some getting used to. The harder you look the more it feels like something is still in there. Something still human...} {You wonder how long it would take to teach this corpse to best a knight in battle. On second thoughts you aren\'t sure if you have that much time. | A victim of violence, %name% seems eager to continue the cycle of suffering. Perfect. | While clumsy, this create will make a fine addition to any collector looking to bulk out their macabre hobby. | You get the impression %name% would\'ve been an interesting person to know when they were alive. Oh well. | A victim of murder, lyncing or witchcraft, maybe %name% was just in the wrong place at the wrong time? | %name% almost seems to enjoy their new existance in unlife. | After all, who needs tiring muscles, decent pay and moments of sheer panic? Not this one. | Weathered and beaten, this one will make a fine addition to the collection. | Sometimes you feel guilty to treat these creatures as personal servants.} {Despite everything, the body is willing and the flesh is weak. But you get the impression this won\'t be a problem. | You jokingly hand the corpse a contract, and it looks at the parchment with some familiarity... | While cheap labour, you really hope you don\'t need to scrub out any armour it might end up wearing. | You push %name% and it manages to stay standing, which is more impressive than it sounds by walking corpse standards. | But with sharp teeth like that, who needs weapons? | %name% drops to their knees and attempts to eat the critters crawling in the dirt. This will be a long and fruitful relationship. | If anything, %name% will make a decent pack mule for all the things you don\'t want to carry. | The poor thing looks hungry. | On second thought, maybe %name% isn\'t memorable enough. Surely you can do better...'}"
};

// scripts\skills\backgrounds\ssu_sellsword_background.nut
::Mod_Sellswords.Strings.ssu_sellsword_background <- {
	Name = "Veteran Sellsword",
	BackgroundDescription = "Sellswords are expensive, but a life of warfare has forged them into skilled fighters.",
	GoodEnding = "%name% the sellsword left the %companyname% and started his own mercenary company. As far as you know, it\'s a very successful venture and he often buddies up with the men of the %companyname% to work together.",
	BadEnding = "%name% left the %companyname% and started his own competing company. The two companies clashed on opposite sides of a battle between nobles. The sellsword died when a mercenary from the %companyname% stove his head in with a hedge knight\'s helmet.",
	Text = "{%fullname%\'s worked as a sellsword since his father handed down his equipment. | %fullname% can\'t remember a time when he wasn\'t a sword for hire. | As a mercenary, %fullname% has never had to look long for work. | The literate talk about letting loose the dogs of war. %fullname% is one such hound. | In war, there is death and profit. %fullname% causes the former to earn the latter. | There has never been a better time for mercenaries like %name% to earn a crown or two. | After his wife ran off with his children, an angry %name% made a steady career as a nasty sellsword. | A decade ago %name% lost everything in a fire. He\'s been working as a sellsword ever since. | %name% always had the mind for violence and has pursued a long career as a sellsword. | Once dirt poor, %name% has earned a very tidy sum over the years as a sellsword. | %fullname% prefers to keep for himself whence he came, but his reputation as a sword for hire speaks for itself.} {Well experienced, he has traveled in the company of many outfits in his time. | Military campaigns are but notches in his belt. | From work as a lord\'s bodyguard to being an enforcer for a skeevy merchant, %name% has seen it all. | He once made a living off slaying the wild beasts that encroach on human settlements. | With a grim grin, he boasts he has slain all manner of living creatures. | Through plenty of use, the mercenary has learned a thing or two about weapons you didn\'t even know existed. | The sellsword is counting how many he has slain to this day and he appears to not be stopping any time soon. | With a sword and shield in hand, the mercenary appears to do what he does best for a living.} {The man is no stranger to the fields of battle. | The man is no stranger to the cruelties of war. | He is used to the harsh realities of mercenary life. | He is said to be a reliable cog in any shield wall. | Some say he can hold a battle line as well as an oak tree. | Rumors abound that the man enjoys the sight of blood. | Without shame, he takes an uneasy pleasure in the misery of others on the battlefield. | Strangely, he seldom joins others around the campfire, instead keeping to himself. | The man loves to tell a good tale about how he killed this thing or that. | Given a chance, the man is quick to showcase a wide variety of fighting styles.} {As long as you have the coin, %name% is yours to command. | A true mercenary, %name% will fight anyone for the right price. | Displaying some fine swordsmanship, %name% says he can run any man through. | With but a hint of a nod, %name% agrees to join you if you have the crowns. | Excited for an opportunity to earn coin, %name% knocks his mug on the table.}"
};

// scripts\skills\effects\ssu_acid_effect_strong.nut
::Mod_Sellswords.Strings.ssu_acid_effect_strong <- {
	Name = "Sprayed with Acid",
	Text = "This character\'s armor has been sprayed with a Stollwurm\'s acidic blood, which is now slowly eating away at it for another [color=%negative%]{1}[/color] turn(s).",
	Tooltip1 = "[color=%negative%]25%[/color] of head armor is lost each turn",
	Tooltip2 = "[color=%negative%]25%[/color] of body armor is lost each turn",
	Log = "{1}\'s body has been sprayed with acid"
};

// scripts\skills\effects\ssu_adrenaline_consequential_effect.nut
::Mod_Sellswords.Strings.ssu_adrenaline_consequential_effect <- {
	Name = "Irresistible Impulse",
	Text = "Go, go, go! This character has an adrenaline rush and will present destructive power.",
	Tooltip1 = "[color=%positive%] +5 [/color] Melee Skill",
	Tooltip2 = "[color=%positive%] +5% [/color] Damage",
	Tooltip3 = "[color=%positive%]6[/color] Fatigue Recovery",
	Tooltip4 = "Makes enemies [color=%positive%]25%[/color] more likely to target you"
};

// scripts\skills\effects\ssu_alp_sequence_effect.nut
::Mod_Sellswords.Strings.ssu_alp_sequence_effect <- {
	Name = "Sequence: Alp",
	Description = "This character\'s eyes have mutated to see through the night as if it were day, and their skin stitches itself back together around small puncture wounds.",
	Weak = [
		"Enhanced Eye Rods: Not affected by nighttime penalties\n[color=%positive%]+1[/color] Vision",
		"Subdermal Stitching: Takes [color=%positive%]25%[/color] less damage from piercing melee attacks and [color=%positive%]50%[/color] less from piercing ranged attacks\n[color=%positive%]+10[/color] Hitpoints"
	],
	Strong = [
		"Levitate: Floats just above the ground, moving freely across all terrain",
		"Horrify: Can blare out a piercing, unworldly sound that distresses anyone unfortunate enough to hear it"
	]
};

// scripts\skills\effects\ssu_armor_fatigue_recovery_effect.nut
::Mod_Sellswords.Strings.ssu_armor_fatigue_recovery_effect <- {
	Name = "Encumbrance",
	Description = "This character\'s armor\'s weight is reducing %their% Fatigue Recovery and Flexibility, in exchange for better protection",
	Text = "{1}[color=%negative%] ({2}[/color]  [color=%positive%]{3}[/color][color=%negative%])[/color]",
	Tooltip1 = "Reduces all damage that ignores armor by [color=%positive%]{1}%[/color].",
	Tooltip2 = "[color=%negative%]-{1}[/color] Fatigue Recovery per turn.",
	Tooltip3 = "[color=%negative%]-{1}[/color] Melee Skill.",
	Tooltip4 = "[color=%negative%]-{1}[/color] Ranged Skill.",
	Tooltip5 = "[color=%negative%]-{1}[/color] Melee Defense.",
	Tooltip6 = "[color=%negative%]-{1}[/color] Ranged Defense."
};

// scripts\skills\effects\ssu_bandage_effect.nut
::Mod_Sellswords.Strings.ssu_bandage_effect <- {
	Name = "Bandaged"
};

// scripts\skills\effects\ssu_basilisk_sequence_effect.nut
::Mod_Sellswords.Strings.ssu_basilisk_sequence_effect <- {
	Name = "Sequence: Basilisk",
	Description = "This character strikes the way a Basilisk pecks: for the eyes, every time.",
	Weak = [
		"Pecking Order: [color=%positive%]+10%[/color] chance to hit the head",
		"Skull Splitter: [color=%positive%]+15%[/color] damage on hits to the head"
	],
	Strong = [
		"Sentry: A further [color=%positive%]+10%[/color] chance to hit the head and [color=%positive%]+15%[/color] damage on hits to the head",
		"Piercing Beak: Hits to the head ignore an additional [color=%positive%]10%[/color] of armor"
	]
};

// scripts\skills\effects\ssu_bleeding_arrows_effect.nut
::Mod_Sellswords.Strings.ssu_bleeding_arrows_effect <- {
	Tooltip = "Inflicts a bleed on the target that does 10 damage per turn, for 2 turns",
	Log = "{1} is bleeding"
};

// scripts\skills\effects\ssu_bolstered_effect.nut
::Mod_Sellswords.Strings.ssu_bolstered_effect <- {
	Name = "Bolstered",
	Description = "This character is feeling bolstered thanks to the shield of an adjacent ally.",
	Tooltip1 = "[color=%positive%]+{1}[/color] Initiative",
	Tooltip2 = "[color=%positive%]+{1}[/color] Melee Defense",
	Tooltip3 = "[color=%positive%]+{1}[/color] Ranged Defense",
	Tooltip4 = "[color=%positive%]+{1}[/color] Block"
};

// scripts\skills\effects\ssu_bone_cleaver_effect.nut
::Mod_Sellswords.Strings.ssu_bone_cleaver_effect <- {
	Log = "{1} heals for {2} points"
};

// scripts\skills\effects\ssu_clarity_effect.nut
::Mod_Sellswords.Strings.ssu_clarity_effect <- {
	Name = "Clarity",
	Tooltip1 = "[color=%positive%]+{1}[/color] Action Points",
	Tooltip2 = "[color=%positive%]+{1}[/color] Action Point"
};

// scripts\skills\effects\ssu_clarity_effect_permanent.nut
::Mod_Sellswords.Strings.ssu_clarity_effect_permanent <- {
	Name = "Clarity",
	Tooltip = "[color=%positive%]+{1}[/color] Action Point"
};

// scripts\skills\effects\ssu_consecrated_effect.nut
::Mod_Sellswords.Strings.ssu_consecrated_effect <- {
	Name = "Consecrated",
	Description = "This character is being consecrated by holy light",
	Tooltip = "Seared by holy light for [color=%negative%]{1}[/color] more turns. Skeletons lose [color=%negative%]1[/color] Action Point while it lasts."
};

// scripts\skills\effects\ssu_direwolf_sequence_effect.nut
::Mod_Sellswords.Strings.ssu_direwolf_sequence_effect <- {
	Name = "Sequence: Direwolf",
	Description = "This character has the sinews and the bloodlust of a Direwolf. Their muscles snap back from a wasted swing, and the closer they are to death the harder they bite.",
	Weak = [
		"Elasticized Sinew: Attacks that miss have [color=%positive%]50%[/color] of their Fatigue cost refunded\n[color=%positive%]+10[/color] Fatigue",
		"Adrenaline Gland: Attacks deal additional damage equal to [color=%positive%]25%[/color] of missing Hitpoints, or [color=%positive%]50%[/color] on Legendary difficulty"
	],
	Strong = [
		"White Wolf: [color=%positive%]+10[/color] Hitpoints\n[color=%positive%]+10[/color] Fatigue\n[color=%positive%]+10[/color] Initiative\n[color=%positive%]+5[/color] Melee Skill\n[color=%positive%]+5[/color] Melee Defense",
		"Howl: Can let loose a howl that boosts the morale of all allies with the Direwolf Sequence within 6 tiles"
	]
};

// scripts\skills\effects\ssu_distracted_effect.nut
::Mod_Sellswords.Strings.ssu_distracted_effect <- {
	Name = "Distracted",
	Text = "This character was on the receiving end of a dirty trick. Distracted for [color=%negative%]{1}[/color] stack(s), they have a harder time landing their attacks.",
	Tooltip1 = "[color=%negative%]-{1}%[/color] Melee Skill",
	Tooltip2 = "[color=%negative%]-{1}%[/color] Ranged Skill",
	Log = "{1} regained his focus thanks to his unnatural physiology"
};

// scripts\skills\effects\ssu_dryad_forest_blessing_effect.nut
::Mod_Sellswords.Strings.ssu_dryad_forest_blessing_effect <- {
	Name = "Blessed",
	Text = "You have been blessed with power for [color=%positive%]{1}[/color] more turn(s)."
};

// scripts\skills\effects\ssu_earth_hammer_effect.nut
::Mod_Sellswords.Strings.ssu_earth_hammer_effect <- {
	Log = "{1} is rooted"
};

// scripts\skills\effects\ssu_fearsome_effect.nut
::Mod_Sellswords.Strings.ssu_fearsome_effect <- {
	Name = "The Dread",
	Description = "This character has killed an enemy recently and looks dreaded. Hitting a target will greatly demoralize him. Missing the attack will waste the effect.",
	Tooltip = "Hitting a target will greatly demoralize him. Missing the attack will waste the effect."
};

// scripts\skills\effects\ssu_flaming_arrows_effect.nut
::Mod_Sellswords.Strings.ssu_flaming_arrows_effect <- {
	Tooltip = "Inflicts additional fire damage based on 50% weapon damage, ignites ground beneath the target"
};

// scripts\skills\effects\ssu_fob_effect.nut
::Mod_Sellswords.Strings.ssu_fob_effect <- {
	Name = "Malicious Wound",
	Tooltip1 = "This character is bleeding profusely from recently dirty tricks or severe piercing wounds.",
	Tooltip2 = "The threshold to receive injury is lowerd by [color=%negative%]{1}%[/color]",
	Tooltip3 = "[color=%negative%]-{1}%[/color] Resolve",
	Log = "{1} had his bleeding wound quickly close thanks to his unnatural physiology"
};

// scripts\skills\effects\ssu_freezing_arrows_effect.nut
::Mod_Sellswords.Strings.ssu_freezing_arrows_effect <- {
	Tooltip = "Inflicts chill on targets for up to 2 turns, reducing their action points by 3 and initiative by 30.",
	Log = "{1} is chilled"
};

// scripts\skills\effects\ssu_ghoul_sequence_effect.nut
::Mod_Sellswords.Strings.ssu_ghoul_sequence_effect <- {
	Name = "Sequence: Ghoul",
	Description = "This character\'s body has mutated to regrow skin and muscle tissue much more quickly than normal and they gain the speed of nachzehrer. Deep injuries heal much faster than normal as a result. They also seem to have developed a hunger for fresh meat, but that\'s probably unrelated.",
	Weak = [
		"Rapid Tissue Growth: Injuries heal one day sooner, down to a minimum of one day\n[color=%positive%]+10[/color] Initiative",
		"Gruesome Feast: Gains the Gruesome Feast perk"
	],
	Strong = [
		"Skin-Flayer: A further [color=%positive%]+10[/color] Initiative",
		"Hyperactive Cell Growth: Heals [color=%positive%]10[/color] Hitpoints each turn and all Hitpoints after battle. Cannot heal while poisoned",
		"Subdermal Clotting: Takes [color=%positive%]50%[/color] less damage from Bleeding\n[color=%positive%]+10[/color] Hitpoints",
		"Lacerate: Gains the Lacerate perk"
	]
};

// scripts\skills\effects\ssu_goblin_sequence_effect.nut
::Mod_Sellswords.Strings.ssu_goblin_sequence_effect <- {
	Name = "Sequence: Goblin",
	Description = "This character has shrunk, and gained the twitching legs and the keen eye of a Goblin in exchange.",
	Weak = [
		"Shrunk: Gains the Tiny trait and loses Huge",
		"Reactive Leg Muscles: Rotation and Footwork cost [color=%positive%]2[/color] Action Points and [color=%positive%]50%[/color] less Fatigue. Does not stack with other reductions\n[color=%positive%]+10[/color] Initiative",
		"Mutated Cornea: An additional [color=%positive%]5%[/color] of damage ignores armor with ranged attacks\n[color=%positive%]+10[/color] Ranged Skill\n[color=%positive%]+10[/color] Ranged Defense"
	],
	Strong = []
};

// scripts\skills\effects\ssu_houndmaster_effect.nut
::Mod_Sellswords.Strings.ssu_houndmaster_effect <- {
	Name = "Well Trianed Hound"
};

// scripts\skills\effects\ssu_hyena_sequence_effect.nut
::Mod_Sellswords.Strings.ssu_hyena_sequence_effect <- {
	Name = "Sequence: Hyena",
	Description = "This character lopes across the battlefield without tiring, and leaves wounds that refuse to close.",
	Weak = [
		"Loping Gait: Movement builds up [color=%positive%]50%[/color] less Fatigue\n[color=%positive%]+15[/color] Initiative",
		"Tearing Bite: Attacks that deal hitpoint damage leave the target Bleeding for [color=%positive%]5[/color] damage each turn",
		"Subdermal Clotting: Takes [color=%positive%]50%[/color] less damage from Bleeding"
	],
	Strong = [
		"Enraged: A further [color=%positive%]+15[/color] Initiative. Tearing Bite bleeds for [color=%positive%]10[/color] damage each turn instead",
		"Run Down: Moving costs [color=%positive%]1[/color] less Action Point per tile"
	]
};

// scripts\skills\effects\ssu_ice_axe_effect.nut
::Mod_Sellswords.Strings.ssu_ice_axe_effect <- {
	Log = "{1} is chilled"
};

// scripts\skills\effects\ssu_meleeskill_effect.nut
::Mod_Sellswords.Strings.ssu_meleeskill_effect <- {
	Log1 = "{1} uses a feinted {2} and hits {3} (Chance: {4}, Rolled: {5})",
	Log2 = "{1} uses a feinted {2} and misses {3} (Chance: {4}, Rolled: {5})"
};

// scripts\skills\effects\ssu_necro_ghost_possessed_effect.nut
::Mod_Sellswords.Strings.ssu_necro_ghost_possessed_effect <- {
	Text1 = "{1} by {2}",
	Name = "Possessed",
	Text2 = "This character has been possessed, and no longer has any control over their actions and is a puppet that has no choice but to obey a master. Wears off in [color=%negative%]{1}[/color] turn(s).",
	Log = "{1} has been banished out of {2}\'s body"
};

// scripts\skills\effects\ssu_necro_lorekeeper_skull_spawn_effect.nut
::Mod_Sellswords.Strings.ssu_necro_lorekeeper_skull_spawn_effect <- {
	Name = "Screaming Skulls",
	Description = "Using the power of the Black Book, at the start of each turn, the user summons Screaming Skulls equal to a third of the %their% level up to a maximum of 4 skulls.",
	Log = "{1} has summoned Screaming Skulls!"
};

// scripts\skills\effects\ssu_obsidian_dagger_effect.nut
::Mod_Sellswords.Strings.ssu_obsidian_dagger_effect <- {
	Log1 = "{1} is withered",
	Log2 = "{1} heals for {2} points"
};

// scripts\skills\effects\ssu_orc_sequence_effect.nut
::Mod_Sellswords.Strings.ssu_orc_sequence_effect <- {
	Name = "Sequence: Orc",
	Description = "This character has grown to the size of a greenskin, and hits and endures like one.",
	Weak = [
		"Major Growth: Gains the Huge trait and loses Tiny",
		"Shock Absorbant Wrists: [color=%positive%]+10%[/color] damage with attacks",
		"Sensory Redundancy: [color=%positive%]33%[/color] chance to resist the Dazed, Staggered, Stunned, Distracted, and Withered status effects\n[color=%positive%]+10[/color] Hitpoints",
		"Colossus: Gains the Colossus perk"
	],
	Strong = [
		"Warlord: A further [color=%positive%]+10%[/color] damage with attacks and [color=%positive%]+10[/color] Hitpoints",
		"Improved Limbic System: Using orc weapons no longer imposes additional Fatigue costs\n[color=%positive%]+10[/color] Fatigue",
		"Hyperactive Glands: Gains [color=%positive%]3[/color] stacks of Rage each time hitpoint damage is taken, up to [color=%positive%]15[/color], and loses one at the end of each turn. Each stack grants [color=%positive%]+1[/color] damage, Resolve and Initiative and [color=%positive%]2%[/color] less damage taken"
	]
};

// scripts\skills\effects\ssu_phantom_strike_effect.nut
::Mod_Sellswords.Strings.ssu_phantom_strike_effect <- {
	Name = "Phantom Strike",
	Text = "This charater has accumulated [color=%positive%]{1}[/color] charges for Phantom Strike",
	Log = "{1} has connected with a phantom strike!"
};

// scripts\skills\effects\ssu_poisoned_arrows_effect.nut
::Mod_Sellswords.Strings.ssu_poisoned_arrows_effect <- {
	Tooltip = "Inflicts a bleed on the target that does 10 damage per turn, for 2 turns",
	Log = "{1} is poisoned"
};

// scripts\skills\effects\ssu_assistance_effect.nut
::Mod_Sellswords.Strings.ssu_assistance_effect <- {
	Name = "Assistance",
	Description = "This character is ready to strike any enemy within attack range that gets hit by an ally.",
	Tooltip = "Assisting attacks deal [color=%negative%]{1}%[/color] less damage",
	Warning = "[color=%negative%]Does not trigger while engaged in melee or without a Two-Handed Melee Weapon[/color]",
	Log = "{1} assists against {2}"
};

// scripts\skills\effects\ssu_rapidmarch_effect.nut
::Mod_Sellswords.Strings.ssu_rapidmarch_effect <- {
	Tooltip = "Action Point cost for movement is reduced by [color=%positive%]1[/color] for each tile, but the Fatigue cost is doubled."
};

// scripts\skills\effects\ssu_reachadvantage_effect.nut
::Mod_Sellswords.Strings.ssu_reachadvantage_effect <- {
	Name = "Reach Advantage",
	Text = "This character is using the superior reach of their weapon to keep nearby opponents at bay."
};

// scripts\skills\effects\ssu_schrat_sequence_effect.nut
::Mod_Sellswords.Strings.ssu_schrat_sequence_effect <- {
	Name = "Sequence: Schrat",
	Description = "With the proper concoction, and implanting the heart of schrat into the body, the test subject can form a symbiosis with the heart, gaining the abilities and properties of a Schrat.",
	Weak = [
		"Deep Wisdom: Gains the Bright trait and loses Dumb",
		"Wooden Carapace: Takes [color=%positive%]75%[/color] less damage from arrows and bolts and [color=%positive%]50%[/color] less from other piercing ranged attacks, but [color=%negative%]100%[/color] more burning damage",
		"Rooted Fundamentals: Immune to being knocked back or grabbed"
	],
	Strong = [
		"Symbiotic Seeds: Taking damage equal to [color=%positive%]15%[/color] of maximum Hitpoints or more births a miniature Schrat on an adjacent tile",
		"Bark-skin: Can grow a wooden shield from sap-like blood"
	]
};

// scripts\skills\effects\ssu_sequence_effect.nut
::Mod_Sellswords.Strings.ssu_sequence_effect <- {
	Warning = "Further mutations may cause this character\'s genes to spiral out of control, crippling them",
	LogPoisoned = "{1} is poisoned",
	LogHealed = "{1} heals for {2} points",
	LogRage = "{1} gains rage!",
	LogHeadArmor = "{1} regenerates {2} points of head armor",
	LogBodyArmor = "{1} regenerates {2} points of body armor"
};

// scripts\skills\effects\ssu_serpent_sequence_effect.nut
::Mod_Sellswords.Strings.ssu_serpent_sequence_effect <- {
	Name = "Sequence: Snake",
	Description = "This character has developed venom glands that allow them to produce poison strong enough to kill any man. Sadly they do not have the fangs of a snake or spider to deliver this venom and have to resort using piercing or cutting weapons to apply it.",
	Weak = [
		"Venom Glands: Piercing or cutting attacks poison the target\n[color=%positive%]+15[/color] Initiative\n[color=%positive%]+5[/color] Melee Skill",
		"Mutated Circulatory System: Immune to poison effects, including those of Webknechts and Goblins"
	],
	Strong = []
};

// scripts\skills\effects\ssu_smackdown_effect.nut
::Mod_Sellswords.Strings.ssu_smackdown_effect <- {
	Name = "Smacked Down"
};

// scripts\skills\effects\ssu_spider_sequence_effect.nut
::Mod_Sellswords.Strings.ssu_spider_sequence_effect <- {
	Name = "Sequence: Spider",
	Description = "This character has grown the venom glands of a Webknecht, along with its indifference to poison and to the dark.",
	Weak = [
		"Venom Glands: Piercing or cutting attacks poison the target\n[color=%positive%]+15[/color] Initiative\n[color=%positive%]+5[/color] Melee Skill",
		"Mutated Circulatory System: Immune to poison effects, including those of Webknechts and Goblins",
		"Enhanced Eye Rods: Not affected by nighttime penalties\n[color=%positive%]+1[/color] Vision"
	],
	Strong = [
		"Redback: Venom Glands poison with Redback venom instead\nA further [color=%positive%]+15[/color] Initiative and [color=%positive%]+10[/color] Melee Skill",
		"Spider-Man: Can spit webs at foes to trap them"
	]
};

// scripts\skills\effects\ssu_steps_guided_temp.nut
::Mod_Sellswords.Strings.ssu_steps_guided_temp <- {
	Name = "Steps guided",
	Description = "This character has been granted pathfinder by a talented ranger"
};

// scripts\skills\effects\ssu_unhold_sequence_effect.nut
::Mod_Sellswords.Strings.ssu_unhold_sequence_effect <- {
	Name = "Sequence: Unhold",
	Description = "This character\'s body grows at an unnatural pace. Wounds close within moments, and the growths that come with it are best not asked about.",
	Weak = [
		"Accelerated Growths: Heals [color=%positive%]5[/color] Hitpoints each turn and all Hitpoints after battle. Cannot heal while poisoned",
		"Thick Skull: The threshold to sustain injuries on getting hit is increased by [color=%positive%]33%[/color]\n[color=%positive%]+10[/color] Hitpoints",
		"Muscularity: Gains the Muscularity perk"
	],
	Strong = [
		"Hyper-Accelerated Growths: Heals [color=%positive%]10[/color] Hitpoints each turn instead",
		"Thick Skinned: Repairs [color=%positive%]20[/color] head and body armor each turn and all of it after battle. Cannot repair while poisoned",
		"Sensory Redundancy: [color=%positive%]33%[/color] chance to resist the Dazed, Staggered, Stunned, Distracted, and Withered status effects\n[color=%positive%]+10[/color] Hitpoints"
	]
};

// scripts\skills\effects\ssu_valor_effect.nut
::Mod_Sellswords.Strings.ssu_valor_effect <- {
	Name = "Inspired",
	Description = "I can do this for the company! This character has been inspired by just the right words, and is ready to go to his limits and beyond."
};

// scripts\skills\effects\ssu_vampire_sequence_effect.nut
::Mod_Sellswords.Strings.ssu_vampire_sequence_effect <- {
	Name = "Sequence: Vampyre",
	Description = "This character\'s body takes in the blood of others and makes it its own, closing wounds as fast as it can open them in someone else.",
	Weak = [
		"Parasitic Blood: Heals [color=%positive%]15%[/color] of hitpoint damage inflicted on adjacent enemies that have blood\n[color=%positive%]+10[/color] Hitpoints\n[color=%positive%]+5[/color] Melee Skill",
		"Nine Lives: Gains the Nine Lives perk",
		"Ageless: Loses the Old trait"
	],
	Strong = [
		"Necrosavant Lord: Parasitic Blood heals [color=%positive%]25%[/color] instead\nA further [color=%positive%]+20[/color] Hitpoints and [color=%positive%]+10[/color] Melee Skill",
		"Synapse Blockage: Morale cannot fall below Steady\n[color=%positive%]+10[/color] Resolve",
		"Mutated Circulatory System: Immune to poison effects, including those of Webknechts and Goblins",
		"Darkflight: Gains the Darkflight perk"
	]
};

// scripts\skills\effects\ssu_whipped_effect.nut
::Mod_Sellswords.Strings.ssu_whipped_effect <- {
	Name = "Motivated!!!",
	Text = "This character just received a hurtful reminder of what they need to do for their masters. It will last for another {1} round(s).",
	Tooltip1 = "[color=%positive%]+5[/color] Melee Skill",
	Tooltip2 = "[color=%positive%]+5[/color] Ranged Skill",
	Tooltip3 = "[color=%positive%]+15[/color] Resolve",
	Tooltip4 = "[color=%positive%]+15[/color] Initiative",
	Tooltip5 = "[color=%positive%]+5[/color] Melee Defense",
	Tooltip6 = "[color=%positive%]+5[/color] Ranged Defense"
};

// scripts\skills\effects\ssu_wurm_sequence_effect.nut
::Mod_Sellswords.Strings.ssu_wurm_sequence_effect <- {
	Name = "Sequence: Lindwurm",
	Description = "This character has the blood of Dragons coursing through them. It has perfected their physique, and it burns whoever spills it.",
	Weak = [
		"Descendant of Dragons: Loses negative physical traits and gains positive ones\n[color=%positive%]+15[/color] Hitpoints\n[color=%positive%]+15%[/color] damage with attacks",
		"Caustic Blood: Adjacent attackers are sprayed with acid whenever they deal hitpoint damage"
	],
	Strong = [
		"Stoll: A further [color=%positive%]+15[/color] Hitpoints and [color=%positive%]+15%[/color] damage with attacks",
		"Sensory Redundancy: [color=%positive%]33%[/color] chance to resist the Dazed, Staggered, Stunned, Distracted, and Withered status effects\n[color=%positive%]+10[/color] Hitpoints",
		"Reactive Muscle Tissue: Accumulates no Fatigue from enemy attacks, whether they hit or miss\n[color=%positive%]+10[/color] Hitpoints"
	]
};

// scripts\skills\effects_world\ssu_oath_effect.nut
::Mod_Sellswords.Strings.ssu_oath_effect <- {
	Name = "Determined",
	Description = "You're now filled with DETERMINATION!",
	Tooltip1 = "[color=%positive%]+15%[/color] Initiative",
	Tooltip2 = "[color=%positive%]+15%[/color] Resolve",
	Tooltip3 = "[color=%positive%]+5%[/color] damage"
};

// scripts\skills\injury_permanent\ssu_missing_head_injury.nut
::Mod_Sellswords.Strings.ssu_missing_head_injury <- {
	Name = "Missing Head",
	Description = "Uh-oh! Looks like someone wasn't listening when we told the men of the company to 'keep their heads'. Missing a head will prevent this character from wearing helmets, biting... or speaking."
};

// scripts\skills\perks\perk_ssu_armor_mastery_cloth.nut
::Mod_Sellswords.Strings.perk_ssu_armor_mastery_cloth <- {
	Log1 = "{1} sprints and is repelled",
	Log2 = "{1} sprints"
};

// scripts\skills\perks\perk_ssu_armor_mastery_light.nut
::Mod_Sellswords.Strings.perk_ssu_armor_mastery_light <- {
	Tooltip1 = "Builds up only [color=%positive%]{1}%[/color] fatigue",
	Tooltip2 = "[color=%negative%]This character\'s body and head armor are too heavy[/color]"
};

// scripts\skills\perks\perk_ssu_armor_mastery_medium.nut
::Mod_Sellswords.Strings.perk_ssu_armor_mastery_medium <- {
	Tooltip1 = "additional [color=%positive%]+{1}[/color] Fatigue Recovery",
	Tooltip2 = "[color=%positive%]+{1}[/color] Ranged Defense",
	Tooltip3 = "This character is not wearing any body armor and hence receives no bonus from this perk",
	Tooltip4 = "This character\'s armor is too light or too heavy or their Initiative is too low to receive any bonus from this perk"
};

// scripts\skills\perks\perk_ssu_battlerhaposdy.nut
::Mod_Sellswords.Strings.perk_ssu_battlerhaposdy <- {
	Tooltip1 = "[color=%positive%]+{1}[/color] Melee Skill and Ranged Skill",
	Tooltip2 = "[color=%positive%]+{1}[/color] Initiative",
	Tooltip3 = "[color=%positive%]+{1}[/color] Action Point(s)"
};

// scripts\skills\perks\perk_ssu_blockmaster.nut
::Mod_Sellswords.Strings.perk_ssu_blockmaster <- {
	Description = "You are poised to block enemies' melee attack",
	Log = "{1} blocks the attack reducing [color=%negative%]{2}%[/color] damage!"
};

// scripts\skills\perks\perk_ssu_blocknormal.nut
::Mod_Sellswords.Strings.perk_ssu_blocknormal <- {
	Description = "You are poised to block enemies' melee attack",
	Log = "{1} blocks the attack reducing [color=%negative%]{2}%[/color] damage!"
};

// scripts\skills\perks\perk_ssu_blockskilled.nut
::Mod_Sellswords.Strings.perk_ssu_blockskilled <- {
	Description = "You are poised to block enemies' melee attack",
	Log = "{1} blocks the attack reducing [color=%negative%]{2}%[/color] damage!"
};

// scripts\skills\perks\perk_ssu_discipline.nut
::Mod_Sellswords.Strings.perk_ssu_discipline <- {
	Tooltip1 = "[color=%positive%]+{1}[/color] Melee Defense",
	Tooltip2 = "[color=%positive%]+{1}[/color] Ranged Defense"
};

// scripts\skills\perks\perk_ssu_hitpoints.nut
::Mod_Sellswords.Strings.perk_ssu_hitpoints <- {
	Tooltip = "Receives only [color=%positive%]{1}%[/color] of any damage"
};

// scripts\skills\perks\perk_ssu_honorheritage.nut
::Mod_Sellswords.Strings.perk_ssu_honorheritage <- {
	Description = "This character has not moved yet and can take %their% time to get a better aim for ranged attacks.",
	Log = "{1}\'s increases morale due to Honor Heritage"
};

// scripts\skills\perks\perk_ssu_initiative.nut
::Mod_Sellswords.Strings.perk_ssu_initiative <- {
	Tooltip = "Use [color=%positive%]{1}[/color] Initiative for determining turn order"
};

// scripts\skills\perks\perk_ssu_ironsideweak.nut
::Mod_Sellswords.Strings.perk_ssu_ironsideweak <- {
	Text = "This character gains [color=%positive%]{1}%[/color] damage reduction because of adjacent opponents."
};

// scripts\skills\perks\perk_ssu_necro_ghost_soul_eater.nut
::Mod_Sellswords.Strings.perk_ssu_necro_ghost_soul_eater <- {
	Log = "{1} feasts on the soul of {2}"
};

// scripts\skills\perks\perk_ssu_necro_zombie_feasting.nut
::Mod_Sellswords.Strings.perk_ssu_necro_zombie_feasting <- {
	Log = "{1} heals for {2} points"
};

// scripts\skills\perks\perk_ssu_reachadvantage.nut
::Mod_Sellswords.Strings.perk_ssu_reachadvantage <- {
	Description = "This character is using the superior reach of their melee weapon to keep opponents at bay.",
	Tooltip1 = "Has a reach advantage",
	Tooltip2 = "Gains [color=%positive%]+{1}[/color] melee defense against {2}"
};

// scripts\skills\perks\perk_ssu_signaturemove.nut
::Mod_Sellswords.Strings.perk_ssu_signaturemove <- {
	Tooltip1 = "Your next attack will build up less fatigue",
	Tooltip2 = "Your next attack will deal more Melee Damage",
	Tooltip3 = "Your next attack will deal more Melee Damage and has a higher hitchance"
};

// scripts\skills\perks\perk_ssu_tic.nut
::Mod_Sellswords.Strings.perk_ssu_tic <- {
	Tooltip1 = "[color=%positive%]+{1}[/color] Melee Skill",
	Tooltip2 = "[color=%positive%]+{1}[/color] Melee Defense",
	Tooltip3 = "[color=%positive%]+{1}[/color] Ranged Defense",
	Tooltip4 = "[color=%positive%]+{1}[/color] Resolve",
	Tooltip5 = "[color=%positive%]+{1}[/color] Initiative",
	Tooltip6 = "[color=%positive%]+{1}%[/color] Damage",
	Tooltip7 = "[color=%positive%]+{1}%[/color] Damage reduction"
};

// scripts\skills\perks\perk_ssu_trumpcard.nut
::Mod_Sellswords.Strings.perk_ssu_trumpcard <- {
	Tooltip1 = "Distract them",
	Tooltip2 = "Have already distracted {1}"
};

// scripts\skills\racial\ssu_necro_fallen_hero_racial.nut
::Mod_Sellswords.Strings.ssu_necro_fallen_hero_racial <- {
	Name = "Champion"
};

// scripts\skills\racial\ssu_necro_ghastly_touch_racial.nut
::Mod_Sellswords.Strings.ssu_necro_ghastly_touch_racial <- {
	Log = "{1} withers"
};

// scripts\skills\traits\ssu_dryad_thorns_trait.nut
::Mod_Sellswords.Strings.ssu_dryad_thorns_trait <- {
	Name = "Thorns",
	Log = "{1} reflected {2} damage back to {3} due to their thorns"
};

// scripts\skills\traits\ssu_gladiator_hornet_trait.nut
::Mod_Sellswords.Strings.ssu_gladiator_hornet_trait <- {
	Name = "Glorious Agility",
	Description = "Forged in the arenas of the south, this character has danced around man and beast alike, and is past an opponent before they can raise a hand. This fabulous lifestyle demands high pay, and should fewer than two gladiators remain in your company, your campaign ends.",
	Tooltip1 = "Ignores Zones of Control",
	Tooltip2 = "Can move through enemies the same way as through allies",
	Wage = "[color=%negative%]+50%[/color] Daily Wage"
};

// scripts\skills\traits\ssu_gladiator_kraken_trait.nut
::Mod_Sellswords.Strings.ssu_gladiator_kraken_trait <- {
	Name = "Glorious Mastery",
	Description = "Forged in the arenas of the south, this character has fought with every weapon the crowd ever called for, and wields each of them as if born to it. This fabulous lifestyle demands high pay, and should fewer than two gladiators remain in your company, your campaign ends.",
	Tooltip = "Knows every weapon mastery on their perk tree without spending perk points, including masteries that are added to it later",
	Wage = "[color=%negative%]+50%[/color] Daily Wage"
};

// scripts\skills\traits\ssu_gladiator_scorpion_trait.nut
::Mod_Sellswords.Strings.ssu_gladiator_scorpion_trait <- {
	Name = "Glorious Venom",
	Description = "Forged in the arenas of the south, this character has survived every poison the pits had to offer, and learned to coat their own weapons in the worst of them. This fabulous lifestyle demands high pay, and should fewer than two gladiators remain in your company, your campaign ends.",
	Tooltip1 = "Immune to poison",
	Tooltip2 = "Attacks that hit apply a random poison the target doesn\'t have yet: goblin, webknecht, redback, basilisk or zombie infection",
	Wage = "[color=%negative%]+50%[/color] Daily Wage",
	Log = "{1} is poisoned"
};

// scripts\skills\traits\ssu_gladiator_wolf_trait.nut
::Mod_Sellswords.Strings.ssu_gladiator_wolf_trait <- {
	Name = "Glorious Ferocity",
	Description = "Forged in the arenas of the south, this character has fought many a battle, and strikes again before an opponent has recovered from the last blow. This fabulous lifestyle demands high pay, and should fewer than two gladiators remain in your company, your campaign ends.",
	Tooltip = "Attacks cost [color=%positive%]1[/color] fewer Action Point, down to a minimum of 3",
	Wage = "[color=%negative%]+50%[/color] Daily Wage"
};

// mod_sellswords\config\ssu_necro_perk_trees.nut
::Mod_Sellswords.Strings.ssu_necro_perk_trees <- {
	Name1 = "Wiederganger",
	Descriptions1 = ["eating brains"],
	Name2 = "Ancient Dead",
	Descriptions2 = ["delivering a boning"],
	Name3 = "Embalmed",
	Descriptions3 = ["playing in the sand"],
	Name4 = "Vengeful Spirit",
	Descriptions4 = ["haunting the living"]
};

// mod_sellswords\config\ssu_scenarios.nut
::Mod_Sellswords.Strings.ssu_scenarios <- {
	Group = "Sellswords Updated"
};

// mod_sellswords\config\ssu_z_perks_tree_special.nut
::Mod_Sellswords.Strings.ssu_z_perks_tree_special <- {
	Name = "Special Perks"
};

// scripts\!mods_preload\mod_sellswords.nut, the mod settings
::Mod_Sellswords.Strings.mod_sellswords <- {
	SellswordsSpawn = {
		Name = "Enable hostile Sellswords",
		Description = "Enabled - there will be roaming groups of hostile Sellsword companies,\n\nEnabled until destroyed - there will be roaming groups of hostile Sellsword companies, but these parties will stop spawning once you defeat the Legendary Company Tower location,\n\nDisabled - standard non-hostile mercenary parties will spawn."
	},
	SellswordStrengthMultiplier = {
		Name = "Sellsword Strength Multiplier %",
		Description = "Affects the CR rating of the hostile SS faction, only affects new spawns, not existing parties."
	},
	EnableHostileSequences = {
		Name = "Enable Hostile Sequences",
		Description = "When enabled, enemies have a low chance to roll with Sequences. If they do, then they also have a chance to drop whichever one they obtain."
	},
	SellswordsPerk = {
		Name = "Sellsword Scenario Perk",
		Description = "Choose a company perk to be added when you recruit a bro for the Sellswords Scenario.\n\nStudent by default."
	},
	AllLootDrops = {
		Name = "All Loot Drops",
		Description = "When enabled, everything killed in a battle drops its loot as if you had killed it, no matter who made the kill. This includes beasts.\n\nDisabled by default."
	},
	DualWieldVisuals = {
		Name = "Enable SSU Dual-Wield Visuals",
		Description = "When enabled, characters wielding a weapon in each hand hold them side by side and tilted down in battle, instead of the crossed weapons Legends uses.\n\nEnabled by default."
	},
	AutoLevel = {
		Name = "Enable Auto Level",
		Description = "When enabled, a brother who levels up gains every attribute instead of choosing three, each by a smaller amount than usual.\n\nEach level gives +2 to +3 Hitpoints, Fatigue, Initiative and Ranged Skill, +2 Melee Skill and +1 to +2 Resolve, Melee Defense and Ranged Defense. Each talent star has a 50% chance to add 1 more.\n\nDisabled by default."
	}
};
