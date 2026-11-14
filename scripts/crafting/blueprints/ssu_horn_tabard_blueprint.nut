this.ssu_horn_tabard_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		::Legends.Blueprints.onCreate(this, ::Mod_Sellswords.Blueprint.SsuHornTabard);
		this.blueprint.create();
	}

});
