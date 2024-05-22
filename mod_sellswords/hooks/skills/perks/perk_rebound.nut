::mods_hookExactClass("skills/perks/perk_rebound", function ( o )
{
	o.onUpdate = function ( _properties )
	{
		local actor = this.getContainer().getActor();
		local maxFat = actor.getFatigueMax();
		local currentFat = actor.getFatigue();
		local ratio = currentFat / maxFat;

		if (ratio >= 0.74000001)
		{
			_properties.FatigueRecoveryRate += 5;
		}
	};
});