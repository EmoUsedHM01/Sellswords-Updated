::mods_hookExactClass("skills/effects/ptr_arrow_to_the_knee_debuff_effect", function ( o )
{
	o.getTooltip = function ()
	{
		local tooltip = this.skill.getTooltip();
		local defenseMalus = this.m.TurnsLeft * this.m.DefMalusPercentagePerTurnLeft;
		local APMalus = this.m.TurnsLeft * this.m.MovementAPCostAdditionalPerTurnLeft;
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + defenseMalus + "%[/color] Melee Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + defenseMalus + "%[/color] Ranged Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]+" + APMalus + "[/color] additional Action Points per tile moved"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] turns remaining. This effect will reduce in intensity with fewer turns remaining."
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + 3 * defenseMalus + "[/color] initiative"
			}
		]);
		return tooltip;
	};
	o.onUpdate = function ( _properties )
	{
		_properties.MeleeDefenseMult *= 1.0 - this.m.TurnsLeft * this.m.DefMalusPercentagePerTurnLeft * 0.01;
		_properties.RangedDefenseMult *= 1.0 - this.m.TurnsLeft * this.m.DefMalusPercentagePerTurnLeft * 0.01;
		_properties.MovementAPCostAdditional += this.m.TurnsLeft * this.m.MovementAPCostAdditionalPerTurnLeft;
		_properties.InitiativeMult *= 1.0 - this.m.TurnsLeft * this.m.DefMalusPercentagePerTurnLeft * 0.03;
	};
});