::Mod_Sellswords.HooksMod.hook("scripts/scenarios/world/legends_troupe_scenario", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Difficulty = 3;
		this.m.Description = ::Mod_Sellswords.Strings.legends_troupe_scenario.Description;
	}

	q.onSpawnAssets = @(__original) function()
	{
		__original();

		foreach (bro in this.World.getPlayerRoster().getAll())
		{
			bro.setVeteranPerks(2);
		}
	}
});
