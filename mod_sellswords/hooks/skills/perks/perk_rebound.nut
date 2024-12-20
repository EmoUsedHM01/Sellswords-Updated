::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_rebound", function ( q ) {

	q.onUpdate = @( __original ) function ( _properties )
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
