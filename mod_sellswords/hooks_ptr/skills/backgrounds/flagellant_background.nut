::mods_hookExactClass("skills/backgrounds/flagellant_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.PerkGroupMultipliers = [
			[3, this.Const.Perks.ResilientTree],
			[3, this.Const.Perks.ViciousTree],
			[2, this.Const.Perks.SturdyTree],
			[0.2, this.Const.Perks.HealerClassTree],
			[0.1, this.Const.Perks.ShieldTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.HolyManProfessionTree
			],
			Class = [
				::Const.Perks.SergeantClassTree
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Weapon = [
				::Const.Perks.CleaverTree
			]
		};
	}
})