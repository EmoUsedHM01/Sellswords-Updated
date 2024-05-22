::mods_hookExactClass("skills/backgrounds/lumberjack_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.LumberjackProfessionTree
			],
			Weapon = [
				::Const.Perks.AxeTree
			],
		};
	}
});