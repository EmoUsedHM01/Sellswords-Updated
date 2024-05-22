::mods_hookExactClass("skills/perks/perk_ptr_survival_instinct", function ( o )
{
	o.onBeforeDamageReceived = function ( _attacker, _skill, _hitInfo, _properties )
	{
	}
	o.onDamageReceived <- function ( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_attacker == null || _attacker == this.getContainer().getActor())
		{
			return;
		}		
		if (_damageHitpoints > this.getContainer().getActor().getHitpointsMax() / 4)
		{
			return;
		}
		this.m.HitStacks += 1;			
	}		
});	