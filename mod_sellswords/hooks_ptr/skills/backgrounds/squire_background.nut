::mods_hookExactClass("skills/backgrounds/squire_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.PerkGroupMultipliers = [
			[3, this.Const.Perks.CalmTree],
			[0.2, this.Const.Perks.OrganisedTree],
			[0.25, this.Const.Perks.DeviousTree],
			[0.5, this.Const.Perks.ShieldTree],
			[2, this.Const.Perks.HeavyArmorTree],
			[0.5, this.Const.Perks.SpearTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::MSU.Class.WeightedContainer([
					[30, ::Const.Perks.SoldierProfessionTree],
					[20, ::Const.Perks.KnightProfessionTree],
					[50, ::Const.Perks.NoTree],					
				])
			],
			Traits = [
				::Const.Perks.TrainedTree
			],
			Class = [
				::MSU.Class.WeightedContainer([
					[75, ::Const.Perks.SergeantClassTree],
					[25, ::Const.Perks.TacticianClassTree]
				])
			],
			Weapon = [
				::Const.Perks.PolearmTree,
				::Const.Perks.SwordTree
			]
		};
	}
});