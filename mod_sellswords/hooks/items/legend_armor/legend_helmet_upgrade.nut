::Mod_Sellswords.HooksMod.hook("scripts/items/legend_helmets/legend_helmet_upgrade", function ( q ) {

	q.m.InitiativeModifier <- 0;

	q.getInitiativeModifier <- function()
	{
		return this.m.InitiativeModifier;
	}

	q.onUpdateProperties <- function(_properties)
	{
		if (this.getInitiativeModifier() != 0) _properties.Initiative += this.getInitiativeModifier();
	}

});