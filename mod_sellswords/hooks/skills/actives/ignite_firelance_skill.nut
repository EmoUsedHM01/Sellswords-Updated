::mods_hookExactClass("skills/actives/ignite_firelance_skill", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.HitChanceBonus = 30;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 10;
	}

	local ws_getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = ws_getTooltip();

		foreach (i, tooltip in ret)
		{
			if (tooltip.id != 6 || tooltip.icon != "ui/icons/hitchance.png") continue;

			tooltip.text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+30%[/color] chance to hit";
			break;
		}
		
		return ret;
	}

	local ws_onAnySkillUsed = o.onAnySkillUsed;
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		ws_onAnySkillUsed(_skill, _targetEntity, _properties);

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

	local ws_onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function(_properties)
	{
		ws_onAfterUpdate(_properties);

		if (_properties.IsSpecializedInCrossbows)
		{
			this.m.DirectDamageMult = _properties.IsSpecializedInCrossbows ? 0.25 : 0.15;
			this.m.ActionPointCost -= 1;
		}
	}

})