::mods_hookExactClass("skills/traits/insecure_trait", function(o) {
	
	o.onUpdate <- function( _properties )
	{
		_properties.DamageTooltipMinMult *= 0.8;
		_properties.DamageTooltipMaxMult *= 0.8;			
	}	

})