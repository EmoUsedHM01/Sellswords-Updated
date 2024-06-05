::Mod_Sellswords.HooksMod.hook("scripts/ai/tactical/agents/military_melee_agent", function ( q ) {

	q.onAddBehaviors = @(__original) function()
	{
		__original();
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_gruesome_feast_sequence"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_darkflight"));
	}

});