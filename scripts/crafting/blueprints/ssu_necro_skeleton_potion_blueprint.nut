this.ssu_necro_skeleton_potion_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		::Legends.Blueprints.onCreate(this, ::Mod_Sellswords.Blueprint.SsuNecroSkeletonPotion);
		this.blueprint.create();
	}

});
