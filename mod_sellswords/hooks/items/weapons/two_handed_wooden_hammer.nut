::mods_hookExactClass("items/weapons/two_handed_wooden_hammer", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Value = 900;
	}
});	