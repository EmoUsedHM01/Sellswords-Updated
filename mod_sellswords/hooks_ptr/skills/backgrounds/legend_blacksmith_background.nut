::mods_hookExactClass("skills/backgrounds/legend_blacksmith_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.PerkTreeDynamic = {
			Profession = [
			::Const.Perks.BlacksmithProfessionTree
			],
			Class = [
				::Const.Perks.MenderClassTree
			],
			Weapon = [
				::Const.Perks.HammerTree
			],			
			Styles = [
				::Const.Perks.OneHandedTree,
				::Const.Perks.TwoHandedTree
			]
		};
	}
});	