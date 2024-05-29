::Mod_Sellswords.HooksMod.hook("scripts/crafting/blueprints/mod_legend/armor/chest/legend_lindwurm_armor_blueprint", function( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.PreviewCraftable = this.new("scripts/items/legend_armor/plate/cr_lindwurm_armor");
		this.m.PreviewComponents.clear();

		this.init([
			{
				Script = "scripts/items/misc/lindwurm_scales_item",
				Num = 3
			},
			{
				Script = "scripts/items/legend_armor/plate/legend_armor_scale_coat",
				Num = 1,
				LegendsArmor = true
			}
		]);
	}

	q.onCraft = @(__original) function( _stash )
	{
		local r = this.Math.rand(1, 4);

		if (r == 1)
		{
			_stash.add(this.new("scripts/items/legend_armor/plate/cr_named_lindwurm_armor"));
		}
		else
		{
			_stash.add(this.new("scripts/items/legend_armor/plate/cr_lindwurm_armor"));
		}
	}
});
