::mods_hookExactClass("skills/traits/craven_trait", function(o) {
	
	local ws_onUpdate = o.onUpdate;
	o.onUpdate = function( _properties )
	{
		ws_onUpdate(_properties);

		_properties.DamageTooltipMinMult *= 0.9;
		_properties.DamageTooltipMaxMult *= 0.9;			
	}

})