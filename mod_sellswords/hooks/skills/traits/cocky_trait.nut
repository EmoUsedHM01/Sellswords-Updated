::mods_hookExactClass("skills/traits/cocky_trait", function(o) {
	
	local ws_onUpdate = o.onUpdate;
	o.onUpdate = function( _properties )
	{
		ws_onUpdate(_properties);

		_properties.DamageTooltipMinMult *= 1.2;
		_properties.DamageTooltipMaxMult *= 1.2;		
	}

})