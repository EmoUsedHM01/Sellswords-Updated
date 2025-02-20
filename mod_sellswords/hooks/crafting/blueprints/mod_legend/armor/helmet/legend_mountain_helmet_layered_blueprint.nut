::Mod_Sellswords.HooksMod.hook("scripts/crafting/blueprints/armor/helmet/legend_mountain_helmet_layered_blueprint", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.PreviewCraftable = this.new("scripts/items/legend_helmets/helm/cr_mountain_helmet");
		this.m.PreviewComponents.clear();

		local ingredients = [
			{
				Script = "scripts/items/misc/legend_rock_unhold_bones_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/legend_rock_unhold_hide_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/legend_masterwork_metal",
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
			_stash.add(this.new("scripts/items/legend_helmets/helm/cr_named_mountain_helmet"));
		}
		else
		{
			_stash.add(this.new("scripts/items/legend_helmets/helm/cr_mountain_helmet"));
		}
	}
});
