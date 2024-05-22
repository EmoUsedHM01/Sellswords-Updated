::mods_hookExactClass("skills/backgrounds/nomad_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.PerkGroupMultipliers = [
			[3, this.Const.Perks.SouthernersTree],
			[2, this.Const.Perks.ResilientTree],
			[0.25, this.Const.Perks.OrganisedTree],
			[2, this.Const.Perks.ScoutClassTree],
			[2, this.Const.Perks.HeavyArmorTree],
			[0, this.Const.Perks.BowTree],
			[0, this.Const.Perks.CrossbowTree],
			[0, this.Const.Perks.SlingTree],
			[0.66, this.Const.Perks.SpearTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.RaiderProfessionTree
			],
			Class = [
				::MSU.Class.WeightedContainer([
					[20, ::Const.Perks.VeteranClassTree],
					[80, ::Const.Perks.NoTree],					
				])
			]
		};
	}
});	