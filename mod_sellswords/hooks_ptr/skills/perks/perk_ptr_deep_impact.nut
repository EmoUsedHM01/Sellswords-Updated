::mods_hookExactClass("skills/perks/perk_ptr_deep_impact", function ( o )
{
	o.onBeforeTargetHit = function ( _skill, _targetEntity, _hitInfo )
	{
		if (_skill.isAttack() && (_hitInfo.DamageType == ::Const.Damage.DamageType.Blunt || this.m.IsForceEnabled))
		{
			::Const.Combat.ArmorDirectDamageMitigationMult *= 0.9 - this.m.AppliedMultiplier;
			this.m.DidApply = true;
		}
	}
	o.onTargetHit = function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (this.m.DidApply)
		{
			::Const.Combat.ArmorDirectDamageMitigationMult /= 0.9 - this.m.AppliedMultiplier;
			this.m.DidApply = false;
		}
	}
});	