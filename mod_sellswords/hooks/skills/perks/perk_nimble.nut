::mods_hookExactClass("skills/perks/perk_nimble", function(o) 
{
	local ws_onBeforeDamageReceived = o.onBeforeDamageReceived;
	o.onBeforeDamageReceived = function( _attacker, _skill, _hitInfo, _properties )
	{
		ws_onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties );
		if (!::Is_PTR_Exist)
		{
			_properties.DamageReceivedArmorMult *= (1 - (1 - this.getChance()) / 2);
		}
	}
});