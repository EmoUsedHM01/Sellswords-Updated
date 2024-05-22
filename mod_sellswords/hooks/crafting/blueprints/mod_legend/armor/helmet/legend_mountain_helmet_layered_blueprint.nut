::mods_hookExactClass("crafting/blueprints/mod_legend/armor/helmet/legend_mountain_helmet_layered_blueprint", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.PreviewCraftable = this.new("scripts/items/legend_helmets/helm/cr_mountain_helmet");
		this.m.PreviewComponents.clear();

		this.init([
			{
				Script = "scripts/items/misc/legend_rock_unhold_bones_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/legend_rock_unhold_hide_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/unhold_hide_item",
				Num = 2
			},
			{
				Script = "scripts/items/legend_helmets/helm/legend_helmet_great_helm",
				Num = 1
			}
		]);
	}

	o.onCraft = function( _stash )
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
})

