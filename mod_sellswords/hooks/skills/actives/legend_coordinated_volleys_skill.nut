::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_coordinated_volleys_skill", function ( q ) {

	q.getTooltip = @( __original ) function()
	{
		local tooltip = this.skill.getDefaultUtilityTooltip();
		tooltip.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = ::Mod_Sellswords.Strings.legend_coordinated_volleys_skill.Tooltip1
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = ::Mod_Sellswords.Strings.legend_coordinated_volleys_skill.Tooltip2
			}
		]);
		return tooltip;
	}
});