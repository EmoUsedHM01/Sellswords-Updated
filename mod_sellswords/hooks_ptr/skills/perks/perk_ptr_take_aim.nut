::mods_hookExactClass("skills/perks/perk_ptr_take_aim", function ( o )
{
	o.m.crchance <- 0;

	o.isEnabled = function()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || (!weapon.isWeaponType(this.Const.Items.WeaponType.Crossbow) && (!weapon.isWeaponType(this.Const.Items.WeaponType.Firearm)) ) )
		{
			return false;
		}

		return true;
	}
});	