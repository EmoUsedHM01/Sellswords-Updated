::mods_hookExactClass("skills/perks/perk_ptr_man_of_steel", function ( o )
{
	o.onBeforeDamageReceived = function( _attacker, _skill, _hitInfo, _properties )
	{
		local p = this.getContainer().getActor().isPlayerControlled() ? 1.667 : 1.333;
		_properties.ArmorMult[_hitInfo.BodyPart] *= p;
	}
});	