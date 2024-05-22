::mods_hookExactClass("skills/backgrounds/legend_conscript_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.PerkGroupMultipliers <- [
			[1.33, this.Const.Perks.AgileTree],
			[1.33, this.Const.Perks.FastTree],
			[0.25, this.Const.Perks.OrganisedTree],
			[0, this.Const.Perks.DeviousTree],
			[1.5, this.Const.Perks.CalmTree],
			[1.5, this.Const.Perks.HeavyArmorTree],
			[0.66, this.Const.Perks.SpearTree],
			[0.5, this.Const.Perks.DaggerTree],			
			[0, this.Const.Perks.BowTree],
			[0, this.Const.Perks.SlingTree],
			[0, this.Const.Perks.CrossbowTree],
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.SoldierProfessionTree
			],
			Styles = [
				::Const.Perks.OneHandedTree,
				::Const.Perks.TwoHandedTree
			]
		};
	}
});	