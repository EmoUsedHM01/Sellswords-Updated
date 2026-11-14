::Mod_Sellswords.HooksMod.hook("scripts/skills/effects/legend_coordinating_volleys_effect", function( q ) {

	q.getTooltip = @(__original) function()
	{
		local tooltip = __original();

		tooltip.push({
			id = 11,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = ::Mod_Sellswords.Strings.legend_coordinating_volleys_effect.Tooltip
		});

		return tooltip;
	}

	q.onUpdate = @(__original) function( _properties )
	{
		__original(_properties);

		_properties.RangedAttackBlockedChanceMult *= 0.8;
	}

});
