::mods_hookExactClass("skills/traits/oath_of_fortification_trait", function(o) {
	
	local ws_getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = ws_getTooltip();

		foreach (tooltip in ret)
		{
			if (tooltip.id == 12) continue;

			tooltip.text = "The \'Shield Wall\' shield skill has grants an additional [color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Melee Defense and [color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Ranged Defense.";
			break;
		}

		return ret;
	}

})