this.cr_lindwurm_helmet_layered_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.cr_lindwurm_helmet_layered_blueprint";
		this.m.Type = this.Const.Items.ItemType.Helmet;
		this.m.PreviewCraftable = this.new("scripts/items/legend_helmets/helm/cr_lindwurm_helmet");
		this.m.Cost = 1000;
		local ingredients = [
			{
				Script = "scripts/items/misc/lindwurm_scales_item",
				Num = 2
			},
			{
				Script = "scripts/items/legend_helmets/top/legend_helmet_chain_attachment",
				Num = 1
			},
			{
				Script = "scripts/items/legend_helmets/helm/legend_helmet_norman_helm",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function isQualified()
	{
		return this.blueprint.isQualified();
	}

	function onCraft( _stash )
	{
		local r = this.Math.rand(1, 4);

		if (r == 1)
		{
			_stash.add(this.new("scripts/items/legend_helmets/helm/cr_named_lindwurm_helmet"));
		}
		else
		{
			_stash.add(this.new("scripts/items/legend_helmets/helm/cr_lindwurm_helmet.nut"));
		}
	}

});

