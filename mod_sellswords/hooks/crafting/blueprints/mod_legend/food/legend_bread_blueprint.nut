::Mod_Sellswords.HooksMod.hook("scripts/crafting/blueprints/food/legend_beer_blueprint", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Cost = 30;
	}
});
