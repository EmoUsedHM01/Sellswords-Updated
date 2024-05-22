::mods_hookExactClass("skills/traits/oath_of_honor_trait", function(o) {
	
	local ws_getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = ws_getTooltip();

		foreach (tooltip in ret)
		{
			if (tooltip.id == 10) continue;

			tooltip.text = "Starts combat at Confident morale if permitted by mood. When you are at Confident morale, gain [color=" + this.Const.UI.Color.PositiveValue + "]+20%[/color] resolve.";
			break;
		}

		return ret;
	}

	o.onUpdate <- function( _properties )
	{
		if (this.getContainer().getActor().getMoraleState() == this.Const.MoraleState.Confident)
		{
			_properties.Bravery *= 1.2;
		}
	}

})