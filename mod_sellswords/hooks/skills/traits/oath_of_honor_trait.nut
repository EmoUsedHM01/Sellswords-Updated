::Mod_Sellswords.HooksMod.hook("scripts/skills/traits/oath_of_honor_trait", function( q ) {
	
	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		foreach (tooltip in ret)
		{
			if (tooltip.id == 10) continue;

			tooltip.text = "Starts combat at Confident morale if permitted by mood. When you are at Confident morale, gain [color=%positive%]+20%[/color] resolve.";
			break;
		}

		return ret;
	}

	q.onUpdate <- function( _properties )
	{
		if (this.getContainer().getActor().getMoraleState() == this.Const.MoraleState.Confident)
		{
			_properties.Bravery *= 1.2;
		}
	}
});
