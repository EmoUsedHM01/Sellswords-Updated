::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/oathbringer", function(q) {
	
	q.onInit = @( __original ) function()
	{
		__original();

		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_second_wind"));				
		this.m.Skills.add(this.new("scripts/skills/perks/perk_sundering_strikes"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_true_believer"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_know_their_weakness"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_the_rush_of_battle"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bulwark"));
		}

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crHonorheritage"));

			if (::Is_PTR_Exist)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_man_of_steel"));	
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_exude_confidence"));				
				this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_personal_armor"));
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
				"weapons/fighting_axe",
				"weapons/noble_sword",
				"weapons/winged_mace",
				"weapons/warhammer"
			];

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/greatsword",
					"weapons/longsword03",					
					"weapons/greataxe",
					"weapons/two_handed_hammer",
					"weapons/greataxe",
					"weapons/two_handed_hammer"					
				]);
			}

			if (this.Const.DLC.Unhold && this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/two_handed_flanged_mace",
					"weapons/two_handed_flail"
				]);
			}

			if (this.Const.DLC.Wildmen && this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/bardiche"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand) && this.Math.rand(1, 100) <= 60)
		{
			local shields = [
				"shields/heater_shield"
			];
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}
		else
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"adorned_mail_shirt_armor_heavy"
			],
			[
				2,
				"adorned_warriors_armor_armor_heavy"
			],
			[
				4,
				"adorned_heavy_mail_hauberk_armor"
			]
		]));
		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[
				4,
				"adorned_closed_flat_top_with_mail_helmet"
			],
			[
				8,
				"adorned_full_helm_helmet"
			],
			[1, "crknight_helmet_mid_bread"],			//350,-23						350,10/16
			[1, "crknight_helmet_mid_decorative"],		 //335,-22
			[1, "crknight_helmet_mid_unadorned"],			//325 -21
			[1, "cr_enclave_armet"],			   //355,-24  			
		]));		

		//if (::Is_PTR_Exist)
		//{
		//	this.m.Skills.addTreeOfEquippedWeapon();	
		//}

		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);
	}

	q.makeMiniboss = @( __original ) function()
	{
		if (!__original())
		{
			return false;
		}
		
		//if (::Is_PTR_Exist)
		//{
		//	this.m.Skills.addTreeOfEquippedWeapon();
		//}
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);
		return true;
	}
});