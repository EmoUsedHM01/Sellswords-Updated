::mods_hookExactClass("skills/actives/legend_hidden_skill", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		this.m.FatigueCost = 25;
	}

});