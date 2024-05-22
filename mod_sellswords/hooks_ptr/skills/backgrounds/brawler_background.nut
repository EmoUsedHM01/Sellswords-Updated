::mods_hookExactClass("skills/backgrounds/brawler_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.PerkGroupMultipliers = [
			[0.5, this.Const.Perks.TalentedTree],
			[0.25, this.Const.Perks.OrganisedTree],
			[2, this.Const.Perks.SergeantClassTree],
			[2, this.Const.Perks.ViciousTree],
			[2, this.Const.Perks.UnstoppableTree],
			[1.5, this.Const.Perks.HeavyArmorTree]
		];

		this.m.PerkTreeDynamic = {
			Class = [
				::Const.Perks.FistsClassTree
			]
		};
	}
	
});	