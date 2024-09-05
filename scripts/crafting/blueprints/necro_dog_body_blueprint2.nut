this.necro_dog_body_blueprint2 <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.necro_dog_body2";
		this.m.Type = this.Const.Items.ItemType.Misc;
		this.m.PreviewCraftable = this.new("scripts/items/spawns/zombie_dog");
		this.m.Cost = 100;
		local ingredients = [
			{
				Script = "scripts/items/accessory/armored_wardog_item",
				Num = 1
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
					"scripts/skills/perks/perk_summon_zombie_dog"
				]
			}
		];
		this.initSkills(skills);
	}

	function onCraft(_stash)
	{
		_stash.add(this.new("scripts/items/spawns/zombie_dog"));
	}

});