::Const.LegendMod.FavoriteZombies.extend([
	this.Const.EntityType.crFallenbetrayer,
	this.Const.EntityType.crZombieswordmaster	
]);

::Const.LegendMod.FavoriteDirewolf.extend([
	this.Const.EntityType.Wolf,
	this.Const.EntityType.GoblinWolfrider,
	this.Const.EntityType.KoboldWolfrider,
]);

::Const.LegendMod.FavoriteGoblin.extend([
	this.Const.EntityType.KoboldWolfrider,
	this.Const.EntityType.KoboldFighter,
	this.Const.EntityType.crGoblinwarrior	
]);

::Const.LegendMod.FavoriteOrc.extend([
	this.Const.EntityType.crOrcPillager,
	this.Const.EntityType.crOrcGrunt,	
	this.Const.EntityType.crOrcVanguard,	
	this.Const.EntityType.crOrcPackleader		
]);

::Const.LegendMod.FavoriteSwordmaster.extend([
	this.Const.EntityType.LegendFencer,
	this.Const.EntityType.BarbarianChampion,
	this.Const.EntityType.BarbarianChosen,	
	this.Const.EntityType.crImmortal,
	this.Const.EntityType.crDesperado,
	this.Const.EntityType.crBanditleaderwolf,
	this.Const.EntityType.crSquire,
	this.Const.EntityType.crSquireFencer,	
	this.Const.EntityType.crKnight,
	this.Const.EntityType.crHonoraryknight,	
	this.Const.EntityType.crMercenary,	
	this.Const.EntityType.crSellsword,
	this.Const.EntityType.crHedgeKnight,
	this.Const.EntityType.crHashshashin	
]);

::Const.LegendMod.FavoriteArcher.extend([
	this.Const.EntityType.crSellsword_Ranger,
	this.Const.EntityType.crConscript,
	this.Const.EntityType.MercenaryRanged,
	this.Const.EntityType.NobleSureshot
]);

::Const.LegendMod.FavoriteBarbarian.extend([
	this.Const.EntityType.crBarbarianKing,	
	this.Const.EntityType.crBarbblacksmith,
	this.Const.EntityType.crBarbarianZerker_Low,
	this.Const.EntityType.crBarbarianZerker_High,
	this.Const.EntityType.crBarbhunter,
	this.Const.EntityType.crImmortal	
]);

::Const.LegendMod.FavoriteBandit.extend([
	this.Const.EntityType.crDesperado,
	this.Const.EntityType.crDesperado_Low,
	this.Const.EntityType.crDesperado_Weak,
	this.Const.EntityType.crOutlander,
	this.Const.EntityType.crBanditleaderwolf	
]);

::Const.LegendMod.FavoriteCaravan.extend([
	this.Const.EntityType.Slave,
	this.Const.EntityType.Engineer,
	this.Const.EntityType.PeasantSouthern,
	this.Const.EntityType.crSquireLow,
	this.Const.EntityType.crPeasantgravedigger,
	this.Const.EntityType.crPeasantherbalist,
	this.Const.EntityType.crPeasantjuggler,
	this.Const.EntityType.crPeasantkiller,
	this.Const.EntityType.crPeasantgravedigger,
	this.Const.EntityType.crPeasantbutcher,
	this.Const.EntityType.crPeasantblacksmith,
	this.Const.EntityType.crPeasantminstrel,	
	this.Const.EntityType.crRetiredsoldier,	
	this.Const.EntityType.crRetiredsoldierpol,		
]);

::Const.LegendMod.FavoriteNoble.extend([
	this.Const.EntityType.crSquire,
	this.Const.EntityType.crSquireFencer,	
	this.Const.EntityType.crKnight,
	this.Const.EntityType.crHonoraryknight,	
	this.Const.EntityType.crInfantry	
]);

::Const.LegendMod.FavoriteMercenary.extend([
	this.Const.EntityType.Swordmaster,
	this.Const.EntityType.HedgeKnight,
	this.Const.EntityType.MasterArcher,
	this.Const.EntityType.FreeCompanyArcher,
	this.Const.EntityType.FreeCompanyCrossbow,
	this.Const.EntityType.FreeCompanyLongbow,
	this.Const.EntityType.FreeCompanyBillman,
	this.Const.EntityType.FreeCompanyPikeman,
	this.Const.EntityType.FreeCompanyInfantry,
	this.Const.EntityType.FreeCompanyLeader,
	this.Const.EntityType.FreeCompanyLeaderLow,
	this.Const.EntityType.crSellsword_Ranger,
	this.Const.EntityType.crMercenary,	
	this.Const.EntityType.crSellsword,
	this.Const.EntityType.crHedgeKnight,
	this.Const.EntityType.crSellsword_Polearm,
	this.Const.EntityType.crSellsword_Tank,
	this.Const.EntityType.crSellsword_Sergeant,
	this.Const.EntityType.crSellsword_Banner,
	this.Const.EntityType.crSellsword_Ranger,
	this.Const.EntityType.crSquire_normal	
]);

