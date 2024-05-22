::mods_hookExactClass("skills/backgrounds/farmhand_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.PerkGroupMultipliers = [];

		this.m.PerkTreeDynamic = {
			Profession = [
				::MSU.Class.WeightedContainer([
					[8.33, ::Const.Perks.ButcherProfessionTree],
					[8.33, ::Const.Perks.BlacksmithProfessionTree],
					[8.33, ::Const.Perks.LaborerProfessionTree],
					[75, ::Const.Perks.FarmerProfessionTree]
				])
			],
			Weapon = [
				::Const.Perks.PolearmTree
			]	
		};
	}
});	