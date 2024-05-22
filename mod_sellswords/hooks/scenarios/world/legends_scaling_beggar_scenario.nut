::mods_hookExactClass("scenarios/world/legends_scaling_beggar_scenario", function ( o )
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Difficulty = 0;
	}	
});	