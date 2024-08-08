::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/master_archer", function( q ) {

	q.onInit = @( __original ) function()
	{
		__original();

		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));

		if (::Is_PTR_Exist)
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

		if (::Mod_Sellswords.EnableHostileSequences)
		{
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 10.0)
				::Mod_Sellswords.add_goblin(this.actor, true);
		}
	}

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		if (::Mod_Sellswords.EnableHostileSequences)
			::Mod_Sellswords.doHostileSequencePotionDrop(_killer, _skill, _tile, _fatalityType, this.actor);
	}

	q.assignRandomEquipment = @( __original ) function()
	{
		__original();

		this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));

		this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Ammo));
		local r = this.Math.rand(1, 10);
		switch (r) {
			case 1:
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_fire_arrows"));
				break;
			case 2:
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_freezing_arrows"));
				break;
			case 3:
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bleeding_arrows"));
				break;
			case 4:
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_poisoned_arrows"));
				break;
			default:
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
				break;
		}

		local weapons = [
			"weapons/dagger",
			"weapons/scramasax",
			"weapons/hatchet"
		];
		this.m.Items.addToBag(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		
		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");
		dc = this.Math.max(dc, mn * 3);

		if (dc <= 60)
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
		else if (dc <= 90)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[3, "crarbalester_armor_early"]
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "crbillman_helmet_low"]
			]));
		}
		else if (dc <= 120)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[3, "crarbalester_armor_mid"]
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "crbillman_helmet_early"]
			]));
		}
		else if (dc <= 150)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[2, "crarbalester_armor_late"],
				[1, "crmasterarcher_armor"]
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "crbillman_helmet_mid_chain"],
				[1, "crbillman_helmet_mid"]
			]));
		}
		else if (dc > 150)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crarbalester_armor_late"],
				[3, "crmasterarcher_armor"]
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[4, "crmasterarcher_helmet"],
				[1, "crbillman_helmet_mid"],
				[1, "crbillman_helmet_mid_chain"]
			]));
		}

		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);
	}

	q.makeMiniboss = @(__original) function()
	{
		__original();

		this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		this.m.Items.equip(this.new("scripts/items/weapons/named/named_warbow"));

		this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Ammo));
		this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_phantom_arrows"));
	}

});