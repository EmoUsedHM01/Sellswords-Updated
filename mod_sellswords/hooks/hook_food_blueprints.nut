foreach (script in [
	"legend_beer_blueprint",
	"legend_cured_rations_blueprint"
])
{
	::Mod_Sellswords.HooksMod.hook("scripts/crafting/blueprints/food/" + script, function ( q ) {
	
		q.create = @(__original) function()
		{
			__original();
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
	::Mod_Sellswords.HooksMod.hook("scripts/crafting/blueprints/food/" + script, function ( q ) {
	
		q.create = @(__original) function()
		{
			__original();
			this.m.Cost = 50;
		}
	})
}
