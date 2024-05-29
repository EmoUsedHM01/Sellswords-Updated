::mods_hookExactClass("entity/tactical/humans/gladiator", function(o) {
	local onInit = o.onInit;
	o.onInit = function()
	{
		onInit();
		if (this.World.getTime().Days >= 120)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crTrumpcard"));
		}
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

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
		assignRandomEquipment();
		
		local r;

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/shamshir",
				"weapons/shamshir",
				"weapons/oriental/heavy_southern_mace",
				"weapons/oriental/heavy_southern_mace",
				"weapons/fighting_axe",
				"weapons/fighting_axe",
				"weapons/fighting_spear"
			];

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/oriental/two_handed_scimitar",
					"weapons/crswordlance",
					"weapons/crpolemace",
					"weapons/two_handed_hammer",
					"weapons/greataxe",
					"weapons/crranged_flail"
				]);
			}

			if (this.Const.DLC.Wildmen && this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/two_handed_flail",
					"weapons/two_handed_flanged_mace",
					"weapons/bardiche"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 50)
		{
			local weapons = [
				"weapons/throwing_axe",
				"weapons/javelin"
			];

			if (this.Const.DLC.Unhold)
			{
				weapons.push("weapons/throwing_spear");
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
		{
			local offhand = [
				"tools/throwing_net",
				"shields/oriental/metal_round_shield"
			];
			this.m.Items.equip(this.new("scripts/items/" + offhand[this.Math.rand(0, offhand.len() - 1)]));
		}

		local armor = this.Const.World.Common.pickArmor([
			[
				1,
				"oriental/gladiator_harness"
			]
		]);

		if (this.Math.rand(1, 3) <= 2)
		{
			armor.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_heavy_gladiator_upgrade"));
		}
		else
		{
			armor.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_light_gladiator_upgrade"));
		}

		this.m.Items.equip(armor);
		local helm = this.Const.World.Common.pickHelmet([
			[
				1,
				"oriental/gladiator_helmet",
				this.Math.rand(13, 15)
			],
			[
				1,
				""
			]
		]);
		this.m.Items.equip(helm);
	}
});