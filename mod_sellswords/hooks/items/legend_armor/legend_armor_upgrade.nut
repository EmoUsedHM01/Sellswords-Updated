// ngl this seems a bit redundant
::mods_hookExactClass("items/legend_armor/legend_armor_upgrade", function ( o )
{
	o.onUpdateProperties = function ( _properties )
	{
		if (this.getInitiativeModifier() != 0)
		{
			_properties.Initiative += this.getInitiativeModifier();
		}

		if (this.getThreatModifier() != 0)
		{
			_properties.Threat += this.getThreatModifier();
		}

		if (this.getResolveModifier() != 0)
		{
			_properties.Bravery += this.getResolveModifier();
		}
	}		
});		