::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/legend_estoc", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.RegularDamage = 55;
		this.m.RegularDamageMax = 75;	
		this.m.DirectDamageAdd = 0.2;
	}
});
