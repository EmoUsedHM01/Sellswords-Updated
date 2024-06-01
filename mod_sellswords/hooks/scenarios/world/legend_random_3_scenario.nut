::Mod_Sellswords.HooksMod.hook("scripts/scenarios/world/legend_random_3_scenario", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Difficulty = 1;
		this.m.RosterTierMax = this.Const.Roster.getTierForSize(22);			
	}	
});
