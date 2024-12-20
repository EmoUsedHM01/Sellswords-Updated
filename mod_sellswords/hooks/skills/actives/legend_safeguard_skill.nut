::Mod_Sellswords.HooksMod.hook("scripts/skills/actives/legend_safeguard_skill", function ( q ) {

	q.getTooltip = @( __original ) function ()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Applies Safeguard to someone, increasing their defenses by [color=" + this.Const.UI.Color.PositiveValue + "]+15[/color]"
		});
		return ret;
	}
});
