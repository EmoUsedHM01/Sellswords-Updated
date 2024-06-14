::Mod_Sellswords.HooksMod.hook("scripts/entity/tactical/humans/mercenary_ranged", function( q ) {

	q.onInit = @( __original ) function()
	{
		__original();

		if (::Is_PTR_Exist)
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ptr_eyes_up"));

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

		this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Ammo));
		local r = this.Math.rand(1, 30);
		switch (r) {
			case 1:
				this.m.Items.equip(this.new("scripts/items/weapons/hunting_bow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_fire_arrows"));
				break;
			case 2:
				this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_fire_arrows"));
				break;
			case 3:
				this.m.Items.equip(this.new("scripts/items/weapons/hunting_bow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_freezing_arrows"));
				break;
			case 4:
				this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_freezing_arrows"));
				break;
			case 5:
				this.m.Items.equip(this.new("scripts/items/weapons/hunting_bow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bleeding_arrows"));
				break;
			case 6:
				this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bleeding_arrows"));
				break;
			case 7:
				this.m.Items.equip(this.new("scripts/items/weapons/hunting_bow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_poisoned_arrows"));
				break;
			case 8:
				this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_poisoned_arrows"));
				break;
			case 9:
				this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_fire_bolts"));
				break;
			case 10:
				this.m.Items.equip(this.new("scripts/items/weapons/heavy_crossbow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_fire_bolts"));
				break;
			case 11:
				this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_freezing_bolts"));
				break;
			case 12:
				this.m.Items.equip(this.new("scripts/items/weapons/heavy_crossbow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_freezing_bolts"));
				break;
			case 13:
				this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bleeding_bolts"));
				break;
			case 14:
				this.m.Items.equip(this.new("scripts/items/weapons/heavy_crossbow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bleeding_bolts"));
				break;
			case 15:
				this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_poisoned_bolts"));
				break;
			case 16:
				this.m.Items.equip(this.new("scripts/items/weapons/heavy_crossbow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_poisoned_bolts"));
				break;
			default:
				local r = this.Math.rand(1, 2);
				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/hunting_bow"));
					this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
				}
				else
				{
					this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
					this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
				}
				break;
		}
		::Mod_Sellswords.HookHelper.addTreeOfEquippedWeapon(this, 6);
	}

});