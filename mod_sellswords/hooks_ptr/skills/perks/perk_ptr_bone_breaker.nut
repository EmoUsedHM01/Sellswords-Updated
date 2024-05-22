::mods_hookExactClass("skills/perks/perk_ptr_bone_breaker", function ( o )
{
	o.m.BonusVsUndead = 1;
	o.onAnySkillExecuted = function ( _skill, _targetTile, _targetEntity, _forFree )
	{			
	}
	o.onTargetHit = function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_damageInflictedHitpoints < 6 || _targetEntity == null || !_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity.isAlliedWith(this.getContainer().getActor()) || !_skill.isAttack() || !this.isEnabled() || !_skill.getDamageType().contains(this.Const.Damage.DamageType.Blunt))
		{
			return;
		}
		local effect = this.new("scripts/skills/effects/crbonebreaker_effect");	
		_targetEntity.getSkills().add(effect);			
		if (_targetEntity.getSkills().getSkillsByFunction((@(_skill) this.m.ValidEffects.find(_skill.getID()) != null).bindenv(this)).len() > 0 || _damageInflictedHitpoints > 40 || _damageInflictedHitpoints > 0.15 * _targetEntity.getHitpoints())
		{
			_targetEntity.getSkills().add(effect);				
		}
	}		
});