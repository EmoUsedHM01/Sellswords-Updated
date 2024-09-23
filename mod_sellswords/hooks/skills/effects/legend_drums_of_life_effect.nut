::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/legend_drums_of_life_effect", function( q ) {

	q.onAdded = @(__original) function()
	{
		local actor = this.getContainer().getActor();

		if (actor.getHitpoints() < actor.getHitpointsMax())
		{
			actor.setHitpoints(this.Math.max(0, this.Math.min(actor.getHitpointsMax(), actor.getHitpoints() + 8)));
		}
	}
});
