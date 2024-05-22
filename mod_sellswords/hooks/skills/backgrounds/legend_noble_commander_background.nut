::mods_hookExactClass("skills/backgrounds/legend_noble_commander_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		this.m.CustomPerkTree[1].push(this.Const.Perks.PerkDefs.LegendBalance);
		this.m.CustomPerkTree[3].push(this.Const.Perks.PerkDefs.laspecialize);
		this.m.CustomPerkTree[3].push(this.Const.Perks.PerkDefs.maspecialize);
		this.m.CustomPerkTree[3].push(this.Const.Perks.PerkDefs.haspecialize);
		this.m.CustomPerkTree[6].push(this.Const.Perks.PerkDefs.LegendFullForce);
		this.m.CustomPerkTree[6].push(this.Const.Perks.PerkDefs.LegendInTheZone);
	}
});