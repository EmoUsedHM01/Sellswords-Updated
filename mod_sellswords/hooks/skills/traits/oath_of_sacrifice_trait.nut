::Mod_Sellswords.HooksMod.hook("scripts/skills/traits/oath_of_sacrifice_trait", function( q ) {
	
	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		foreach (tooltip in ret)
		{
			if (tooltip.id == 11) continue;

			tooltip.text = ::Mod_Sellswords.Strings.oath_of_sacrifice_trait.Tooltip;
			break;
		}

		return ret;
	}

	q.onUpdate = @(__original) function(_properties)
	{
		__original(_properties);
		
		_properties.ThresholdToReceiveInjuryMult *= 1.2;	
	}
});
