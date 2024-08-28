::Mod_Sellswords.HooksMod.hook("scripts/skills/perks/perk_legend_piercing_shot", function ( q ) {

	q.isEnabled <- function()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || (!weapon.isWeaponType(this.Const.Items.WeaponType.Crossbow)))
			return false;

		return true;
	}

});