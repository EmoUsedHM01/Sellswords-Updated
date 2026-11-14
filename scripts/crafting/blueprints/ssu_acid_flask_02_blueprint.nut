this.ssu_acid_flask_02_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		::Legends.Blueprints.onCreate(this, ::Mod_Sellswords.Blueprint.SsuAcidFlask02);
		this.blueprint.create();
	}

});
