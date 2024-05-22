::mods_hookExactClass("skills/perks/perk_ptr_light_weapon", function ( o )
{
	o.onUpdate = function ( _properties )
	{
		if (!this.isEnabled())
		{
			return;
		}

		_properties.ActionPoints += 1;
		_properties.FatigueEffectMult *= 0.9;
	};
});