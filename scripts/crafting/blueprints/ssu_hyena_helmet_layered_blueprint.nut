this.ssu_hyena_helmet_layered_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		::Legends.Blueprints.onCreate(this, ::Mod_Sellswords.Blueprint.SsuHyenaHelmet);
		this.blueprint.create();
	}

});
