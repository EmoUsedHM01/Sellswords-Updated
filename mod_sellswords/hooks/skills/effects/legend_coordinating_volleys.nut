::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/legend_coordinating_volleys", function( q ) {

	q.getTooltip = @(__original) function()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]10[/color] ranged attack to all allies within [color=" + this.Const.UI.Color.PositiveValue + "]4[/color] tiles for one turn"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "The penalty from ranged cover is reduced by [color=" + this.Const.UI.Color.PositiveValue + "]20%[/color]"
			}
		]);
		return tooltip;
	}

	q.onUpdate = @(__original) function( _properties )
	{
		_properties.RangedSkill += 10;
		_properties.RangedAttackBlockedChanceMult *= 0.8;
	}

});	