::mods_hookExactClass("skills/perks/perk_ptr_mauler", function ( o )
{
	o.getBonusBody <- function( _targetEntity )
	{
		local remainingArmorFraction = _targetEntity.getArmor(this.Const.BodyPart.Body)/(_targetEntity.getArmorMax(this.Const.BodyPart.Body) + 1);
		return 0.01 * this.m.MaxBonus * (1.0 - remainingArmorFraction);
	}	
	
	o.getBonusHead <- function( _targetEntity )
	{
		local remainingArmorFraction = _targetEntity.getArmor(this.Const.BodyPart.Head)/(_targetEntity.getArmorMax(this.Const.BodyPart.Head) + 1);
		return 0.01 * this.m.MaxBonus * (1.0 - remainingArmorFraction);
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (!_skill.isAttack() || _targetEntity == null || !this.isEnabled())
		{
			return;
		}

		//_properties.DamageTotalMult *= 1.0 + this.getBonus(_targetEntity);
		_properties.DamageAgainstMult[this.Const.BodyPart.Body] *= 1.0 + this.getBonusBody(_targetEntity);			
		_properties.DamageAgainstMult[this.Const.BodyPart.Head] *= 1.0 + this.getBonusHead(_targetEntity);		
	}
});	