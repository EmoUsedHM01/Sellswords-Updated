::mods_hookExactClass("entity/tactical/enemies/bandit_leader", function(o) {
	local onInit = o.onInit;
	o.onInit = function()
	{		
		onInit();
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		{
			this.m.BaseProperties.MeleeSkill += 2;
			this.m.BaseProperties.Initiative += 2;
			if (this.World.getTime().Days >= 60)
			{			
				this.m.BaseProperties.MeleeDefense += 2;
				this.m.BaseProperties.RangedDefense += 2;
				this.m.BaseProperties.Bravery += 2;
				if (this.World.getTime().Days >= 80)
				{					
					this.m.BaseProperties.MeleeSkill += 3;
					this.m.BaseProperties.Initiative += 3;
					if (this.World.getTime().Days >= 100)
					{
						this.m.BaseProperties.MeleeDefense += 3;
						this.m.BaseProperties.RangedDefense += 3;
						this.m.BaseProperties.Bravery += 3;											
					}		
				}
			}
		}			
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));				
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
					"weapons/warbrand",
					"weapons/spontoon03",						
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			local shields = [
				"shields/heater_shield",
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

		local dc = this.World.getTime().Days;
		local mn = this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon");	
		dc = this.Math.max(dc, mn * 3);			
		if (dc <= 35)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[3, "crbandit_early"],		 //180 				
				[1, "crbandit_mid"],	  	   //220					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "crbandit_helmet_low"],			//125,-6				 					
				[1, "crbandit_helmet_early"],		  //170,-10					
			]));
		}
		else if (dc <= 60)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crbandit_early"],		 //180 				
				[1, "crbandit_mid"],	  	   //220					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "crbandit_helmet_low"],			//125,-6				 					
				[3, "crbandit_helmet_early"],		  //170,-10
				[1, "red_bandit_leader_helmet"],	   //195					
				[1, "crbandit_helmet_mid"],			//215,-12				
			]));
		}
		else if (dc <= 85)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crbandit_early"],		 //180 				
				[2, "crbandit_mid"],	  	   //220
				[1, "crbandit_late"],		  //270 									
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([				 					
				[2, "crbandit_helmet_early"],		  //170,-10
				[2, "red_bandit_leader_helmet"],	   //195					
				[4, "crbandit_helmet_mid"],			//215,-12					
				[1, "cr_hedgeknight_low"],			//255,-16					
			]));
		}
		else if (dc <= 120)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crbandit_late"],		  //270 				
				[1, "crbandit_heavy"],	 	   //290					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([	
				[1, "red_bandit_leader_helmet"],	   //195				
				[1, "crbandit_helmet_mid"],			//215,-12
				[3, "cr_enclave_kettle_with_chain"],   //265,-17					
				[1, "cr_enclave_kettle"],			  //270,-18					
				[1, "cr_hedgeknight_low"],			//255,-16					
			]));
		}
		else if (dc <= 160)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crbandit_late"],		  //270 				
				[2, "crbandit_heavy"],	 	   //290					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([					
				[1, "cr_enclave_kettle_with_chain"],   //265,-17					
				[1, "cr_enclave_kettle"],			  //270,-18					
				[1, "cr_hedgeknight_low"],			//255,-16					
			]));
		}
		else if (dc > 160)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "crbandit_late"],		  //270 				
				[3, "crbandit_heavy"],	 	   //290					
			]));
			this.m.Items.equip(this.Const.World.Common.pickHelmet([					
				[1, "cr_enclave_kettle_with_chain"],   //265,-17					
				[2, "cr_enclave_kettle"],			  //270,-18					
				[1, "cr_hedgeknight_low"],			//255,-16					
			]));
		}			
	}
	o.makeMiniboss = function ()
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