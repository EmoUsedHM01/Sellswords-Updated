::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/spetum", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original()

		this.m.Value = 1500;
		this.m.ArmorDamageMult = 1.05;
	}
});	
