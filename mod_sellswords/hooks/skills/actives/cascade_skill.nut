::mods_hookExactClass("skills/actives/cascade_skill", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.FatigueCost = 13;
	}

});