::mods_hookExactClass("skills/legend_favoured_enemy_skill", function( o )
{
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

	local ws_getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = ws_getTooltip();
		if (this.getContainer().getActor().getFlags().has(this.m.ID))
		{
			// Perk Point has been refunded
			ret.push({
				id = 15,
				type = "hint",
				icon = "ui/icons/unlocked_small.png",
				text = "The perk point spent on this perk has been refunded."
			});
		}
		
		return ret;
	};

});