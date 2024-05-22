::mods_hookExactClass("skills/backgrounds/legend_conscript_ranged_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.PerkGroupMultipliers = [
			[1.5, this.Const.Perks.AgileTree],
			[1.5, this.Const.Perks.FastTree],
			[2, this.Const.Perks.ViciousTree],			
			[0.5, this.Const.Perks.OrganisedTree],
			[0.25, this.Const.Perks.DeviousTree],
			[1.5, this.Const.Perks.CalmTree],
		];

		this.m.PerkTreeDynamic = {
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Weapon = [
				::MSU.Class.WeightedContainer([
					[25, ::Const.Perks.BowTree],
					[25, ::Const.Perks.CrossbowTree],
					[25, ::Const.Perks.SlingTree],
					[25, ::Const.Perks.ThrowingTree]
				])
			]
		};
	}
});	