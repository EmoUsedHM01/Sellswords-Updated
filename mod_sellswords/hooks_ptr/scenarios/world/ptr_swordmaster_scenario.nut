::mods_hookExactClass("scenarios/world/ptr_swordmaster_scenario", function ( o )
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Difficulty = 0;
	}	
});