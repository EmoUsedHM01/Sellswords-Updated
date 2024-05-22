::mods_hookExactClass("skills/actives/ptr_staff_sweep_skill", function(o) {
	o.m.BonusPerNegativeStatusEffect <- 0.33;
	o.m.Effects <- [
		"effects.stunned",
		"effects.staggered",
		"effects.legend_baffled",
		"effects.dazed"
	];

	local ws_create = o.create;
	o.create = function()
	{
		ws_create();

		this.m.DirectDamageMult = 0.95;
	}

	local ws_getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = ws_getTooltip();

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInStaves)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Target's every negative effect will make you deal [color=" + this.Const.UI.Color.PositiveValue + "]33%[/color] more damage"
			});
		}

		return ret;
	}

	local ws_onAnySkillUsed = o.onAnySkillUsed;
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{	
		if (_skill == this)
		{
			ws_onAnySkillUsed( _skill, _targetEntity, _properties );
			
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInStaves)
			{
				if (_targetEntity == null || !_skill.isAttack())
				{
					return;
				}			
				local count = _targetEntity.getSkills().getSkillsByFunction((@(_skill) this.m.Effects.find(_skill.getID()) != null).bindenv(this)).len();
				_properties.DamageTotalMult *= 1.0 + (count * this.m.BonusPerNegativeStatusEffect);				
			}			
		}
	}

})