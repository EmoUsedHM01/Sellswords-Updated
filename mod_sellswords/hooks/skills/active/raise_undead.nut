::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/raise_undead", function( q ) {

	q.m.SpawnedUndead <- [];

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "Raise a corpse back to life as an undead, faithfully follows your bidding.";
		this.m.IconDisabled = "skills/active_26_sw.png";
	}

	q.getTooltip = @(__original) function()
	{
		return this.getDefaultUtilityTooltip();
	}

	q.spawnUndead = @(__original) function(_user, _tile)
	{
		__original(_user, _tile);
		local zombie = _tile.getEntity();
		this.m.SpawnedUndead.push([zombie, _user]);
	}

	q.onCombatFinished = @(__original) function()
	{
		while(this.m.SpawnedUndead.len() != 0)
		{
			local pair = this.m.SpawnedUndead.pop();
			pair[0].kill(pair[1], this, this.Const.FatalityType.Kraken, true);
		}
	}

});