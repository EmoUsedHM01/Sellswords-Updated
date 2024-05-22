::mods_hookExactClass("skills/backgrounds/assassin_southern_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.PerkGroupMultipliers = [
			[0.5, this.Const.Perks.StaffTree],
			[0.1, this.Const.Perks.ShieldTree],
			[0.5, this.Const.Perks.HeavyArmorTree],
			[0.66, this.Const.Perks.HammerTree],
			[0.66, this.Const.Perks.MaceTree],
			[0.5, this.Const.Perks.PolearmTree],			
			[0, this.Const.Perks.BowTree],
			[0, this.Const.Perks.SlingTree],
			[0, this.Const.Perks.CrossbowTree],
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.AssassinProfessionTree
			],
			Weapon = [
				::Const.Perks.DaggerTree
			]
		};
	}
});	