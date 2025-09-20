::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/legend_ranger_commander_background", function ( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.CustomPerkTree[5].push(this.Const.Perks.PerkDefs.crrangedskill);
	}

});
