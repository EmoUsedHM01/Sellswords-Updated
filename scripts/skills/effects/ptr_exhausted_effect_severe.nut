this.ptr_exhausted_effect_severe <- this.inherit("scripts/skills/skill", {
	m = {
		DamageReductionPercentage = 50,
		FatigueBuiltIncrease = 100,
		StartingAPMalus	= 50,
		TurnsLeft = 3		
	},
	function create()
	{
		this.m.ID = "effects.ptr_exhausted_severe";
		this.m.Name = "Exhausted";
		this.m.Description = "This character is exhasuted after a particularly intense turn. This effect will expire at three turns.";
		this.m.Icon = "skills/ptr_exhausted_effect.png";		
		this.m.IconMini = "ptr_exhausted_effect_mini";
		this.m.Overlay = "ptr_exhausted_effect";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		local var = 0.25 + 0.25 * this.m.TurnsLeft;

		tooltip.extend(
			[
				{
					id = 10,
					type = "text",
					icon = "ui/icons/damage_dealt.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.DamageReductionPercentage * var + "%[/color] Damage inflicted"
				},
				{
					id = 10,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = "Skills build [color=" + this.Const.UI.Color.NegativeValue + "]+" + this.m.FatigueBuiltIncrease * var + "%[/color] Fatigue"
				},
				{
					id = 10,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Will start the turn with [color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.StartingAPMalus * var + "%[/color] Action Points"
				},
			]
		);

		return tooltip;
	}

	function onUpdate( _properties )
	{
		if (!this.isGarbage())
		{
			local var = 0.25 + 0.25 * this.m.TurnsLeft;
			_properties.DamageTotalMult *= 1.0 - this.m.DamageReductionPercentage * 0.01 * var;
			_properties.FatigueEffectMult *= 1.0 + this.m.FatigueBuiltIncrease * 0.01 * var;
			_properties.ActionPointsMult *= 1.0 - 0.5 * var;
		}
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}
});
