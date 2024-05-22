::mods_hookExactClass("crafting/blueprints/mod_legend/armor/chest/legend_skin_armor_blueprint", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.PreviewCraftable = this.new("scripts/items/legend_armor/plate/cr_skin_armor");
		this.m.PreviewComponents.clear();

		this.init([
			{
				Script = "scripts/items/misc/legend_skin_ghoul_skin_item",
				Num = 4
			},
			{
				Script = "scripts/items/legend_armor/chain/legend_armor_hauberk",
				Num = 1,
				LegendsArmor = true
			}
		]);
	}

	o.onCraft = function( _stash )
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
})

