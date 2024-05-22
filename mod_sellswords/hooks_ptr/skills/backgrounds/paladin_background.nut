::mods_hookExactClass("skills/backgrounds/paladin_background", function(o) {
	local ws_create = o.create;
	o.create = function()
	{
		ws_create()

		this.m.PerkGroupMultipliers = [
			[1.2, this.Const.Perks.AgileTree],
			[0, this.Const.Perks.DeviousTree],
			[1.2, this.Const.Perks.FastTree],
			[0, this.Const.Perks.OrganisedTree],
			[1.33, this.Const.Perks.TrainedTree],
			[1.5, this.Const.Perks.MenderClassTree],
			[1.5, this.Const.Perks.SergeantClassTree],
			[1.5, this.Const.Perks.TacticianClassTree],
			[0, this.Const.Perks.LightArmorTree],
			[0, this.Const.Perks.BowTree],
			[0, this.Const.Perks.CrossbowTree],
			[0, this.Const.Perks.SlingTree],
			[0.5, this.Const.Perks.DaggerTree],
			[0, this.Const.Perks.RangedTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::MSU.Class.WeightedContainer([
					[5, ::Const.Perks.KnightProfessionTree],				
					[5, ::Const.Perks.SoldierProfessionTree],
					[5, ::Const.Perks.MilitiaProfessionTree],
					[3, ::Const.Perks.RaiderProfessionTree],
					[1, ::Const.Perks.NobleProfessionTree],
					[1, ::Const.Perks.WildlingProfessionTree],
					[1, ::Const.Perks.JugglerProfessionTree],
					[5, ::Const.Perks.ButcherProfessionTree],
					[5, ::Const.Perks.DiggerProfessionTree],
					[5, ::Const.Perks.FarmerProfessionTree],
					[5, ::Const.Perks.LaborerProfessionTree],
					[5, ::Const.Perks.LumberjackProfessionTree],
					[5, ::Const.Perks.MinerProfessionTree],
					[49, ::Const.Perks.NoTree]
				])
			],
			Class = [
				::MSU.Class.WeightedContainer([
					[20, ::Const.Perks.VeteranClassTree],
					[80, ::Const.Perks.NoTree],					
				])
			]
		};
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		if (items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/arming_sword",
				"weapons/fighting_axe",
				"weapons/winged_mace",
				"weapons/military_pick",
				"weapons/warhammer",
				"weapons/billhook",
				"weapons/longaxe",
				"weapons/greataxe",
				"weapons/greatsword"
			];

			if (this.Const.DLC.Unhold)
			{
				weapons.extend([
					"weapons/longsword",
					"weapons/polehammer",
					"weapons/two_handed_flail",
					"weapons/two_handed_flanged_mace"
				]);
			}

			if (this.Const.DLC.Wildmen)
			{
				weapons.extend([
					"weapons/bardiche"
				]);
			}

			items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (items.hasEmptySlot(this.Const.ItemSlot.Offhand) && this.Math.rand(1, 100) <= 75)
		{
			local shields = [
				"shields/wooden_shield",
				"shields/wooden_shield",
				"shields/heater_shield",
				"shields/kite_shield"
			];
			items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}

		r = this.Math.rand(0, 5);
		items.equip(this.Const.World.Common.pickArmor([
			[
				2,
				"adorned_mail_shirt_armor"
			],
			[
				2,
				"adorned_warriors_armor_armor"
			],
			[
				1,
				"adorned_heavy_mail_hauberk_armor"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				2,
				"heavy_mail_coif_helmet"
			],
			[
				2,
				"adorned_closed_flat_top_with_mail_helmet"
			],
			[
				1,
				"adorned_full_helm_helmet"
			]
		]));
	}
});	