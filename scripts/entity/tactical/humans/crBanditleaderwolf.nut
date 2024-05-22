this.crBanditleaderwolf <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.crBanditleaderwolf;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.BanditLeader.XP;
		this.m.Name = this.generateName();
		this.m.IsGeneratingKillName = false;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Raider;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function generateName()
	{
		local vars = [
			[
				"randomname",
				this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]
			],
			[
				"randomtown",
				this.Const.World.LocationNames.VillageWestern[this.Math.rand(0, this.Const.World.LocationNames.VillageWestern.len() - 1)]
			]
		];
		return this.buildTextFromTemplate(this.Const.Strings.BanditLeaderNames[this.Math.rand(0, this.Const.Strings.BanditLeaderNames.len() - 1)], vars);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditLeader);
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(150, 255);
		this.setArmorSaturation(0.85);
		this.getSprite("shield_icon").setBrightness(0.85);
		this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_sundering_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nine_lives"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_close_combat_archer"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_shields_up"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rally_the_troops"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_hold_the_line"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_push_forward"));

		if (::Is_PTR_Exist)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_bully"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_the_rush_of_battle"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_primal_fear"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_exude_confidence"));
		}

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_composure"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/actives/rally_the_troops"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_clarity"));
			this.m.BaseProperties.MeleeSkill += 2;
			this.m.BaseProperties.MeleeDefense += 2;
			this.m.BaseProperties.RangedSkill += 2;	
			this.m.BaseProperties.RangedDefense += 2;				
			this.m.BaseProperties.Hitpoints += 10;				
		}

		if (this.World.getTime().Days >= 40)
		{
			b.MeleeSkill += 2;
			b.Initiative += 2;
			if (this.World.getTime().Days >= 60)
			{			
				b.MeleeDefense += 2;
				b.RangedDefense += 2;
				b.Bravery += 2;
				if (this.World.getTime().Days >= 80)
				{					
					b.MeleeSkill += 3;
					b.Initiative += 3;
					if (this.World.getTime().Days >= 100)
					{
						b.MeleeDefense += 3;
						b.RangedDefense += 3;
						b.Bravery += 3;											
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

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setArmorBrightness(0.9);
		this.setDirty(true);
	}

	function assignRandomEquipment()
	{
		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
		{
			local weapons = [
				"weapons/noble_sword",
				"weapons/fighting_axe",
				"weapons/warhammer",
				"weapons/legend_glaive",
				"weapons/fighting_spear",
				"weapons/winged_mace",
				"weapons/arming_sword",
				"weapons/military_cleaver"
			];

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
			{
				weapons.extend([
					"weapons/greatsword",
					"weapons/longsword03",					
					"weapons/greataxe",
					"weapons/legend_swordstaff",
					"weapons/legend_longsword",
					"weapons/warbrand",
					"weapons/legend_estoc"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		//if (::Is_PTR_Exist)
		//{
		//	this.m.Skills.addTreeOfEquippedWeapon(7);	
		//}	
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this);

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			local shields = [
				"shields/wooden_shield",
				"shields/heater_shield",
				"shields/kite_shield"
			];
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}

		if (this.Math.rand(1, 100) <= 35)
		{
			local weapons = [
				"weapons/throwing_axe",
				"weapons/javelin"
			];
			this.m.Items.addToBag(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body) && this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local armor = this.Const.World.Common.pickArmor([
				[1, "coat_of_plates"],
				[1, "coat_of_scales"],
				[1, "heavy_lamellar_armor"],
				[1, "footman_armor"],
				[1, "brown_hedgeknight_armor"],
				[1, "northern_mercenary_armor_02"],
				[1, "lamellar_harness"],
				[1, "reinforced_mail_hauberk"],
				[1, "leather_scale_armor"],
				[1, "light_scale_armor"]
			]);		
			
			armor.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_armor_white_wolf_pelt_upgrade"))			

			this.m.Items.equip(armor);

			local helm = this.Const.World.Common.pickHelmet([
				[1, "closed_mail_coif"],
				[1, "padded_kettle_hat"],
				[1, "kettle_hat_with_closed_mail"],
				[1, "kettle_hat_with_mail"],
				[1, "padded_flat_top_helmet"],
				[1, "nasal_helmet_with_mail"],
				[1, "flat_top_with_mail"],
				[1, "padded_nasal_helmet"],
				[1, "bascinet_with_mail"]
			])
			this.m.Items.equip(helm);
			
		    local mainhandItem = this.getMainhandItem();
		    if (mainhandItem != null)
		    {
		    	if (mainhandItem.isItemType(this.Const.Items.ItemType.TwoHanded))
			    {
					if (::Is_PTR_Exist && ("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
					{
						this.m.Skills.addPerkTree(this.Const.Perks.TwoHandedTree);
					}

			        this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
			    }
			    else
			    {
			    	if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
					{
				        this.m.Skills.add(this.new("scripts/skills/perks/perk_double_strike"));

	       				if (::Is_PTR_Exist)
						{
							this.m.Skills.addPerkTree(this.Const.Perks.OneHandedTree);
							this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));	
						}
					}

			        this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
			    }
		    }			
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body) == null)
		{
			local armor = [
				[1, "reinforced_mail_hauberk"],
				[1, "worn_mail_shirt"],
				[1, "patched_mail_shirt"]
				// [1, "mail_shirt"]
			];

			if (this.Const.DLC.Unhold)
			{
				armor.extend([
					[1, "footman_armor"],
					[1, "leather_scale_armor"],
					[1, "light_scale_armor"],
					[1, "red_bandit_leader_armor"]
				]);
			}

			this.m.Items.equip(this.Const.World.Common.pickArmor(armor))
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null)
		{
			local item = this.Const.World.Common.pickHelmet([
				[1, "closed_mail_coif"],
				[1, "padded_kettle_hat"],
				[1, "kettle_hat_with_closed_mail"],
				[1, "kettle_hat_with_mail"],
				[1, "padded_flat_top_helmet"],
				[1, "nasal_helmet_with_mail"],
				[1, "flat_top_with_mail"],
				[1, "padded_nasal_helmet"],
				[1, "bascinet_with_mail"],
				[1, "red_bandit_leader_helmet"]
			])
			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local shields = clone this.Const.Items.NamedShields;
		shields.extend([
			"shields/named/named_bandit_kite_shield",
			"shields/named/named_bandit_heater_shield"
		]);
		local r = this.Math.rand(1, 4);

		if (r == 1)
		{
			//Use this one if u want only melee weapons
			this.m.Items.equip(this.new("scripts/items/" + this.Const.Items.NamedMeleeWeapons[this.Math.rand(0, this.Const.Items.NamedMeleeWeapons.len() - 1)]));

			//Use this to allocate ammo on guy
			/*
			local itemName = this.Const.Items.NamedWeapons[this.Math.rand(0, this.Const.Items.NamedWeapons.len() - 1)];
			if (itemName == "weapons/named/named_crossbow")
			{
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
			}
			else if (itemName == "weapons/named/named_warbow")
			{
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
			}
			this.m.Items.equip(this.new("scripts/items/" + itemName));
			*/
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}
		else if (r == 3)
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

		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		return true;
	}

});

