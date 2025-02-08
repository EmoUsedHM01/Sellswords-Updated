::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/legend_zombie", function( q ) {

	q.create = @(__original) function()
	{
		this.zombie.create();
		this.m.Name = "Raised Wiederganger";
		this.m.ResurrectWithScript = "";
		this.m.IsSummoned = true;
		this.m.IsActingImmediately = true;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/zombie_agent");
		this.m.AIAgent.setActor(this);
	}

});