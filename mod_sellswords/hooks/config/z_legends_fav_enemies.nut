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

local OrignalGetFavoriteEnemyValue = ::Const.LegendMod.GetFavoriteEnemyValue;
::Const.LegendMod.GetFavoriteEnemyValue = function ( _type )
{
	switch(_type)
	{
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

		case this.Const.EntityType.Solemner: // no cr prefix even though not legends/vanilla?
		case this.Const.EntityType.crGoblinwarrior:
		case this.Const.EntityType.crGuardsman:
		case this.Const.EntityType.crGuardsman_pol:
		case this.Const.EntityType.crInfantry:
		case this.Const.EntityType.crMercenary:
		case this.Const.EntityType.crSquire:
			return 4;

		case this.Const.EntityType.crBarbarianZerker_High:
		case this.Const.EntityType.crBarbblacksmith:
		case this.Const.EntityType.crOrcGrunt:
		case this.Const.EntityType.crSquireLow:
		case this.Const.EntityType.crSquire_normal:
			return 5;
		default:
			return OrignalGetFavoriteEnemyValue(_type);
	}
};
