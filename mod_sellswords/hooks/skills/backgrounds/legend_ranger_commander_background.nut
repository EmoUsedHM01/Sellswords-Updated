::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/legend_ranger_commander_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.CustomPerkTree[3].push(this.Const.Perks.PerkDefs.laspecialize);
		this.m.CustomPerkTree[3].push(this.Const.Perks.PerkDefs.maspecialize);
		this.m.CustomPerkTree[3].push(this.Const.Perks.PerkDefs.LegendFavouredEnemyArcher);
		this.m.CustomPerkTree[4].push(this.Const.Perks.PerkDefs.crParthianshot);
		this.m.CustomPerkTree[6].push(this.Const.Perks.PerkDefs.crrangedskill);
	}

});