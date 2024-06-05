::Mod_Sellswords.HooksMod.hook("scripts/crafting/blueprints/mod_legend/accessories/legend_dog_blueprint", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Cost = 300;
	}
});
