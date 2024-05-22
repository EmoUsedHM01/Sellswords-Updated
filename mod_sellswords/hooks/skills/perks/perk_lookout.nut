::mods_hookExactClass("skills/perks/perk_lookout", function ( o )
{
	o.onUpdate = function ( _properties )
	{
		_properties.Vision += 1;
		if (!this.World.getTime().IsDaytime && this.getContainer().getActor().isPlacedOnMap())
		{
			_properties.Vision += 1;			
			_properties.RangedSkillMult *= 1.215;
			_properties.RangedDefenseMult *= 1.215;			
		}			
	}
});	