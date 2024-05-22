::mods_hookExactClass("skills/actives/debilitate", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()
		this.m.ActionPointCost = 2;
		this.m.FatigueCost = 20;
	}
});