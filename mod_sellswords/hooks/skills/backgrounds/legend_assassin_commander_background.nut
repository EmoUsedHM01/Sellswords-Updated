::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/legend_assassin_commander_background", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.CustomPerkTree[3].push(this.Const.Perks.PerkDefs.laspecialize);
		this.m.CustomPerkTree[3].push(this.Const.Perks.PerkDefs.maspecialize);
	}
});
