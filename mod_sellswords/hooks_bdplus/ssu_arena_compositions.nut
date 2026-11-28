local function addEntityType( _type, _troop, _icon, _maxInComp )
{
	::BDP.Arena.EntityTypes[_type] <- {
		ID = _troop.ID,
		Type = _type,
		Strength = _troop.Strength,
		MaxInComp = _maxInComp,
		Variant = 0,
		DisplayIcon = "ui/arena/" + _icon + ".png",
		Script = _troop.Script
	};
}

local function addChampionType( _type, _troop, _icon )
{
	addEntityType(_type, _troop, _icon, 1);
	local champion = ::BDP.Arena.EntityTypes[_type];
	champion.Strength += 25;
	champion.Variant = 1;
	champion.NameList <- _troop.NameList;
	champion.TitleList <- _troop.TitleList;
}

local troops = ::Const.World.Spawn.Troops;

addEntityType("SsuDesperadoLow", troops.SsuDesperadoLow, "ssu_desperado", 4);
addEntityType("SsuDesperado", troops.SsuDesperado, "ssu_desperado", 5);
addEntityType("SsuDesperadoHigh", troops.SsuDesperadoHigh, "ssu_desperado", 3);
addChampionType("ChampionSsuDesperado", troops.SsuDesperado, "ssu_desperado");

addEntityType("SsuHashshashinLow", troops.SsuHashshashinLow, "ssu_hashshashin", 4);
addEntityType("SsuHashshashin", troops.SsuHashshashin, "ssu_hashshashin", 5);
addEntityType("SsuHashshashinHigh", troops.SsuHashshashinHigh, "ssu_hashshashin", 3);
addChampionType("ChampionSsuHashshashin", troops.SsuHashshashin, "ssu_hashshashin");

addEntityType("SsuOrcWarlock", troops.SsuOrcWarlock, "ssu_orc_warlock", 1);

::BDP.Arena.CompositionNames.SsuDesperados <- ::Mod_Sellswords.Strings.ssu_arena_compositions.DesperadoNames;
::BDP.Arena.CompositionNames.SsuHashshashins <- ::Mod_Sellswords.Strings.ssu_arena_compositions.HashshashinNames;
::BDP.Arena.CompositionNames.SsuOrcWarlock <- ::Mod_Sellswords.Strings.ssu_arena_compositions.OrcWarlockNames;
::BDP.Arena.CompositionTitles.SsuOrcWarlock <- ::Mod_Sellswords.Strings.ssu_arena_compositions.OrcWarlockTitles;
