::mods_hookExactClass("skills/perks/perk_ptr_long_reach", function ( o )
{
	o.onUpdate <- function ( _properties )
	{
		if (!this.isEnabled())
		{
			return;
		}		
		_properties.SurroundedBonus += 1.5;
	}
});	