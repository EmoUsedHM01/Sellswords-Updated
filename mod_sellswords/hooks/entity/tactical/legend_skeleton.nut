::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/legend_skeleton", function( q ) {

	q.create = @(__original) function()
	{
		this.skeleton.create();
		this.m.Name = ::Mod_Sellswords.Strings.legend_skeleton.Name;
		this.m.ResurrectWithScript = "";
		this.m.IsSummoned = true;
		this.m.IsActingImmediately = true;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/skeleton_melee_agent");
		this.m.AIAgent.setActor(this);
	}

});