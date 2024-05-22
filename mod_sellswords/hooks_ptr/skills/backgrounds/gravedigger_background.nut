::mods_hookExactClass("skills/backgrounds/gravedigger_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.DiggerProfessionTree
			],
			Weapon = [
				::Const.Perks.MaceTree
			]
		};
	}
});	