::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/greenskins/orc_flail_2h", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original()

		this.m.RegularDamage = 55;	
		this.m.RegularDamageMax = 110;
		this.m.ArmorDamageMult = 1.3;
		this.m.DirectDamageMult = 0.4;
	}
});
