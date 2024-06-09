::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/legend_ranger_background", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.CustomPerkTree[3].push(this.Const.Perks.PerkDefs.maspecialize);
		this.m.CustomPerkTree[4].push(this.Const.Perks.PerkDefs.crParthianshot);
	}
});
