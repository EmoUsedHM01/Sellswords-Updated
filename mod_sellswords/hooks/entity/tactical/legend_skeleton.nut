::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/legend_skeleton", function( q ) {

	q.create = @(__original) function()
	{
		this.skeleton.create();
		this.m.Name = "Raised Skeleton";
		this.m.ResurrectWithScript = "";
		this.m.IsSummoned = true;
		this.m.IsActingImmediately = true;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/skeleton_melee_agent");
		this.m.AIAgent.setActor(this);
	}

});