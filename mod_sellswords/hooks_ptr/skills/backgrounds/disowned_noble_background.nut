::mods_hookExactClass("skills/backgrounds/disowned_noble_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.PerkGroupMultipliers = [
			[0.5, this.Const.Perks.CalmTree],
			[0.5, this.Const.Perks.OrganisedTree],
			[0.5, this.Const.Perks.SergeantClassTree],
			[1.5, this.Const.Perks.TacticianClassTree],
			[0.8, this.Const.Perks.ShieldTree],
			[2, this.Const.Perks.HeavyArmorTree],
			[0, this.Const.Perks.BowTree],
			[0, this.Const.Perks.CrossbowTree],
			[0, this.Const.Perks.SlingTree],
			[0.66, this.Const.Perks.SpearTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::MSU.Class.WeightedContainer([
					[5, ::Const.Perks.KnightProfessionTree],
					[95, ::Const.Perks.NoTree],					
				])
			],			
			Weapon = [
				::Const.Perks.SwordTree
			],
			Styles = [
				::Const.Perks.OneHandedTree,
				::Const.Perks.TwoHandedTree
			]
		};
	}
});	