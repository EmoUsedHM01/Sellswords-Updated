this.necro_human_body_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.necro_human_body";
		this.m.Type = this.Const.Items.ItemType.Misc;
		this.m.PreviewCraftable = this.new("scripts/items/spawns/legend_zombie_item");
		this.m.Cost = 150;
		local ingredients = [
			{
				Script = "scripts/items/legend_armor/cloth/legend_padded_surcoat",
				Num = 1,
				LegendsArmor = true
			},
			{
				Script = "scripts/items/legend_helmets/hood/legend_helmet_padded_cap",
				Num = 1,
				LegendsArmor = true
			},
			{
				Script = "scripts/items/supplies/strange_meat_item",
				Num = 1
			}
		];
		this.init(ingredients);
		local skills = [
			{
				Scripts = [
					"scripts/skills/perks/perk_summon_zombie"
				]
			}
		];
		this.initSkills(skills);
	}

	function onCraft(_stash)
	{
		_stash.add(this.new("scripts/items/spawns/legend_zombie_item"));
	}

});