this.ssu_necro_human_body_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		::Legends.Blueprints.onCreate(this, ::Mod_Sellswords.Blueprint.SsuNecroHumanBody);
		this.blueprint.create();
	}

});
