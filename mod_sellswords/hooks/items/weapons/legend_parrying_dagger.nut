::mods_hookExactClass("items/weapons/legend_parrying_dagger", function ( o )
{	
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.Value = 1000;
	}
});	