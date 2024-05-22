::mods_hookExactClass("skills/effects/legend_drums_of_life_effect", function(o) {
	o.onAdded = function()
	{
		local actor = this.getContainer().getActor();

		if (actor.getHitpoints() < actor.getHitpointsMax())
		{
			actor.setHitpoints(this.Math.max(0, this.Math.min(actor.getHitpointsMax(), actor.getHitpoints() + 8)));
			this.spawnIcon(this.m.Overlay, actor.getTile());
		}
	}
})