::mods_hookExactClass("skills/perks/perk_ptr_bear_down", function ( o )
{
	o.onBeforeDamageReceived <- function( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance())
		{
			return;
		}		
		local count = _attacker.getSkills().getSkillsByFunction((@(_skill) this.m.Effects.find(_skill.getID()) != null).bindenv(this)).len();
		//_properties.DamageReceivedRegularMult *= 1.0 - (count * this.m.BonusPerNegativeStatusEffect);
		_properties.DamageReceivedTotalMult = 1.0 - (count * this.m.BonusPerNegativeStatusEffect);		
	}
});	