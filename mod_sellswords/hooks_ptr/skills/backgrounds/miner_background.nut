::mods_hookExactClass("skills/backgrounds/miner_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.MinerProfessionTree
			],
			Weapon = [
				::Const.Perks.HammerTree
			]
		};
	}
});	