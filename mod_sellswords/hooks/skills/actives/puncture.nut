::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/puncture", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.HitChanceBonus = 0;
	}
	q.getHitChance = @( __original ) function ( _targetEntity )
	{
		if (_targetEntity == null)
		{
			return 0;
		}

		local mod = 0;

		if (_targetEntity.getSkills().hasSkill("effects.dazed"))
		{
			mod = mod + 10;
		}

		if (_targetEntity.getSkills().hasSkill("effects.legend_parried"))
		{
			mod = mod + 10;
		}

		if (_targetEntity.getSkills().hasSkill("effects.legend_grappled"))
		{
			mod = mod + 30;
		}

		if (_targetEntity.getSkills().hasSkill("effects.stunned"))
		{
			mod = mod + 20;
		}

		if (_targetEntity.getSkills().hasSkill("effects.sleeping"))
		{
			mod = mod + 30;
		}

		if (_targetEntity.getSkills().hasSkill("effects.net"))
		{
			mod = mod + 25;
		}

		if (_targetEntity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			mod = mod + 50;
		}

		if (_targetEntity != null && this.getContainer().getActor().isPlayerControlled())
		{
			local targetArmor = _targetEntity.getArmor(this.Const.BodyPart.Body);

			if (targetArmor > 125)
			{
				mod = mod - this.Math.min(35, (targetArmor - 125) / 5);
			}
		}

		local chance = (1.0 - _targetEntity.getFatiguePct()) * 50;
		return mod - this.Math.round(chance);
	};
	q.onAnySkillUsed = @( __original) function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			local chance = this.getHitChance(_targetEntity);

			if (_properties.IsSpecializedInDaggers)
			{
				chance = chance + 15;
			}

			_properties.MeleeSkill += chance;
			_properties.DamageArmorMult *= 0.0;
			_properties.IsIgnoringArmorOnAttack = true;
			_properties.HitChanceMult[this.Const.BodyPart.Head] = 0.0;
			_properties.HitChanceMult[this.Const.BodyPart.Body] = 1.0;

			if (this.canDoubleGrip())
			{
				if (::Legends.Perks.has(this, ::Legends.Perk.SsuGrandslam))
				{
					_properties.DamageTotalMult /= 1.25;
				}
				else
				{
					_properties.DamageTotalMult /= 1.0;
				}
			}
		}
	};
	q.onAfterUpdate = @( __original ) function ( _properties )
	{
		if (_properties.IsSpecializedInDaggers)
		{
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
			this.m.ActionPointCost -= 1;
		}
	};
	q.getTooltip = @( __original ) function ()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = ::Mod_Sellswords.Strings.puncture.Tooltip1
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.puncture.Tooltip2
			}
		]);
		return ret;
	}		
});
