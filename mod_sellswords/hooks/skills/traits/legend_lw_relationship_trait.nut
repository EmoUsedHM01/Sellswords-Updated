::Mod_Sellswords.HooksMod.hook("scripts/skills/traits/legend_lw_relationship_trait", function( q ) {
	
	q.onAdded = @(__original) function()
	{
		if (!this.m.Container.hasSkill("effects.legend_lw_relationship"))
		{
			local actor = this.getContainer().getActor();		
			local effect = this.new("scripts/skills/effects/legend_lw_relationship_effect");
			effect.setLevel(this.Math.min(15, actor.getLevel()));			
			this.m.Container.add(effect);
		}
	}
});
