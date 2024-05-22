::mods_hookExactClass("items/weapons/greenskins/goblin_spear", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Condition = 48;
		this.m.ConditionMax = 48;
	}
	
});