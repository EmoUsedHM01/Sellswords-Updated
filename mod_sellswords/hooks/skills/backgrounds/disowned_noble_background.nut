::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/disowned_noble_background", function ( q ) {

	q.onAdded = @(__original) function()
	{
		__original();
		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			this.m.Container.add(this.new("scripts/skills/perks/perk_legend_wind_reader"));
		}
		else
		{
			this.m.Container.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
		}
	}	

	q.buildPerkTree = @(__original) function()
	{
		__original();

		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			addPerk(::Const.Perks.PerkDefs.LegendWindReader, 0, false);
		}
		else
		{
			addPerk(::Const.Perks.PerkDefs.LegendAssuredConquest, 0, false);
		}
	}
});
