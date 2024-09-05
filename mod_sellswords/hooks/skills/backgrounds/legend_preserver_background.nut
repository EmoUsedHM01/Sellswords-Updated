::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/legend_preserver_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.HiringCost = 1500;
		this.m.DailyCost = 20;
	}

});