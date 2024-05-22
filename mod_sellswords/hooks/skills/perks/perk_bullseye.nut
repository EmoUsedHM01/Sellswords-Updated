::mods_hookExactClass("skills/perks/perk_bullseye", function ( o )
{
	o.onUpdate = function ( _properties )
	{
		_properties.RangedAttackBlockedChanceMult *= 0.44;
	}
});	