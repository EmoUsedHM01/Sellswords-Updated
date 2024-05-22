::mods_hookExactClass("skills/perks/perk_legend_piercing_shot", function ( o )
{
	o.isEnabled <- function()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || (!weapon.isWeaponType(this.Const.Items.WeaponType.Crossbow)))
		{
			return false;
		}

		return true;
	}
});	