::mods_hookExactClass("skills/traits/oath_of_sacrifice_trait", function(o) {
	
	local ws_getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = ws_getTooltip();

		foreach (tooltip in ret)
		{
			if (tooltip.id == 11) continue;

			tooltip.text = "Is not paid any wage. And the threshold to sustain injuries on getting hit is increased by [color=" + this.Const.UI.Color.PositiveValue + "]20%[/color]";
			break;
		}

		return ret;
	}

	local ws_onUpdate = o.onUpdate;
	o.onUpdate = function(_properties)
	{
		ws_onUpdate(_properties);
		
		_properties.ThresholdToReceiveInjuryMult *= 1.2;	
	}

})