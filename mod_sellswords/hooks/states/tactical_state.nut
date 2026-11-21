::Mod_Sellswords.HooksMod.hook("scripts/states/tactical_state", function ( q ) {

	// Parthian Shot joins the free first tile Legends has for Athletic and Lone Wolf, the path preview counts it in
	q.getFreeMoveSkills = @( __original ) function ( _activeEntity )
	{
		local ret = __original(_activeEntity);
		local perk = ::Legends.Perks.get(_activeEntity, ::Legends.Perk.SsuParthianshot);

		if (perk != null && perk.isFreeMoveReady())
		{
			ret.IsActive = true;
		}

		return ret;
	}

	q.disableAllFreeMoveSkills = @( __original ) function ( _activeEntity )
	{
		__original(_activeEntity);
		local perk = ::Legends.Perks.get(_activeEntity, ::Legends.Perk.SsuParthianshot);

		if (perk != null)
		{
			perk.m.HasMoved = true;
		}
	}

});
