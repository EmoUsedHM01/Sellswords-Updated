::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/legend_berserker_background", function ( q ) {
	q.getTooltip = @(__original) function()
	{
		local ret = this.character_background.getTooltip();
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] Damage when unarmed"
		});
		return ret;
	}
});
