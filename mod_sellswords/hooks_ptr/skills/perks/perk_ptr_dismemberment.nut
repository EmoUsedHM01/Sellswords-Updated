::mods_hookExactClass("skills/perks/perk_ptr_dismemberment", function ( o )
{
	o.m.PercentageOfMaximumDamage = 30;

	local ws_onAnySkillUsed = o.onAnySkillUsed;
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() && (_skill.getDamageType().contains(this.Const.Damage.DamageType.Cutting) || this.m.IsForceEnabled) && this.isEnabled())
		{
			ws_onAnySkillUsed( _skill, _targetEntity, _properties );
			if (_targetEntity != null && _targetEntity.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
			{
				_properties.DamageTotalMult *= 1.1;
			}			
		}		
	}
});	