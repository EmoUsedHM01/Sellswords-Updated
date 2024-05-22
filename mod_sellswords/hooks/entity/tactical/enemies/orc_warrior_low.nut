::Mod_Sellswords("entity/tactical/enemies/orc_warrior_low", function(q)
{
	q.assignRandomEquipment = @( __original ) function()
	{
		local r;
		r = this.Math.rand(1, 6);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/greenskins/orc_axe"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/greenskins/orc_axe"));
		}			
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/greenskins/orc_cleaver"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/greenskins/orc_cleaver"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/greenskins/legend_skin_flayer"));
		}			
		else if (r == 6)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/greenskins/legend_skullsmasher"));
		}
		
		if (this.Math.rand(1, 100) <= 66)
		{
			this.m.Items.equip(this.new("scripts/items/shields/greenskins/orc_heavy_shield"));
		}
		
		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			//this.m.Skills.addTreeOfEquippedWeapon(6);
			::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 6);
		}
		else
		{
			//this.m.Skills.addTreeOfEquippedWeapon(5);
			::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 5);
		}

		this.m.Skills.removeByID("perk.ptr_kata");
		
		local helmet;
		helmet = [
			[1, ""],
			[1, "greenskins/orc_warrior_light_helmet"],
			[1, "greenskins/orc_warrior_medium_helmet"]
		];
		if (this.World.getTime().Days >= 80)
		{
			helmet = [
				[3, "greenskins/orc_warrior_light_helmet"],
				[2, "greenskins/orc_warrior_medium_helmet"]
			];
		}
		if (this.World.getTime().Days >= 160)
		{
			helmet = [
				[2, "greenskins/orc_warrior_light_helmet"],
				[3, "greenskins/orc_warrior_medium_helmet"]
			];
		}
		if (this.World.getTime().Days >= 240)
		{
			helmet = [
				[1, "greenskins/orc_warrior_light_helmet"],
				[3, "greenskins/orc_warrior_medium_helmet"]
			];
		}			

		this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));	
		
		local armor;
		armor = [
			[1, "greenskins/orc_warrior_light_armor"],
			[1, "greenskins/orc_warrior_medium_armor"]
		];
		if (this.World.getTime().Days >= 80)
		{
			armor = [
				[3, "greenskins/orc_warrior_light_armor"],
				[2, "greenskins/orc_warrior_medium_armor"]
			];
		}
		if (this.World.getTime().Days >= 160)
		{
			armor = [
				[2, "greenskins/orc_warrior_light_armor"],
				[3, "greenskins/orc_warrior_medium_armor"]
			];
		}
		if (this.World.getTime().Days >= 240)
		{
			armor = [
				[1, "greenskins/orc_warrior_light_armor"],
				[3, "greenskins/orc_warrior_medium_armor"]
			];
		}				

		this.m.Items.equip(this.Const.World.Common.pickArmor(armor));				

	}
});
