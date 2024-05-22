::mods_hookExactClass("skills/actives/legend_safeguard", function ( o )
{
	o.getTooltip = function ()
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