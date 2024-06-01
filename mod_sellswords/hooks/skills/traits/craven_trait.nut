::Mod_Sellswords.HooksMod.hook("scripts/skills/traits/craven_trait", function( q ) {
	
	q.onUpdate = @(__original) function( _properties )
	{
		__original(_properties);

		_properties.DamageTooltipMinMult *= 0.9;
		_properties.DamageTooltipMaxMult *= 0.9;			
	}
});
