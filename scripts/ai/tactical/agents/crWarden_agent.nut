this.crWarden_agent <- this.inherit("scripts/ai/tactical/agents/bandit_melee_agent", {
	function create()
	{
		this.bandit_melee_agent.create();
		this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.BoostMorale] = 3;		
	}
	function onAddBehaviors()
	{
		this.bandit_melee_agent.onAddBehaviors();
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_boost_morale"));
	}
});