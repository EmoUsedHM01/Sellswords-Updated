::Mod_Sellswords.HooksMod.hook("scripts/skills/traits/cocky_trait", function( q ) {
	
	q.onUpdate = @(__original) function( _properties )
	{
		__original(_properties);

		_properties.DamageTooltipMinMult *= 1.2;
		_properties.DamageTooltipMaxMult *= 1.2;		
	}
});
