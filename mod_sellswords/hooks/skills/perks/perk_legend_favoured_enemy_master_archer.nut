::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_favoured_enemy_master_archer", function( q ) {

	q.onAfterUpdate <- function( _properties )
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
	};
});
