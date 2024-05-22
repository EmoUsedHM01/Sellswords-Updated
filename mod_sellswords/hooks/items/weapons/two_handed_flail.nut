::mods_hookExactClass("items/weapons/two_handed_flail", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Value = 3000;
		this.m.DirectDamageMult = 0.4;
	}
});	