::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/legend_crusader_commander_background", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.CustomPerkTree[4].push(this.Const.Perks.PerkDefs.crBlocknormal);
	}
});
