::mods_hookExactClass("skills/perks/perk_ptr_muscle_memory", function ( o )
{
	local ws_onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function(_properties)
	{
		local reloadBolt = this.getContainer().getSkillByID("actives.reload_bolt");
		if (reloadBolt != null && reloadBolt.m.ActionPointCost > 0)
		{
			reloadBolt.m.ActionPointCost -= 1;
		}

		ws_onAfterUpdate(_properties);
	}
});	