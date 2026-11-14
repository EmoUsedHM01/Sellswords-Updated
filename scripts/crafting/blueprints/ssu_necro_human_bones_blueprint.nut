this.ssu_necro_human_bones_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		::Legends.Blueprints.onCreate(this, ::Mod_Sellswords.Blueprint.SsuNecroHumanBones);
		this.blueprint.create();
	}

});
