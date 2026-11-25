::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_rebound", function ( q ) {

	// +5 Fatigue regeneration while over 75% fatigued instead of 10% of the accumulated Fatigue, the Legends tooltip reads this too
	q.getBonus = @( __original ) function ()
	{
		local actor = this.getContainer().getActor();
		return actor.getFatigue() >= actor.getFatigueMax() * 0.74 ? 5 : 0;
	}
});
