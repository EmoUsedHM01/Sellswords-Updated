::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/anatomist_background", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.BackgroundDescription = ::Mod_Sellswords.Strings.anatomist_background.BackgroundDescription;
		this.m.HiringCost = 2000;
		this.m.DailyCost = 35;
	}

	q.getTooltip = @() function()
	{
		local ret = [
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Mod_Sellswords.Strings.anatomist_background.Tooltip
			}
		];
		
		if (this.getContainer() == null || this.getContainer().getActor() == null)
			return ret;

		ret.extend(this.getAttributesTooltip());
		return ret;
	}

});