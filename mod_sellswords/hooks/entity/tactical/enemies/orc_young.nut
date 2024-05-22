::Mod_Sellswords("entity/tactical/enemies/orc_young", function(q)
{
	q.onInit = @( __original ) function()
	{
		__original();
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 120)
		{
			this.m.BaseProperties.RangedSkill += 5;	
			//this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));				
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
		local r;
		local weapon;

		if (this.Math.rand(1, 100) <= 25)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/orc_javelin"));
		}

		if (this.Math.rand(1, 100) <= 75)
		{
			if (this.Math.rand(1, 100) <= 75)
			{
				r = this.Math.rand(1, 3);

				if (r == 1)
				{
					weapon = this.new("scripts/items/weapons/greenskins/orc_axe");
				}
				else if (r == 2)
				{
					weapon = this.new("scripts/items/weapons/greenskins/orc_cleaver");
				}
				else if (r == 3)
				{
					weapon = this.new("scripts/items/weapons/greenskins/legend_skin_flayer");
				}					
			}
			else
			{
				r = this.Math.rand(1, 6);
				if (r == 1)
				{
					weapon = this.new("scripts/items/weapons/greenskins/orc_wooden_club");
				}
				else if (r == 2 || r == 3)
				{
					weapon = this.new("scripts/items/weapons/greenskins/orc_metal_club");
				}
				else if (r == 4)
				{
					weapon = this.new("scripts/items/weapons/greenskins/legend_skullsmasher");
				}
				else if (r == 5)
				{
					weapon = this.new("scripts/items/weapons/orcspear");
				}
				else if (r == 6)
				{
					weapon = this.new("scripts/items/weapons/crorc_mace");
				}					
			}
		}
		else
		{
			r = this.Math.rand(1, 4);

			if (r == 1)
			{
				weapon = this.new("scripts/items/weapons/greenskins/goblin_falchion");
			}
			else if (r == 2)
			{
				weapon = this.new("scripts/items/weapons/morning_star");
			}
			else if (r == 3)
			{
				weapon = this.new("scripts/items/weapons/greenskins/legend_meat_hacker");
			}
				else if (r == 4)
			{
				weapon = this.new("scripts/items/weapons/greenskins/legend_bone_carver");
			}
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			this.m.Items.equip(weapon);
		}
		else
		{
			this.m.Items.addToBag(weapon);
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			this.m.Items.equip(this.new("scripts/items/shields/greenskins/orc_light_shield"));
		}

		//if (::Is_PTR_Exist) this.m.Skills.addTreeOfEquippedWeapon(4);
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 4);	

		local armor;
		armor = [
			[1, "greenskins/orc_young_light_armor"],
			[1, "greenskins/orc_young_medium_armor"],
			[1, "greenskins/orc_young_heavy_armor"],
			[1, ""]
		];

		if (this.World.getTime().Days >= 80)
		{
			armor = [
				[1, "greenskins/orc_young_light_armor"],
				[1, "greenskins/orc_young_medium_armor"],
				[1, "greenskins/orc_young_heavy_armor"]
			];
		}
		if (this.World.getTime().Days >= 160)
		{
			armor = [
				[1, "greenskins/orc_young_light_armor"],
				[2, "greenskins/orc_young_medium_armor"],
				[1, "greenskins/orc_young_heavy_armor"]
			];
		}	
		if (this.World.getTime().Days >= 240)
		{
			armor = [
				[1, "greenskins/orc_young_medium_armor"],
				[2, "greenskins/orc_young_heavy_armor"]
			];
		}			

		this.m.Items.equip(this.Const.World.Common.pickArmor(armor));
		local helmet;
		helmet = [
			[1, "greenskins/orc_young_light_helmet"],
			[1, "greenskins/orc_young_medium_helmet"],
			[1, "greenskins/orc_young_heavy_helmet"],
			[1, ""]
		];

		if (this.World.getTime().Days >= 80)
		{
			helmet = [
				[1, "greenskins/orc_young_light_helmet"],
				[1, "greenskins/orc_young_medium_helmet"],
				[1, "greenskins/orc_young_heavy_helmet"]
			];
		}
		if (this.World.getTime().Days >= 160)
		{
			helmet = [
				[1, "greenskins/orc_young_light_helmet"],
				[2, "greenskins/orc_young_medium_helmet"],
				[1, "greenskins/orc_young_heavy_helmet"]
			];
		}
		if (this.World.getTime().Days >= 240)
		{
			helmet = [
				[1, "greenskins/orc_young_medium_helmet"],
				[2, "greenskins/orc_young_heavy_helmet"]
			];
		}			

		this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));			
	}
});
