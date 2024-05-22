::mods_hookExactClass("items/weapons/greenskins/legend_bough", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.ShieldDamage = 38;
		this.m.Condition = 84.0;
		this.m.ConditionMax = 84.0;
		this.m.RegularDamage = 85;
		this.m.RegularDamageMax = 115;
	}
});	