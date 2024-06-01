::Mod_Sellswords.HooksMod.hook("scripts/skills/backgrounds/legend_berserker_commander_background", function( q ) {

	q.create = @(__original) function()
	{
		__original();
		this.m.CustomPerkTree[2].push(this.Const.Perks.PerkDefs.crAudaciouscharge)
		this.m.CustomPerkTree[3].push(this.Const.Perks.PerkDefs.laspecialize);
		this.m.CustomPerkTree[6].push(this.Const.Perks.PerkDefs.crGrandslam);
		this.m.CustomPerkTree[5].push(this.Const.Perks.PerkDefs.crHackSPM)
		this.m.CustomPerkTree[6].push(this.Const.Perks.PerkDefs.LegendUnarmedTraining);
	}
});
