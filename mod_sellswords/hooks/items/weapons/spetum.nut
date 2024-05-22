::mods_hookExactClass("items/weapons/spetum", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Value = 1500;
		this.m.ArmorDamageMult = 1.05;
	}
});	