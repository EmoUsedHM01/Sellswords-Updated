this.banquet_blueprint <- this.inherit("scripts/crafting/legend_food_blueprint", {
	m = {},
	function create()
	{
		this.legend_food_blueprint.create();
		this.m.ID = "blueprint.banquet";
		this.m.PreviewCraftable = this.new("scripts/items/supplies/banquet_item");
		this.m.Cost = 150;		
		local ingredients = [
			{
				Script = "scripts/items/trade/legend_cooking_spices_trade_item",
				Num = 1
			},			
			{
				Script = "scripts/items/supplies/cured_venison_item",
				Num = 1
			},
			{
				Script = "scripts/items/supplies/salad_item",
				Num = 1
			},
			{
				Script = "scripts/items/supplies/legend_porridge_item",
				Num = 1
			},			
			{
				Script = "scripts/items/supplies/wine_item",
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
		_stash.add(this.new("scripts/items/supplies/banquet_item"));
	}

});

