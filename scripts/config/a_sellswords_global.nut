local function addEntityType(_id, _name, _namePlural, _icon)
{
	/*
	if (!("EntityTypeMax" in ::Const))
	{
		local max = 0;
		foreach(key, value in ::Const.EntityType)
		{
			if (typeof value == "integer" && value > max) max = value; 
		}
		::Const.EntityTypeMax <- max;
	}
	*/
	
	::Const.EntityType[_id] <- ::Const.Strings.EntityName.len();
	::Const.Strings.EntityName.push(_name);
	::Const.Strings.EntityNamePlural.push(_namePlural);
	::Const.EntityIcon.push(_icon);
}

addEntityType("crSellsword_Ranger", "Sellsword Ranger", "Sellsword Rangers", "ss08");		//165					original pack
addEntityType("crSellsword", "Sellsword", "Sellswords", "ss06");
addEntityType("crSellsword_Elite", "Sellsword Elite", "Sellsword Elites", "ss07");
addEntityType("crSellswordveteran", "Sellsword Veteran", "Sellsword Veterans", "ss09");
addEntityType("crSquire", "Squire", "Squires", "ss10");																//folk pack
addEntityType("crSquireLow", "Squire", "Squires", "ss10");
addEntityType("crBarbblacksmith", "Barbarian Blacksmith", "Barbarian Blacksmiths", "ss01");		//171
addEntityType("crConscript", "Conscript", "Conscripts", "conscript_orientation");
addEntityType("crFallenbetrayer", "Fallen Betrayer", "Fallen Betrayers", "zombie_betrayer_orientation");
addEntityType("crBaron", "Baron", "Barons", "ss02");
addEntityType("crManhunter", "Manhunter", "Manhunters", "nomad_02_orientation");
addEntityType("crSlaveowner", "Slave Owner", "Slave Owners", "nomad_05_orientation");		
addEntityType("crAbjectfighter", "Slave Fighter", "Slave Fighters", "slave_orientation");
addEntityType("crAbjectgladiator", "Slave Gladiator", "Slave Gladiators", "gladiator_orientation");
addEntityType("crWarden", "Warden", "Wardens", "gladiator_orientation");
addEntityType("crDesperado", "Desperado", "Desperados", "ss04");													//deperados pack
addEntityType("crHashshashin", "Hashshashin", "Hashshashins", "ss05");		 //181		
addEntityType("crDesperado_Low", "Desperado", "Desperados", "ss04");		
addEntityType("crHashshashin_Low", "Hashshashin", "Hashshashins", "ss05");
addEntityType("crOrcPillager", "Orc Pillager", "Orc Pillagers", "orc_pillager_orientation");								//berserkers pack
addEntityType("crBarbarianZerker_Low", "Barbarian Rager", "Barbarian Ragers", "yemanren_01_orientation");
addEntityType("crBarbarianZerker_High", "Barbarian Berserker", "Barbarian Berserkers", "yemanren_01_orientation");
addEntityType("crKnight", "Knight", "Knights", "knight_orientation");		 //187		
addEntityType("crHedgeKnight", "Hedge Knight", "Hedge Knights", "hedge_knight_orientation");
addEntityType("crOathbringer", "Oathbringer", "Oathbringers", "ss_oathbringer");		
addEntityType("crBarbhunter", "Barbarian Hunter", "Barbarian Hunters", "poacher_orientation");
addEntityType("crMercenary", "Mercenary", "Mercenaries", "mercenary_orientation");									//test_sellswords
addEntityType("crPeasantgravedigger", "Gravedigger", "Gravediggers", "ss11");										//professions pack
addEntityType("crPeasantherbalist", "Herbalist", "Herbalists", "ss12");
addEntityType("crPeasantblacksmith", "Blacksmith", "Blacksmiths", "blacksmith_orientation");		
addEntityType("crPeasantbutcher", "Butcher", "Butchers", "butcher_orientation");
addEntityType("crPeasantminstrel", "Minstrel", "Minstrels", "minstrel_orientation");
addEntityType("crPeasantjuggler", "Juggler", "Jugglers", "ss13");
addEntityType("crBanditleaderwolf", "Disguised Bandit Leader", "Disguised Bandit Leaders", "bandit_leader_orientation");
addEntityType("crDesperado_High", "Desperado", "Desperados", "ss04");												//deperados rework
addEntityType("crHashshashin_High", "Hashshashin", "Hashshashins", "ss05");
addEntityType("crBarbarianChampionhigh", "Barbarian Chosen", "Barbarian Chosens", "wildman_03_orientation");
addEntityType("crDesperado_Weak", "Desperado", "Desperados", "ss04");
addEntityType("crRetiredsoldier", "Retired Soldier", "Retired Soldiers", "orientation_retiredsoldier");
addEntityType("crRetiredsoldierpol", "Retired Soldier", "Retired Soldiers", "orientation_retiredsoldier");
addEntityType("crPeasantkiller", "Killer", "Killers", "ss14");
addEntityType("crZombieswordmaster", "Yaksha", "Yakshas", "ss15");
addEntityType("crOutlander", "Outlander", "Outlanders", "ss16");
addEntityType("crInfantry", "Infantry", "Infantries", "infantry_orientation");								//military pack
addEntityType("crGuardsman", "Guardsman", "Guardsmen", "ss03");		
addEntityType("crGuardsman_pol", "Guardsman", "Guardsmen", "ss03");
addEntityType("Solemner", "Mulathamin", "Mulathamun", "ss05");
addEntityType("crHonoraryknight", "Honorary Knight", "Honorary Knights", "knight_orientation");
addEntityType("crSquireFencer", "Squire", "Squires", "ss10");
addEntityType("crSellsword_Polearm", "Sellsword", "Sellswords", "ss06");												//sellswords rework
addEntityType("crSellsword_Tank", "Sellsword", "Sellswords", "ss06");		
addEntityType("crSellswordveteran_Polearm", "Sellsword Veteran", "Sellsword Veterans", "ss09");
addEntityType("crSellswordveteran_Tank", "Sellsword Veteran", "Sellsword Veterans", "ss09");
addEntityType("crSellswordveteran_Ranger", "Sellsword Veteran", "Sellsword Veterans", "ss08");
addEntityType("crSellsword_Sergeant", "Sellsword Sergeant", "Sellsword Sergeants", "sergeant_orientation");
addEntityType("crSellsword_Lieutenant", "Sellsword Sergeant", "Sellsword Sergeants", "sergeant_orientation");
addEntityType("crSellsword_Banner", "Sellsword Standard Bearer", "Sellsword Standard Bearers", "standard_bearer_orientation");
addEntityType("crSquire_normal", "Squire", "Squires", "ss10");								
addEntityType("crImmortal", "Barbarian Chosen", "Barbarian Chosens", "wildman_03_orientation");						//monsters pack
addEntityType("crSkeleton", "Ancient Praetoriani", "Ancient Praetorianus", "skeleton_05_orientation");
addEntityType("crSkeleton_pol", "Ancient Praetoriani", "Ancient Praetorianus", "skeleton_05_orientation");
addEntityType("crGoblinwarrior", "Goblin Warrior", "Goblin Warriors", "kobold_fighter_orientation");
addEntityType("crKnight_guest", "Knight", "Knights", "knight_orientation");
addEntityType("crSquire_guest", "Squire", "Squires", "ss10");
addEntityType("crStandardBearer_guest", "Standard Bearer", "Standard Bearers", "standard_bearer_orientation");		//civil pack   228
addEntityType("crFootman_guest", "Footman", "Footmen", "footman_veteran_orientation");
addEntityType("crBillman_guest", "Billman", "Billmen", "billman_orientation");
addEntityType("crArbalester_guest", "Arbalester", "Arbalesters", "arbalester_orientation");
addEntityType("crZweihander_guest", "Greatsword", "Greatswords", "greatsword_orientation");		
addEntityType("crSergeant_guest", "Sergeant", "Sergeants", "sergeant_orientation");
addEntityType("crBanditFootman", "Footman", "Footmen", "footman_veteran_orientation");
addEntityType("crBanditBillman", "Billman", "Billmen", "billman_orientation");
addEntityType("crBanditArbalester", "Arbalester", "Arbalesters", "arbalester_orientation");
addEntityType("crBanditZweihander", "Greatsword", "Greatswords", "greatsword_orientation");		
addEntityType("crBanditSergeant", "Sergeant", "Sergeants", "sergeant_orientation");
addEntityType("crBarbarianFootman", "Footman", "Footmen", "footman_veteran_orientation");
addEntityType("crBarbarianBillman", "Billman", "Billmen", "billman_orientation");
addEntityType("crBarbarianArbalester", "Arbalester", "Arbalesters", "arbalester_orientation");
addEntityType("crBarbarianZweihander", "Greataxe", "Greataxes", "greatsword_orientation");		
addEntityType("crBarbarianSergeant", "Sergeant", "Sergeants", "sergeant_orientation");
addEntityType("crNomadFootman", "Footman", "Footmen", "footman_veteran_orientation");
addEntityType("crNomadBillman", "Billman", "Billmen", "billman_orientation");
addEntityType("crNomadArbalester", "Arbalester", "Arbalesters", "arbalester_orientation");
addEntityType("crNomadZweihander", "Grenadier", "Grenadiers", "greatsword_orientation");		
addEntityType("crNomadSergeant", "Sergeant", "Sergeants", "sergeant_orientation");
addEntityType("crZombieFootman", "Wiederganger", "Wiedergangers", "zombie_02_orientation");
addEntityType("crZombieBillman", "Wiederganger", "Wiedergangers", "zombie_02_orientation");
addEntityType("crZombieArbalester", "Wiederganger", "Wiedergangers", "zombie_02_orientation");
addEntityType("crZombieZweihander", "Wiederganger", "Wiedergangers", "zombie_02_orientation");		
addEntityType("crNecromancer", "Necromancer", "Necromancers", "human_01_orientation");
addEntityType("crPaladin_guest", "Paladin", "Paladins", "monk_orientation");
addEntityType("crOrcWarlock", "Orc Warlock", "Orc Warlocks", "orientation_orcwarlock");
addEntityType("crBarbarianKing", "Barbarian King", "Barbarian Kings", "wildman_06_orientation");
addEntityType("crSlayer", "Beast Slayer", "Beast Slayers", "ss08");
addEntityType("crLindwurm_slayer", "Lindwurm Slayer", "Lindwurm Slayers", "orientation_slayer");						 //257
addEntityType("crDeathknight", "Death Knight", "Death Knights", "deathknight_orientation");
addEntityType("crKnightcommander", "Knight Commander", "Knight Commanders", "ss07");
addEntityType("crOrcGrunt", "Orc Grunt", "Orc Grunts", "orc_grunt_orientation");	
addEntityType("crOrcVanguard", "Orc Slaughterer", "Orc Slaughterers", "orc_slaughterer_orientation");	
addEntityType("crOrcPackleader", "Orc Packleader", "Orc Packleaders", "orc_packleader_orientation");
addEntityType("crAbjectgladiator02", "Slave Gladiator", "Slave Gladiators", "gladiator_orientation");	  //263
addEntityType("crNomadScavenger", "Nomad Scavenger", "Nomad Scavengers", "gladiator_orientation");
addEntityType("crBaron02", "Baron", "Barons", "ss02");
addEntityType("crGoblinRider01", "Goblin Gendarme", "Goblin Gendarmes", "goblin_05_orientation");	
addEntityType("crGoblinRider02", "Goblin Chasseur", "Goblin Chasseurs", "goblin_05_orientation");	
addEntityType("crGoblinRider03", "Goblin Caballero", "Goblin Caballeros", "goblin_05_orientation");
addEntityType("crGoblinRider04", "Goblin Ranger", "Goblin Rangers", "goblin_05_orientation");
addEntityType("crGoblinRider00", "Goblin Fighter", "Goblin Fighters", "goblin_05_orientation");
addEntityType("crConqueror", "The Conqueror", "The Conquerors", "skeleton_05_orientation");

addEntityType("DryadWolf", "Verdant Hound", "Verdant Hounds", "ss_dryad_wolf");	   // dryad entities
addEntityType("DryadSnake", "Thicket Stalker", "Thicket Stalkers", "ss_dryad_snake");
addEntityType("DryadUnhold", "Woodland Protector", "Woodland Protector", "ss_dryad_unhold");
addEntityType("DryadLindy", "Forest Avatar", "Forest Avatars", "ss_dryad_lindy");
addEntityType("DryadWarrior", "Dryad Warrior", "Dryad Warriors", "ss_dryad_warrior");
addEntityType("DryadArcher", "Dryad Archer", "Dryad Archers", "ss_dryad_archer");
addEntityType("DryadShaman", "Dryad Shaman", "Dryad Shaman", "ss_dryad_shaman");