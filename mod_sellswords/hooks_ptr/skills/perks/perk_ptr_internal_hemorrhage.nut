::mods_hookExactClass("skills/perks/perk_ptr_internal_hemorrhage", function ( o )
{
	o.onTargetHit = function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || _targetEntity.isDying() || !_skill.isAttack() || (!_skill.getDamageType().contains(this.Const.Damage.DamageType.Blunt) && !this.m.IsForceEnabled))
		{
			return;
		}
		if (!_targetEntity.getCurrentProperties().IsImmuneToBleeding && _damageInflictedHitpoints >= this.Const.Combat.MinDamageToApplyBleeding )
		{
			local hemorrhageDamage = this.Math.floor(_damageInflictedHitpoints * this.m.PercentageOfDamage * 0.01);
			if (hemorrhageDamage < 1)
			{
				return;
			}
			local actor = this.getContainer().getActor();
			local effect = this.new("scripts/skills/effects/bleeding_effect");
			effect.m.ihe = true;
			effect.m.TurnsLeft = 1;				
			if (actor.getFaction() == this.Const.Faction.Player || actor.getFaction() == this.Const.Faction.PlayerAnimals)
			{
				effect.setActor(actor);
			}
			effect.setDamage(hemorrhageDamage);
			_targetEntity.getSkills().add(effect);
		}
	}
});	