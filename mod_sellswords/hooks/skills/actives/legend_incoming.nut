::mods_hookExactClass("skills/actives/legend_incoming", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.ActionPointCost = 4;
	}
});	