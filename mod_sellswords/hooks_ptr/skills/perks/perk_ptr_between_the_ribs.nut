::mods_hookExactClass("skills/perks/perk_ptr_between_the_ribs", function ( o )
{
	o.m.DamageBonusPerSurroundCount = 0.035;

	o.onUpdate <- function( _properties )
	{
		local minus = this.Math.min(_properties.HitChance[this.Const.BodyPart.Head], 25);
		_properties.HitChance[this.Const.BodyPart.Head] -= minus;
	}	

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (!_skill.isAttack() || _targetEntity == null || _targetEntity.getCurrentProperties().IsImmuneToSurrounding || _targetEntity.isAlliedWith(this.getContainer().getActor()))
		{
			return;
		}

		local count = _targetEntity.getSurroundedCount();		
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null && weapon.isWeaponType(this.Const.Items.WeaponType.Dagger))
		{
			count *= 1.5;
		}
		
		//if (_skill.isAttack() && (this.m.IsForceEnabled || (!_skill.isRanged() &&  _skill.getDamageType().contains(this.Const.Damage.DamageType.Piercing))))
		if (_skill.isAttack() && (this.m.IsForceEnabled || !_skill.isRanged()))		
		{
			_properties.DamageTotalMult *= 1.0 + (this.m.DamageBonusPerSurroundCount * count);
		}
	}
});	