::Mod_Sellswords.HooksMod.hook("scripts/skills/traits/insecure_trait", function( q ) {

	q.onUpdate <- function( _properties )
	{
		_properties.DamageTooltipMinMult *= 0.8;
		_properties.DamageTooltipMaxMult *= 0.8;
	}
});
