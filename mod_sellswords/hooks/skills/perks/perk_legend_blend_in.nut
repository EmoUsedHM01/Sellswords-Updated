::mods_hookExactClass("skills/perks/perk_legend_blend_in", function ( o )
{
	if ("onUpdate" in o)
	{
		local ws_onUpdate = o.onUpdate;
		o.onUpdate = function( _properties )
		{
			ws_onUpdate(_properties);
			_properties.TargetAttractionMult *= 5.0;
		}
	}
	else
	{
		o.onUpdate <- function( _properties )
		{
			_properties.MeleeDefense += 3;
			_properties.RangedDefense += 5;
			_properties.TargetAttractionMult *= 0.5;
		}
	}
	
});	