::mods_hookExactClass("skills/perks/perk_legend_blend_in", function (o)
{
	local ws_onUpdate = o.onUpdate;
	o.onUpdate = function( _properties )
	{
		ws_onUpdate(_properties);
		_properties.TargetAttractionMult *= 5.0;
	}

});