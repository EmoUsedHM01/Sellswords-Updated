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
		case "this.Const.EntityType.Lindwurm":
			return 1;

		case "this.Const.EntityType.Serpent":
			return 4;

		case "this.Const.EntityType.LegendStollwurm":
			return 0.3;

		case "this.Const.EntityType.Alp":
			return 3;

		case "this.Const.EntityType.LegendDemonAlp":
			return 0.3;

		case "this.Const.EntityType.LegendGreenwoodSchrat":
			return 0.3;

		case "this.Const.EntityType.LegendGreenwoodSchratSmall":
			return 5;

		case "this.Const.EntityType.SandGolem":
			return 1;

		case "this.Const.EntityType.Schrat":
			return 1;

		case "this.Const.EntityType.LegendRockUnhold":
			return 0.5;

		case "this.Const.EntityType.Unhold":
			return 2;

		case "this.Const.EntityType.UnholdBog":
			return 2;

		case "this.Const.EntityType.UnholdFrost":
			return 2;

		case "this.Const.EntityType.Hexe":
			return 2;

		case "this.Const.EntityType.LegendHexeLeader":
			return 0.5;

		case "this.Const.EntityType.Spider":
			return 8;

		case "this.Const.EntityType.SpiderBodyguard":
			return 8;

		case "this.Const.EntityType.LegendRedbackSpider":
			return 1;

		case "this.Const.EntityType.Ghoul":
			return 6;

		case "this.Const.EntityType.LegendSkinGhoul":
			return 2;

		case "this.Const.EntityType.Hyena":
			return 4;

		case "this.Const.EntityType.Direwolf":
			return 6;

		case "this.Const.EntityType.LegendWhiteDirewolf":
			return 0.5;

		case "this.Const.EntityType.Vampire":
			return 2;

		case "this.Const.EntityType.LegendVampireLord":
			return 1;

		case "this.Const.EntityType.SkeletonPriest":
			return 2;

		case "this.Const.EntityType.SkeletonHeavy":
			return 3;

		case "this.Const.EntityType.SkeletonMedium":
			return 5;

		case "this.Const.EntityType.SkeletonLight":
			return 7;

		case "this.Const.EntityType.Ghost":
			return 4;

		case "this.Const.EntityType.LegendBanshee":
			return 3;

		case "this.Const.EntityType.ZombieBoss":
			return 1;

		case "this.Const.EntityType.ZombieBetrayer":
			return 4;

		case "this.Const.EntityType.ZombieKnight":
			return 5;

		case "this.Const.EntityType.ZombieYeoman":
			return 10;

		case "this.Const.EntityType.Zombie":
			return 20;

		case "this.Const.EntityType.Necromancer":
			return 3;

		case "this.Const.EntityType.GoblinWolfrider":
			return 5;

		case "this.Const.EntityType.GoblinShaman":
			return 3;

		case "this.Const.EntityType.GoblinLeader":
			return 3;

		case "this.Const.EntityType.GoblinFighter":
			return 6;

		case "this.Const.EntityType.GoblinAmbusher":
			return 5;

		case "this.Const.EntityType.OrcYoung":
			return 6;

		case "this.Const.EntityType.OrcBerserker":
			return 4;

		case "this.Const.EntityType.OrcElite":
			return 2;

		case "this.Const.EntityType.OrcWarlord":
			return 2;

		case "this.Const.EntityType.OrcBehemoth":
			return 2;

		case "this.Const.EntityType.OrcWarrior":
			return 3;

		case "this.Const.EntityType.Militia":
			return 10;

		case "this.Const.EntityType.MilitiaRanged":
			return 8;

		case "this.Const.EntityType.MilitiaCaptain":
			return 5;

		case "this.Const.EntityType.MilitiaVeteran":
			return 7;

		case "this.Const.EntityType.BountyHunter":
			return 5;

		case "this.Const.EntityType.Peasant":
			return 25;

		case "this.Const.EntityType.CaravanHand":
			return 10;

		case "this.Const.EntityType.CaravanGaurd":
			return 7;

		case "this.Const.EntityType.Wardog":
			return 12;

		case "this.Const.EntityType.Mercenary":
		case "this.Const.EntityType.MercenaryRanged":
			return 4;

		case "this.Const.EntityType.HedgeKnight":
			return 2;

		case "this.Const.EntityType.MasterArcher":
			return 2;

		case "this.Const.EntityType.Footman":
			return 5;

		case "this.Const.EntityType.Greatsword":
			return 4;

		case "this.Const.EntityType.Swordmaster":
			return 2;

		case "this.Const.EntityType.Billman":
			return 5;

		case "this.Const.EntityType.Arbalester":
			return 5;

		case "this.Const.EntityType.StandardBearer":
			return 4;

		case "this.Const.EntityType.Sergeant":
			return 3;

		case "this.Const.EntityType.Knight":
			return 2;

		case "this.Const.EntityType.BanditRabble":
		case "this.Const.EntityType.BanditRabblePoacher":
			return 30;

		case "this.Const.EntityType.BanditThug":
			return 15;

		case "this.Const.EntityType.BanditPoacher":
			return 12;

		case "this.Const.EntityType.BanditMarksman":
			return 7;

		case "this.Const.EntityType.BanditRaider":
			return 5;

		case "this.Const.EntityType.BanditLeader":
			return 3;

		case "this.Const.EntityType.Warhound":
			return 10;

		case "this.Const.EntityType.BarbarianThrall":
			return 8;

		case "this.Const.EntityType.BarbarianMarauder":
			return 4;

		case "this.Const.EntityType.BarbarianChampion":
			return 3;

		case "this.Const.EntityType.BarbarianChosen":
		case "this.Const.EntityType.crBarbarianKing":	
			return 2;

		case "this.Const.EntityType.BarbarianDrummer":
			return 3;

		case "this.Const.EntityType.BarbarianUnhold":
			return 2;

		case "this.Const.EntityType.BarbarianUnholdFrost":
			return 2;

		case "this.Const.EntityType.BarbarianBeastmaster":
			return 5;

		case "this.Const.EntityType.BarbarianMadman":
			return 1;

		case "this.Const.EntityType.Conscript":
			return 5;

		case "this.Const.EntityType.Gunner":
			return 5;

		case "this.Const.EntityType.Officer":
			return 3;

		case "this.Const.EntityType.Engineer":
			return 15;

		case "this.Const.EntityType.Assassin":
			return 3;

		case "this.Const.EntityType.Slave":
			return 30;

		case "this.Const.EntityType.Gladiator":
			return 3;

		case "this.Const.EntityType.NomadCutthroat":
			return 15;

		case "this.Const.EntityType.NomadOutlaw":
			return 5;

		case "this.Const.EntityType.NomadSlinger":
			return 12;

		case "this.Const.EntityType.NomadArcher":
			return 7;

		case "this.Const.EntityType.NomadLeader":
			return 3;

		case "this.Const.EntityType.DesertStalker":
			return 2;

		case "this.Const.EntityType.Executioner":
			return 2;

		case "this.Const.EntityType.DesertDevil":
			return 2;

		case "this.Const.EntityType.PeasantSouthern":
			return 25;

		case "this.Const.EntityType.SatoManhunter":
			return 5;

		case "this.Const.EntityType.SatoManhunterVeteran":
			return 3;

		case "this.Const.EntityType.SatoManhunterRanged":
			return 6;

		case "this.Const.EntityType.SatoManhunterVeteranRanged":
			return 4;

		case "this.Const.EntityType.SkeletonLich":
			return 0.3;

		case "this.Const.EntityType.SkeletonLichMirrorImage":
			return 0.5;

		case "this.Const.EntityType.SkeletonPhylactery":
			return 5;

		case "this.Const.EntityType.ZombieTreasureHunter":
			return 2;

		case "this.Const.EntityType.FlyingSkull":
			return 30;
			
		case "this.Const.EntityType.crFallenbetrayer":
		case "this.Const.EntityType.crZombieswordmaster":
		case "this.Const.EntityType.crSkeleton":
		case "this.Const.EntityType.crImmortal":
		case "this.Const.EntityType.crDesperado":
		case "this.Const.EntityType.crBanditleaderwolf":
		case "this.Const.EntityType.crKnight":
		case "this.Const.EntityType.crHonoraryknight":	
		case "this.Const.EntityType.crHedgeKnight":
		case "this.Const.EntityType.crHashshashin":
		case "this.Const.EntityType.crOrcPackleader":		
			return 2;

		case "this.Const.EntityType.crOrcPillager":	
		case "this.Const.EntityType.crSquireFencer":
		case "this.Const.EntityType.crSellsword":	
		case "this.Const.EntityType.crSellsword_Ranger":
		case "this.Const.EntityType.crSellsword_Polearm":
		case "this.Const.EntityType.crSellswordveteran_Tank":	
		case "this.Const.EntityType.crSellsword_Polearm":
		case "this.Const.EntityType.crSellsword_Sergeant":		
		case "this.Const.EntityType.crSellsword_Banner":	
		case "this.Const.EntityType.crOrcVanguard":	
		case "this.Const.EntityType.MercenaryRanged":
		case "this.Const.EntityType.NobleSureshot":
			return 3;

		case "this.Const.EntityType.crGoblinwarrior":
		case "this.Const.EntityType.crSquire":
		case "this.Const.EntityType.crMercenary":	
		case "this.Const.EntityType.crInfantry":
		case "this.Const.EntityType.crGuardsman":
		case "this.Const.EntityType.crGuardsman_pol":
		case "this.Const.EntityType.Solemner":	
			return 4;

		case "this.Const.EntityType.crBarbblacksmith":
		case "this.Const.EntityType.crBarbarianZerker_High":
		case "this.Const.EntityType.crSquireLow":
		case "this.Const.EntityType.crSquire_normal":
		case "this.Const.EntityType.crOrcGrunt":
			return 5;
	}

	return 10;
};