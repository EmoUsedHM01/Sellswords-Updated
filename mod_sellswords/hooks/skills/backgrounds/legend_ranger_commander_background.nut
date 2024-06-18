::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/legend_ranger_commander_background", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.CustomPerkTree[6].push(this.Const.Perks.PerkDefs.crrangedskill);
	}

});
