::mods_hookExactClass("skills/perks/perk_legend_terrifying_visage", function ( o )
{
	o.onUpdate = function ( _properties )
	{
		_properties.Threat += 20;
	};
});