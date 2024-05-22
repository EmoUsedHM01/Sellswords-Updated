::mods_hookExactClass("skills/backgrounds/legend_nightwatch_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.MilitiaProfessionTree
			],
			Weapon = [
				::Const.Perks.SpearTree
			],
		};
	}
});	