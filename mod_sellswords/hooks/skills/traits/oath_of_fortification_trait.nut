::Mod_Sellswords.HooksMod.hook("scripts/skills/traits/oath_of_fortification_trait", function( q ) {
	
	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		foreach (tooltip in ret)
		{
			if (tooltip.id == 12) continue;

			tooltip.text = ::Mod_Sellswords.Strings.oath_of_fortification_trait.Tooltip;
			break;
		}

		return ret;
	}
});
