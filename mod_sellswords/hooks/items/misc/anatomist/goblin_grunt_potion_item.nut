::mods_hookExactClass("items/misc/anatomist/goblin_grunt_potion_item", function (o) {
	local ws_getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = ws_getTooltip();

		foreach (tooltip in ret)
		{
			if (!("icon" in tooltip)) continue;

			switch(tooltip.icon)
			{
			case "ui/icons/action_points.png":
				tooltip.text = "The Action Point costs of the Rotation and Footwork skills are reduced to [color=" + ::Const.UI.Color.PositiveValue + "]2[/color], while the Kata Step skill is reduced by [color=" + ::Const.UI.Color.PositiveValue + "]1[/color]";
				break;

			case "ui/icons/fatigue.png":
				tooltip.text = "The Fatigue costs of the Rotation, Footwork and Kata Step skills are reduced by [color=" + ::Const.UI.Color.PositiveValue + "]50%[/color]";
				break;
			}
		}

		return ret;
	}
})