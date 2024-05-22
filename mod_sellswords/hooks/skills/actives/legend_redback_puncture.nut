::mods_hookExactClass("skills/actives/legend_redback_puncture", function ( o )
{
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.HitChanceBonus = 0;
	}

	o.getHitChance = function ( _targetEntity )
	{
		if (_targetEntity == null)
		{
			return 0;
		}

		local mod = 0;

		if (_targetEntity.getSkills().hasSkill("effects.legend_dazed"))
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
	o.onGetHitFactors <- function ( _skill, _targetTile, _tooltip )
	{
		if (_skill.getID() != "actives.legend_redback_puncture")
		{
			return;
		}		
		local targetEntity = _targetTile.getEntity();
		local targetArmor = targetEntity.getArmor(this.Const.BodyPart.Body);		
		if (targetArmor > 125)
		{
			local modarmor = this.Math.min(35, (targetArmor - 125) / 5);
			_tooltip.push({
				icon = "ui/tooltips/negative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]" + modarmor + "%[/color] Firm armor"
			});				
		}	
		local modvigor = this.Math.floor((1.0 - targetEntity.getFatiguePct()) * 50);			
		_tooltip.push({
			icon = "ui/tooltips/negative.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]" + modvigor + "%[/color] Fresh and energetic"
		});	
		local mod = 0;
		if (targetEntity.getSkills().hasSkill("effects.legend_dazed"))
		{
			mod = mod + 10;
		}
		if (targetEntity.getSkills().hasSkill("effects.legend_parried"))
		{
			mod = mod + 10;
		}
		if (targetEntity.getSkills().hasSkill("effects.legend_grappled"))
		{
			mod = mod + 30;
		}
		if (targetEntity.getSkills().hasSkill("effects.stunned"))
		{
			mod = mod + 20;
		}
		if (targetEntity.getSkills().hasSkill("effects.sleeping"))
		{
			mod = mod + 30;
		}
		if (targetEntity.getSkills().hasSkill("effects.net"))
		{
			mod = mod + 25;
		}
		if (targetEntity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			mod = mod + 50;
		}	
		if (mod > 0)
		{
			_tooltip.push({
				icon = "ui/tooltips/positive.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + mod + "%[/color] Negative status"
			});	
		}
	}		
	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
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
				if (this.getContainer().hasSkill("perk.crGrandslam"))
				{
					_properties.DamageTotalMult /= 1.5;
				}
				else
				{
					_properties.DamageTotalMult /= 1.25;
				}
			}
		}
	};	
	o.onAfterUpdate = function ( _properties )
	{
		if (_properties.IsSpecializedInDaggers)
		{
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
			this.m.ActionPointCost -= 1;
		}
	};
	o.getTooltip = function ()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Hit chance determined by your target's fatigue, remaining body armor and negative status like stunned, netted, grappled, etc. [color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color] hitchance if they are fresh and [color=" + this.Const.UI.Color.NegativeValue + "]-0%[/color] if they are exhausted. Also has [color=" + this.Const.UI.Color.NegativeValue + "]-1%[/color] chance to hit for every 5 points of Body Armor durability the target has above 125, up to a maximum of [color=" + this.Const.UI.Color.NegativeValue + "]-35%[/color]. While negative status can provide you a total of [color=" + this.Const.UI.Color.PositiveValue + "]+175%[/color] bonus."
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Completely ignores armor"
			}
		]);
		return ret;
	}		
});