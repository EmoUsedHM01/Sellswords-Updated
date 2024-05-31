::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/legend_staff_gnarled", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original()

		this.m.Value = 3500;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 40;
		this.m.DirectDamageAdd = 0.0;
		this.m.DirectDamageMult = 0.95;
	}
});	
