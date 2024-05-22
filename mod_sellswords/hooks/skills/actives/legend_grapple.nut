::mods_hookExactClass("skills/actives/legend_grapple", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()
		this.m.FatigueCost = 15;
	}
	
});