::Const.LegendMod.FavoriteSoutherners.extend([
	this.Const.EntityType.SatoManhunterVeteran,
	this.Const.EntityType.Gladiator,
	this.Const.EntityType.PeasantSouthern,
	this.Const.EntityType.crConscript,
	this.Const.EntityType.crGuardsman,
	this.Const.EntityType.crGuardsman_pol,
	this.Const.EntityType.Solemner	
]);

::Const.LegendMod.FavoriteNomad.extend([
	this.Const.EntityType.Gladiator,
	this.Const.EntityType.DesertStalker,
	this.Const.EntityType.Executioner,
	this.Const.EntityType.DesertDevil,
	this.Const.EntityType.PeasantSouthern,
	this.Const.EntityType.crHashshashin,
	this.Const.EntityType.crHashshashin_Low,	
	this.Const.EntityType.crOutlander	
]);

::Const.LegendMod.FavoriteSkeleton.push(this.Const.EntityType.crSkeleton);

::Const.LegendMod.GetFavoriteEnemyValue = function ( _type )
{
	switch(_type)
	{
		case this.Const.EntityType.SkeletonBoss:
			return 0.25;

		case this.Const.EntityType.LegendStollwurm:
			return 0.4;

		case this.Const.EntityType.LegendHexeLeader:
		case this.Const.EntityType.LegendMummyQueen:
		case this.Const.EntityType.LegendRockUnhold:
		case this.Const.EntityType.LegendWhiteDirewolf:
		case this.Const.EntityType.SkeletonLichMirrorImage:
			return 0.5;

		case this.Const.EntityType.BanditWarlord:
		case this.Const.EntityType.BarbarianChampion:
		case this.Const.EntityType.Engineer:
		case this.Const.EntityType.Knight:
		case this.Const.EntityType.LegendDemonAlp:
		case this.Const.EntityType.LegendGreenwoodSchrat:
		case this.Const.EntityType.LegendMummyHeavy:
		case this.Const.EntityType.OrcWarlord:
		case this.Const.EntityType.Schrat:
		case this.Const.EntityType.SkeletonLich:
		case this.Const.EntityType.SkeletonPhylactery:
		case this.Const.EntityType.ZombieBoss:
		case this.Const.EntityType.Lindwurm:
			return 1;

		case this.Const.EntityType.Alp:
		case this.Const.EntityType.Arbalester:
		case this.Const.EntityType.Assassin:
		case this.Const.EntityType.BanditLeader:
		case this.Const.EntityType.BarbarianBeastmaster:
		case this.Const.EntityType.BarbarianChosen:
		case this.Const.EntityType.BarbarianDrummer:
		case this.Const.EntityType.BountyHunter:
		case this.Const.EntityType.DesertDevil:
		case this.Const.EntityType.DesertStalker:
		case this.Const.EntityType.Executioner:
		case this.Const.EntityType.GoblinLeader:
		case this.Const.EntityType.GoblinShaman:
		case this.Const.EntityType.Gladiator:
		case this.Const.EntityType.Greatsword:
		case this.Const.EntityType.HedgeKnight:
		case this.Const.EntityType.LegendBanshee:
		case this.Const.EntityType.LegendFencer:
		case this.Const.EntityType.LegendHalberdier:
		case this.Const.EntityType.LegendMummyLight:
		case this.Const.EntityType.Mercenary:
		case this.Const.EntityType.MercenaryRanged:
		case this.Const.EntityType.MilitiaCaptain:
		case this.Const.EntityType.Necromancer:
		case this.Const.EntityType.NobleSureshot:
		case this.Const.EntityType.NomadLeader:
		case this.Const.EntityType.Officer:
		case this.Const.EntityType.SatoManhunter:
		case this.Const.EntityType.SatoManhunterRanged:
		case this.Const.EntityType.StandardBearer:
		case this.Const.EntityType.Swordmaster:
		case this.Const.EntityType.Vampire:
		case this.Const.EntityType.crBanditleaderwolf:
		case this.Const.EntityType.crDesperado:
		case this.Const.EntityType.crFallenbetrayer:
		case this.Const.EntityType.crHashshashin:
		case this.Const.EntityType.crHedgeKnight:
		case this.Const.EntityType.crHonoraryknight:
		case this.Const.EntityType.crImmortal:
		case this.Const.EntityType.crKnight:
		case this.Const.EntityType.crOrcPackleader:
		case this.Const.EntityType.crSellsword:
		case this.Const.EntityType.crSellsword_Banner:
		case this.Const.EntityType.crSellsword_Polearm:
		case this.Const.EntityType.crSellsword_Ranger:
		case this.Const.EntityType.crSellsword_Sergeant:
		case this.Const.EntityType.crSellswordveteran_Tank:
		case this.Const.EntityType.crSkeleton:
		case this.Const.EntityType.crZombieswordmaster:
			return 3;

		case this.Const.EntityType.Direwolf:
		case this.Const.EntityType.Ghoul:
		case this.Const.EntityType.GoblinFighter:
		case this.Const.EntityType.LegendSkinGhoul:
		case this.Const.EntityType.SatoManhunterRanged:
		case this.Const.EntityType.Serpent:
		case this.Const.EntityType.Solemner:
		case this.Const.EntityType.crGoblinwarrior:
		case this.Const.EntityType.crGuardsman:
		case this.Const.EntityType.crGuardsman_pol:
		case this.Const.EntityType.crInfantry:
		case this.Const.EntityType.crMercenary:
		case this.Const.EntityType.crSquire:
			return 4;

		case this.Const.EntityType.BanditMarksman:
		case this.Const.EntityType.BanditRaider:
		case this.Const.EntityType.Billman:
		case this.Const.EntityType.CaravanGuard:
		case this.Const.EntityType.Conscript:
		case this.Const.EntityType.Ghost:
		case this.Const.EntityType.GoblinAmbusher:
		case this.Const.EntityType.GoblinWolfrider:
		case this.Const.EntityType.LegendCaravanPolearm:
		case this.Const.EntityType.LegendHalberdier:
		case this.Const.EntityType.LegendSlinger:
		case this.Const.EntityType.MilitiaVeteran:
		case this.Const.EntityType.NobleEliteFootman:
		case this.Const.EntityType.NoblePollax:
		case this.Const.EntityType.NomadArcher:
		case this.Const.EntityType.NomadOutlaw:
		case this.Const.EntityType.OrcVanguard:
		case this.Const.EntityType.SchratSmall:
		case this.Const.EntityType.Sergeant:
		case this.Const.EntityType.SkeletonLight:
		case this.Const.EntityType.SkeletonMedium:
		case this.Const.EntityType.ZombieKnight:
		case this.Const.EntityType.crBarbarianZerker_High:
		case this.Const.EntityType.crBarbblacksmith:
		case this.Const.EntityType.crOrcGrunt:
		case this.Const.EntityType.crSquireLow:
		case this.Const.EntityType.crSquire_normal:
			return 5;

		case this.Const.EntityType.BarbarianThrall:
		case this.Const.EntityType.CaravanHand:
		case this.Const.EntityType.LegendGreenwoodSchratSmall:
		case this.Const.EntityType.NomadSlinger:
		case this.Const.EntityType.Wardog:
		case this.Const.EntityType.Warhound:
		case this.Const.EntityType.ZombieYeoman:
			return 10;

		case this.Const.EntityType.ArmoredWardog:
		case this.Const.EntityType.BanditPoacher:
		case this.Const.EntityType.BanditThug:
		case this.Const.EntityType.Footman:
		case this.Const.EntityType.NomadCutthroat:
			return 15;

		case this.Const.EntityType.BanditRabble:
		case this.Const.EntityType.BanditRabblePoacher:
		case this.Const.EntityType.FlyingSkull:
		case this.Const.EntityType.LegendPeasantBlacksmith:
		case this.Const.EntityType.LegendPeasantButcher:
		case this.Const.EntityType.LegendPeasantFarmhand:
		case this.Const.EntityType.LegendPeasantMiner:
		case this.Const.EntityType.LegendPeasantMinstrel:
		case this.Const.EntityType.LegendPeasantMonk:
		case this.Const.EntityType.LegendPeasantPoacher:
		case this.Const.EntityType.LegendPeasantSquire:
		case this.Const.EntityType.LegendPeasantWitchHunter:
		case this.Const.EntityType.Militia:
		case this.Const.EntityType.MilitiaRanged:
		case this.Const.EntityType.Peasant:
		case this.Const.EntityType.PeasantSouthern:
		case this.Const.EntityType.Slave:
		case this.Const.EntityType.Zombie:
			return 25;

		default:
			return 5;
	}
};