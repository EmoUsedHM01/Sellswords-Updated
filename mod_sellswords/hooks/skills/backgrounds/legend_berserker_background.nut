::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/legend_berserker_background", function ( q ) {
	q.getTooltip = @(__original) function()
	{
		local ret = this.character_background.getTooltip();
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = ::Mod_Sellswords.Strings.legend_berserker_background.Tooltip
		});
		return ret;
	}
});
