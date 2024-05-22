::mods_hookExactClass("skills/backgrounds/legend_cannibal_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.PerkGroupMultipliers = [];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.ButcherProfessionTree
			],
			Traits = [
				::Const.Perks.ViciousTree
			],
			Class = [
				::Const.Perks.ChefClassTree
			],
			Styles = [
				::Const.Perks.OneHandedTree
			],
			Weapon = [
				::Const.Perks.CleaverTree
			]
		};
	}
});