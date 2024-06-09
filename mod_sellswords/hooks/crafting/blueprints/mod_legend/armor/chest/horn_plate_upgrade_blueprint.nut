::Mod_Sellswords.HooksMod.hook("scripts/crafting/blueprints/horn_plate_upgrade_blueprint", function ( q ) {

	q.create = @(__original) function() // Removing the ability to craft the Kraken armour attachment as SSU replaces it with a Tabard layer
	{
	}

	q.onCraft = @(__original) function( _stash )
	{
	}
})

