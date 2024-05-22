::mods_hookExactClass("skills/backgrounds/militia_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.PerkGroupMultipliers = [];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.MilitiaProfessionTree
			],
			Traits = [
				::Const.Perks.TrainedTree
			],
			Class = [
				::MSU.Class.WeightedContainer([
					[15, ::Const.Perks.VeteranClassTree],
					[85, ::Const.Perks.NoTree],					
				])
			]
		};
	}
	
});	