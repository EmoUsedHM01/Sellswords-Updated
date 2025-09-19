::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/enemies/orc_warrior", function(q) {

	q.onInit = @( __original ) function()
	{
		__original();

		if (::Is_PTR_Exist)
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bulwark"));

		this.m.BaseProperties.Initiative += 10;
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days <= 90)
		{
			this.m.BaseProperties.Bravery -= 3;
			if (this.World.getTime().Days <= 60)
				this.m.BaseProperties.Bravery -= 3;
		}

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 80)
		{
			this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 10;
			this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 10;
			this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 10;
			this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 10;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));

			if (::Is_PTR_Exist)
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bully"));

			if (this.World.getTime().Days >= 120)
			{
				if (this.World.getTime().Days >= 160)
				{
					this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 20;
					this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 20;
					this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 20;
					this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 20;
					this.m.Skills.add(this.new("scripts/skills/perks/perk_crBruiser"));
					if (this.World.getTime().Days >= 200)
					{
						this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 20;
						this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 20;
						this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 20;
						this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 20;
					}
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
		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
		{
			local weapons = [
				"weapons/greenskins/orc_axe",
				"weapons/greenskins/orc_axe",
				"weapons/greenskins/orc_cleaver",
				"weapons/greenskins/orc_cleaver",
				"weapons/greenskins/legend_skin_flayer",
				"weapons/greenskins/legend_skullsmasher",
				"weapons/greenskins/legend_skin_flayer",
				"weapons/greenskins/legend_skullsmasher",
				"weapons/greenskins/cr_orc_mace"
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
			this.m.Items.equip(this.new("scripts/items/shields/greenskins/orc_heavy_shield"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 6);
		else
			::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 5);

		this.m.Skills.removeByID("perk.ptr_kata");

		local helmet;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");				
		helmet = [
				[1, "greenskins/orc_warrior_light_helmet"],
				[1, "greenskins/orc_warrior_medium_helmet"],
				[1, "greenskins/orc_warrior_heavy_helmet"]
		];
		if (this.World.getTime().Days >= 80 || mn >= 25)
		{
			helmet = [
					[1, "greenskins/orc_warrior_light_helmet"],
					[2, "greenskins/orc_warrior_medium_helmet"],
					[1, "greenskins/orc_warrior_heavy_helmet"]
			];
		}
		if (this.World.getTime().Days >= 160 || mn >= 50)
		{
			helmet = [
					[2, "greenskins/orc_warrior_medium_helmet"],
					[1, "greenskins/orc_warrior_heavy_helmet"]
			];
		}
		if (this.World.getTime().Days >= 240)
		{
			helmet = [
					[1, "greenskins/orc_warrior_medium_helmet"],
					[2, "greenskins/orc_warrior_heavy_helmet"]
			];
		}

		this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));	

		local armor;
		armor = [
				[1, "greenskins/orc_warrior_light_armor"],
				[1, "greenskins/orc_warrior_medium_armor"],
				[2, "greenskins/orc_warrior_heavy_armor"]
		];
		if (this.World.getTime().Days >= 80  || mn >= 25)
		{
			armor = [
					[1, "greenskins/orc_warrior_light_armor"],
					[4, "greenskins/orc_warrior_medium_armor"],
					[5, "greenskins/orc_warrior_heavy_armor"]
			];
		}
		if (this.World.getTime().Days >= 160  || mn >= 50)
		{
			armor = [
					[1, "greenskins/orc_warrior_medium_armor"],
					[2, "greenskins/orc_warrior_heavy_armor"]
			];
		}
		if (this.World.getTime().Days >= 240)
		{
			armor = [
					[1, "greenskins/orc_warrior_medium_armor"],
					[4, "greenskins/orc_warrior_heavy_armor"]
			];
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor(armor));					
	}

	q.onDeath = @(__original) function(_killer, _skill, _tile, _fatalityType)
	{
		__original(_killer, _skill, _tile, _fatalityType);
		local chance = 1.25;
		local item = "scripts/items/misc/anatomist/orc_sequence_item";
		::Mod_Sellswords.doPotionDrop(_killer, _skill, _tile, _fatalityType, chance, item);
	}

});