::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_throw_sand", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.Name = this.Const.Strings.PerkName.LegendThrowSand;
		this.m.Description = this.Const.Strings.PerkDescription.LegendThrowSand;
	}
});