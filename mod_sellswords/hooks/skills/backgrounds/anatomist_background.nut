::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/anatomist_background", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.BackgroundDescription = ::Mod_Sellswords.Strings.anatomist_background.BackgroundDescription;
		this.m.HiringCost = 2000;
		this.m.DailyCost = 35;
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		ret.push({
			id = 14,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Mod_Sellswords.Strings.anatomist_background.Tooltip
		});
		return ret;
	}

});