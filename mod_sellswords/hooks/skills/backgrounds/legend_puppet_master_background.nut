::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/legend_puppet_master_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.HiringCost = 1500;
		this.m.DailyCost = 20;
	}

});