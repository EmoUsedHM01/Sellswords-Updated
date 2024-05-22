::mods_hookExactClass("skills/backgrounds/legend_ranger_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create();
		this.m.CustomPerkTree[3].push(this.Const.Perks.PerkDefs.maspecialize);
		this.m.CustomPerkTree[4].push(this.Const.Perks.PerkDefs.crParthianshot);
	}
});