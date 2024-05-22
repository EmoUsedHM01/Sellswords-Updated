::mods_hookExactClass("skills/backgrounds/legend_druid_background", function(o) {
	o.getTooltip = function()
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