::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/weapon", function ( q ) {
	q.onDamageDealt = @(__original) function( _target, _skill, _hitInfo )
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

	q.addSkill = @(__original) function( _skill )
	{
		this.item.addSkill(_skill);

		if (_skill.isType(this.Const.SkillType.Active))
		{
			local actor = this.getContainer().getActor();
			local fatigueOnSkillUse = this.m.FatigueOnSkillUse;

			if (fatigueOnSkillUse > 0)
			{
				if (actor.getCurrentProperties().IsProficientWithHeavyWeapons)
				{
					fatigueOnSkillUse = 0;
				}
				else if (actor.getSkills().hasSkill("trait.huge") && actor.getSkills().hasSkill("trait.strong"))
				{
					fatigueOnSkillUse = 0;
				}
				else if (actor.getSkills().hasSkill("trait.huge"))
				{
					fatigueOnSkillUse -= 3;
				}
				// might just make a positive trait too good
				// else if (actor.getSkills().hasSkill("trait.strong"))
				// {
				// 	fatigueOnSkillUse -= 1;
				// }

				fatigueOnSkillUse = this.Math.max(0, fatigueOnSkillUse)
			}

			_skill.setFatigueCost(this.Math.max(0, _skill.getFatigueCostRaw() + fatigueOnSkillUse));
		}
	}
});	
