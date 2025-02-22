::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/adventurous_noble_background", function ( q ) {

	q.onAdded = @(__original) function()
	{
		__original();
		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			this.m.Container.add(this.new("scripts/skills/perks/perk_bullseye"));
		}
		else
		{
			this.m.Container.add(this.new("scripts/skills/perks/perk_duelist"));
		}
	}	

	q.buildPerkTree = @(__original) function()
	{
		__original();

		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			addPerk(::Const.Perks.PerkDefs.Bullseye, 0, false);
		}
		else
		{
			addPerk(::Const.Perks.PerkDefs.Duelist, 0, false);
		}
	}
});
