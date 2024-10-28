::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/legend_katar", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.Value = 1800;
		this.m.ArmorDamageMult = 0.9;
		this.m.DirectDamageMult = 0.2;
		this.m.DirectDamageAdd = 0.1;		
	}
});
