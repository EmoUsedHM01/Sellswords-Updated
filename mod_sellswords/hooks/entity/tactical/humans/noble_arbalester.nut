::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/noble_arbalester", function( q ) {

	q.onInit = @( __original ) function()
	{
		__original();

		local dc = this.World.getTime().Days;

		if (::Is_PTR_Exist && 0.5 * dc > this.Math.rand(1, 100) && dc >= 120)
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_eyes_up"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getEconomicDifficulty() == this.Const.Difficulty.Legendary)
		{
			local dc = this.World.getTime().Days;
			local dca = this.Math.floor(dc/50) + this.Math.floor(dc/100) + this.Math.floor(dc/150) + this.Math.floor(dc/200);
			dca = this.Math.min(dca, 8 + this.Math.floor(dc/100));
			this.m.BaseProperties.MeleeSkill += dca;
			this.m.BaseProperties.MeleeDefense += 0.5 * dca;
			this.m.BaseProperties.RangedSkill += dca;
			this.m.BaseProperties.RangedDefense += 0.5 * dca;
			this.m.BaseProperties.Bravery += dca;
			this.m.BaseProperties.Hitpoints += 2 * dca;
		}
	}

	q.assignRandomEquipment = @( __original ) function()
	{
		__original();
		
		local r;
		local banner = 3;
		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");
		dc = this.Math.max(dc, mn * 3);

		if (!this.Tactical.State.isScenarioMode())
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		else
			banner = this.getFaction();

		this.m.Surcoat = banner;
		this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));

		this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		local weapons = [
			"weapons/crossbow",
			"weapons/heavy_crossbow"
		];
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Ammo));
		local r = this.Math.rand(1, 10);
		switch (r) {
			case 1:
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_fire_bolts"));
				break;
			case 2:
				this.m.Items.equip(this.new("scripts/items/ammo/legend_armor_piercing_bolts"));
				break;
			case 3:
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bleeding_bolts"));
				break;
			default:
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
				break;
		}

		local weapons = [
			"weapons/dagger",
			"weapons/knife"
		];
		this.m.Items.addToBag(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		if (dc <= 80)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "padded_surcoat"],
				[1, "gambeson"]
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[2, "mail_coif"],
				[1, "aketon_cap"],
				[1, "open_leather_cap"],
				[1, "headscarf"],
				[1, ""]
			]));
		}
		else if (dc <= 130)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[3, "crarbalester_armor_early"]
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "crbillman_helmet_low"]
			]));
		}
		else if (dc <= 180)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[3, "crarbalester_armor_mid"]
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "crbillman_helmet_early"]
			]));
		}
		else if (dc > 180)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[3, "crarbalester_armor_late"]
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[2, "crbillman_helmet_mid_chain"],
				[2, "crbillman_helmet_mid"]
			]));
		}
	}

});