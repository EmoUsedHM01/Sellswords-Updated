::mods_hookExactClass("skills/perks/perk_legend_battleheart", function ( o )
{
	o.getBonus <- function ()
	{
		local actor = this.getContainer().getActor();
		//return (::Tactical.Entities.getFactionActors(actor.getFaction(), actor.getTile(), 1).len() - 1) * 3;
		return (::Tactical.Entities.getHostileActors(actor.getFaction(), actor.getTile(), 1).len() - 0) * 3;
	};
	
	o.onUpdate = function ( _properties )
	{
		_properties.IsImmuneToSurrounding = true;
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			return;
		}

		local bonus = this.getBonus();
		if (bonus > 0)
		{
			_properties.Bravery += this.getBonus();			
		}
	};
});	