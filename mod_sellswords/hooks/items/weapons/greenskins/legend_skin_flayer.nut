::mods_hookExactClass("items/weapons/greenskins/legend_skin_flayer", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.RegularDamage = 50;
	}
});	