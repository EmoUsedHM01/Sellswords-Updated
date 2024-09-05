::Mod_Sellswords.HooksMod.hook("scripts/skills/traits/necromancer_trait", function( q ) {

	q.onNewDay = @(__original) function()
	{
		local factions = [];
		factions.extend(this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse));
		factions.extend(this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState));

		foreach( f in factions )
		{
			if (f.m.PlayerRelation > 30)
			{
				f.m.PlayerRelation = this.Math.minf(100.0, this.Math.max(0.0, f.m.PlayerRelation - 0.1));
				f.updatePlayerRelation();
			}
		}
	}

});