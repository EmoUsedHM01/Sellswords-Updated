::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/oriental/firelance", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original()
		this.m.Ammo = 1;
		this.m.AmmoMax = 1;
		this.m.AmmoCost = 3;
	}
});
