::mods_hookExactClass("items/weapons/greenskins/goblin_falchion", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Condition = 64;
		this.m.ConditionMax = 64;
	}
	
});