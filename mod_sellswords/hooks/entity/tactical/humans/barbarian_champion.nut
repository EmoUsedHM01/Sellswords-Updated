::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/barbarian_champion", function( q ) {

	q.onInit = @( __original ) function()
	{
		__original();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crBruiser"));
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 80)
		{
			this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 10;
			this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 10;
			this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 10;
			this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 10;
			if (this.World.getTime().Days >= 160)
			{
				this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 10;
				this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 10;
				this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 10;
				this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 10;
				this.m.Skills.add(this.new("scripts/skills/perks/perk_last_stand"));
				if (this.World.getTime().Days >= 200)
				{
					this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 10;
					this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 10;
					this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 10;
					this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 10;
				}
			}
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

	q.assignRandomEquipment = @( __original ) function()
	{
		__original();
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/barbarians/crbarbarian_hammer",
				"weapons/barbarians/crbarbarian_mace",	
				"weapons/barbarians/twinaxes_t2"	
				"weapons/barbarians/twincleavers_t2"	
				"weapons/barbarians/rusty_warblade",
				"weapons/barbarians/heavy_rusty_axe"
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 50)
		{
			local weapons = [
				"weapons/throwing_axe",
				"weapons/javelin"
			];

			if (this.Const.DLC.Unhold)
				weapons.push("weapons/throwing_spear");

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		local armor = [
			[
				33,
				"crbarbarian_rugged_scale_armor"
			],
			[
				34,
				"crbarbarian_heavy_iron_armor"
			],
			[
				33,
				"crbarbarian_thick_plated_barbarian_armor"
			]
		];

		armor.push([
			5,
			"crbarbarian_reinforced_heavy_iron_armor"
		]);

		this.m.Items.equip(this.Const.World.Common.pickArmor(armor));

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[
					1,
					"barbarians/crude_faceguard_helmet"
				],
				[
					1,
					"barbarians/closed_scrap_metal_helmet"
				],
				[
					1,
					"barbarians/crude_metal_helmet"
				]
			]));
		}
	}

	q.makeMiniboss = @( __original ) function()
	{
		if (!__original())
			return false;

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = this.Const.Items.NamedBarbarianWeapons;
		local r = this.Math.rand(1, 3);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crbarbarian_champion_fur"],
				[1, "crbarbarian_champion_skull"],
			]));
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "crbarbarian_champion_skull"],
				[1, "crbarbarian_champion_spiked"],
			]));
		}

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_vengeful_spite"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_man_of_steel"));
		}

		return true;
	}

});