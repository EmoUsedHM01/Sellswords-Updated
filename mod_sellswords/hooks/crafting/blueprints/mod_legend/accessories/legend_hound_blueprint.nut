::Mod_Sellswords.HooksMod.hook("scripts/crafting/blueprints/accessories/legend_hound_blueprint", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Cost = 250;
	}
});
