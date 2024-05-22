::mods_hookExactClass("skills/backgrounds/butcher_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.PerkGroupMultipliers = [];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.ButcherProfessionTree
			],
			Weapon = [
				::Const.Perks.CleaverTree
			]
		};
	}
});