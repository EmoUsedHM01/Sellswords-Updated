::Mod_Sellswords.HooksMod.hook("scripts/states/tactical_state", function ( q ) {

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

	q.computeEntityPath = @( __original ) function ( _activeEntity, _mouseEvent )
	{
		if (!_activeEntity.getSkills().hasSkill("trait.ssu_gladiator_hornet"))
			return __original(_activeEntity, _mouseEvent);

		local getAlliedFactions = _activeEntity.getAlliedFactions;
		_activeEntity.getAlliedFactions = function ()
		{
			local ret = [];

			foreach (faction, _ in this.Tactical.Entities.getAllInstances())
				ret.push(faction);

			return ret;
		};
		__original(_activeEntity, _mouseEvent);
		_activeEntity.getAlliedFactions = getAlliedFactions;
	}

});
