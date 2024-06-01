::Mod_Sellswords.HooksMod.hook("scripts/skills/traits/oath_of_fortification_trait", function( q ) {
	
	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		foreach (tooltip in ret)
		{
			if (tooltip.id == 12) continue;

			tooltip.text = "The \'Shield Wall\' shield skill has grants an additional [color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Melee Defense and [color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Ranged Defense.";
			break;
		}

		return ret;
	}
});
