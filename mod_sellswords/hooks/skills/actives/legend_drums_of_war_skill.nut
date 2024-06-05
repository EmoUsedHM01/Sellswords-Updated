::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_drums_of_war_skill", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.Description = "Push allies on with your music, lowering the fatigue of all allies within 8 tiles by 4 fatigue. Must be holding a musical instrument to use.";
	}

});
