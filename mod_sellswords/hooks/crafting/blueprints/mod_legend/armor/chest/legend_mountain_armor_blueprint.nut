::mods_hookExactClass("crafting/blueprints/mod_legend/armor/chest/legend_mountain_armor_blueprint", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.PreviewCraftable = this.new("scripts/items/legend_armor/plate/cr_mountain_armor");
		this.m.PreviewComponents.clear();

		this.init([
			{
				Script = "scripts/items/misc/legend_rock_unhold_bones_item",
				Num = 2
			},
			{
				Script = "scripts/items/misc/legend_rock_unhold_hide_item",
				Num = 2
			},
			{
				Script = "scripts/items/misc/unhold_hide_item",
				Num = 2
			},
			{
				Script = "scripts/items/legend_armor/plate/legend_armor_plate_chest",
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
			_stash.add(this.new("scripts/items/legend_armor/plate/cr_named_mountain_armor"));
		}
		else
		{
			_stash.add(this.new("scripts/items/legend_armor/plate/cr_mountain_armor"));
		}
	}
})

