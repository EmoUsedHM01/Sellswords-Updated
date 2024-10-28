::Mod_Sellswords.HooksMod.hook("scripts/items/weapons/greenskins/goblin_staff", function ( q ) {
	
	q.create = @(__original) function()
	{
		__original();

		this.m.RegularDamage = 15;
		this.m.RegularDamageMax = 25;
		this.m.ArmorDamageMult = 0.35;
		this.m.DirectDamageAdd = 0.4;	
	}
});	
