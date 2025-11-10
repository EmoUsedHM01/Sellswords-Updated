::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_duelist", function ( q ) {
	q.getBonus = @(__original) function()
	{
		local bonus = __original();
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (::Legends.Perks.has(this, ::Legends.Perk.crGrandslam))
		{	
			if (weapon == null)
			{
				bonus += 0.5;
				return bonus;
			}
			else if (weapon.isItemType(this.Const.Items.ItemType.RangedWeapon) && !weapon.isWeaponType(this.Const.Items.WeaponType.Throwing))
			{
				return bonus;
			}
			else if (weapon.isItemType(this.Const.Items.ItemType.OneHanded))
			{
				bonus += 0.1;
				return bonus;
			}
			bonus += 0.2;
		}
		return bonus;
	}
});
