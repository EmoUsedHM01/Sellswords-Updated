::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/legend_free_company_crossbow", function( q ) {
	
	q.onInit = @( __original ) function()
	{
		__original();

		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_back_to_basics"));

		if (::Is_PTR_Exist)
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_strength_in_numbers"));

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

		this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Ammo));
		local r = this.Math.rand(1, 10);
		switch (r) {
			case 1:
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_fire_bolts"));
				break;
			case 2:
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bleeding_bolts"));
				break;
			default:
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
				break;
		}
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 6);
	}

});