this.cr_acid_flask_02_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.cr_acid_flask_02";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/tools/acid_flask_item_02");
		this.m.Cost = 150;
		local ingredients = [
			{
				Script = "scripts/items/misc/legend_stollwurm_blood_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/tools/acid_flask_item_02"));
	}

});

