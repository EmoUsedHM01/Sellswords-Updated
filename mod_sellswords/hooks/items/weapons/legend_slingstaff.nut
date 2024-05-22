::mods_hookExactClass("items/weapons/legend_slingstaff", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Value = 4000;
		this.m.ArmorDamageMult = 0.9;
	}
});	