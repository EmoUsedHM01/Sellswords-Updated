::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_unleash_warbear_skill", function ( q ) {

	// adds the SSU hound bonuses on top of what Legends gives the bear
	q.onUse = @( __original ) function ( _user, _targetTile )
	{
		local ret = __original(_user, _targetTile);

		if (_targetTile.IsOccupiedByActor)
		{
			::Mod_Sellswords.HookHelper.addHoundBonuses(_user, _targetTile.getEntity());
		}

		return ret;
	}
});
