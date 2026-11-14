::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/legend_commander_crusader_background", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.CustomPerkTree[4].push(this.Const.Perks.PerkDefs.SsuBlocknormal);
	}
});
