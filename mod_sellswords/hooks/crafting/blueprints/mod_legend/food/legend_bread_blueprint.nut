::mods_hookExactClass("crafting/blueprints/mod_legend/food/legend_beer_blueprint", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		this.m.Cost = 30;
	}
})

