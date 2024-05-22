::mods_hookExactClass("skills/effects/str_covered_by_ally_effect", function ( o )
{
	o.onUpdate = function ( _properties )
	{
		if (!this.isEnabled())
		{
			this.onRemoved();
			this.removeSelf();			
			return;
		}

		_properties.InitiativeForTurnOrderAdditional += 2000;
	}
});