::mods_hookExactClass("skills/traits/oath_of_wrath_trait", function(o) {
	
	local ws_getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = ws_getTooltip();

		foreach (tooltip in ret)
		{
			if (tooltip.id == 10) continue;

			tooltip.text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color] Ranged Defense";
			break;
		}

		return ret;
	}

	local ws_onUpdate = o.onUpdate;
	o.onUpdate = function( _properties )
	{
		ws_onUpdate(_properties);

		_properties.RangedDefense += 5;
	}

})