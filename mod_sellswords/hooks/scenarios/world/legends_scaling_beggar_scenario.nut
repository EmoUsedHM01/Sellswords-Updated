::Mod_Sellswords.HooksMod.hook("scripts/scenarios/world/legends_scaling_beggar_scenario", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Difficulty = 0;
	}	
});
