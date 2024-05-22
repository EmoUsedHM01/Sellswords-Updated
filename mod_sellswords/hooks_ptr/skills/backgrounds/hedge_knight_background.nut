::mods_hookExactClass("skills/backgrounds/hedge_knight_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.PerkGroupMultipliers = [
			[0.25, this.Const.Perks.AgileTree],
			[0.25, this.Const.Perks.FastTree],
			[0.1, this.Const.Perks.DeviousTree],
			[0.1, this.Const.Perks.OrganisedTree],
			[0.5, this.Const.Perks.TalentedTree],
			[0.5, this.Const.Perks.CalmTree],
			[2, this.Const.Perks.TacticianClassTree],
			[2, this.Const.Perks.MediumArmorTree],
			[0.66, this.Const.Perks.ShieldTree],
			[0.1, this.Const.Perks.LightArmorTree],
			[0.25, this.Const.Perks.DaggerTree],
			[0.16, this.Const.Perks.SpearTree],
			[0, this.Const.Perks.StaffTree],
			[0, this.Const.Perks.SlingTree],			
			[0, this.Const.Perks.BowTree],
			[0, this.Const.Perks.CrossbowTree],			
			[0, this.Const.Perks.ThrowingTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::MSU.Class.WeightedContainer([
					[25, ::Const.Perks.RaiderProfessionTree],
					[25, ::Const.Perks.SoldierProfessionTree],
					[50, ::Const.Perks.KnightProfessionTree]
				])
			],
			Defense = [
				::Const.Perks.HeavyArmorTree
			],
			Styles = [
				::Const.Perks.OneHandedTree,
				::Const.Perks.TwoHandedTree
			],
			Enemy = [
				::Const.Perks.SwordmastersTree
		]
		};
	}
	
});