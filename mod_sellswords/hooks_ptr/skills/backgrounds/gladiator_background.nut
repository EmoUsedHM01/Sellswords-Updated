::mods_hookExactClass("skills/backgrounds/gladiator_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.PerkGroupMultipliers = [
			[0.1, this.Const.Perks.OrganisedTree],
			[2, this.Const.Perks.ViciousTree],
			[3, this.Const.Perks.HeavyArmorTree],
			[0.8, this.Const.Perks.ShieldTree],
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
			Profession = [
				::MSU.Class.WeightedContainer([
					[20, ::Const.Perks.RaiderProfessionTree],
					[10, ::Const.Perks.SoldierProfessionTree],
					[70, ::Const.Perks.NoTree]
				])
			],
			Class = [
				::Const.Perks.TrapperClassTree
			],
			Styles = [
				::Const.Perks.OneHandedTree,
				::Const.Perks.TwoHandedTree
			]
		};
	}
});	