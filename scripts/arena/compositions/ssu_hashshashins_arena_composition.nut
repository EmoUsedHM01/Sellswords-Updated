this.ssu_hashshashins_arena_composition <- this.inherit("scripts/arena/compositions/arena_composition", {
	m = {},
	function create()
	{
		this.arena_composition.create();
		this.m.Type = "arena_composition.ssu_hashshashins";
		this.m.DisplayName = ::Mod_Sellswords.Strings.ssu_hashshashins_arena_composition.DisplayName;
		this.m.DisplayText = ::Mod_Sellswords.Strings.ssu_hashshashins_arena_composition.DisplayText;
		this.m.SignatureEntities = [
			::BDP.Arena.EntityTypes.SsuHashshashin
		];
		this.m.PotentialEntities = [
			::BDP.Arena.EntityTypes.SsuHashshashinLow,
			::BDP.Arena.EntityTypes.SsuHashshashinLow,
			::BDP.Arena.EntityTypes.SsuHashshashin,
			::BDP.Arena.EntityTypes.SsuHashshashin,
			::BDP.Arena.EntityTypes.SsuHashshashinHigh
		];
		this.m.PotentialChampions = [
			::BDP.Arena.EntityTypes.ChampionSsuHashshashin
		];
		this.m.Pay = 350;
		this.m.AllowedEntrants = 3;
		this.m.BaseStrength = 45;
		this.m.MinDay = 20;
	}

	function generateDisplayName()
	{
		local titles = clone ::BDP.Arena.CompositionTitles.Desert;
		titles.extend(::BDP.Arena.CompositionTitles.Nomads);
		this.m.DisplayName = ::MSU.Array.rand(::BDP.Arena.CompositionNames.SsuHashshashins) + " of " + ::MSU.Array.rand(titles);
	}

});
