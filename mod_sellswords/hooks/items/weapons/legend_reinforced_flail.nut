::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/legend_reinforced_flail", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original()

		this.m.Value = 1400;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 75;
		this.m.DirectDamageMult = 0.4;
	}
});	
