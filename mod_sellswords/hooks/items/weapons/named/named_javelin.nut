::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/named/named_javelin", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original()

		this.m.WeaponType = this.m.WeaponType | this.Const.Items.WeaponType.Spear;
		this.setupWeaponType();
	}
});
