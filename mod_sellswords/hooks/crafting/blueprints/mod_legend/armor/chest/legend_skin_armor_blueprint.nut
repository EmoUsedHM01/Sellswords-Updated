::Mod_Sellswords.HooksMod.hook("scripts/crafting/blueprints/armor/chest/legend_skin_armor_blueprint", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.PreviewCraftable = this.new("scripts/items/legend_armor/plate/cr_skin_armor");
		this.m.PreviewComponents.clear();

		local ingredients = [
			{
				Script = "scripts/items/misc/legend_skin_ghoul_skin_item",
				Num = 5
			},
			{
				Script = "scripts/items/misc/legend_masterwork_fabric",
				Num = 1
			},
			{
				Script = "scripts/items/misc/legend_masterwork_tools",
				Num = 1
			}
		];

	    this.init(ingredients);
	}

	q.onCraft = @(__original) function( _stash )
	{
		local r = this.Math.rand(1, 4);

		if (r == 1)
		{
			_stash.add(this.new("scripts/items/legend_armor/plate/cr_named_skin_armor"));
		}
		else
		{
			_stash.add(this.new("scripts/items/legend_armor/plate/cr_skin_armor"));
		}
	}
});
