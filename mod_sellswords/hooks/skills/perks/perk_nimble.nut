::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_nimble", function ( q ) {

	q.onBeforeDamageReceived = @( __original ) function( _attacker, _skill, _hitInfo, _properties )
	{
		__original( _attacker, _skill, _hitInfo, _properties );
		if (!::Is_PTR_Exist)
		{
			_properties.DamageReceivedArmorMult *= (1 - (1 - this.getChance()) / 2);
		}
	}
});