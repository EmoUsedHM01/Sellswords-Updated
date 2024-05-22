::mods_hookExactClass("items/weapons/legend_estoc", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.RegularDamage = 55;
		this.m.RegularDamageMax = 75;	
		this.m.DirectDamageAdd = 0.2;
	}
});	