::mods_hookExactClass("skills/backgrounds/legend_herbalist_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.PerkGroupMultipliers = [];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.ApothecaryProfessionTree
			],
			Weapon = [
				::Const.Perks.SwordTree
			]
		};
	}
});	