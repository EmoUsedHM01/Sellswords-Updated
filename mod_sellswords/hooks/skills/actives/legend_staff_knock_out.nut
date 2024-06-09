::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_staff_knock_out", function ( q ) {

	q.m.BonusPerNegativeStatusEffect <- 0.33;
	q.m.Effects <- [
		"effects.stunned",
		"effects.staggered",
		"effects.legend_baffled",
		"effects.dazed"
	];

	q.create = @(__original) function()
	{
		__original();

		this.m.DirectDamageMult = 0.95;
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInStaves)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "For each negative effect your target has, deal [color=" + this.Const.UI.Color.PositiveValue + "]33%[/color] more damage"
			});
		}

		return ret;
	}

	q.onAnySkillUsed = @(__original) function(_skill, _targetEntity, _properties)
	{
		if (_skill == this)
		{
			__original(_skill, _targetEntity, _properties);

			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInStaves)
			{
				if (_targetEntity == null || !_skill.isAttack())
					return;

				local count = _targetEntity.getSkills().getSkillsByFunction((@(_skill) this.m.Effects.find(_skill.getID()) != null).bindenv(this)).len();
				_properties.DamageTotalMult *= 1.0 + (count * this.m.BonusPerNegativeStatusEffect);
			}
		}
	}

});
