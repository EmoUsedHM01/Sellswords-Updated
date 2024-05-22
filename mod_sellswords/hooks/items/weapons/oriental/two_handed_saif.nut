::mods_hookExactClass("items/weapons/oriental/two_handed_saif", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Value = 1600;
	}
});	