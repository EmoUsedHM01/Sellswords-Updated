::mods_hookExactClass("crafting/blueprints/horn_plate_upgrade_blueprint", function(o) {

	o.create = function() // Removing the ability to craft the Kraken armour attachment as SSU replaces it with a Tabard layer
	{
	}

	o.onCraft = function( _stash )
	{
	}
})

