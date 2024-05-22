::mods_hookExactClass("skills/backgrounds/raider_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.PerkGroupMultipliers = [
			[0.25, this.Const.Perks.OrganisedTree],
			[0, this.Const.Perks.BowTree],
			[0, this.Const.Perks.CrossbowTree],
			[0, this.Const.Perks.SlingTree],
			[2, this.Const.Perks.HeavyArmorTree],
			[2, this.Const.Perks.MediumArmorTree],
			[0.66, this.Const.Perks.ShieldTree],
			[0.66, this.Const.Perks.SpearTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.RaiderProfessionTree
			],
			Styles = [
				::Const.Perks.OneHandedTree,
				::Const.Perks.TwoHandedTree
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