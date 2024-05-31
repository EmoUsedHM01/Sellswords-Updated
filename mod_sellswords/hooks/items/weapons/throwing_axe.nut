::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/throwing_axe", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original()

		this.m.WeaponType = this.m.WeaponType | this.Const.Items.WeaponType.Axe;
		this.setupWeaponType();
	}
});	
