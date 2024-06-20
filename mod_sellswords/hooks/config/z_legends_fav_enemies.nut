::Const.LegendMod.FavoriteZombies.extend([
	::Const.EntityType.crFallenbetrayer,
	::Const.EntityType.crZombieswordmaster
]);

::Const.LegendMod.FavoriteDirewolf.extend([
	::Const.EntityType.Wolf,
	::Const.EntityType.GoblinWolfrider,
	::Const.EntityType.KoboldWolfrider
]);

::Const.LegendMod.FavoriteGoblin.extend([
	::Const.EntityType.KoboldWolfrider,
	::Const.EntityType.KoboldFighter,
	::Const.EntityType.crGoblinwarrior
]);

::Const.LegendMod.FavoriteOrc.extend([
	::Const.EntityType.crOrcPillager,
	::Const.EntityType.crOrcGrunt,
	::Const.EntityType.crOrcVanguard,
	::Const.EntityType.crOrcPackleader
]);

::Const.LegendMod.FavoriteSwordmaster.extend([
	::Const.EntityType.LegendFencer,
	::Const.EntityType.BarbarianChampion,
	::Const.EntityType.BarbarianChosen,
	::Const.EntityType.crImmortal,
	::Const.EntityType.crDesperado,
	::Const.EntityType.crBanditleaderwolf,
	::Const.EntityType.crSquire,
	::Const.EntityType.crSquireFencer,
	::Const.EntityType.crKnight,
	::Const.EntityType.crHonoraryknight,
	::Const.EntityType.crMercenary,
	::Const.EntityType.crSellsword,
	::Const.EntityType.crHedgeKnight,
	::Const.EntityType.crHashshashin
]);

::Const.LegendMod.FavoriteArcher.extend([
	::Const.EntityType.crSellsword_Ranger,
	::Const.EntityType.crConscript,
	::Const.EntityType.NobleSureshot,
	::Const.EntityType.MercenaryRanged
]);

::Const.LegendMod.FavoriteBarbarian.extend([
	::Const.EntityType.crBarbarianKing,	
	::Const.EntityType.crBarbblacksmith,
	::Const.EntityType.crBarbarianZerker_Low,
	::Const.EntityType.crBarbarianZerker_High,
	::Const.EntityType.crBarbhunter,
	::Const.EntityType.crImmortal
]);

::Const.LegendMod.FavoriteBandit.extend([
	::Const.EntityType.crDesperado,
	::Const.EntityType.crDesperado_Low,
	::Const.EntityType.crDesperado_Weak,
	::Const.EntityType.crOutlander,
	::Const.EntityType.crBanditleaderwolf
]);

::Const.LegendMod.FavoriteCaravan.extend([
	::Const.EntityType.Slave,
	::Const.EntityType.Engineer,
	::Const.EntityType.PeasantSouthern,
	::Const.EntityType.crSquireLow,
	::Const.EntityType.crPeasantgravedigger,
	::Const.EntityType.crPeasantherbalist,
	::Const.EntityType.crPeasantjuggler,
	::Const.EntityType.crPeasantkiller,
	::Const.EntityType.crPeasantgravedigger,
	::Const.EntityType.crPeasantbutcher,
	::Const.EntityType.crPeasantblacksmith,
	::Const.EntityType.crPeasantminstrel,
	::Const.EntityType.crRetiredsoldier,
	::Const.EntityType.crRetiredsoldierpol
]);

::Const.LegendMod.FavoriteNoble.extend([
	::Const.EntityType.crSquire,
	::Const.EntityType.crSquireFencer,
	::Const.EntityType.crKnight,
	::Const.EntityType.crHonoraryknight,
	::Const.EntityType.crInfantry
]);

