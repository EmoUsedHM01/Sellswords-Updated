::mods_hookExactClass("items/weapons/weapon", function ( o )
{
	o.onDamageDealt = function ( _target, _skill, _hitInfo )
	{
		local actor = this.getContainer().getActor();
		local pe = actor.getSkills().hasSkill("perk.ptr_pointy_end") && _skill.getDamageType().contains(this.Const.Damage.DamageType.Piercing) && !_target.isArmedWithShield();
		if (actor == null || actor.isNull())
		{
			return;
		}
		if (actor.isPlayerControlled() && _skill.getDirectDamage() < 1.0 && !_skill.isRanged() && this.m.ConditionMax > 1)
		{
			if (_target.getArmorMax(_hitInfo.BodyPart) >= 50 && _hitInfo.DamageInflictedArmor >= 5 || this.m.ConditionMax == 2)
			{
				if ( pe )
				{
					this.lowerCondition(2);
				}
				else
				{
					this.lowerCondition();
				}					
			}
		}
	}
});	