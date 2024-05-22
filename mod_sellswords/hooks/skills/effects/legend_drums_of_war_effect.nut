::mods_hookExactClass("skills/effects/legend_drums_of_war_effect", function(o) {
	o.onAdded = function()
	{
		local actor = this.getContainer().getActor();
		actor.setFatigue(this.Math.max(0, actor.getFatigue() - 4));
		this.spawnIcon(this.m.Overlay, actor.getTile());
	}
})