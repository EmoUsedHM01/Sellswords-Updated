::mods_hookExactClass("items/weapons/two_handed_wooden_flail", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Value = 700;
		this.m.RegularDamageMax = 65;
	}
});	