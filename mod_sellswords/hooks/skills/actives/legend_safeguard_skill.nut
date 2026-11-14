::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_safeguard_skill", function ( q ) {

	q.getTooltip = @( __original ) function ()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.legend_safeguard_skill.Tooltip
		});
		return ret;
	}
});
