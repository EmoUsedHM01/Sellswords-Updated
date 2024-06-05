::mods_hookExactClass("skills/perks/perk_legend_favoured_enemy_master_archer", function( o )
{
	// Gotta add a second copy of this because FE Archer overwrites the original onUpdate function
	local ws_onUpdate = o.onUpdate;
	o.onUpdate = function( _properties )
	{
		local actor = this.getContainer().getActor().get();
		if (!actor.getFlags().has(this.m.ID))
		{
			local stats = this.Const.LegendMod.GetFavoriteEnemyStats(actor, this.m.ID);
			if (stats.Strength >= 10)
			{
				actor.getFlags().add(this.m.ID);
				actor.m.PerkPoints += 1;
			}
		}

		ws_onUpdate(_properties);
	};

});