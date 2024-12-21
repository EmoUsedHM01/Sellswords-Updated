::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/anatomist_background", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.BackgroundDescription = "Part scientist, part surgeon. Anatomists are unaccustomed to battle, but are blessed with steady hands.\nAfter a battle, Anatomists have a chance to concoct a Sequence for each suitable enemy slain.\nThis chance increases with each Anatomist in your roster.";
		this.m.HiringCost = 2000;
		this.m.DailyCost = 35;
	}

	q.getTooltip = @() function()
	{
		local ret = [
//			{
//				id = 1,
//				type = "title",
//				text = this.getName()
//			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Having an Anatomist in your roster allows you to harvest Sequences from defeated enemies. Each additional Anatomist increases the chance of a successful harvest."
			}
		];
		
		if (this.getContainer() == null || this.getContainer().getActor() == null)
			return ret;

		ret.extend(this.getAttributesTooltip());
		return ret;
	}

});