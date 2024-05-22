this.salad_blueprint <- this.inherit("scripts/crafting/food_blueprint", {
	m = {},
	function create()
	{
		this.food_blueprint.create();
		this.m.ID = "blueprint.salad";
		this.m.PreviewCraftable = this.new("scripts/items/supplies/salad_item");
		this.m.Cost = 50;		
		local ingredients = [
			{
				Script = "scripts/items/trade/legend_cooking_spices_trade_item",
				Num = 1
			},			
			{
				Script = "scripts/items/supplies/dried_fruits_item",
				Num = 1
			},
			{
				Script = "scripts/items/supplies/dates_item",
				Num = 1
			},			
			{
				Script = "scripts/items/supplies/roots_and_berries_item",
				Num = 1
			}			
		];
		this.init(ingredients);
		local skills = [
			{
				Scripts = ["scripts/skills/perks/perk_legend_camp_cook"]
			}
		]
		this.initSkills(skills);		

	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/supplies/salad_item"));
	}

});

