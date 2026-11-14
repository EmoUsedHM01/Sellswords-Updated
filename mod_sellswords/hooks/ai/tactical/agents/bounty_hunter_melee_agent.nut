::Mod_Sellswords.HooksMod.hook("scripts/ai/tactical/agents/bounty_hunter_melee_agent", function ( q ) {

	q.onAddBehaviors = @(__original) function()
	{
		__original();
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ssu_ai_gruesome_feast_sequence"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_darkflight"));
	}

});