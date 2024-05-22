::mods_hookExactClass("skills/backgrounds/sellsword_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.PerkGroupMultipliers = [
			[2, this.Const.Perks.MercenaryTree],
			[0.1, this.Const.Perks.OrganisedTree],
			[2, this.Const.Perks.HeavyArmorTree],
			[0.66, this.Const.Perks.ShieldTree],
			[0, this.Const.Perks.CrossbowTree],
			[0, this.Const.Perks.SlingTree],
			[0.66, this.Const.Perks.SpearTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::MSU.Class.WeightedContainer([
					[60, ::Const.Perks.RaiderProfessionTree],
					[25, ::Const.Perks.SoldierProfessionTree],
					[10, ::Const.Perks.KnightProfessionTree],					
					[5, ::Const.Perks.NoTree]
				])
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