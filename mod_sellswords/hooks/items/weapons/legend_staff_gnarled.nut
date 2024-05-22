::mods_hookExactClass("items/weapons/legend_staff_gnarled", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Value = 3500;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 40;
		this.m.DirectDamageAdd = 0.0;
		this.m.DirectDamageMult = 0.95;
	}
});	