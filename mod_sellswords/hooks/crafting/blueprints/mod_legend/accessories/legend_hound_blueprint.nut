::Mod_Sellswords.HooksMod.hook("scripts/crafting/blueprints/mod_legend/accessories/legend_hound_blueprint", function( q ) {

	q.create = @(__original) function()
	{
		ws_create();
		this.m.Cost = 250;
	}
});
