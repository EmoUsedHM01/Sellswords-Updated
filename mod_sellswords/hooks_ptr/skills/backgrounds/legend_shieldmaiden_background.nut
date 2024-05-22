::mods_hookExactClass("skills/backgrounds/legend_shieldmaiden_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.PerkGroupMultipliers = [
			[0.1, this.Const.Perks.OrganisedTree],
			[0.25, this.Const.Perks.FastTree],
			[0.25, this.Const.Perks.AgileTree],
			[0.1, this.Const.Perks.LightArmorTree],
			[3, this.Const.Perks.HeavyArmorTree],
			[0, this.Const.Perks.BowTree],
			[0, this.Const.Perks.SlingTree],
			[0, this.Const.Perks.CrossbowTree],
			[0.5, this.Const.Perks.DaggerTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::MSU.Class.WeightedContainer([
					[90, ::Const.Perks.LaborerProfessionTree],
					[10, ::Const.Perks.WildlingProfessionTree]
				])
			],
			Defense = [
				::Const.Perks.ShieldTree
			],
			Styles = [
				::Const.Perks.OneHandedTree
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