::mods_hookExactClass("skills/backgrounds/legend_man_at_arms_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.PerkGroupMultipliers = [
			[0.8, this.Const.Perks.CrossbowTree],
			[0.5, this.Const.Perks.SlingTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.SoldierProfessionTree
			],
			Class = [
				::MSU.Class.WeightedContainer([
					[75, ::Const.Perks.SergeantClassTree],
					[15, ::Const.Perks.TacticianClassTree],
					[10, ::Const.Perks.VeteranClassTree]					
				])
			]
		};
	}
});	