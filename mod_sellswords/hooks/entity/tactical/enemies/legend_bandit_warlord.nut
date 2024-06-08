::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/enemies/legend_bandit_warlord", function( q ) {

	q.onInit = @( __original ) function()
	{
		__original();
		this.m.Skills.removeByID("perk.perk.hold_out");	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crresilient"));				
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));	
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_second_wind"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crBlocknormal"));	

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_wears_it_well"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_fruits_of_labor"));
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

		if (::Mod_Sellswords.EnableHostileSequences)
		{
			local roll = this.Math.rand(1.0, 100.0);
			if (roll <= 20.0)
			{
				if (roll <= 4.0)
					::Mod_Sellswords.add_ghoul(this.actor, true);
				else if (roll <= 8.0)
					::Mod_Sellswords.add_ghoul(this.actor, false);
				else if (roll <= 12.0)
					::Mod_Sellswords.add_orc(this.actor, true);
				else if (roll <= 16.0)
					::Mod_Sellswords.add_orc(this.actor, false);
				else if (roll <= 20.0)
					::Mod_Sellswords.add_necrosavant(this.actor, true);
			}
		}
	}

	q.assignRandomEquipment = @( __original ) function()
	{
		__original();
		
		local shields = clone this.Const.Items.NamedShields;
		shields.extend([
			"shields/named/named_bandit_kite_shield",
			"shields/named/named_bandit_heater_shield"
		]);
		local r = this.Math.rand(1, 100);

		if (r > 50)
		{
			r = this.Math.rand(1, 100);
			if (r <= 90)
			{
				this.m.Items.equip(this.new("scripts/items/" + this.Const.Items.NamedMeleeWeapons[this.Math.rand(0, this.Const.Items.NamedMeleeWeapons.len() - 1)]));
			}
			else
			{
				this.m.Items.equip(this.new("scripts/items/weapons/named/named_spontoon"));
			}			
		}
		else
		{
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
		{
			local weapons = [
				"weapons/noble_sword",
				"weapons/fighting_axe",
				"weapons/warhammer",
				"weapons/fighting_spear",
				"weapons/legend_battle_glaive",
				"weapons/winged_mace",
				"weapons/noble_sword",
				"weapons/military_cleaver"
			];

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
			{
				weapons.extend([
					"weapons/greatsword",
					"weapons/greataxe",
					"weapons/legend_swordstaff",
					"weapons/longsword03",
					"weapons/warbrand",
					"weapons/spontoon03"						
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			local shields = [
				"shields/legend_tower_shield",
				"shields/heater_shield",
				"shields/kite_shield"
			];
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}

		if (this.Math.rand(1, 100) > 50)
		{
			local named = this.Const.Items.NamedArmors;
			local weightName = this.Const.World.Common.convNameToList(named);
			this.m.Items.equip(this.Const.World.Common.pickArmor(weightName));
		}
		else
		{
			local named = this.Const.Items.NamedHelmets;
			local weightName = this.Const.World.Common.convNameToList(named);
			this.m.Items.equip(this.Const.World.Common.pickHelmet(weightName));
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body) == null)
		{
			local armor = [
				[
					1,
					"crbandit_warlord_armor"
				]
			];
			local item = this.Const.World.Common.pickArmor(armor);
			this.m.Items.equip(item);
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null)
		{
			local helmet = [
				[
					1,
					"crbandit_warlord_helmet"
				]
			];
			local item = this.Const.World.Common.pickHelmet(helmet);
			this.m.Items.equip(item);
		}	
	}

});