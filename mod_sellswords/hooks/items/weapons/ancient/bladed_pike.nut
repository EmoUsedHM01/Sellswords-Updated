::mods_hookExactClass("items/weapons/ancient/bladed_pike", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Value = 900;
	}
});	