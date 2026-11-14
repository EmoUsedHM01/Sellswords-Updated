this.ssu_lindwurm_helmet_layered_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		::Legends.Blueprints.onCreate(this, ::Mod_Sellswords.Blueprint.SsuLindwurmHelmet);
		this.blueprint.create();
	}

	// one in four crafts gives the named version
	function onCraft( _stash )
	{
		if (this.Math.rand(1, 4) == 1)
		{
			_stash.add(this.new("scripts/items/legend_helmets/helm/ssu_named_lindwurm_helmet"));
		}
		else
		{
			this.blueprint.onCraft(_stash);
		}
	}

});
