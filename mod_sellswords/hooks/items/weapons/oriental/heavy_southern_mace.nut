::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/oriental/heavy_southern_mace", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original()
		this.m.ArmorDamageMult = 1.25;
	}
});
