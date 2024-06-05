this.gain_ap_potion_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.gain_ap_potion";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/misc/ssu_ap_potion_item");
		this.m.Cost = 5000;
		local ingredients = [
			{
				Script = "scripts/items/special/fountain_of_youth_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/potion_of_knowledge_item",
				Num = 1,
			},
			{
				Script = "scripts/items/misc/legend_stollwurm_blood_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/kraken_tentacle_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/mysterious_herbs_item",
				Num = 1,
			},
			{
				Script = "scripts/items/supplies/roots_and_berries_item",
				Num = 1
			}
		];
		this.init(ingredients);

		local skills = [
			{
				Scripts = [
					"scripts/skills/perks/perk_legend_potion_brewer"
				]
			}
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/misc/ssu_ap_potion_item"));
	}

});