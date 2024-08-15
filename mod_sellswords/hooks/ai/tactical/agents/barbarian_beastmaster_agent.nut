::Mod_Sellswords.HooksMod.hook("scripts/ai/tactical/agents/barbarian_beastmaster_agent", function ( q ) {

	q.onAddBehaviors = @(__original) function()
	{
		__original();
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_dryad_summon"));
	}

});