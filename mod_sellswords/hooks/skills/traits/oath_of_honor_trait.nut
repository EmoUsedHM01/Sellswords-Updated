::Mod_Sellswords.HooksMod.hook("scripts/skills/traits/oath_of_honor_trait", function( q ) {
	
	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		foreach (tooltip in ret)
		{
			if (tooltip.id == 10) continue;

			tooltip.text = ::Mod_Sellswords.Strings.oath_of_honor_trait.Tooltip;
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