::Const.LegendMod.FavoriteMercenary.extend([
	::Const.EntityType.Swordmaster,
	::Const.EntityType.HedgeKnight,
	::Const.EntityType.MasterArcher,
	::Const.EntityType.FreeCompanyArcher,
	::Const.EntityType.FreeCompanyCrossbow,
	::Const.EntityType.FreeCompanyLongbow,
	::Const.EntityType.FreeCompanyBillman,
	::Const.EntityType.FreeCompanyPikeman,
	::Const.EntityType.FreeCompanyInfantry,
	::Const.EntityType.FreeCompanyLeader,
	::Const.EntityType.FreeCompanyLeaderLow,
	::Const.EntityType.crSellsword_Ranger,
	::Const.EntityType.crMercenary,
	::Const.EntityType.crSellsword,
	::Const.EntityType.crHedgeKnight,
	::Const.EntityType.crSellsword_Polearm,
	::Const.EntityType.crSellsword_Tank,
	::Const.EntityType.crSellsword_Sergeant,
	::Const.EntityType.crSellsword_Banner,
	::Const.EntityType.crSellsword_Ranger,
	::Const.EntityType.crSquire_normal
]);

::Const.LegendMod.FavoriteSoutherners.extend([
	::Const.EntityType.SatoManhunterVeteran,
	::Const.EntityType.Gladiator,
	::Const.EntityType.PeasantSouthern,
	::Const.EntityType.crConscript,
	::Const.EntityType.crGuardsman,
	::Const.EntityType.crGuardsman_pol,
	::Const.EntityType.Solemner	
]);

::Const.LegendMod.FavoriteNomad.extend([
	::Const.EntityType.Gladiator,
	::Const.EntityType.DesertStalker,
	::Const.EntityType.Executioner,
	::Const.EntityType.DesertDevil,
	::Const.EntityType.PeasantSouthern,
	::Const.EntityType.crHashshashin,
	::Const.EntityType.crHashshashin_Low,
	::Const.EntityType.crOutlander
]);

::Const.LegendMod.FavoriteSkeleton.push(::Const.EntityType.crSkeleton);

