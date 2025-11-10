::Mod_Sellswords.HooksMod.hook("scripts/skills/traits/oath_of_wrath_trait", function( q ) {
	
	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		foreach (tooltip in ret)
		{
			if (tooltip.id == 10) continue;

			tooltip.text = "[color=%negative%]-5[/color] Ranged Defense";
			break;
		}

		return ret;
	}

	q.onUpdate = @(__original) function( _properties )
	{
		__original(_properties);

		_properties.RangedDefense += 5;
	}
});
