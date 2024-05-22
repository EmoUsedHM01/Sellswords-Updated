::mods_hookExactClass("skills/backgrounds/legend_ironmonger_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.BlacksmithProfessionTree
			],
			Weapon = [
				::Const.Perks.HammerTree
			]
		};
	}
});	