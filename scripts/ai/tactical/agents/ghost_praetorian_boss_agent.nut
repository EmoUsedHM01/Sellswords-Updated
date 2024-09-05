this.ghost_praetorian_boss_agent <- ::inherit("scripts/ai/tactical/agent", {
	m = {},
	function create()
	{
		this.agent.create();
		this.m.ID = ::Const.AI.Agent.ID.Ghost;
		this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Split] = 1.25;
		this.m.Properties.TargetPriorityHitchanceMult = 0.4;
		this.m.Properties.TargetPriorityHitpointsMult = 0.25;
		this.m.Properties.TargetPriorityRandomMult = 0.0;
		this.m.Properties.TargetPriorityDamageMult = 0.35;
		this.m.Properties.TargetPriorityFleeingMult = 0.5;
		this.m.Properties.TargetPriorityHittingAlliesMult = 0.1;
		this.m.Properties.TargetPriorityFinishOpponentMult = 3.0;
		this.m.Properties.TargetPriorityCounterSkillsMult = 0.5;
		this.m.Properties.TargetPriorityArmorMult = 0.6;
		this.m.Properties.OverallDefensivenessMult = 1.25;
		this.m.Properties.OverallFormationMult = 1.5;
		this.m.Properties.EngageTargetMultipleOpponentsMult = 1.25;
		this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.0;

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Properties.TargetPriorityHitchanceMult = 0.9;
			this.m.Properties.TargetPriorityHitpointsMult = 0.8;
			this.m.Properties.TargetPriorityRandomMult = 0.0;
			this.m.Properties.TargetPriorityDamageMult = 0.35;
			this.m.Properties.TargetPriorityFleeingMult = 0.5;
			this.m.Properties.TargetPriorityHittingAlliesMult = 0.1;
			this.m.Properties.TargetPriorityFinishOpponentMult = 5.0;
			this.m.Properties.TargetPriorityCounterSkillsMult = 1.5;
			this.m.Properties.TargetPriorityArmorMult = 0.6;
			this.m.Properties.OverallDefensivenessMult = 2.5;
			this.m.Properties.OverallFormationMult = 3.5;
			this.m.Properties.EngageTargetMultipleOpponentsMult = 0.25;
			this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 2.0;
		}
	}

	function onAddBehaviors()
	{
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_engage_melee"));
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_attack_default"));
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_attack_split"));
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_attack_reap"));
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_disengage"));
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_defend"));
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_defend_knock_back"));
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_always_use"));

		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_ghost_teleport"));
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_ghost_passive_teleport"));
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_spawn_ghost_fragment"));
	}

	function onUpdate()
	{
		this.setEngageRangeBasedOnWeapon();
	}

});