::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/ignite_firelance_skill", function ( q ) {

	q.create = @(__original) function()
	{
		__original();

		this.m.HitChanceBonus = 30;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 10;
	}

	q.getTooltip = @( __original ) function()
	{
		local ret = __original();

		foreach (i, tooltip in ret)
		{
			if (tooltip.id != 6 || tooltip.icon != "ui/icons/hitchance.png") continue;

			tooltip.text = "Has [color=%positive%]+30%[/color] chance to hit";
			break;
		}
		
		return ret;
	}

	q.onAnySkillUsed = @( __original ) function( _skill, _targetEntity, _properties )
	{
		__original(_skill, _targetEntity, _properties);

		if (_skill == this)
		{
			_properties.RangedSkill -= 10;
			_properties.DamageRegularMax += 10;
			_properties.DamageArmorMult -= 0.2;

			if (this.getContainer().hasSkill("perk.ptr_muscle_memory"))
			{
				_properties.DamageRegularMin += 10;
				_properties.DamageRegularMax += 15;	
				_properties.DamageArmorMult += 0.3;				
			}	
		}
	}

	q.onAfterUpdate = @( __original ) function(_properties)
	{
		__original(_properties);

		if (_properties.IsSpecializedInCrossbows)
		{
			this.m.DirectDamageMult = _properties.IsSpecializedInCrossbows ? 0.25 : 0.15;
			this.m.ActionPointCost -= 1;
		}
	}

});
