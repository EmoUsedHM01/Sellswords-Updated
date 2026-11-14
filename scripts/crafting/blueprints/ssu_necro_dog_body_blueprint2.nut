this.ssu_necro_dog_body_blueprint2 <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		::Legends.Blueprints.onCreate(this, ::Mod_Sellswords.Blueprint.SsuNecroDogBody2);
		this.blueprint.create();
	}

});
