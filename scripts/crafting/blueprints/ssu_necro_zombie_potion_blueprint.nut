this.ssu_necro_zombie_potion_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		::Legends.Blueprints.onCreate(this, ::Mod_Sellswords.Blueprint.SsuNecroZombiePotion);
		this.blueprint.create();
	}

});
