::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/legend_ranger_background", function ( q ) {

	q.onAdded = @(__original) function()
	{
		__original();

		if (this.m.IsNew)
			this.m.Container.add(this.new("scripts/skills/perks/perk_crrangedskill"));
	}

});