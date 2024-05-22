::mods_hookExactClass("scenarios/world/legend_random_3_scenario", function ( o )
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Difficulty = 1;
		this.m.RosterTierMax = this.Const.Roster.getTierForSize(22);			
	}	
});