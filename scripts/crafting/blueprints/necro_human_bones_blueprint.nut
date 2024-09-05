this.necro_human_bones_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.necro_human_bones";
		this.m.Type = this.Const.Items.ItemType.Misc;
		this.m.PreviewCraftable = this.new("scripts/items/spawns/skeleton_item");
		this.m.Cost = 150;
		local ingredients = [
			{
				Script = "scripts/items/legend_armor/plate/legend_armor_plate_ancient_chest",
				Num = 1,
				LegendsArmor = true
			},
			{
				Script = "scripts/items/legend_helmets/helm/legend_helmet_ancient_face_plate",
				Num = 1,
				LegendsArmor = true
			}
		];
		this.init(ingredients);
		local skills = [
			{
				Scripts = [
					"scripts/skills/perks/perk_summon_skeleton"
				]
			}
		];
		this.initSkills(skills);
	}

	function onCraft(_stash)
	{
		_stash.add(this.new("scripts/items/spawns/skeleton_item"));
	}

});