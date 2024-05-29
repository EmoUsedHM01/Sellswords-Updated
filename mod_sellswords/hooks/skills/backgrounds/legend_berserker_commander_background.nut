::mods_hookExactClass("skills/backgrounds/legend_berserker_commander_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		this.m.CustomPerkTree[2].push(this.Const.Perks.PerkDefs.crAudaciouscharge)
		this.m.CustomPerkTree[3].push(this.Const.Perks.PerkDefs.laspecialize);
		this.m.CustomPerkTree[6].push(this.Const.Perks.PerkDefs.crGrandslam);
		this.m.CustomPerkTree[5].push(this.Const.Perks.PerkDefs.crHackSPM)
		this.m.CustomPerkTree[6].push(this.Const.Perks.PerkDefs.LegendUnarmedTraining);
	}
});