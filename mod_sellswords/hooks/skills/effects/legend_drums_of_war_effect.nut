::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/legend_drums_of_war_effect", function( q ) {

	q.onAdded = @(__original) function()
	{
		local actor = this.getContainer().getActor();
		actor.setFatigue(this.Math.max(0, actor.getFatigue() - 4));
		this.spawnIcon(this.m.Overlay, actor.getTile());
	}
});
