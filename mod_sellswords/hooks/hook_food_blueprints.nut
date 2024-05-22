foreach (script in [
	"legend_beer_blueprint",
	"legend_cured_rations_blueprint"
])
{
	::mods_hookExactClass("crafting/blueprints/mod_legend/food/" + script, function(o) {
		local ws_create = o.create;
		o.create = function()
		{
			ws_create();
			this.m.Cost = 100;
		}
	})
}


foreach (script in [
	"legend_cured_venison_blueprint",
	"legend_cured_rations_blueprint",
	"legend_pie_blueprint",
	"legend_porridge_blueprint",
	"legend_pudding_blueprint",
])
{
	::mods_hookExactClass("crafting/blueprints/mod_legend/food/" + script, function(o) {
		local ws_create = o.create;
		o.create = function()
		{
			ws_create();
			this.m.Cost = 50;
		}
	})
}
