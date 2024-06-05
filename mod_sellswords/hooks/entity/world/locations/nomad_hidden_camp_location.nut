::Mod_Sellswords.HooksMod.hook("scripts/entity/world/locations/nomad_hidden_camp_location", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		local r = this.Math.rand(1, 100);
		if (r <= 25)
			this.setDefenderSpawnList(this.Const.World.Spawn.Manhunters);
		else if (r > 25)
			this.setDefenderSpawnList(this.Const.World.Spawn.NomadDefenders);
	}

});
