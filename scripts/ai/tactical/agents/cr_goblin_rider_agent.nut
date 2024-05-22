this.cr_goblin_rider_agent <- this.inherit("scripts/ai/tactical/agents/goblin_wolfrider_agent", {
	m = {},
	function create()
	{
		this.goblin_wolfrider_agent.create();	
	}
	function onAddBehaviors()
	{
		this.goblin_wolfrider_agent.onAddBehaviors();
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_throw_net"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_spearwall"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_shieldwall"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_knock_back"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_switchto_melee"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_switchto_ranged"));
	}

});

