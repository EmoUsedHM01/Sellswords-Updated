this.ssu_desperados_arena_composition <- this.inherit("scripts/arena/compositions/arena_composition", {
	m = {},
	function create()
	{
		this.arena_composition.create();
		this.m.Type = "arena_composition.ssu_desperados";
		this.m.DisplayName = ::Mod_Sellswords.Strings.ssu_desperados_arena_composition.DisplayName;
		this.m.DisplayText = ::Mod_Sellswords.Strings.ssu_desperados_arena_composition.DisplayText;
		this.m.SignatureEntities = [
			::BDP.Arena.EntityTypes.SsuDesperado
		];
		this.m.PotentialEntities = [
			::BDP.Arena.EntityTypes.SsuDesperadoLow,
			::BDP.Arena.EntityTypes.SsuDesperadoLow,
			::BDP.Arena.EntityTypes.SsuDesperado,
			::BDP.Arena.EntityTypes.SsuDesperado,
			::BDP.Arena.EntityTypes.SsuDesperadoHigh
		];
		this.m.PotentialChampions = [
			::BDP.Arena.EntityTypes.ChampionSsuDesperado
		];
		this.m.Pay = 350;
		this.m.AllowedEntrants = 3;
		this.m.BaseStrength = 50;
		this.m.MinDay = 20;
	}

	function generateDisplayName()
	{
		local titles = clone ::BDP.Arena.CompositionTitles.Plain;
		titles.extend(::BDP.Arena.CompositionTitles.Forest);
		this.m.DisplayName = ::MSU.Array.rand(::BDP.Arena.CompositionNames.SsuDesperados) + " of " + ::MSU.Array.rand(titles);
	}

});
