::mods_hookExactClass("skills/perks/perk_ptr_eyes_up", function ( o ){

	o.isEnabled = function()
	{
		if (this.m.IsForceEnabled)
		{
			return true;
		}

		local actor = this.getContainer().getActor();
		if (!actor.isArmedWithRangedWeapon())
		{
			return false;
		}
		return true;
	}

	o.onBeforeAnySkillExecuted = function( _skill, _targetTile, _targetEntity, _forFree )
	{
		local d = this.getContainer().getActor().getTile().getDistanceTo(_targetTile);			
		if (d <= 4)
		{
			return;
		}

		this.m.TargetTile = _targetTile;
		this.m.ActorsAppliedTo = [];
	}

});	