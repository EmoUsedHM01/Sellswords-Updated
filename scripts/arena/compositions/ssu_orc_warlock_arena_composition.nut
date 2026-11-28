this.ssu_orc_warlock_arena_composition <- this.inherit("scripts/arena/compositions/arena_composition", {
	m = {},
	function create()
	{
		this.arena_composition.create();
		this.m.Type = "arena_composition.ssu_orc_warlock";
		this.m.DisplayName = ::Mod_Sellswords.Strings.ssu_orc_warlock_arena_composition.DisplayName;
		this.m.DisplayText = ::Mod_Sellswords.Strings.ssu_orc_warlock_arena_composition.DisplayText;
		this.m.SignatureEntities = [
			::BDP.Arena.EntityTypes.SsuOrcWarlock
		];
		this.m.PotentialEntities = [
			::BDP.Arena.EntityTypes.OrcYoung,
			::BDP.Arena.EntityTypes.OrcYoung,
			::BDP.Arena.EntityTypes.OrcBerserker,
			::BDP.Arena.EntityTypes.OrcBerserker,
			::BDP.Arena.EntityTypes.OrcWarrior,
			::BDP.Arena.EntityTypes.OrcWarrior
		];
		this.m.Pay = 600;
		this.m.AllowedEntrants = 4;
		this.m.BaseStrength = 60;
		this.m.MinDay = 40;
	}

	function generateDisplayName()
	{
		local titles = clone ::BDP.Arena.CompositionTitles.SsuOrcWarlock;
		titles.extend(::BDP.Arena.CompositionTitles.Steppe);
		this.m.DisplayName = ::MSU.Array.rand(::BDP.Arena.CompositionNames.SsuOrcWarlock) + " of " + ::MSU.Array.rand(titles);
	}

	function setDifficulty( _difficulty )
	{
		this.m.Difficulty = this.Math.max(_difficulty, 2);
	}

});