::Const.LegendMod.GetFavoriteEnemyValue = function(_type)
{
	switch(_type)
	{
		// Grouped by return values, lower number means higher %
		case "::Const.EntityType.LegendStollwurm":
		case "::Const.EntityType.LegendDemonAlp":
		case "::Const.EntityType.LegendGreenwoodSchrat":
		case "::Const.EntityType.SkeletonLich":
			return 0.3;

		case "::Const.EntityType.LegendRockUnhold":
		case "::Const.EntityType.LegendHexeLeader":
		case "::Const.EntityType.LegendWhiteDirewolf":
		case "::Const.EntityType.SkeletonLichMirrorImage":
			return 0.5;

		case "::Const.EntityType.Lindwurm":
		case "::Const.EntityType.SandGolem":
		case "::Const.EntityType.Schrat":
		case "::Const.EntityType.LegendRedbackSpider":
		case "::Const.EntityType.Vampire":
		case "::Const.EntityType.LegendVampireLord":
		case "::Const.EntityType.ZombieBoss":
		case "::Const.EntityType.Mercenary":
		case "::Const.EntityType.MercenaryRanged":
		case "::Const.EntityType.BarbarianMadman":
			return 1;

		case "::Const.EntityType.Unhold":
		case "::Const.EntityType.UnholdBog":
		case "::Const.EntityType.UnholdFrost":
		case "::Const.EntityType.Hexe":
		case "::Const.EntityType.OrcElite":
		case "::Const.EntityType.OrcWarlord":
		case "::Const.EntityType.OrcBehemoth":
		case "::Const.EntityType.MasterArcher":
		case "::Const.EntityType.NobleSureshot":
		case "::Const.EntityType.Swordmaster":
		case "::Const.EntityType.Knight":
		case "::Const.EntityType.LegendSkinGhoul":
		case "::Const.EntityType.ZombieTreasureHunter":
		case "::Const.EntityType.crFallenbetrayer":
		case "::Const.EntityType.crZombieswordmaster":
		case "::Const.EntityType.crSkeleton":
		case "::Const.EntityType.crImmortal":
		case "::Const.EntityType.crDesperado":
		case "::Const.EntityType.crBanditleaderwolf":
		case "::Const.EntityType.crKnight":
		case "::Const.EntityType.crHonoraryknight":
		case "::Const.EntityType.crHedgeKnight":
		case "::Const.EntityType.crHashshashin":
		case "::Const.EntityType.crOrcPackleader":
		case "::Const.EntityType.DesertStalker":
		case "::Const.EntityType.Executioner":
		case "::Const.EntityType.DesertDevil":
		case "::Const.EntityType.BarbarianChosen":
		case "::Const.EntityType.crBarbarianKing":
		case "::Const.EntityType.BarbarianUnhold":
		case "::Const.EntityType.BarbarianUnholdFrost":
			return 2;

		case "::Const.EntityType.Alp":
		case "::Const.EntityType.SkeletonHeavy":
		case "::Const.EntityType.LegendBanshee":
		case "::Const.EntityType.Necromancer":
		case "::Const.EntityType.GoblinShaman":
		case "::Const.EntityType.GoblinLeader":
		case "::Const.EntityType.OrcWarrior":
		case "::Const.EntityType.Sergeant":
		case "::Const.EntityType.BarbarianChampion":
		case "::Const.EntityType.Officer":
		case "::Const.EntityType.Assassin":
		case "::Const.EntityType.Gladiator":
		case "::Const.EntityType.NomadLeader":
			return 3;

		case "::Const.EntityType.Serpent":
		case "::Const.EntityType.Hyena":
		case "::Const.EntityType.Ghost":
		case "::Const.EntityType.OrcBerserker":
		case "::Const.EntityType.Greatsword":
		case "::Const.EntityType.StandardBearer":
		case "::Const.EntityType.Solemner":
		case "::Const.EntityType.crGoblinwarrior":
		case "::Const.EntityType.crSquire":
		case "::Const.EntityType.crMercenary":
		case "::Const.EntityType.crInfantry":
		case "::Const.EntityType.crGuardsman":
		case "::Const.EntityType.crGuardsman_pol":
		case "::Const.EntityType.SatoManhunterVeteranRanged":
			return 4;

		case "::Const.EntityType.LegendGreenwoodSchratSmall":
		case "::Const.EntityType.SkeletonMedium":
		case "::Const.EntityType.ZombieKnight":
		case "::Const.EntityType.GoblinWolfrider":
		case "::Const.EntityType.GoblinAmbusher":
		case "::Const.EntityType.BarbarianBeastmaster":
		case "::Const.EntityType.MilitiaCaptain":
		case "::Const.EntityType.BountyHunter":
		case "::Const.EntityType.Footman":
		case "::Const.EntityType.Billman":
		case "::Const.EntityType.Arbalester":
		case "::Const.EntityType.SkeletonPhylactery":
		case "::Const.EntityType.Conscript":
		case "::Const.EntityType.Gunner":
		case "::Const.EntityType.NomadOutlaw":
		case "::Const.EntityType.crBarbblacksmith":
		case "::Const.EntityType.crBarbarianZerker_High":
		case "::Const.EntityType.crSquireLow":
		case "::Const.EntityType.crSquire_normal":
		case "::Const.EntityType.crOrcGrunt":
			return 5;

		case "::Const.EntityType.Ghoul":
		case "::Const.EntityType.Direwolf":
		case "::Const.EntityType.GoblinFighter":
		case "::Const.EntityType.OrcYoung":
		case "::Const.EntityType.SatoManhunterRanged":
			return 6;

		case "::Const.EntityType.SkeletonLight":
		case "::Const.EntityType.BanditMarksman":
		case "::Const.EntityType.CaravanGaurd":
		case "::Const.EntityType.NomadArcher":
		case "::Const.EntityType.MilitiaVeteran":
			return 7;

		case "::Const.EntityType.Spider":
		case "::Const.EntityType.SpiderBodyguard":
		case "::Const.EntityType.BarbarianThrall":
		case "::Const.EntityType.MilitiaRanged":
			return 8;

		case "::Const.EntityType.BanditThug":
		case "::Const.EntityType.NomadCutthroat":
		case "::Const.EntityType.Engineer":
			return 15;

		case "::Const.EntityType.Zombie":
			return 20;

		case "::Const.EntityType.Peasant":
		case "::Const.EntityType.PeasantSouthern":
		case "::Const.EntityType.Slave":
		case "::Const.EntityType.BanditRabble":
		case "::Const.EntityType.BanditRabblePoacher":
		case "::Const.EntityType.FlyingSkull":
			return 30;
	}
};