::Mod_Sellswords.HooksMod.hook("scripts/crafting/blueprints/legend_lindwurm_scale_armor_blueprint", function ( q ) {

	// one in four crafts gives the named version
	q.onCraft = @(__original) function( _stash )
	{
		if (this.Math.rand(1, 4) == 1)
		{
			_stash.add(this.new("scripts/items/legend_armor/plate/ssu_named_lindwurm_armor"));
		}
		else
		{
			__original(_stash);
		}
	}
});
