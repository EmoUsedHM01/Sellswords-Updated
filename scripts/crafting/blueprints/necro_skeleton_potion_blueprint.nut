this.necro_skeleton_potion_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.necro_skeleton_potion";
		this.m.Type = this.Const.Items.ItemType.Misc;
		this.m.PreviewCraftable = this.new("scripts/items/misc/necro_skeleton_potion");
		this.m.Cost = 100;
		local ingredients = [
			{
				Script = "scripts/items/misc/mysterious_herbs_item",
				Num = 1
			}
		];
		this.init(ingredients);
		local skills = [
			{
				Scripts = [
					"scripts/skills/backgrounds/necro_lorekeeper"
				]
			}
		];
		this.initSkills(skills);
	}

	function onCraft(_stash)
	{
		_stash.add(this.new("scripts/items/misc/necro_skeleton_potion"));
	}

});