this.ghost_fragment_agent <- ::inherit("scripts/ai/tactical/agent", {
	m = {},
	function create()
	{
		this.agent.create();
		this.m.ID = ::Const.AI.Agent.ID.Ghost;
		this.m.Properties.TargetPriorityHitchanceMult = 0.5;
		this.m.Properties.TargetPriorityHitpointsMult = 0.3;
		this.m.Properties.TargetPriorityRandomMult = 0.0;
		this.m.Properties.TargetPriorityDamageMult = 0.2;
		this.m.Properties.TargetPriorityFleeingMult = 0.5;
		this.m.Properties.TargetPriorityHittingAlliesMult = 0.1;
		this.m.Properties.TargetPriorityFinishOpponentMult = 3.0;
		this.m.Properties.TargetPriorityCounterSkillsMult = 0.5;
		this.m.Properties.TargetPriorityArmorMult = 0.75;
		this.m.Properties.OverallDefensivenessMult = 1.15;
		this.m.Properties.OverallFormationMult = 1.5;
		this.m.Properties.EngageFlankingMult = 1.25;
		this.m.Properties.EngageTargetMultipleOpponentsMult = 1.5;
		this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 0.5;
		this.m.Properties.EngageRangeMin = 1;
		this.m.Properties.EngageRangeMax = 2;
		this.m.Properties.EngageRangeIdeal = 2;
		this.m.Properties.PreferCarefulEngage = true;
	}

	function onAddBehaviors()
	{
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_engage_melee"));
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_attack_default"));
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_disengage"));
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_defend"));
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_defend_rotation"));
	}

	function onUpdate()
	{
	}

});