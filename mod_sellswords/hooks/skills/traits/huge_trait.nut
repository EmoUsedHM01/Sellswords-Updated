::Mod_Sellswords.HooksMod.hook("scripts/skills/traits/huge_trait", function( q ) {

	q.getTooltip = @(__original) function()
	{
		local tooltip = __original();
		tooltip.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Weapons with extra Fatigue build-up on skills have this penalty reduced by [color=" + ::Const.UI.Color.PositiveValue + "]-3[/color]"
		});

		return tooltip;
	}
});