this.barbarian_zerker_agent <- this.inherit("scripts/ai/tactical/agents/barbarian_melee_agent", {
	function create() {
		this.barbarian_melee_agent.create();
	}

	function onAddBehaviors()
	{
		this.barbarian_melee_agent.onAddBehaviors();
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_warcry"));
	}
});